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
    var totalOverlap: Double = 2.0
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
        self.areaCover = (Double)((self.totalOverlap + self.length) * (self.totalOverlap + self.width))
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


//----------------------------------------------------------
// This captures the info needed to describe the pool.
// With the final solution, the area will be calculated from the
// point cloud, so the length & width fields will be unnecessary.
// But other stuff like the shape description and pool shape are
// needed for lookups and for some calculations (e.g. the width
// of the border/overlap is 12" per side for geometric pools,
// and 18" per side for freeform pools (so 3' total overlap width).
//
// TODO
//  - Add a field to capture the units (e.g. feet, meters)
//----------------------------------------------------------
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
                capturePoolShape_Rectangle(length: longLength, width: longWidth)

            case .oval:
                capturePoolShape_Oval(length: longLength, width: longWidth)

            case .grecian:
                capturePoolShape_Grecian(length: longLength, width: longWidth)

            case .roman:
                capturePoolShape_Roman(length: longLength, width: longWidth)

            case .truel:
                capturePoolShape_TrueL(longLength: longLength, longWidth: longWidth, shortLength: shortLength, shortWidth: shortWidth)

            case .lazyl:
                capturePoolShape_LazyL(longLength: longLength, longWidth: longWidth, shortLength: shortLength, shortWidth: shortWidth, longDiagLength: longDiagLength, shortDiagLength: shortDiagLength)

            case .oasis:
                capturePoolShape_Oasis(length: longLength, width: longWidth)

            case .tahiti:
                capturePoolShape_Tahiti(length: longLength, width: longWidth)

            case .lagoon:
                capturePoolShape_Lagoon(longLength: longLength, longWidth: longWidth, shortLength: shortLength, shortWidth: shortWidth)
                
            default:
                return
        }
    }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_Rectangle(length: Double, width: Double) {
        self.longLength = length
        self.longWidth = width
        
        self.areaPool = (Double)(longLength * longWidth)
        
        //self.areaCover = getCoverArea_Rectangle()
        self.areaCover = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 2.0)
        self.perimeter = getPerimeter_Rectangle()

        self.shapeDescription = .geometric
    }

    //---------------------------
    //---------------------------
    // func getCoverArea_Rectangle() -> Double {
    //     let totalOverlap: Double = 2.0
    //     //let area: Double = (Double)((totalOverlap + longLength) * (totalOverlap + longWidth))
    //     //getAreaWithOverlap_Rectangle(totalOverlap)
    //     getAreaWithOverlap(self.longLength, self.longWidth, totalOverlap)
    //     return area
    // }

    //---------------------------
    //---------------------------
    // func getCoverArea_FreeformRectangle() -> Double {
    //     let totalOverlap: Double = 3.0
    //     getAreaWithOverlap(self.longLength, self.longWidth, totalOverlap)
    //     return area
    // }
    
    //---------------------------
    //---------------------------
     func getPerimeter_Rectangle() -> Double {
         let p: Double = (2 * longLength) + (2 * longWidth)
         return p
     }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_Oval(length: Double, width: Double) {
        self.longLength = length
        self.longWidth = width
        
        // TODO - This is obviously not correct
        self.areaPool = (Double)(self.longLength * self.longWidth)
        
        //self.areaCover = getCoverArea_Rectangle()
        areaCover = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 2.0)

        // TODO - This is obviously not correct
        //self.perimeter = getPerimeter_Rectangle()

        shapeDescription = .geometric
    }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_Grecian(length: Double, width: Double) {
        self.longLength = length
        self.longWidth = width
        
        // TODO - This is obviously not correct
        self.areaPool = (Double)(self.longLength * self.longWidth)
        
        //self.areaCover = getCoverArea_Rectangle()
        self.areaCover = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 2.0)

        // TODO - This is obviously not correct
        //self.perimeter = getPerimeter_Rectangle()

        self.shapeDescription = .geometric
    }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_Roman(length: Double, width: Double) {
        self.longLength = length
        self.longWidth = width
        
        // TODO - This is obviously not correct
        self.areaPool = (Double)(self.longLength * self.longWidth)
        
        //self.areaCover = getCoverArea_Rectangle()
        self.areaCover = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 2.0)

        // TODO - This is obviously not correct
        //self.perimeter = getPerimeter_Rectangle()

        self.shapeDescription = .geometric
    }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_TrueL(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double) {
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
    }
    
    //---------------------------
    //---------------------------
    func getCoverArea_TrueL() -> Double {
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
    func getPerimeter_TrueL() -> Double {
        let p: Double = (longWidth + shortWidth + (longWidth - shortWidth)) + (longLength + shortLength + (longLength - shortLength))
        return p
    }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_LazyL(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double, longDiagLength: Double, shortDiagLength: Double) {
        self.longLength = longLength
        self.longWidth = longWidth

        self.shortLength = shortLength
        self.shortWidth = shortWidth
        
        self.longDiagLength = longDiagLength
        self.shortDiagLength = shortDiagLength

        self.shapeDescription = .geometric
        
        self.areaPool = getPoolArea_LazyL()
        self.areaCover = getCoverArea_LazyL()

        self.perimeter = getPerimeter_LazyL()
    }

    //---------------------------
    //---------------------------
    func getCoverArea_LazyL() -> Double {
        // Full overlap width
        let fow: Double = 2.0
        
        // Half overlap width
        // This is half of the full (actual) overlap width because the area
        // calculation double-counts it.
        // I'm not convinced that this isn't a bug but whatever, it's Latham's
        // calc and we'll replace this with the real value from the scanner...
        let how: Double = (fow / 2)
        
        let area: Double = getArea_LazyL(a: longWidth + fow, x1: longLength + how, w1: longDiagLength + how, a1: shortWidth + fow, v3: shortDiagLength + how, t: shortLength + how)
        
        return area
    }
    
    //---------------------------
    //---------------------------
    func getPoolArea_LazyL() -> Double {
        let area: Double = getArea_LazyL(a: longWidth, x1: longLength, w1: longDiagLength, a1: shortWidth, v3: shortDiagLength, t: shortLength)
        return area
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
    func getArea_LazyL(a: Double, x1: Double, w1: Double, a1: Double, v3: Double, t: Double) -> Double {
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
    func getPerimeter_LazyL() -> Double {
        let p: Double = (longLength + longWidth + shortLength + shortWidth + longDiagLength + shortDiagLength)
        return p
    }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_Oasis(length: Double, width: Double) {
        self.longLength = length
        self.longWidth = width
        
        // TODO - This is obviously not correct
        //self.areaPool = (Double)(longLength * longWidth)
        
        //self.areaCover = getCoverArea_FreeformRectangle()
        self.areaCover = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 3.0)

        // TODO - This is obviously not correct
        //self.perimeter = getPerimeter_Rectangle()

        self.shapeDescription = .freeform
    }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_Tahiti(length: Double, width: Double) {
        self.longLength = length
        self.longWidth = width
        
        // TODO - This is obviously not correct
        //self.areaPool = (Double)(longLength * longWidth)
        
        //self.areaCover = getCoverArea_FreeformRectangle()
        self.areaCover = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 3.0)

        // TODO - This is obviously not correct
        //self.perimeter = getPerimeter_Rectangle()

        self.shapeDescription = .freeform
    }

    //---------------------------
    //---------------------------
    mutating func capturePoolShape_Lagoon(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double) {
        self.longLength = longLength
        self.longWidth = longWidth

        self.shortLength = shortLength
        self.shortWidth = shortWidth
        
        // TODO - This is obviously not correct
        //self.areaPool = (Double)(longLength * longWidth)
        self.areaPool = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 0)
        self.areaPool += getAreaWithOverlap(length: self.shortLength, width: self.shortWidth, totalOverlap: 0)
        
        //self.areaCover = getCoverArea_FreeformRectangle()
        self.areaCover = getAreaWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 3.0)
        self.areaCover += getAreaWithOverlap(length: self.shortLength, width: self.shortWidth, totalOverlap: 3.0)

        // TODO - This is obviously not correct
        //self.perimeter = getPerimeter_Rectangle()

        self.shapeDescription = .freeform
    }

    //---------------------------
    //---------------------------
    func getAreaWithOverlap(length: Double, width: Double, totalOverlap: Double) -> Double {
        let area: Double = (Double)((totalOverlap + length) * (totalOverlap + width))
        return area
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
