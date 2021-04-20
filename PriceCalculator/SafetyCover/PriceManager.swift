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

enum ShapeCharacterization {
    case undefined
    case freeform
    case geometric
}

enum ShapeDescription {
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
    var shapeCharacterization: ShapeCharacterization = .undefined
    var shapeDescription: ShapeDescription = .undefined
    var area: Double = 0
    var perimeter: Double = 0

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

    init(shapeDescription: ShapeDescription, longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double, longDiagLength: Double, shortDiagLength: Double) {
        
        if(shapeDescription == ShapeDescription.undefined) {
            return
        }
        else {
            self.shapeDescription = shapeDescription
        }
        
        var borderWidth: Double = 0

        switch shapeDescription {
            case ShapeDescription.rectangle:
                self.longLength = longLength
                self.longWidth = longWidth
                
                borderWidth = 2.0
                self.area = (Double)((borderWidth + longLength) * (borderWidth + longWidth))
                
                self.perimeter = (2 * longLength) + (2 * longWidth)

                self.shapeCharacterization = .geometric

            case ShapeDescription.truel:
                self.longLength = longLength
                self.longWidth = longWidth

                self.shortLength = shortLength
                self.shortWidth = shortWidth
                
                borderWidth = 3.0
                let area1 = (Double)(longLength * shortWidth)
                let area2 = (Double)(shortLength * (longWidth - shortWidth))
                area = area1 + area2

                self.perimeter = (longWidth + shortWidth + (longWidth - shortWidth)) + (longLength + shortLength + (longLength - shortLength))

                self.shapeCharacterization = .geometric

            case ShapeDescription.lazyl:
                self.longLength = longLength
                self.longWidth = longWidth

                self.shortLength = shortLength
                self.shortWidth = shortWidth
                
                self.longDiagLength = longDiagLength
                self.shortDiagLength = shortDiagLength

                self.shapeCharacterization = .geometric

            default:
                return
        }
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
        priceResult.calculatedPrice = _dataLayer.getPriceForArea(shapeCharacterization: self._areaDimensions!.shapeCharacterization, coverModel: _safetyCoverModel, panelSize: _safetyCoverPanelSize, area: self._areaDimensions!.area)

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
                optionsTotal += (rawItem.unitPrice * (Double(selectedOption.quantity)))
            }
        }
        
        return optionsTotal
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
