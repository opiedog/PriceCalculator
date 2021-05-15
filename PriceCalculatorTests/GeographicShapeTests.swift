//
//  GeographicShapeTests.swift
//  PriceCalculatorTests
//
//  Created by John Tafoya on 5/12/21.
//

import XCTest
@testable import PriceCalculator

class GeographicShapeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // SIMPLE AREA AND PERIMETER TESTS
    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Rectangle1() throws {
        // INPUTS
        let l: Double = 1
        let w: Double = 1
        let areaPoolExpected: Double = 1
        let areaCoverExpected: Double = 9
        let perimeterPoolExpected: Double = ((w * 2) + (l * 2))
        let shapeDescriptionExpected = ShapeDescription.geometric
        let poolShapeExpected = PoolShape.rectangle
        // END INPUTS

        let pool = Rectangle(length: l, width: w)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(areaPoolExpected, areaPool)

        let areaCover: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, areaCover)

        let pActual: Double = pool.perimeterPool
        XCTAssertEqual(perimeterPoolExpected, pActual)
        
        XCTAssertEqual(shapeDescriptionExpected, pool.shapeDescription)
        XCTAssertEqual(poolShapeExpected, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Rectangle10x20ish() throws {
        let helper = MeasurementHelper()
        // INPUTS
        let l: Double = 10
        let w: Double = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        let areaPoolExpected: Double = 205
        let areaCoverExpected: Double = 270
        let perimeterPoolExpected: Double = ((w * 2) + (l * 2))
        let shapeDescriptionExpected = ShapeDescription.geometric
        let poolShapeExpected = PoolShape.rectangle
        // END INPUTS

        XCTAssertEqual(20.5, w)

        let pool = Rectangle(length: l, width: w)

        let areaPool: Double = pool.areaPool
        XCTAssertEqual(areaPoolExpected, areaPool)

        let areaCover: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, areaCover)

        let pActual: Double = pool.perimeterPool
        XCTAssertEqual(perimeterPoolExpected, pActual)
        
        XCTAssertEqual(shapeDescriptionExpected, pool.shapeDescription)
        XCTAssertEqual(poolShapeExpected, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Rectangle38x14ish() throws {
        let helper = MeasurementHelper()
        // INPUTS
        let A: Double = helper.feetAndInchesToFeet(footVal: 14, inchVal: 7)
        let B: Double = helper.feetAndInchesToFeet(footVal: 38, inchVal: 3)
        let areaPoolExpected: Double = 557.8125
        let areaCoverExpected: Double = 667.4792
        let perimeterPoolExpected: Double = ((B * 2) + (A * 2))
        let shapeDescriptionExpected = ShapeDescription.geometric
        let poolShapeExpected = PoolShape.rectangle
        // END INPUTS

        // Test DoubleHelper - this should be its own utest
        XCTAssertEqual(14.5833, DoubleHelper.roundToTenThousandth(value: A))
        XCTAssertEqual(38.25, B)
        
        let pool = Rectangle(length: B, width: A)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: areaPool))

        let areaCover: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: areaCover))

        let pActual: Double = pool.perimeterPool
        XCTAssertEqual(perimeterPoolExpected, pActual)
        
        XCTAssertEqual(shapeDescriptionExpected, pool.shapeDescription)
        XCTAssertEqual(poolShapeExpected, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Rectangle_34x16() throws {
        // INPUTS
        let B: Double = 34
        let A: Double = 16
        let areaPoolExpected: Double = 544
        let areaCoverExpected: Double = 648
        let perimeterPoolExpected: Double = 100
        let shapeDescriptionExpected = ShapeDescription.geometric
        let poolShapeExpected = PoolShape.rectangle
        // END INPUTS

        let pool = Rectangle(length: B, width: A)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: areaPool))

        let areaCover: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: areaCover))

        let pActual: Double = pool.perimeterPool
        XCTAssertEqual(perimeterPoolExpected, pActual)
        
        XCTAssertEqual(shapeDescriptionExpected, pool.shapeDescription)
        XCTAssertEqual(poolShapeExpected, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Oval_38x18() throws {
        // INPUTS
        let B: Double = 38
        let A: Double = 18
        let areaPoolExpected: Double = 684
        let areaCoverExpected: Double = 800
        //let perimeterPoolExpected: Double? = nil
        let shapeDescriptionExpected = ShapeDescription.geometric
        let poolShapeExpected = PoolShape.oval
        // END INPUTS

        let pool = Oval(length: B, width: A)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: areaPool))

        let areaCover: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: areaCover))

        //let pActual: Double = rect.perimeterPool
        //let pExpected: Double = 100
        //XCTAssertEqual(pExpected, pActual)
        
        XCTAssertEqual(shapeDescriptionExpected, pool.shapeDescription)
        XCTAssertEqual(poolShapeExpected, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Grecian_31x17() throws {
        // INPUTS
        let B: Double = 31
        let A: Double = 17
        let areaPoolExpected: Double = 527
        let areaCoverExpected: Double = 627
        //let perimeterPoolExpected: Double? = nil
        let shapeDescriptionExpected = ShapeDescription.geometric
        let poolShapeExpected = PoolShape.grecian
        // END INPUTS

        let pool = Grecian(length: B, width: A)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: areaPool))

        let areaCover: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: areaCover))

        //        let pActual: Double = rect.perimeterPool
        //        let pExpected: Double = 100
        //        XCTAssertEqual(pExpected, pActual)
        
        XCTAssertEqual(shapeDescriptionExpected, pool.shapeDescription)
        XCTAssertEqual(poolShapeExpected, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Roman_36x16() throws {
        // INPUTS
        let B: Double = 36
        let A: Double = 16
        let areaPoolExpected: Double = 576
        let areaCoverExpected: Double = 684
        //let perimeterPoolExpected: Double? = nil
        let shapeDescriptionExpected = ShapeDescription.geometric
        let poolShapeExpected = PoolShape.roman
        // END INPUTS

        let pool = Roman(length: B, width: A)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: areaPool))

        let areaCover: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: areaCover))

        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)
        
        XCTAssertEqual(shapeDescriptionExpected, pool.shapeDescription)
        XCTAssertEqual(poolShapeExpected, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_TrueL1() throws {
        // INPUTS
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 5, inchVal: 0)
        let A1 = helper.feetAndInchesToFeet(footVal: 5, inchVal: 0)
        let B = helper.feetAndInchesToFeet(footVal: 5, inchVal: 0)
        let B7 = helper.feetAndInchesToFeet(footVal: 0, inchVal: 0)
        let areaPoolExpected: Double = 25
        let areaCoverExpected: Double = 49
        // END INPUTS

        let pool = TrueL(longLength: B, longWidth: A1, shortLength: B7, shortWidth: A)

        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: pool.areaCover))
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: pool.areaPool))
        
        let perimeterExpected: Double = DoubleHelper.roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: pool.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(ShapeDescription.geometric, pool.shapeDescription)
        XCTAssertEqual(PoolShape.truel, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_TrueL2() throws {
        let helper = MeasurementHelper()
        // INPUTS
        let A = helper.feetAndInchesToFeet(footVal: 3, inchVal: 0)
        let A1 = helper.feetAndInchesToFeet(footVal: 5, inchVal: 0)
        let B = helper.feetAndInchesToFeet(footVal: 10, inchVal: 0)
        let B7 = helper.feetAndInchesToFeet(footVal: 4, inchVal: 0)
        let areaPoolExpected: Double = DoubleHelper.roundToTenThousandth(value: (((B - B7) * A) + (A1 * B7)))
        let areaCoverExpected: Double = 72
        // END INPUTS

        let pool = TrueL(longLength: B, longWidth: A1, shortLength: B7, shortWidth: A)

        let areaCoverActual: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: pool.areaPool))
        
        let perimeterExpected: Double = DoubleHelper.roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: pool.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(ShapeDescription.geometric, pool.shapeDescription)
        XCTAssertEqual(PoolShape.truel, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_TrueL3() throws {
        let helper = MeasurementHelper()
        // INPUTS
        let A = helper.feetAndInchesToFeet(footVal: 13, inchVal: 2)
        let A1 = helper.feetAndInchesToFeet(footVal: 21, inchVal: 4)
        let B = helper.feetAndInchesToFeet(footVal: 42, inchVal: 5)
        let B7 = helper.feetAndInchesToFeet(footVal: 9, inchVal: 0)
        let areaPoolExpected: Double = DoubleHelper.roundToTenThousandth(value: (((B - B7) * A) + (A1 * B7)))
        let areaCoverExpected: Double = 763.4861
        // END INPUTS

        let pool = TrueL(longLength: B, longWidth: A1, shortLength: B7, shortWidth: A)

        let areaCoverActual: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: pool.areaPool))
        
        let perimeterExpected: Double = DoubleHelper.roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: pool.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(ShapeDescription.geometric, pool.shapeDescription)
        XCTAssertEqual(PoolShape.truel, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_LazyL1() throws {
        let helper = MeasurementHelper()
        // INPUTS
        let A = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let A1 = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let T = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let V3 = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let X1 = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let W1 = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let areaPoolExpected: Double = 2
        let areaCoverDiffSideAvgExpected: Double = 12
        let areaCoverNOTDiffSideAvgExpected: Double = 18
        let perimeterExpected: Double = 6
        // END INPUTS
        
        let pool = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let areaCoverActual: Double = pool.areaCover
        if(pool.useDiffSideAverageMethod) {
            XCTAssertEqual(areaCoverDiffSideAvgExpected, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(areaCoverNOTDiffSideAvgExpected, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }

        XCTAssertEqual(DoubleHelper.roundToTenThousandth(value: areaPoolExpected), DoubleHelper.roundToTenThousandth(value: pool.areaPool))

        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: pool.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(ShapeDescription.geometric, pool.shapeDescription)
        XCTAssertEqual(PoolShape.lazyl, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_LazyL2() throws {
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 3, inchVal: 0)
        let A1 = helper.feetAndInchesToFeet(footVal: 3, inchVal: 0)
        let T = helper.feetAndInchesToFeet(footVal: 3, inchVal: 0)
        let V3 = helper.feetAndInchesToFeet(footVal: 3, inchVal: 0)
        let X1: Double = (3 * 0.414214)
        let W1: Double = (3 * 0.414214)

        let pool = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let areaCoverActual: Double = pool.areaCover
        if(pool.useDiffSideAverageMethod) {
            XCTAssertEqual(31.2132, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(41.2132, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }

        let areaPoolExpected: Double = 12.727926
        XCTAssertEqual(DoubleHelper.roundToTenThousandth(value: areaPoolExpected), DoubleHelper.roundToTenThousandth(value: pool.areaPool))

        let perimeterExpected: Double = DoubleHelper.roundToHundredth(value: (A + X1 + W1 + A1 + V3 + T))
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: pool.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(ShapeDescription.geometric, pool.shapeDescription)
        XCTAssertEqual(PoolShape.lazyl, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_LazyL3() throws {
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 11, inchVal: 8)
        let A1 = helper.feetAndInchesToFeet(footVal: 12, inchVal: 1)
        let T = helper.feetAndInchesToFeet(footVal: 15, inchVal: 6)
        let V3 = helper.feetAndInchesToFeet(footVal: 13, inchVal: 7)
        let W1 = helper.feetAndInchesToFeet(footVal: 18, inchVal: 2)
        let X1 = helper.feetAndInchesToFeet(footVal: 19, inchVal: 4)

        let pool = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let areaCoverActual: Double = pool.areaCover
        if(pool.useDiffSideAverageMethod) {
            XCTAssertEqual(489.3507, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(523.1806, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }

//        let areaPoolExpected: Double = 1
//        XCTAssertEqual(roundToTenThousandth(value: areaPoolExpected), roundToTenThousandth(value: lazyL.areaPool))
//
//        let perimeterExpected: Double = 1
//        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: lazyL.perimeter)
//        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(ShapeDescription.geometric, pool.shapeDescription)
        XCTAssertEqual(PoolShape.lazyl, pool.poolShape)
    }

    //----------------------------------------------------
    // These values are from "SC Sq ft.pdf"
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_LazyL4() throws {
        let A: Double = 16.0
        let A1: Double = 16.0
        let T: Double = 24.0
        let V3: Double = 13.0
        let W1: Double = 6.0
        let X1: Double = 17.0

        let pool = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let areaPoolExpected: Double = ((A * T) + (W1 * A1))
        XCTAssertEqual(DoubleHelper.roundToTenThousandth(value: areaPoolExpected), DoubleHelper.roundToTenThousandth(value: pool.areaPool))

        let areaCoverActual: Double = pool.areaCover
        if(pool.useDiffSideAverageMethod) {
            XCTAssertEqual(576, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(612, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        
        let perimeterExpected: Double = (A + T + V3 + A1 + W1 + X1)
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: pool.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(ShapeDescription.geometric, pool.shapeDescription)
        XCTAssertEqual(PoolShape.lazyl, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Oasis_34x16() throws {
        let B: Double = 34
        let A: Double = 16
        
        let pool = Oasis(length: B, width: A)

        let area: Double = pool.areaCover
        XCTAssertEqual(703, DoubleHelper.roundToTenThousandth(value: area))

        //area = areaDims.areaPool
        //XCTAssertEqual(544, roundToTenThousandth(value: area))
        
        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)

        XCTAssertEqual(ShapeDescription.freeform, pool.shapeDescription)
        XCTAssertEqual(PoolShape.oasis, pool.poolShape)
}

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Tahiti_32x18() throws {
        let B: Double = 32
        let A: Double = 18
        
        let pool = Tahiti(length: B, width: A)

        let area: Double = pool.areaCover
        XCTAssertEqual(735, DoubleHelper.roundToTenThousandth(value: area))

        //area = areaDims.areaPool
        //XCTAssertEqual(576, roundToTenThousandth(value: area))
        
        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)

        XCTAssertEqual(ShapeDescription.freeform, pool.shapeDescription)
        XCTAssertEqual(PoolShape.tahiti, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Lagoon_32x16_16x12() throws {
        let BL: Double = 32
        let AL: Double = 16
        let BS: Double = 16
        let AS: Double = 12
        let poolAreaExpected: Double = 950
        //let coverAreaExpected: Double? = nil
        //let perimeterExpected: Double? = nil
        let shapeDescExpected = ShapeDescription.freeform
        let shapeExpected = PoolShape.lagoon
        // END INPUTS

        let pool = Lagoon(longLength: BL, longWidth: AL, shortLength: BS, shortWidth: AS)

        let area: Double = pool.areaCover
        XCTAssertEqual(poolAreaExpected, DoubleHelper.roundToTenThousandth(value: area))

        //area = areaDims.areaPool
        //XCTAssertEqual(704, roundToTenThousandth(value: area))

        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)

        XCTAssertEqual(shapeDescExpected, pool.shapeDescription)
        XCTAssertEqual(shapeExpected, pool.poolShape)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_DoubleWidthRectangle_1() throws {
        // INPUTS
        let l: Double = 1
        let w: Double = 1
        let wLesser: Double = 1
        let poolAreaExpected: Double = 1
        //let coverAreaExpected: Double? = nil
        //let perimeterExpected: Double? = nil
        let shapeDescExpected = ShapeDescription.freeform
        let shapeExpected = PoolShape.doublewidthrect
        // END INPUTS

        let pool = DoubleWidthRectangle(length: l, greaterWidth: w, lesserWidth: wLesser)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(poolAreaExpected, areaPool)

//        let areaCover: Double = pool.areaCover
//        XCTAssertEqual(9, areaCover)

        XCTAssertEqual(shapeDescExpected, pool.shapeDescription)
        XCTAssertEqual(shapeExpected, pool.poolShape)
    }

    //let helper = MeasurementHelper()
    //helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_DoubleWidthRectangle_10x20ish() throws {
        // INPUTS
        let l: Double = 16
        let w: Double = 32
        let wLesser: Double = 13
        let poolAreaExpected: Double = 512
        //let coverAreaExpected: Double? = nil
        //let perimeterExpected: Double? = nil
        let shapeDescExpected = ShapeDescription.freeform
        let shapeExpected = PoolShape.doublewidthrect
        // END INPUTS

        let pool = DoubleWidthRectangle(length: l, greaterWidth: w, lesserWidth: wLesser)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(poolAreaExpected, areaPool)

//        let areaCover: Double = pool.areaCover
//        XCTAssertEqual(coverAreaExpected, areaCover)

        XCTAssertEqual(shapeDescExpected, pool.shapeDescription)
        XCTAssertEqual(shapeExpected, pool.poolShape)
    }

//    //----------------------------------------------------
//    //----------------------------------------------------
//    func processBase_DoubleWidthRect() throws {
//    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Octagon_r1() throws {
        // INPUTS
        let r: Double = 1
        let poolAreaExpected: Double = (.pi * pow(r, 2))
//        let coverAreaExpected: Double = 1234.56789
        let shapeDescExpected = ShapeDescription.geometric
        let shapeExpected = PoolShape.octagon
        // END INPUTS

        let pool = Octagon(radius: r)

        let areaPool: Double = pool.areaPool
        XCTAssertEqual(poolAreaExpected, areaPool)

//        let areaCover: Double = pool.areaCover
//        XCTAssertEqual(coverAreaExpected, areaCover)
        
        XCTAssertEqual(shapeDescExpected, pool.shapeDescription)
        XCTAssertEqual(shapeExpected, pool.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Octagon_r6point5() throws {
        // INPUTS
        let r: Double = 6.5
        let poolAreaExpected: Double = (.pi * pow(r, 2))
//        let coverAreaExpected: Double = 1234.56789
        let shapeDescExpected = ShapeDescription.geometric
        let shapeExpected = PoolShape.octagon
        // END INPUTS

        let pool = Octagon(radius: r)

        let areaPool: Double = pool.areaPool
        XCTAssertEqual(poolAreaExpected, areaPool)

//        let areaCover: Double = pool.areaCover
//        XCTAssertEqual(coverAreaExpected, areaCover)
        
        XCTAssertEqual(shapeDescExpected, pool.shapeDescription)
        XCTAssertEqual(shapeExpected, pool.poolShape)
    }

//    //----------------------------------------------------
//    //----------------------------------------------------
//    func testPoolAreaAndPerimeter_ObliqueCelebrity_10x20ish() throws {
//        // INPUTS
//        let l: Double = 16
//        let w: Double = 32
//        let wLesser: Double = 13
//        let poolAreaExpected: Double = 512
////        let coverAreaExpected: Double = 123.45
//        // END INPUTS
//
//        let pool = ObliqueCelebrity(length: l, width: w, lesserWidth: wLesser)
//
//        let areaPool: Double = pool.areaPool
//        XCTAssertEqual(poolAreaExpected, areaPool)
//
////        let areaCover: Double = pool.areaCover
////        XCTAssertEqual(coverAreaExpected, areaCover)
//    }
}
