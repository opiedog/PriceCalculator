//
//  PriceManager.swift
//  PriceCalculator
//
//  Created by John Tafoya on 4/15/21.
//

import Foundation

enum CalculatePriceError {
    case ignore
    case validateInputs
    case configureFromPoolShape
}

struct PriceResult {
    var success = true
    var errorType = CalculatePriceError.ignore
    var calculatedPrice = 0.0
}

// Was ShapeDescription
enum PoolShape {
    case undefined
    case rectangle
    case truel
    case lazyl
}

struct SafetyCoverOptionSelection {
    var optionItem: SafetyCoverOptionItem
    var quantity: Int = 0
}

// TODO
//  - Add a field to capture the units (e.g. feet, meters)
struct AreaDimensions {
    var shapeDescription: ShapeDescription = .undefined
    var poolShape: PoolShape = .undefined
    
    var areaPool: Double = 0    // The area of the pool
    var areaCover: Double = 0   // The area of the cover that includes an amount to be larger than the pool
    
    var perimeter: Double = 0   // This is the pool perimeter, not the cover

    //                              // These values/names are re "2021 US Safety Cover Calculator.xlsm" on the 'Setup' tab
    //                              // Rect     // TrueL    // LazyL
    // Something described by an enclosing rectangle
    var longLength: Double = 0      // B        // B        // X1
    var longWidth: Double = 0       // A        // A1       // A
    
    // True L
    var shortLength: Double = 0     //          // B7       // T
    var shortWidth: Double = 0      //          // A        // A1

    // Lazy L
    var longDiagLength: Double = 0  //          //          // W1
    var shortDiagLength: Double = 0 //          //          // V3

    init(poolShape: PoolShape, longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double, longDiagLength: Double, shortDiagLength: Double) {
        
        if(poolShape == PoolShape.undefined) {
            return
        }
        else {
            self.poolShape = poolShape
        }
        
        //var borderWidth: Double = 0

        switch poolShape {
            case .rectangle:
                self.longLength = longLength
                self.longWidth = longWidth
                
                self.areaPool = (Double)(longLength * longWidth)
                
                self.areaCover = getCoverArea_Rectangle()
                self.perimeter = getPerimeter_Rectangle()

                self.shapeDescription = .geometric

            case .truel:
                self.longLength = longLength
                self.longWidth = longWidth

                self.shortLength = shortLength
                self.shortWidth = shortWidth
                
                let area1 = (Double)(longLength * shortWidth)
                let area2 = (Double)(shortLength * (longWidth - shortWidth))
                self.areaPool = area1 + area2
                
                self.areaCover = getCoverArea_TrueL()
                self.perimeter = getPerimeter_TrueL()

                self.shapeDescription = .geometric

            case .lazyl:
                self.longLength = longLength
                self.longWidth = longWidth

                self.shortLength = shortLength
                self.shortWidth = shortWidth
                
                self.longDiagLength = longDiagLength
                self.shortDiagLength = shortDiagLength

                self.shapeDescription = .geometric

            default:
                return
        }
    }
    
    //---------------------------
    //---------------------------
    func getCoverArea_Rectangle() -> Double {
        let borderWidth: Double = 2.0
        let area: Double = (Double)((borderWidth + longLength) * (borderWidth + longWidth))
        return area
    }
    
    //---------------------------
    //---------------------------
    func getPerimeter_Rectangle() -> Double {
        let p: Double = (2 * longLength) + (2 * longWidth)
        return p
    }
    
    //---------------------------
    //---------------------------
    func getCoverArea_TrueL() -> Double {
        let borderWidth: Double = 2.0

        // B  == longLength  &&   B7 == shortLength
        // A1 == longWidth   &&    A == shortWidth
        // We are calculating two separate areas and combining them.
        // We will add the borderWidth to each side since the cover must be bigger than the pool
        // But with this L shape, we need to remove the sizes of the two separate areas that
        // don't actually exist.
        
        //                        B                             A
        let area1 = (Double)(((longLength + borderWidth) * (shortWidth + borderWidth)))
        
        //                         B7                           A1             A
        let area2 = (Double) ((shortLength + borderWidth) * (longWidth - shortWidth))
        
        let area = area1 + area2  // TODO - I don't think the Excel calculator includes the borderWidth
        
        return area
    }
    
