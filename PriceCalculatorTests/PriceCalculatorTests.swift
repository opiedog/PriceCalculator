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

        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        
        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 1, longWidth: 1, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        calculator.setAreaDimensions(areaDimensions: areaDims)
        
        //let area: Double = calculator.getArea()
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

        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        let w: Double = calculator.convertToFeet(footVal: 20, inchVal: 6)
        XCTAssertEqual(20.5, w)
        
        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        calculator.setAreaDimensions(areaDimensions: areaDims)
        
        //let area: Double = calculator.getArea()
        let area: Double = areaDims.area
        XCTAssertEqual(270, area)
        
        let perimeter: Double = areaDims.perimeter
        XCTAssertEqual((20.5 * 2) + (10 * 2), perimeter)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testRectanglularPoolAreaAndPerimeter3() throws {
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()

        let B: Double = calculator.convertToFeet(footVal: 38, inchVal: 3)
        XCTAssertEqual(38.25, B)

        let A: Double = calculator.convertToFeet(footVal: 14, inchVal: 7)
        XCTAssertEqual(14.5833, roundToTenThousandth(value: A))
        
        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: B, longWidth: A, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        calculator.setAreaDimensions(areaDimensions: areaDims)
        //let area: Double = calculator.getArea()
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

        // Set the dimensions of the pool and the pool type
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        
        // 1x1 pool
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 1, longWidth: 1, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        calculator.setAreaDimensions(areaDimensions: areaDims)

        let area: Double = areaDims.area
        
        // Area is the actual size val plus a constant border amount (e.g. 2) - so (1 + 2) x (1 + 2) == 9
        XCTAssertEqual(9, area)

        // Set the core product to purchase
        let coverModel: SafetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let panelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        
        // Calculate the price
        calculator.calculatePrice(safetyCoverModel: coverModel, safetyCoverPanelSize: panelSize, selectedOptions: nil)

        XCTAssertEqual(37.26, calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool2() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        let w = calculator.convertToFeet(footVal: 20, inchVal: 6)
        
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        calculator.setAreaDimensions(areaDimensions: areaDims)

        let area: Double = areaDims.area
        XCTAssertEqual(270, area)

        // Set the core product to purchase
        let coverModel: SafetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let panelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        
        // Calculate the price
        calculator.calculatePrice(safetyCoverModel: coverModel, safetyCoverPanelSize: panelSize, selectedOptions: nil)

        XCTAssertEqual(1117.8, calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool3() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        let w = calculator.convertToFeet(footVal: 20, inchVal: 6)
        
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        calculator.setAreaDimensions(areaDimensions: areaDims)

        let area: Double = areaDims.area
        XCTAssertEqual(270, area)

        // Set the core product to purchase
        let coverModel: SafetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let panelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        
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

        // Calculate the price
        calculator.calculatePrice(safetyCoverModel: coverModel, safetyCoverPanelSize: panelSize, selectedOptions: options)

        XCTAssertEqual(1432.83, calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool4() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        let A = calculator.convertToFeet(footVal: 19, inchVal: 11)
        let B = calculator.convertToFeet(footVal: 39, inchVal: 10)

        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: B, longWidth: A, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        calculator.setAreaDimensions(areaDimensions: areaDims)

        let area: Double = areaDims.area
        XCTAssertEqual(916.8472, roundToTenThousandth(value: area))

        // Set the core product to purchase
        let coverModel: SafetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let panelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        
        // Set the options
        // TODO

        // Calculate the price
        calculator.calculatePrice(safetyCoverModel: coverModel, safetyCoverPanelSize: panelSize, selectedOptions: nil)

        XCTAssertEqual(2099.5801, roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
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
