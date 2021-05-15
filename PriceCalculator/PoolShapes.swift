//
//  PoolShapes.swift
//  PriceCalculator
//
//  Created by John Tafoya on 5/4/21.
//
//  **THIS MODULE IMPLEMENTS BUSINESS LOGIC**
//

import Foundation

enum ShapeDescription {
    case undefined
    case freeform
    case geometric
}

enum PoolShape {
    // Geometric/rectangle shapes from "SC Sq ft.pdf"
    case undefined
    case rectangle
    case oval
    case grecian
    case truel
    case lazyl
    case roman
    
    // Freeform shapes from "SC Sq ft.pdf"
    case oasis
    case tahiti
    case lagoon

    // Geometric/rectangle shapes from "Latham_Sq_Ft_Pricing Examples.pdf"
    case octagon

    // Freeform shapes from "Latham_Sq_Ft_Pricing Examples.pdf"
    case doublewidthrect
    //case kidney
    //case obliquecelebrity
}

//===========================================================
//===========================================================
class PoolBase {
    var shapeDescription: ShapeDescription = .geometric
    var areaPool: Double = 0
    var areaCover: Double = 0
    var perimeterPool: Double = 0
    
    init() {
        // This is somewhat arbitrary to use this as the default
        // but that's the gist of it. Subclasses can change it.
        shapeDescription = .geometric
        
        areaPool = 0
        areaCover = 0
        perimeterPool = 0
    }
    
    var isIrregular: Bool {
        (shapeDescription == ShapeDescription.freeform)
    }
}

//===========================================================
//===========================================================
class RectangleBase : PoolBase {
    var length: Double = 0      // B        // B        // X1
    var width: Double = 0       // A        // A1       // A

    override init() {
        super.init()

        self.length = 0
        self.width = 0
    }
    
    init(length: Double, width: Double) {
        super.init()
        
        self.length = length
        self.width = width
        
        calculateAreaPool()
        calculateAreaCover()
        calculatePerimeterPool()
    }
    
    //---------------------------
    //---------------------------
    func calculateAreaPool() {
        let totalCoverOverlap: Double = 0
        self.areaPool = getAreaRectWithOverlap(length: self.length, width: self.width, totalOverlap: totalCoverOverlap)

    }

    //---------------------------
    //---------------------------
    func calculateAreaCover() {
        let totalCoverOverlap: Double = 2.0
        self.areaCover = getAreaRectWithOverlap(length: self.length, width: self.width, totalOverlap: totalCoverOverlap)
    }

    //---------------------------
    //---------------------------
     func calculatePerimeterPool() {
        self.perimeterPool = (2 * self.length) + (2 * self.width)
     }
}

//===========================================================
//===========================================================
class Rectangle : RectangleBase {
    var poolShape: PoolShape = .rectangle
}

//===========================================================
class Oval : RectangleBase {
    var poolShape: PoolShape = .oval
}

//===========================================================
class Grecian : RectangleBase {
    var poolShape: PoolShape = .grecian
}

//===========================================================
class Roman : RectangleBase {
    var poolShape: PoolShape = .roman
}

//===========================================================
class Oasis : RectangleBase {
    var poolShape: PoolShape = .oasis

    //---------------------------
    //---------------------------
    override init(length: Double, width: Double) {
        super.init(length: length, width: width)
        
        self.shapeDescription = .freeform
    }
    
    //---------------------------
    //---------------------------
    override func calculateAreaCover() {
        let totalCoverOverlap: Double = 3.0
        self.areaCover = getAreaRectWithOverlap(length: self.length, width: self.width, totalOverlap: totalCoverOverlap)
    }
}

//===========================================================
class Tahiti : RectangleBase {
    private let _sd = ShapeDescription.freeform
    var poolShape: PoolShape = .tahiti

    //---------------------------
    //---------------------------
    override init(length: Double, width: Double) {
        super.init(length: length, width: width)

        self.shapeDescription = _sd
    }
    
    //---------------------------
    //---------------------------
    override func calculateAreaCover() {
        let totalCoverOverlap: Double = 3.0
        self.areaCover = getAreaRectWithOverlap(length: self.length, width: self.width, totalOverlap: totalCoverOverlap)
    }
}