    //---------------------------
    //---------------------------
    func getPerimeter_TrueL() -> Double {
        let p: Double = (longWidth + shortWidth + (longWidth - shortWidth)) + (longLength + shortLength + (longLength - shortLength))
        return p
    }
}

//====================================
class SafetyCoverPriceCalculator {
    private let _dataLayer: DataLayer = DataLayer()
    private var _areaDimensions: AreaDimensions?
    private var _safetyCoverModel: SafetyCoverModel
    private var _safetyCoverPanelSize: SafetyCoverPanelSize
    private var _selectedOptions: [SafetyCoverOptionSelection]?

    var priceResult: PriceResult = PriceResult()

    init(safetyCoverModel: SafetyCoverModel, safetyCoverPanelSize: SafetyCoverPanelSize) {
        _areaDimensions = nil
        _safetyCoverModel = safetyCoverModel
        _safetyCoverPanelSize = safetyCoverPanelSize
        _selectedOptions = nil
    }
    
    func setAreaDimensions(areaDimensions: AreaDimensions) {
        _areaDimensions = areaDimensions
    }
    
    func setSelectedOptions(selectedOptions: [SafetyCoverOptionSelection]) {
        _selectedOptions = selectedOptions
    }

    func validateAreaDimensions(areaDimensions: AreaDimensions) -> Bool {
        //guard areaDimensions != nil else {
        //    return false
        //}
        
        // TODO
        return true
    }

    //--------------------------------
    func calculatePrice() {
        // Validate inputs
        // TODO

        // Get the baseline for the square footage
        let unitPrice: Double = _dataLayer.getUnitPriceForArea(shapeDescription: self._areaDimensions!.shapeDescription, coverModel: _safetyCoverModel, panelSize: _safetyCoverPanelSize, area: self._areaDimensions!.areaCover)
        priceResult.calculatedPrice = self._areaDimensions!.areaCover * unitPrice

        // Add the options
        priceResult.calculatedPrice += getTotalForOptionsList(selectedOptions: _selectedOptions)
    }
    
    //--------------------------------
    func getTotalForOptionsList(selectedOptions: [SafetyCoverOptionSelection]?) -> Double {
        var optionsTotal: Double = 0.0
        
        if(selectedOptions != nil) {
            for selectedOption in selectedOptions! {
                // Get the item from the data layer
                let rawItem: SafetyCoverOptionItem = _dataLayer.getSafetyCoverOptionItem(name: selectedOption.optionItem.name, safetyCoverPanelSize: _safetyCoverPanelSize)
                
                // Multiple its unit price times the quantity and add it to the total
                switch(rawItem.uom) {
                    case .each:
                        optionsTotal += (rawItem.unitPrice * (Double(selectedOption.quantity)))
                    case .linearfoot:
                        optionsTotal += (rawItem.unitPrice * (Double(selectedOption.quantity)))
                    case .poolarea:
                        optionsTotal += (rawItem.unitPrice * self._areaDimensions!.areaPool)
                    case .coverarea:
                        optionsTotal += (rawItem.unitPrice * self._areaDimensions!.areaCover)

                    case .perimeter:
                        // TODO
                        optionsTotal += 0
                    case .undefined:
                        // TODO
                        optionsTotal += 0
                }
            }
        }
        
        return optionsTotal
    }
    
    func getUnitPriceForArea() -> Double {
        let unitPrice: Double = _dataLayer.getUnitPriceForArea(shapeDescription: self._areaDimensions!.shapeDescription, coverModel: _safetyCoverModel, panelSize: _safetyCoverPanelSize, area: self._areaDimensions!.areaCover)
        return unitPrice
    }
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func getArea_geometric(aFeet: Double, aInches: Double, bFeet: Double, bInches: Double) -> Double {
    let aVal: Double = (2 + (aFeet + (aInches / 12)))
    let bVal: Double = (2 + (bFeet + (bInches / 12)))
    let area = aVal * bVal
    
    return area
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
//func validateInputs() -> Bool {
//    // TODO
//    return true
//}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func testConfigResult(configResult: Bool) -> PriceResult {
    var priceResult = PriceResult()
    if (!configResult) {
        priceResult.success = false
        priceResult.errorType = CalculatePriceError.configureFromPoolShape
        return priceResult
    }
    else {
        priceResult.success = true
        return priceResult
    }
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func configureFreeformPoolShape() -> Bool {
    // TODO
    return true
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func configureGeometricPoolShape() -> Bool {
    // TODO
    return true
}
