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
        let l: Double = 1
        let w: Double = 1

        let rect = Rectangle(length: l, width: w)
        
        let areaPool: Double = rect.areaPool
        XCTAssertEqual(1, areaPool)
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(9, areaCover)

        let pActual: Double = rect.perimeterPool
        let pExpected: Double = (l * 2) + (w * 2)
        XCTAssertEqual(pExpected, pActual)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Rectangle10x20ish() throws {
        let l: Double = 10
        let helper = MeasurementHelper()
        let w: Double = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        XCTAssertEqual(20.5, w)

        let rect = Rectangle(length: l, width: w)

        let areaPool: Double = rect.areaPool
        XCTAssertEqual(205, areaPool)

        let areaCover: Double = rect.areaCover
        XCTAssertEqual(270, areaCover)

        let pActual: Double = rect.perimeterPool
        let pExpected: Double = (w * 2) + (l * 2)
        XCTAssertEqual(pExpected, pActual)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Rectangle38x14ish() throws {
        let helper = MeasurementHelper()
        let B: Double = helper.feetAndInchesToFeet(footVal: 38, inchVal: 3)
        XCTAssertEqual(38.25, B)

        let A: Double = helper.feetAndInchesToFeet(footVal: 14, inchVal: 7)
        XCTAssertEqual(14.5833, DoubleHelper.roundToTenThousandth(value: A))
        
        let rect = Rectangle(length: B, width: A)
        
        let areaPool: Double = rect.areaPool
        XCTAssertEqual(557.8125, DoubleHelper.roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(667.4792, DoubleHelper.roundToTenThousandth(value: areaCover))

        let pActual: Double = rect.perimeterPool
        let pExpected: Double = (B * 2) + (A * 2)
        XCTAssertEqual(pExpected, pActual)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Rectangle_34x16() throws {
        let B: Double = 34
        let A: Double = 16
        
        let rect = Rectangle(length: B, width: A)
        
        let areaPool: Double = rect.areaPool
        XCTAssertEqual(544, DoubleHelper.roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(648, DoubleHelper.roundToTenThousandth(value: areaCover))

        let pActual: Double = rect.perimeterPool
        let pExpected: Double = 100
        XCTAssertEqual(pExpected, pActual)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Oval_38x18() throws {
        let B: Double = 38
        let A: Double = 18

        let rect = Oval(length: B, width: A)
        
        let areaPool: Double = rect.areaPool
        XCTAssertEqual(684, DoubleHelper.roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(800, DoubleHelper.roundToTenThousandth(value: areaCover))

//        let pActual: Double = rect.perimeterPool
//        let pExpected: Double = 100
//        XCTAssertEqual(pExpected, pActual)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Grecian_31x17() throws {
        let B: Double = 31
        let A: Double = 17

        let rect = Grecian(length: B, width: A)
        
        let areaPool: Double = rect.areaPool
        XCTAssertEqual(527, DoubleHelper.roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(627, DoubleHelper.roundToTenThousandth(value: areaCover))

        //        let pActual: Double = rect.perimeterPool
        //        let pExpected: Double = 100
        //        XCTAssertEqual(pExpected, pActual)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Roman_36x16() throws {
        let B: Double = 36
        let A: Double = 16

        let rect = Grecian(length: B, width: A)
        
        let areaPool: Double = rect.areaPool
        XCTAssertEqual(576, DoubleHelper.roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(684, DoubleHelper.roundToTenThousandth(value: areaCover))

        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_TrueL1() throws {
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 5, inchVal: 0)
        let A1 = helper.feetAndInchesToFeet(footVal: 5, inchVal: 0)
        let B = helper.feetAndInchesToFeet(footVal: 5, inchVal: 0)
        let B7 = helper.feetAndInchesToFeet(footVal: 0, inchVal: 0)

        let trueL = TrueL(longLength: B, longWidth: A1, shortLength: B7, shortWidth: A)

        let areaCoverActual: Double = trueL.areaCover
        XCTAssertEqual(49, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        
        //let areaPoolExpected: Double = roundToTenThousandth(value: (((B - B7) * A) + (A1 * B7)))
        let areaPoolExpected: Double = 25
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: trueL.areaPool))
        
        let perimeterExpected: Double = DoubleHelper.roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: trueL.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(PoolShape.truel, trueL.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_TrueL2() throws {
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 3, inchVal: 0)
        let A1 = helper.feetAndInchesToFeet(footVal: 5, inchVal: 0)
        let B = helper.feetAndInchesToFeet(footVal: 10, inchVal: 0)
        let B7 = helper.feetAndInchesToFeet(footVal: 4, inchVal: 0)

        let trueL = TrueL(longLength: B, longWidth: A1, shortLength: B7, shortWidth: A)

        let areaCoverActual: Double = trueL.areaCover
        XCTAssertEqual(72, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        
        let areaPoolExpected: Double = DoubleHelper.roundToTenThousandth(value: (((B - B7) * A) + (A1 * B7)))
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: trueL.areaPool))
        
        let perimeterExpected: Double = DoubleHelper.roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: trueL.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(PoolShape.truel, trueL.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_TrueL3() throws {
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 13, inchVal: 2)
        let A1 = helper.feetAndInchesToFeet(footVal: 21, inchVal: 4)
        let B = helper.feetAndInchesToFeet(footVal: 42, inchVal: 5)
        let B7 = helper.feetAndInchesToFeet(footVal: 9, inchVal: 0)

        let trueL = TrueL(longLength: B, longWidth: A1, shortLength: B7, shortWidth: A)

        let areaCoverActual: Double = trueL.areaCover
        XCTAssertEqual(763.4861, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        
        let areaPoolExpected: Double = DoubleHelper.roundToTenThousandth(value: (((B - B7) * A) + (A1 * B7)))
        XCTAssertEqual(areaPoolExpected, DoubleHelper.roundToTenThousandth(value: trueL.areaPool))
        
        let perimeterExpected: Double = DoubleHelper.roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: trueL.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(PoolShape.truel, trueL.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_LazyL1() throws {
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let A1 = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let T = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let V3 = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let X1 = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)
        let W1 = helper.feetAndInchesToFeet(footVal: 1, inchVal: 0)

        let lazyL = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let areaCoverActual: Double = lazyL.areaCover
        if(lazyL.useDiffSideAvgerageMethod) {
            XCTAssertEqual(12, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(18, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }

        let areaPoolExpected: Double = 2
        XCTAssertEqual(DoubleHelper.roundToTenThousandth(value: areaPoolExpected), DoubleHelper.roundToTenThousandth(value: lazyL.areaPool))

        let perimeterExpected: Double = 6
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: lazyL.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(PoolShape.lazyl, lazyL.poolShape)
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

        let lazyL = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let areaCoverActual: Double = lazyL.areaCover
        if(lazyL.useDiffSideAvgerageMethod) {
            XCTAssertEqual(31.2132, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(41.2132, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }

        let areaPoolExpected: Double = 12.727926
        XCTAssertEqual(DoubleHelper.roundToTenThousandth(value: areaPoolExpected), DoubleHelper.roundToTenThousandth(value: lazyL.areaPool))

        let perimeterExpected: Double = DoubleHelper.roundToHundredth(value: (A + X1 + W1 + A1 + V3 + T))
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: lazyL.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(PoolShape.lazyl, lazyL.poolShape)
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

        let lazyL = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let areaCoverActual: Double = lazyL.areaCover
        if(lazyL.useDiffSideAvgerageMethod) {
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
        
        XCTAssertEqual(PoolShape.lazyl, lazyL.poolShape)
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

        let lazyL = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let areaPoolExpected: Double = ((A * T) + (W1 * A1))
        XCTAssertEqual(DoubleHelper.roundToTenThousandth(value: areaPoolExpected), DoubleHelper.roundToTenThousandth(value: lazyL.areaPool))

        let areaCoverActual: Double = lazyL.areaCover
        if(lazyL.useDiffSideAvgerageMethod) {
            XCTAssertEqual(576, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(612, DoubleHelper.roundToTenThousandth(value: areaCoverActual))
        }
        
        let perimeterExpected: Double = (A + T + V3 + A1 + W1 + X1)
        let perimeterActual: Double = DoubleHelper.roundToHundredth(value: lazyL.perimeterPool)
        XCTAssertEqual(perimeterExpected, perimeterActual)
        
        XCTAssertEqual(PoolShape.lazyl, lazyL.poolShape)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Oasis_34x16() throws {
        let B: Double = 34
        let A: Double = 16
        
        let oasis = Oasis(length: B, width: A)

        let area: Double = oasis.areaCover
        XCTAssertEqual(703, DoubleHelper.roundToTenThousandth(value: area))

        //area = areaDims.areaPool
        //XCTAssertEqual(544, roundToTenThousandth(value: area))
        
        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)

        XCTAssertEqual(ShapeDescription.freeform, oasis.shapeDescription)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Tahiti_32x18() throws {
        let B: Double = 32
        let A: Double = 18
        
        let tahiti = Tahiti(length: B, width: A)

        let area: Double = tahiti.areaCover
        XCTAssertEqual(735, DoubleHelper.roundToTenThousandth(value: area))

        //area = areaDims.areaPool
        //XCTAssertEqual(576, roundToTenThousandth(value: area))
        
        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)

        XCTAssertEqual(ShapeDescription.freeform, tahiti.shapeDescription)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_Lagoon_32x16_16x12() throws {
        let BL: Double = 32
        let AL: Double = 16
        let BS: Double = 16
        let AS: Double = 12
    
        let lagoon = Lagoon(longLength: BL, longWidth: AL, shortLength: BS, shortWidth: AS)

        let area: Double = lagoon.areaCover
        XCTAssertEqual(950, DoubleHelper.roundToTenThousandth(value: area))

        //area = areaDims.areaPool
        //XCTAssertEqual(704, roundToTenThousandth(value: area))
        
        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)

        XCTAssertEqual(ShapeDescription.freeform, lagoon.shapeDescription)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testPoolAreaAndPerimeter_DoubleWidthRectangle_1() throws {
        // INPUTS
        let l: Double = 1
        let w: Double = 1
        let wLesser: Double = 1
        let poolAreaExpected: Double = 1
        // END INPUTS

        let pool = DoubleWidthRectangle(length: l, greaterWidth: w, lesserWidth: wLesser)
        
        let areaPool: Double = pool.areaPool
        XCTAssertEqual(poolAreaExpected, areaPool)
        
//        let areaCover: Double = pool.areaCover
//        XCTAssertEqual(9, areaCover)
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
//        let coverAreaExpected: Double = 123.45
        // END INPUTS

        let pool = DoubleWidthRectangle(length: l, greaterWidth: w, lesserWidth: wLesser)

        let areaPool: Double = pool.areaPool
        XCTAssertEqual(poolAreaExpected, areaPool)

//        let areaCover: Double = pool.areaCover
//        XCTAssertEqual(coverAreaExpected, areaCover)
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