//===========================================================
//  LINER POOL AREA CALCULATIONS
// Various shapes that have two different width dimensions, and that
// by definition have their pool areas calculated as a rectangle.
// This will work for at least the following shapes per "Latham_Sq_Ft_Pricing Examples.pdf"
// and the set in "shapes.zip" that we got from Will @ Latham.
//  Oblique Celebrity; kidney; Rio; Norlander / Cape May; Mountain Pond
//  Gemini / Omni / Oasis / Cypress; Mountain Lake / Crystal Lake
//  Liberty; Odyssey; Keyhole; Taormina; Sentra / Michigan
//===========================================================
class DoubleWidthRectangle : RectangleBase {
    private let _sd = ShapeDescription.freeform
    var poolShape: PoolShape = .doublewidthrect
    
    // For a certain set of pools of various freeform shapes, Latham defines the
    // shape as an overall length with two width values, one being greater than
    // the other.
    // In general, it's assumed that the width at the shallow end that is less
    // than the width at the deep end.
    // The calculation for area is defined as the length times the greater of
    // the two widths.
    // The greater of the two widths is captured in RectangleBase.width.
    // The lesser of the two widths is captured in this class in ._lesserWidth.
    // This value is not yet used but it's included here to hopefully
    // make things more clear to the implementation.
    private var _lesserWidth: Double = 0
    
    //---------------------------
    //---------------------------
    override init() {
        super.init()
        
        self.shapeDescription = _sd
    }
    
    //---------------------------
    //---------------------------
    init(length: Double, greaterWidth: Double, lesserWidth: Double) {
        super.init(length: length, width: greaterWidth)
        
        self.shapeDescription = _sd
        _lesserWidth = lesserWidth
        
        calculateAreaPool()
    }
    
    //---------------------------
    //---------------------------
    override func calculateAreaPool() {
        self.areaPool = getAreaRectWithOverlap(length: self.length, width: self.width, totalOverlap: 0)
    }
}

////===========================================================
//class ObliqueCelebrity: DoubleWidthRectangle {
//    private let _ps: PoolShape = .obliquecelebrity
//    
//    override init(length: Double, width: Double, lesserWidth: Double) {
//        super.init(length: length, width: width, lesserWidth: lesserWidth)
//        self.poolShape = _ps
//    }
//}

//===========================================================
class TrueL : PoolBase {
    //                              // These values/names are re "2021 US Safety Cover Calculator.xlsm" on the 'Setup' tab
    //                              // Rect     // TrueL    // LazyL
    // Something described by an enclosing rectangle
    var longLength: Double = 0      // B        // B        // X1
    var longWidth: Double = 0       // A        // A1       // A
    
    // True L
    var shortLength: Double = 0     //          // B7       // T
    var shortWidth: Double = 0      //          // A        // A1

    var totalOverlap: Double = 2.0
    var poolShape: PoolShape = .truel

