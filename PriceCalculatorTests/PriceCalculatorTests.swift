//
//  PriceCalculatorTests.swift
//  PriceCalculatorTests
//
//  Created by John Tafoya on 4/15/21.
//

import XCTest
@testable import PriceCalculator

class PriceCalculatorTests: XCTestCase {
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

    //----------------------------------------------------
    //----------------------------------------------------
    func testRectanglularPoolAreaAndPerimeter1() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 1, longWidth: 1, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        let area: Double = areaDims.area
        XCTAssertEqual(9, area)
        
        let perimeter: Double = areaDims.perimeter
        XCTAssertEqual((1 * 2) + (1 * 2), perimeter)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testRectanglularPoolAreaAndPerimeter2() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let helper = MeasurementHelper()
        let w: Double = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        XCTAssertEqual(20.5, w)
        
        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.area
        XCTAssertEqual(270, area)
        
        let perimeter: Double = areaDims.perimeter
        XCTAssertEqual((20.5 * 2) + (10 * 2), perimeter)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testRectanglularPoolAreaAndPerimeter3() throws {
        let helper = MeasurementHelper()
        let B: Double = helper.feetAndInchesToFeet(footVal: 38, inchVal: 3)
        XCTAssertEqual(38.25, B)

        let A: Double = helper.feetAndInchesToFeet(footVal: 14, inchVal: 7)
        XCTAssertEqual(14.5833, roundToTenThousandth(value: A))
        
        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: B, longWidth: A, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.area
        XCTAssertEqual(roundToTenThousandth(value: 667.4792), roundToTenThousandth(value: area))
        
        let perimeter: Double = areaDims.perimeter
        XCTAssertEqual((B * 2) + (A * 2), perimeter)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool1() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // 1x1 pool
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 1, longWidth: 1, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.area
        
        // Area is the actual size val plus a constant border amount (e.g. 2) - so (1 + 2) x (1 + 2) == 9
        XCTAssertEqual(9, area)

        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.StandardMesh5000M, safetyCoverPanelSize: SafetyCoverPanelSize.fivebyfive)        
        calculator.setAreaDimensions(areaDimensions: areaDims)
        
        // Calculate the price
        calculator.calculatePrice()
        XCTAssertEqual(37.26, calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool2() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.area
        XCTAssertEqual(270, area)

        // Calculate the price
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.StandardMesh5000M, safetyCoverPanelSize: SafetyCoverPanelSize.fivebyfive)
        calculator.setAreaDimensions(areaDimensions: areaDims)
        
        calculator.calculatePrice()
        XCTAssertEqual(1117.8, calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool3() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.area
        XCTAssertEqual(270, area)

        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.StandardMesh5000M, safetyCoverPanelSize: SafetyCoverPanelSize.fivebyfive)
        calculator.setAreaDimensions(areaDimensions: areaDims)
        
        // Set the options
        var optionItem_step = SafetyCoverOptionItem()
        optionItem_step.name = "Step w/pads <= 8"
        var selectedOption_step: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem_step)
        selectedOption_step.quantity = 1

        var optionItem_fullPerimLawnTube = SafetyCoverOptionItem()
        optionItem_fullPerimLawnTube.name = "Full Perimeter Anchor - Lawn Tubes"
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

        XCTAssertEqual(1432.83, calculator.priceResult.calculatedPrice)
        
        /*********
        // Add 1 more option
        var optionItem_FastenSysDoubleDRings = SafetyCoverOptionItem()
        optionItem_FastenSysDoubleDRings.name = "Double D-Rings (Non-buckle) Option/not updgrade"
        var selectedOption_FastenSysDoubleDRings: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem_FastenSysDoubleDRings)
        selectedOption_FastenSysDoubleDRings.quantity = 15

        // Calculate the price again
        calculator.calculatePrice(safetyCoverModel: coverModel, safetyCoverPanelSize: panelSize, selectedOptions: options)

        XCTAssertEqual(1432.83, calculator.priceResult.calculatedPrice)
        *********/
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool4() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 19, inchVal: 11)
        let B = helper.feetAndInchesToFeet(footVal: 39, inchVal: 10)

        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: B, longWidth: A, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.area
        XCTAssertEqual(916.8472, roundToTenThousandth(value: area))

        // Calculate the price
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.StandardMesh5000M, safetyCoverPanelSize: SafetyCoverPanelSize.fivebyfive)
        calculator.setAreaDimensions(areaDimensions: areaDims)

        calculator.calculatePrice()
        XCTAssertEqual(2099.5801, roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeterLawnTube() throws {
        // Set the options
        var optionItem_partialPerimLawnTube = SafetyCoverOptionItem()
        optionItem_partialPerimLawnTube.name = "Partial Perimeter Anchor - Lawn Tubes"
        var selectedOption_partialPerimLawnTube: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem_partialPerimLawnTube)
        selectedOption_partialPerimLawnTube.quantity = 1
        
        
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
    func roundToTenThousandth(value: Double) -> Double {
        let rounded: Double = round(value * 10000) / 10000.0
        return rounded
    }
}
