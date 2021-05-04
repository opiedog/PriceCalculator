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
    var wasSuccessful = true
    var errorType = CalculatePriceError.ignore
    var calculatedPrice = 0.0
    init() {
        wasSuccessful = true
        errorType = CalculatePriceError.ignore
        calculatedPrice = 0.0
    }
}

enum PoolShape {
    // Geometric shapes
    case undefined
    case rectangle
    case oval
    case grecian
    case truel
    case lazyl
    case roman

    // Freeform shapes
    case oasis
    case tahiti
    case lagoon
}

enum ShapeDescription {
    case undefined
    case freeform
    case geometric
}

enum SafetyCoverPanelSize {
    case fivebyfive
    case threebythree
    case undefined
}

enum SafetyCoverModel {
    case StandardMesh5000M
    case HighShadeMesh7000MS
    case MaxShadeMesh9000MX
    case HeavyDutySolid1000V
    case LiteSolid500P
    case undefined
}

enum UnitOfMeasure {
    case each
    case perimeter
    case poolarea
    case coverarea
    case linearfoot
    case undefined
}

struct SafetyCoverOptionSelection {
    var optionItem: SafetyCoverOptionItem
    var quantity: Int = 0
}

//===========================================================
class RectangleBase {
    var length: Double = 0      // B        // B        // X1
    var width: Double = 0       // A        // A1       // A
    var areaPool: Double = 0
    var areaCover: Double = 0
    var perimeterPool: Double = 0

    init(length: Double, width: Double) {
        self.length = length
        self.width = width
        
        calculateAreaPool()
        calculateAreaCover()
        calculatePerimeterPool()
    }
    
    //---------------------------
    //---------------------------
    func calculateAreaPool() {
        self.areaPool = (Double)(self.length * self.width)
    }

    //---------------------------
    //---------------------------
    func calculateAreaCover() {
        let totalCoverOverlap: Double = 2.0
        self.areaCover = (Double)((totalCoverOverlap + self.length) * (totalCoverOverlap + self.width))
    }

    //---------------------------
    //---------------------------
     func calculatePerimeterPool() {
        self.perimeterPool = (2 * self.length) + (2 * self.width)
     }
}

class Rectangle: RectangleBase {
    var shapeDescription: ShapeDescription = .geometric
    var poolShape: PoolShape = .rectangle
}

class Oval: RectangleBase {
    var shapeDescription: ShapeDescription = .geometric
    var poolShape: PoolShape = .oval
}

class Grecian: RectangleBase {
    var shapeDescription: ShapeDescription = .geometric
    var poolShape: PoolShape = .grecian
}

class Roman: RectangleBase {
    var shapeDescription: ShapeDescription = .geometric
    var poolShape: PoolShape = .roman
}

class Oasis: RectangleBase {
    var shapeDescription: ShapeDescription = .freeform
    var poolShape: PoolShape = .oasis

    //---------------------------
    //---------------------------
    override func calculateAreaCover() {
        let totalCoverOverlap: Double = 3.0
        self.areaCover = (Double)((totalCoverOverlap + self.length) * (totalCoverOverlap + self.width))
    }
}

class Tahiti: RectangleBase {
    var shapeDescription: ShapeDescription = .freeform
    var poolShape: PoolShape = .tahiti

    //---------------------------
    //---------------------------
    override func calculateAreaCover() {
        let totalCoverOverlap: Double = 3.0
        self.areaCover = (Double)((totalCoverOverlap + self.length) * (totalCoverOverlap + self.width))
    }
}

class Lagoon {
    var shapeDescription: ShapeDescription = .freeform
    var poolShape: PoolShape = .lagoon

    var longLength: Double = 0
    var longWidth: Double = 0
    
    var shortLength: Double = 0
    var shortWidth: Double = 0

    var areaPool: Double = 0
    var areaCover: Double = 0
    var perimeterPool: Double = 0
    
    //var rect1: Rectangle
    //var rect2: Rectangle
    
    init(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double) {
        self.longLength = longLength
        self.longWidth = longWidth
        self.shortLength = shortLength
        self.shortWidth = shortWidth
        
        calculateAreaPool()
        calculateAreaCover()
    }
    