    //---------------------------
    //---------------------------
    init(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double) {
        super.init()
        
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
        // We will add the overlap to each side since the cover must be bigger than the pool.
        // But with this L shape, we need to ignore the sides of the two separate areas of
        // the rectangles that cross over the pool surface.
        
        //                                             B                  A
        let area1 = getAreaRectWithOverlap(length: longLength, width: shortWidth, totalOverlap: totalOverlap)

        //                         B7                           A1             A
        let area2 = (Double) ((shortLength + totalOverlap) * (longWidth - shortWidth))
        //                                                    ^^^^^^^^^^^^^^^^^^^^^^
        //                                                    Note that this doesn't include the overlap
        //                                                    since this area is technically over the water.
        // We therefore can't use the standard getAreaRectWithOverlap function.

        let area = area1 + area2  // TODO - I don't think the Excel calculator includes the overlap
        
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
class LazyL : PoolBase {
    var poolShape: PoolShape = .lazyl
    
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

    // This is here to test/compare/contrast between the method Latham
    // uses in the Excel price calculator, and the method defined in
    // the "SC Sq ft.pdf" file they recently sent.
    // In Excel for covers, they use a technique to average the diffs of two
    // opposite edges. I'm calling this "different side averaging" or "DiffSideAvgerage"
    // I previously called this "ExcelCoverCalcMethod" but that gets confusing since
    // this same technique is used in the PDF for liners...
    var useDiffSideAverageMethod: Bool = true
    
    //---------------------------
    //---------------------------
    init(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double, longDiagLength: Double, shortDiagLength: Double) {
        super.init()
        
        self.longLength = longLength
        self.longWidth = longWidth

        self.shortLength = shortLength
        self.shortWidth = shortWidth
        
        self.longDiagLength = longDiagLength
        self.shortDiagLength = shortDiagLength
        
        calculateAreaPool()
        calculateAreaCover()

        calculatePerimeterPool()
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
        var how: Double = (fow / 2)
        if(!self.useDiffSideAverageMethod) {
            how = fow
        }

        let area: Double = getAreaBase(a: longWidth + fow, x1: longLength + how, w1: longDiagLength + how, a1: shortWidth + fow, v3: shortDiagLength + how, t: shortLength + how)
        
        self.areaCover = area
    }

    //
    func getAreaBase(a: Double, x1: Double, w1: Double, a1: Double, v3: Double, t: Double) -> Double {
        //let useExcelCoverCalcMethod: Bool = false
        
        var area: Double = 0
        if(self.useDiffSideAverageMethod) {
            area = getAreaBase_perExcelCoverCalculator(a: a, x1: x1, w1: w1, a1: a1, v3: v3, t: t)
        }
        else {
            area = getAreaBase_perSCSqFtPDF(a: a, x1: x1, w1: w1, a1: a1, v3: v3, t: t)
        }
        return area
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
    func getAreaBase_perExcelCoverCalculator(a: Double, x1: Double, w1: Double, a1: Double, v3: Double, t: Double) -> Double {
        let horizSquareArea: Double = ((a * (t + x1)) / 2)
        let slantSquareArea: Double = ((a1 * (v3 + w1)) / 2)
        
        let area: Double = horizSquareArea + slantSquareArea
        
        return area
    }

    //
    func getAreaBase_perSCSqFtPDF(a: Double, x1: Double, w1: Double, a1: Double, v3: Double, t: Double) -> Double {
        let horizSquareArea: Double = (a * t)
        let slantSquareArea: Double = (a1 * w1)
        
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
    func calculatePerimeterPool() {
        let p: Double = (longLength + longWidth + shortLength + shortWidth + longDiagLength + shortDiagLength)
        self.perimeterPool = p
    }
}

//===========================================================
//===========================================================
class Octagon : PoolBase {
    private let _sd: ShapeDescription = .geometric
    var poolShape: PoolShape = .octagon

    var radius: Double = 0
    
    init(radius: Double) {
        super.init()
        
        self.radius = radius
        
        calculateAreaPool()
        //calculateAreaCover()
    }

    //---------------------------
    //---------------------------
    func calculateAreaPool() {
        // area == pi * r squared
        self.areaPool = .pi * 6
    }

    //---------------------------
    //---------------------------
//    func calculateAreaCover() {
//        // TODO
//    }
}

// FREEFORM SHAPES
//===========================================================
// Biz Rule: Per "SC Sq ft.pdf": For freeform shapes:
//  - "Manufactured with approximately 18" overlap" (so 18" (1.5') per side, which means 3' total overlap)
//===========================================================
class Lagoon : PoolBase {
    private let _sd: ShapeDescription = .freeform
    var poolShape: PoolShape = .lagoon

    var longLength: Double = 0
    var longWidth: Double = 0
    
    var shortLength: Double = 0
    var shortWidth: Double = 0
    
    init(longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double) {
        super.init()
        
        self.shapeDescription = _sd
        
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
        self.areaPool = getAreaRectWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 0)
        self.areaPool += getAreaRectWithOverlap(length: self.shortLength, width: self.shortWidth, totalOverlap: 0)
    }

    //---------------------------
    //---------------------------
    func calculateAreaCover() {
        self.areaCover = getAreaRectWithOverlap(length: self.longLength, width: self.longWidth, totalOverlap: 3.0)
        self.areaCover += getAreaRectWithOverlap(length: self.shortLength, width: self.shortWidth, totalOverlap: 3.0)
    }

    //---------------------------
    //---------------------------
//     func calculatePerimeterPool() {
//        self.perimeterPool = (2 * self.length) + (2 * self.width)
//     }
}

//---------------------------
//---------------------------
func getAreaRectWithOverlap(length: Double, width: Double, totalOverlap: Double) -> Double {
    let area: Double = (Double)((totalOverlap + length) * (totalOverlap + width))
    return area
}

