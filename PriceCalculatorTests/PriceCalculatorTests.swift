//
//  PriceCalculatorTests.swift
//  PriceCalculatorTests
//
//  Created by John Tafoya on 4/15/21.
//

import XCTest
@testable import PriceCalculator

class PriceCalculatorTests: XCTestCase {
    enum PriceType {
        case adder_only
        case per_unit_area
        case per_pool_size
    }
    //----------------------------------------------------
    //----------------------------------------------------
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    //----------------------------------------------------
    //----------------------------------------------------
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
    func testPoolAreaAndPerimeter_Rectangle2() throws {
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
    func testPoolAreaAndPerimeter_Rectangle3() throws {
        let helper = MeasurementHelper()
        let B: Double = helper.feetAndInchesToFeet(footVal: 38, inchVal: 3)
        XCTAssertEqual(38.25, B)

        let A: Double = helper.feetAndInchesToFeet(footVal: 14, inchVal: 7)
        XCTAssertEqual(14.5833, roundToTenThousandth(value: A))
        
        let rect = Rectangle(length: B, width: A)
        
        let areaPool: Double = rect.areaPool
        XCTAssertEqual(557.8125, roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(667.4792, roundToTenThousandth(value: areaCover))

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
        XCTAssertEqual(544, roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(648, roundToTenThousandth(value: areaCover))

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
        XCTAssertEqual(684, roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(800, roundToTenThousandth(value: areaCover))

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
        XCTAssertEqual(527, roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(627, roundToTenThousandth(value: areaCover))

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
        XCTAssertEqual(576, roundToTenThousandth(value: areaPool))
        
        let areaCover: Double = rect.areaCover
        XCTAssertEqual(684, roundToTenThousandth(value: areaCover))

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
        XCTAssertEqual(49, roundToTenThousandth(value: areaCoverActual))
        
        //let areaPoolExpected: Double = roundToTenThousandth(value: (((B - B7) * A) + (A1 * B7)))
        let areaPoolExpected: Double = 25
        XCTAssertEqual(areaPoolExpected, roundToTenThousandth(value: trueL.areaPool))
        
        let perimeterExpected: Double = roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = roundToHundredth(value: trueL.perimeterPool)
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
        XCTAssertEqual(72, roundToTenThousandth(value: areaCoverActual))
        
        let areaPoolExpected: Double = roundToTenThousandth(value: (((B - B7) * A) + (A1 * B7)))
        XCTAssertEqual(areaPoolExpected, roundToTenThousandth(value: trueL.areaPool))
        
        let perimeterExpected: Double = roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = roundToHundredth(value: trueL.perimeterPool)
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
        XCTAssertEqual(763.4861, roundToTenThousandth(value: areaCoverActual))
        
        let areaPoolExpected: Double = roundToTenThousandth(value: (((B - B7) * A) + (A1 * B7)))
        XCTAssertEqual(areaPoolExpected, roundToTenThousandth(value: trueL.areaPool))
        
        let perimeterExpected: Double = roundToHundredth(value: (B + A1 + B7 + (A1 - A) + (B - B7) + A))
        let perimeterActual: Double = roundToHundredth(value: trueL.perimeterPool)
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
            XCTAssertEqual(12, roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(18, roundToTenThousandth(value: areaCoverActual))
        }

        let areaPoolExpected: Double = 2
        XCTAssertEqual(roundToTenThousandth(value: areaPoolExpected), roundToTenThousandth(value: lazyL.areaPool))

        let perimeterExpected: Double = 6
        let perimeterActual: Double = roundToHundredth(value: lazyL.perimeter)
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
            XCTAssertEqual(31.2132, roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(41.2132, roundToTenThousandth(value: areaCoverActual))
        }

        let areaPoolExpected: Double = 12.727926
        XCTAssertEqual(roundToTenThousandth(value: areaPoolExpected), roundToTenThousandth(value: lazyL.areaPool))

        let perimeterExpected: Double = roundToHundredth(value: (A + X1 + W1 + A1 + V3 + T))
        let perimeterActual: Double = roundToHundredth(value: lazyL.perimeter)
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
            XCTAssertEqual(489.3507, roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(523.1806, roundToTenThousandth(value: areaCoverActual))
        }

//        let areaPoolExpected: Double = 1
//        XCTAssertEqual(roundToTenThousandth(value: areaPoolExpected), roundToTenThousandth(value: lazyL.areaPool))
//
//        let perimeterExpected: Double = 1
//        let perimeterActual: Double = roundToHundredth(value: lazyL.perimeter)
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
        XCTAssertEqual(roundToTenThousandth(value: areaPoolExpected), roundToTenThousandth(value: lazyL.areaPool))

        let areaCoverActual: Double = lazyL.areaCover
        if(lazyL.useDiffSideAvgerageMethod) {
            XCTAssertEqual(576, roundToTenThousandth(value: areaCoverActual))
        }
        else {
            XCTAssertEqual(612, roundToTenThousandth(value: areaCoverActual))
        }
        
        let perimeterExpected: Double = (A + T + V3 + A1 + W1 + X1)
        let perimeterActual: Double = roundToHundredth(value: lazyL.perimeter)
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
        XCTAssertEqual(703, roundToTenThousandth(value: area))

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
        XCTAssertEqual(735, roundToTenThousandth(value: area))

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
        XCTAssertEqual(950, roundToTenThousandth(value: area))

        //area = areaDims.areaPool
        //XCTAssertEqual(704, roundToTenThousandth(value: area))
        
        // let perimeter: Double = areaDims.perimeter
        // XCTAssertEqual(100, perimeter)

        XCTAssertEqual(ShapeDescription.freeform, lagoon.shapeDescription)
    }

    // PRICE CHECKS
    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool1() throws {
        // Set the dimensions
        // 1x1 pool
        let l: Double = 1
        let w: Double = 1

        let pool = Rectangle(length: l, width: w)
        
        let area: Double = pool.areaCover
        
        // Area is the actual size val plus a constant border amount (e.g. 2) - so (1 + 2) x (1 + 2) == 9
        let areaExpected: Double = 9
        XCTAssertEqual(areaExpected, area)

        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)
        
        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice = 37.26
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)
        
        let dict: [String: Double] = ["A": l, "B": w]

        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool2() throws {
        // Set the dimensions of the pool and the pool type
        let l: Double = 10
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let pool = Rectangle(length: l, width: w)

        let area: Double = pool.areaCover
        let areaExpected: Double = 270
        XCTAssertEqual(areaExpected, area)

        // Calculate the price
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice = 1117.8
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool3() throws {
        // Set the dimensions of the pool and the pool type
        let l: Double = 10
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let pool = Rectangle(length: l, width: w)

        let area: Double = pool.areaCover
        let areaExpected: Double = 270
        XCTAssertEqual(areaExpected, area)

        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        // Set the options
        var optionItem_step = SafetyCoverOptionItem()
        optionItem_step.name = "Step w/pads <= 8'"
        var selectedOption_step: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem_step)
        selectedOption_step.quantity = 1

        var optionItem_fullPerimLawnTube = SafetyCoverOptionItem()
        optionItem_fullPerimLawnTube.name = "Lawn Tubes: (18\" aluminum for non secure/no sub-deck)"
        var selectedOption_fullPerimLawnTube: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem_fullPerimLawnTube)
        selectedOption_fullPerimLawnTube.quantity = 1

        var optionItem_partialPerimLawnTube = SafetyCoverOptionItem()
        optionItem_partialPerimLawnTube.name = "Partial Perimeter Anchor - Lawn Tubes"
        var selectedOption_partialPerimLawnTube: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem_partialPerimLawnTube)
        selectedOption_partialPerimLawnTube.quantity = 15

        var options = [SafetyCoverOptionSelection]()
        options.append(selectedOption_step)
        options.append(selectedOption_fullPerimLawnTube)
        options.append(selectedOption_partialPerimLawnTube)
        
        calculator.setSelectedOptions(selectedOptions: options)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        XCTAssertTrue(calculator.priceResult.wasSuccessful)

        let expectedPrice = 1432.83
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: options, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool4() throws {
        // Set the dimensions of the pool and the pool type
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 19, inchVal: 11)
        let B = helper.feetAndInchesToFeet(footVal: 39, inchVal: 10)

        let pool = Rectangle(length: B, width: A)

        let area: Double = pool.areaCover
        XCTAssertEqual(916.8472, roundToTenThousandth(value: area))

        // Calculate the price
        let scModel: SafetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        XCTAssertEqual(2099.5801, roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        
        let dict: [String: Double] = ["A": roundToHundredth(value: A), "B": roundToHundredth(value: B)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: roundToHundredth(value: area), dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: roundToHundredth(value: calculator.priceResult.calculatedPrice))
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceFor_TrueL_1() throws {
        // Set the dimensions of the pool and the pool type
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 13, inchVal: 2)
        let A1 = helper.feetAndInchesToFeet(footVal: 21, inchVal: 4)
        let B = helper.feetAndInchesToFeet(footVal: 42, inchVal: 5)
        let B7 = helper.feetAndInchesToFeet(footVal: 9, inchVal: 0)

        let pool = TrueL(longLength: B, longWidth: A1, shortLength: B7, shortWidth: A)

        let area: Double = pool.areaCover
        XCTAssertEqual(763.4861, roundToTenThousandth(value: area))

        // Calculate the price
        let scModel: SafetyCoverModel = SafetyCoverModel.HighShadeMesh7000MS
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.threebythree
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        XCTAssertEqual(2962.3261, roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        
        let dict: [String: Double] = ["A": roundToHundredth(value: A), "A1": roundToHundredth(value: A1), "B": roundToHundredth(value: B), "B7": roundToHundredth(value: B7)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: roundToHundredth(value: area), dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: roundToHundredth(value: calculator.priceResult.calculatedPrice))
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceFor_LazyL_1() throws {
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 11, inchVal: 8)
        let A1 = helper.feetAndInchesToFeet(footVal: 12, inchVal: 1)
        let T = helper.feetAndInchesToFeet(footVal: 15, inchVal: 6)
        let V3 = helper.feetAndInchesToFeet(footVal: 13, inchVal: 7)
        let W1 = helper.feetAndInchesToFeet(footVal: 18, inchVal: 2)
        let X1 = helper.feetAndInchesToFeet(footVal: 19, inchVal: 4)

        let pool = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let area: Double = pool.areaCover
        if(pool.useDiffSideAvgerageMethod) {
            XCTAssertEqual(489.3507, roundToTenThousandth(value: area))
        }
        else {
            XCTAssertEqual(523.1806, roundToTenThousandth(value: area))
        }

        // Calculate the price
        let scModel: SafetyCoverModel = SafetyCoverModel.MaxShadeMesh9000MX
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.threebythree
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        if(pool.useDiffSideAvgerageMethod) {
            XCTAssertEqual(2618.0262, roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        }
        else {
            XCTAssertEqual(2563.5847, roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        }

        let dict: [String: Double] = ["A": roundToHundredth(value: A), "A1": roundToHundredth(value: A1), "T": roundToHundredth(value: T), "V3": roundToHundredth(value: V3), "W1": roundToHundredth(value: W1), "X1": roundToHundredth(value: X1)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: roundToHundredth(value: area), dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: roundToHundredth(value: calculator.priceResult.calculatedPrice))
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceFor_LazyL_2() throws {
        let A: Double = 16
        let A1: Double = 16
        let T: Double = 24
        let V3: Double = 13
        let W1: Double = 6
        let X1: Double = 17

        let pool = LazyL(longLength: X1, longWidth: A, shortLength: T, shortWidth: A1, longDiagLength: W1, shortDiagLength: V3)

        let area: Double = pool.areaCover
        if(pool.useDiffSideAvgerageMethod) {
            XCTAssertEqual(576, roundToTenThousandth(value: area))
        }
        else {
            XCTAssertEqual(612, roundToTenThousandth(value: area))
        }

        // Calculate the price
        let scModel: SafetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        var optionItem = SafetyCoverOptionItem()
        optionItem.name = "Reverse Corner/Nose Pad (2'x2' sewn on)"
        var selectedOption: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem)
        selectedOption.quantity = 1
        // This should be $41.51
        let selectedOptionCostExpected: Double = 41.51

        var options = [SafetyCoverOptionSelection]()
        options.append(selectedOption)
        
        calculator.setSelectedOptions(selectedOptions: options)

        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        if(pool.useDiffSideAvgerageMethod) {
            XCTAssertEqual((1612.80 + selectedOptionCostExpected), roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        }
        else {
            XCTAssertEqual((1646.28 + selectedOptionCostExpected), roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        }

        let dict: [String: Double] = ["A": roundToHundredth(value: A), "A1": roundToHundredth(value: A1), "T": roundToHundredth(value: T), "V3": roundToHundredth(value: V3), "W1": roundToHundredth(value: W1), "X1": roundToHundredth(value: X1)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: roundToHundredth(value: area), dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: roundToHundredth(value: calculator.priceResult.calculatedPrice))
    }

    // SINGLE ITEM ADDERS
    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_FullPerimeter_LawnTube_geo_270() throws {
        let l: Double = 10.0
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)

        let scModel = SafetyCoverModel.undefined
        let scSize = SafetyCoverPanelSize.fivebyfive
        
        let optionName = "Lawn Tubes: (18\" aluminum for non secure/no sub-deck)"
        let qty = 1
        
        let amount = singleItemPrice_rect_area_core(lengthFractionalFoot: l, widthFractionalFoot: w, safetyCoverModel: scModel, safetyCoverPanelSize: scSize, optionName: optionName, quantity: qty)
        
        XCTAssertEqual(99.9, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_FasteningSystem_DRings_geo_205() throws {
        let helper = MeasurementHelper()
        let l = helper.feetAndInchesToFeet(footVal: 13, inchVal: 3)
        let w = helper.feetAndInchesToFeet(footVal: 19, inchVal: 11)

        let scModel = SafetyCoverModel.undefined
        let scSize = SafetyCoverPanelSize.threebythree
        
        let optionName = "Double D-Rings (Non-buckle) Option/not updgrade"
        let qty = 1
        
        let amount = singleItemPrice_rect_area_core(lengthFractionalFoot: l, widthFractionalFoot: w, safetyCoverModel: scModel, safetyCoverPanelSize: scSize, optionName: optionName, quantity: qty)
        let roundedAmount: Double = roundToHundredth(value: amount)
        
        XCTAssertEqual(116.98, roundedAmount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func singleItemPrice_rect_area_core(lengthFractionalFoot: Double, widthFractionalFoot: Double, safetyCoverModel: SafetyCoverModel, safetyCoverPanelSize: SafetyCoverPanelSize, optionName: String, quantity: Int) -> Double {
        //let poolShape: PoolShape = .rectangle
        //let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: lengthFractionalFoot, longWidth: widthFractionalFoot, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        let pool = Rectangle(length: lengthFractionalFoot, width: widthFractionalFoot)

        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: safetyCoverModel, safetyCoverPanelSize: safetyCoverPanelSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        // Set the options
        var optionItem = SafetyCoverOptionItem()
        optionItem.name = optionName
        var selectedOption: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem)
        selectedOption.quantity = quantity

        var options = [SafetyCoverOptionSelection]()
        options.append(selectedOption)
                
        let amount: Double = calculator.getTotalForOptionsList(selectedOptions: options)
        
        let dict: [String: Double] = ["A": roundToHundredth(value: lengthFractionalFoot), "B": roundToHundredth(value: widthFractionalFoot)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: roundToHundredth(value: pool.areaCover), dimensionDict: dict, safetyCoverModel: safetyCoverModel, panelSize: safetyCoverPanelSize, optionList: options, price: amount)
        
        return amount
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeter_LawnTube_1() throws {
        // Set the options
        let optionName: String = "Partial Perimeter Anchor - Lawn Tubes"
        let quantity: Int = 1
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.threebythree
        let amount: Double = getPriceForSingleItem_PartialPerimeter_base(optionItemName: optionName, quantity: quantity, safetyCoverPanelSize: scSize)

        XCTAssertEqual(4.33, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeter_LawnTube_15() throws {
        // Set the options
        let optionName: String = "Partial Perimeter Anchor - Lawn Tubes"
        let quantity: Int = 15
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        let amount: Double = getPriceForSingleItem_PartialPerimeter_base(optionItemName: optionName, quantity: quantity, safetyCoverPanelSize: scSize)

        XCTAssertEqual(43.35, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeter_RDMSystem_1() throws {
        // Set the options
        let optionName: String = "RDM System  (Anchor system for decks 20\" - 35\")"
        let quantity: Int = 1
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.threebythree
        let amount: Double = getPriceForSingleItem_PartialPerimeter_base(optionItemName: optionName, quantity: quantity, safetyCoverPanelSize: scSize)

        XCTAssertEqual(9.52, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeter_DeckTube_1() throws {
        // Set the options
        let optionName: String = "Deck Tube (10\" stainless steel for secure/sub deck)"
        let quantity: Int = 1
        let coverPanelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        let amount: Double = getPriceForSingleItem_PartialPerimeter_base(optionItemName: optionName, quantity: quantity, safetyCoverPanelSize: coverPanelSize)

        XCTAssertEqual(4.73, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeter_WoodDeckAnchors_1() throws {
        // Set the options
        let optionName: String = "Wood Deck Anchors (includes 4 screws) - Partial Perim"
        let quantity: Int = 1
        let coverPanelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.threebythree
        let amount: Double = getPriceForSingleItem_PartialPerimeter_base(optionItemName: optionName, quantity: quantity, safetyCoverPanelSize: coverPanelSize)

        XCTAssertEqual(3.64, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func getPriceForSingleItem_PartialPerimeter_base(optionItemName: String, quantity: Int, safetyCoverPanelSize: SafetyCoverPanelSize) -> Double {
        var optionItem = SafetyCoverOptionItem()
        optionItem.name = optionItemName
        var selectedOption: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem)
        selectedOption.quantity = quantity

        var options = [SafetyCoverOptionSelection]()
        options.append(selectedOption)
        
        let scModel: SafetyCoverModel = SafetyCoverModel.undefined
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: safetyCoverPanelSize)

        // Set a 1x1 area
        let a: Double = 1
        let b: Double = 1
        let pool = Rectangle(length: a, width: b)
        
        // This avoids using the adjusted area (i.e. the area for the cover is greater than the area of the pool surface) in
        // the calculation since we're just testing the raw lookup value.
        pool.areaCover = pool.areaPool
        calculator.setArea(area: pool.areaCover)

        let amount: Double = calculator.getTotalForOptionsList(selectedOptions: options)
        let roundedAmount: Double = roundToHundredth(value: amount)
        
        let dict: [String: Double] = ["A": a, "B": b]
        printTestResultForLathamValidation(priceType: PriceType.adder_only, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: 1, dimensionDict: dict, safetyCoverModel: scModel, panelSize: safetyCoverPanelSize, optionList: options, price: roundedAmount)

        return amount
    }
    
    // COVER MATERIAL TESTS
    // 5000
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_StMesh5000M_5x5_geo_1() throws {
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 4.14

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_StMesh5000M_5x5_geo_612() throws {
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 612
        let expectedPrice = 2.69

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_StMesh5000M_5x5_geo_2000() throws {
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 2000   // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 1.94

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_StMesh5000M_3x3_geo_1() throws {
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 4.88

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_StMesh5000M_3x3_freeform_1() throws {
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 5.99

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.freeform, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    // 7000
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_HighShadeMesh7000MS_5x5_geo_1() throws {
        let scModel = SafetyCoverModel.HighShadeMesh7000MS
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 4.90

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_HighShadeMesh7000MS_5x5_geo_2000() throws {
        let scModel = SafetyCoverModel.HighShadeMesh7000MS
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 2000   // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 2.48

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_HighShadeMesh7000MS_3x3_geo_1() throws {
        let scModel = SafetyCoverModel.HighShadeMesh7000MS
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 5.54

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_HighShadeMesh7000MS_3x3_freeform_1() throws {
        let scModel = SafetyCoverModel.HighShadeMesh7000MS
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 7.66

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.freeform, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    // 9000
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_MaxShadeMesh9000MX_5x5_geo_1() throws {
        let scModel = SafetyCoverModel.MaxShadeMesh9000MX
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 5.72

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_MaxShadeMesh9000MX_5x5_geo_2000() throws {
        let scModel = SafetyCoverModel.MaxShadeMesh9000MX
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 2000   // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 3.03

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_MaxShadeMesh9000MX_3x3_geo_1() throws {
        let scModel = SafetyCoverModel.MaxShadeMesh9000MX
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 6.48

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_MaxShadeMesh9000MX_3x3_freeform_1() throws {
        let scModel = SafetyCoverModel.MaxShadeMesh9000MX
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 8.55

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.freeform, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    // 1000
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_HeavyDutySolid1000V_5x5_geo_1() throws {
        let scModel = SafetyCoverModel.HeavyDutySolid1000V
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 5.12

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_HeavyDutySolid1000V_5x5_geo_1000() throws {
        let scModel = SafetyCoverModel.HeavyDutySolid1000V
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 1000   // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 2.92

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_HeavyDutySolid1000V_3x3_geo_1() throws {
        let scModel = SafetyCoverModel.HeavyDutySolid1000V
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1                              // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 5.73

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_HeavyDutySolid1000V_3x3_freeform_1() throws {
        let scModel = SafetyCoverModel.HeavyDutySolid1000V
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 6.85

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.freeform, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    // 500
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_LiteSolid500P_5x5_geo_1() throws {
        let scModel = SafetyCoverModel.LiteSolid500P
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 4.86

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_LiteSolid500P_5x5_geo_1000() throws {
        let scModel = SafetyCoverModel.LiteSolid500P
        let scSize = SafetyCoverPanelSize.fivebyfive
        let sqFeet: Double = 1000   // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 2.58

        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_LiteSolid500P_3x3_geo_1() throws {
        let scModel = SafetyCoverModel.LiteSolid500P
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 5.41
        
        // Get the price
        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.geometric, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testUnitPrice_LiteSolid500P_3x3_freeform_1() throws {
        let scModel = SafetyCoverModel.LiteSolid500P
        let scSize = SafetyCoverPanelSize.threebythree
        let sqFeet: Double = 1      // Will be multiplied by longLength of 1 so we'll set this to whatever area we want to test
        let expectedPrice = 6.39

        let actualPrice: Double = getUnitPriceCoverMaterial_rect(scModel: scModel, scSize: scSize, shapeDescription: ShapeDescription.freeform, sqFeet: sqFeet)
        XCTAssertEqual(expectedPrice, actualPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func getUnitPriceCoverMaterial_rect(scModel: SafetyCoverModel, scSize: SafetyCoverPanelSize, shapeDescription: ShapeDescription, sqFeet: Double) -> Double {
        let l: Double = 1

        let pool = Rectangle(length: l, width: sqFeet)
        
        // This avoids using the adjusted area (i.e. the area for the cover is greater than the area of the pool surface) in
        // the calculation since we're just testing the raw lookup value.
        pool.areaCover = pool.areaPool

        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: shapeDescription)
        
        // Get the price
        let actualPrice: Double = calculator.getUnitPriceForArea()

        let roundedAmount: Double = roundToHundredth(value: actualPrice)
        
        let dict: [String: Double] = ["A": l, "B": sqFeet]
        printTestResultForLathamValidation(priceType: PriceType.per_unit_area, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: sqFeet, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: roundedAmount)

        return actualPrice
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func printTestResultForLathamValidation(priceType: PriceType, shapeDesc: ShapeDescription, shape: PoolShape, area: Double, dimensionDict: [String: Double],safetyCoverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, optionList: [SafetyCoverOptionSelection]?, price: Double) {
        var optionMsg = ""
        if optionList != nil {
            optionMsg = "Selected Option(s): "
            for optionItem in optionList! {
                optionMsg += "\(optionItem.quantity) '\(optionItem.optionItem.name)'; "
            }
        }
        
        var prefix: String = ">>> Test Passed: "
        
        switch priceType {
            case .adder_only:
                prefix = prefix + "Adder Item: "
                break
                
            case .per_unit_area:
                prefix = prefix + "For unit-price lookup for area '\(area) sq ft' - "
                
            case .per_pool_size:
                let dims: String = getDimensionStringForPoolShapeFromDict(shape: shape, dimensionDict: dimensionDict)
                prefix = prefix + "For \(shapeDesc) \(shape) pool area: \(area); Dimensions: \(dims); Cover product: '\(safetyCoverModel)'; "
        }
        
        let msg = prefix + "Panel Size: '\(panelSize)'; \(optionMsg) Price: $\(price)"
        
        print(msg)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func getDimensionStringForPoolShapeFromDict(shape: PoolShape, dimensionDict: [String: Double]) -> String {
        var dims: String = ""
        switch shape {
            case .rectangle:
                dims = "A: \(dimensionDict["A"]!), B: \(dimensionDict["B"]!)"
            case .truel:
                dims = "A: \(dimensionDict["A"]!), A1: \(dimensionDict["A1"]!), B: \(dimensionDict["B"]!), B7: \(dimensionDict["B7"]!)"
            case .lazyl:
                dims = "A: \(dimensionDict["A"]!), A1: \(dimensionDict["A1"]!), T: \(dimensionDict["T"]!), V3: \(dimensionDict["V3"]!), W1: \(dimensionDict["W1"]!), X1: \(dimensionDict["X1"]!)"
            default:
                break
        }
        return dims
    }

    //----------------------------------------------------
    //----------------------------------------------------
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    
    //----------------------------------------------------
    //----------------------------------------------------
    func roundToHundredth(value: Double) -> Double {
        let rounded: Double = round(value * 100) / 100.0
        return rounded
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func roundToTenThousandth(value: Double) -> Double {
        let rounded: Double = round(value * 10000) / 10000.0
        return rounded
    }

    //----------------------------------------------------
    //----------------------------------------------------
//    func testPushToAPI() {
//        typealias MsgType = (area: Double, safetyCoverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, price: Double)
//        var msgs = [MsgType]()
//
//        msgs.append(MsgType(area: 88.99, safetyCoverModel: SafetyCoverModel.HighShadeMesh7000MS, panelSize: SafetyCoverPanelSize.fivebyfive, price: 123.45))
//        msgs.append(MsgType(area: 777.88, safetyCoverModel: SafetyCoverModel.StandardMesh5000M, panelSize: SafetyCoverPanelSize.threebythree, price: 1987.65))
//
//        for msg in msgs {
//            printTestResultForLathamValidation(area: msg.area, safetyCoverModel: msg.safetyCoverModel, panelSize: msg.panelSize, optionList: nil, price: msg.price)
//        }
//    }
}