    //---------------------------
    //---------------------------
    func calculateAreaPool() {
        self.areaPool = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 0)
        self.areaPool += getAreaWithOverlap(length: self.shortLength, width: self.shortWidth, totalOverlap: 0)
    }

    //---------------------------
    //---------------------------
    func calculateAreaCover() {
        self.areaCover = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 3.0)
        self.areaCover += getAreaWithOverlap(length: self.shortLength, width: self.shortWidth, totalOverlap: 3.0)
    }

    //---------------------------
    //---------------------------
//     func calculatePerimeterPool() {
//        self.perimeterPool = (2 * self.length) + (2 * self.width)
//     }

    //---------------------------
    //---------------------------
    func getAreaWithOverlap(length: Double, width: Double, totalOverlap: Double) -> Double {
        let area: Double = (Double)((totalOverlap + length) * (totalOverlap + width))
        return area
    }
}

//===========================================================
class TrueL {
    //                              // These values/names are re "2021 US Safety Cover Calculator.xlsm" on the 'Setup' tab
    //                              // Rect     // TrueL    // LazyL
    // Something described by an enclosing rectangle
    var longLength: Double = 0      // B        // B        // X1
    var longWidth: Double = 0       // A        // A1       // A
    
    // True L
    var shortLength: Double = 0     //          // B7       // T
    var shortWidth: Double = 0      //          // A        // A1

    var totalOverlap: Double = 2.0
    var areaPool: Double = 0
    var areaCover: Double = 0
    var perimeterPool: Double = 0
    var shapeDescription: ShapeDescription = .geometric
    var poolShape: PoolShape = .truel

    //---------------------------
    //---------------------------
    init(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double) {
        self.longLength = longLength
        self.longWidth = longWidth

        self.shortLength = shortLength
        self.shortWidth = shortWidth
        
        let area1 = (Double)(longLength * shortWidth)
        let area2 = (Double)(shortLength * (longWidth - shortWidth))
        self.areaPool = area1 + area2
        
        self.areaCover = calculateAreaCover()
        self.perimeterPool = calculatePerimiterPool()
    }
    
    //---------------------------
    //---------------------------
    func calculateAreaCover() -> Double {
        let totalOverlap: Double = 2.0

        // B  == longLength  &&   B7 == shortLength
        // A1 == longWidth   &&    A == shortWidth
        // We are calculating two separate areas and combining them.
        // We will add the borderWidth to each side since the cover must be bigger than the pool
        // But with this L shape, we need to remove the sizes of the two separate areas that
        // don't actually exist.
        
        //                        B                             A
        let area1 = (Double)(((longLength + totalOverlap) * (shortWidth + totalOverlap)))
        
        //                         B7                           A1             A
        let area2 = (Double) ((shortLength + totalOverlap) * (longWidth - shortWidth))
        
        let area = area1 + area2  // TODO - I don't think the Excel calculator includes the borderWidth
        
        return area
    }
    
    //---------------------------
    //---------------------------
    func calculatePerimiterPool() -> Double {
        let p: Double = (longWidth + shortWidth + (longWidth - shortWidth)) + (longLength + shortLength + (longLength - shortLength))
        return p
    }
}

//===========================================================
class LazyL {
    var shapeDescription: ShapeDescription = .geometric
    var poolShape: PoolShape = .lazyl
    
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

    //---------------------------
    //---------------------------
    init(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double, longDiagLength: Double, shortDiagLength: Double) {
        self.longLength = longLength
        self.longWidth = longWidth

        self.shortLength = shortLength
        self.shortWidth = shortWidth
        
        self.longDiagLength = longDiagLength
        self.shortDiagLength = shortDiagLength
        
        calculateAreaPool()
        calculateAreaCover()

        getPerimeterPool()
    }

    //---------------------------
    //---------------------------
    func calculateAreaCover() {
        // Full overlap width
        let fow: Double = 2.0
        
        // Half overlap width
        // This is half of the full (actual) overlap width because the area
        // calculation double-counts it.
        // I'm not convinced that this isn't a bug but whatever, it's Latham's
        // calc and we'll replace this with the real value from the scanner...
        let how: Double = (fow / 2)
        
        let area: Double = getAreaBase(a: longWidth + fow, x1: longLength + how, w1: longDiagLength + how, a1: shortWidth + fow, v3: shortDiagLength + how, t: shortLength + how)
        
        self.areaCover = area
    }
    
    //---------------------------
    //---------------------------
    func calculateAreaPool() {
        let area: Double = getAreaBase(a: longWidth, x1: longLength, w1: longDiagLength, a1: shortWidth, v3: shortDiagLength, t: shortLength)
        self.areaPool = area
    }

    //---------------------------
    // This approach is what Latham did.
    // The lazy L shape is a rectangle that's horizontal that is combined with
    // one at an angle (which isn't always 45 degrees).
    // So the top of each rect (e.g. "t") is shorter than the bottom (e.g. "x1").
    //
    // This approach adds the top and bottom lengths, multiplies times the width,
    // and cuts in half, which basically averages the two different lengths.
    //
    //      t           x1
    //  |------- - - - - - - -|
    //  |                     |
    //  |----------- - - - - -|
    //        x1         t
    //
    // The same is done for both the horizontal rect and the angled rect,
    // and the total area is the sum of the two.
    //---------------------------
    func getAreaBase(a: Double, x1: Double, w1: Double, a1: Double, v3: Double, t: Double) -> Double {
        let horizSquareArea: Double = ((a * (t + x1)) / 2)
        let slantSquareArea: Double = ((a1 * (v3 + w1)) / 2)
        
        let area: Double = horizSquareArea + slantSquareArea
        
        return area
    }

    //    func getArea_LazyL(a: Double, x1: Double, w1: Double, a1: Double, v3: Double, t: Double) -> Double {
    //        let horizSquareArea: Double = (a * t)
    //        let slantSquareArea: Double = (a1 * v3)
    //
    ////        // Assuming the lazy L slants up at 45 degrees
    ////        let degrees: Double = (45 / 2)
    ////        let radians: Double = (degrees * .pi / 180)
    ////        let extraLenFactor: Double = tan(radians)
    //
    //        let horizTriangeArea: Double = (0.5 * (a * (x1 - t)))
    //        let slantTriangleArea: Double = (0.5 * (a1 * (w1 - v3)))
    //
    //        let area: Double = horizSquareArea + slantSquareArea + horizTriangeArea + slantTriangleArea
    //
    //        return area
    //    }

    //---------------------------
    //---------------------------
    func getPerimeterPool() {
        let p: Double = (longLength + longWidth + shortLength + shortWidth + longDiagLength + shortDiagLength)
        self.perimeter = p
    }
}


//====================================
class SafetyCoverPriceCalculator {
    private let _dataLayer: DataLayer = DataLayer()
    //private var _areaDimensions: AreaDimensions?
    private var _area: Double?
    private var _shapeDescription: ShapeDescription?
    private var _safetyCoverModel: SafetyCoverModel
    private var _safetyCoverPanelSize: SafetyCoverPanelSize
    private var _selectedOptions: [SafetyCoverOptionSelection]?

    var priceResult: PriceResult = PriceResult()

    init(safetyCoverModel: SafetyCoverModel, safetyCoverPanelSize: SafetyCoverPanelSize) {
        _area = nil
        _shapeDescription = ShapeDescription.undefined
        _safetyCoverModel = safetyCoverModel
        _safetyCoverPanelSize = safetyCoverPanelSize
        _selectedOptions = nil
    }
    
    func setArea(area: Double) {
        _area = area
    }
    
    func setPoolCharacteristics(shapeDescription: ShapeDescription) {   //, shape: PoolShape
        _shapeDescription = shapeDescription
        //_poolShape = shape
    }
    
    func setSelectedOptions(selectedOptions: [SafetyCoverOptionSelection]) {
        _selectedOptions = selectedOptions
    }

    //--------------------------------
    func calculatePrice() {
        // Validate inputs
        // TODO

        // Get the baseline for the square footage
        let unitPrice: Double = _dataLayer.getUnitPriceForArea(shapeDescription: self._shapeDescription!, coverModel: _safetyCoverModel, panelSize: _safetyCoverPanelSize, area: self._area!)
        
        // This is a crappy implementation done just to get this done ASAP
        if(unitPrice >= 0) {
            priceResult.calculatedPrice = self._area! * unitPrice

            // Add the options
            priceResult.calculatedPrice += getTotalForOptionsList(selectedOptions: _selectedOptions)
        }
        else {
            priceResult.wasSuccessful = false
        }
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
                        optionsTotal += (rawItem.unitPrice * self._area!)
                    case .coverarea:
                        optionsTotal += (rawItem.unitPrice * self._area!)

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
        let unitPrice: Double = _dataLayer.getUnitPriceForArea(shapeDescription: self._shapeDescription!, coverModel: _safetyCoverModel, panelSize: _safetyCoverPanelSize, area: self._area!)
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

