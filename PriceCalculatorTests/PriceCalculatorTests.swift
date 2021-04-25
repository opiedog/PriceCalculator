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
        
        let area: Double = areaDims.areaCover
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

        let area: Double = areaDims.areaCover
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

        let area: Double = areaDims.areaCover
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

        let area: Double = areaDims.areaCover
        
        // Area is the actual size val plus a constant border amount (e.g. 2) - so (1 + 2) x (1 + 2) == 9
        let areaExpected: Double = 9
        XCTAssertEqual(areaExpected, area)

        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setAreaDimensions(areaDimensions: areaDims)
        
        // Calculate the price
        calculator.calculatePrice()
        let expectedPrice = 37.26
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)
        
        printTestResult(area: areaExpected, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: expectedPrice)
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

        let area: Double = areaDims.areaCover
        let areaExpected: Double = 270
        XCTAssertEqual(areaExpected, area)

        // Calculate the price
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setAreaDimensions(areaDimensions: areaDims)
        
        calculator.calculatePrice()
        let expectedPrice = 1117.8
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        printTestResult(area: areaExpected, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: expectedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool3() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let l: Double = 10
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: l, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.areaCover
        let areaExpected: Double = 270
        XCTAssertEqual(areaExpected, area)

        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
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

        let expectedPrice = 1432.83
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)
        //XCTAssertEqual(1432.83, roundToHundredth(value: calculator.priceResult.calculatedPrice))

//        let scModel = SafetyCoverModel.StandardMesh5000M
//        let scSize = SafetyCoverPanelSize.fivebyfive
//        let expectedPrice = 1117.8
        printTestResult(area: areaExpected, safetyCoverModel: scModel, panelSize: scSize, optionList: options, price: expectedPrice)

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

        let area: Double = areaDims.areaCover
        XCTAssertEqual(916.8472, roundToTenThousandth(value: area))

        // Calculate the price
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.StandardMesh5000M, safetyCoverPanelSize: SafetyCoverPanelSize.fivebyfive)
        calculator.setAreaDimensions(areaDimensions: areaDims)

        calculator.calculatePrice()
        XCTAssertEqual(2099.5801, roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_FullPerimeter_LawnTube_geo_270() throws {
        let l: Double = 10.0
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let safetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let safetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        
        let optionName = "Full Perimeter Anchor - Lawn Tubes"
        let qty = 1
        
        let amount = testSingleItemPrice_rect_area_core(lengthFractionalFoot: l, widthFractionalFoot: w, safetyCoverModel: safetyCoverModel, safetyCoverPanelSize: safetyCoverPanelSize, optionName: optionName, quantity: qty)
        
        XCTAssertEqual(99.9, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_FasteningSystem_DRings_geo_205() throws {
        let l: Double = 10.0
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let safetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let safetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        
        let optionName = "Double D-Rings (Non-buckle) Option/not updgrade"
        let qty = 1
        
        let amount = testSingleItemPrice_rect_area_core(lengthFractionalFoot: l, widthFractionalFoot: w, safetyCoverModel: safetyCoverModel, safetyCoverPanelSize: safetyCoverPanelSize, optionName: optionName, quantity: qty)
        
        XCTAssertEqual(61.5, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_rect_area_core(lengthFractionalFoot: Double, widthFractionalFoot: Double, safetyCoverModel: SafetyCoverModel, safetyCoverPanelSize: SafetyCoverPanelSize, optionName: String, quantity: Int) -> Double {
        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: lengthFractionalFoot, longWidth: widthFractionalFoot, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: safetyCoverModel, safetyCoverPanelSize: safetyCoverPanelSize)
        calculator.setAreaDimensions(areaDimensions: areaDims)

        // Set the options
        var optionItem = SafetyCoverOptionItem()
        optionItem.name = optionName
        var selectedOption: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem)
        selectedOption.quantity = quantity

        var options = [SafetyCoverOptionSelection]()
        options.append(selectedOption)
                
        let amount: Double = calculator.getTotalForOptionsList(selectedOptions: options)
        return amount
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeter_LawnTube_1() throws {
        // Set the options
        var optionItem = SafetyCoverOptionItem()
        optionItem.name = "Partial Perimeter Anchor - Lawn Tubes"
        var selectedOption: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem)
        selectedOption.quantity = 1

        var options = [SafetyCoverOptionSelection]()
        options.append(selectedOption)
                
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.StandardMesh5000M, safetyCoverPanelSize: SafetyCoverPanelSize.fivebyfive)
        let amount: Double = calculator.getTotalForOptionsList(selectedOptions: options)
        XCTAssertEqual(2.89, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeter_LawnTube_15() throws {
        // Set the options
        var optionItem = SafetyCoverOptionItem()
        optionItem.name = "Partial Perimeter Anchor - Lawn Tubes"
        var selectedOption: SafetyCoverOptionSelection = SafetyCoverOptionSelection(optionItem: optionItem)
        selectedOption.quantity = 15

        var options = [SafetyCoverOptionSelection]()
        options.append(selectedOption)
                
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.StandardMesh5000M, safetyCoverPanelSize: SafetyCoverPanelSize.fivebyfive)
        let amount: Double = calculator.getTotalForOptionsList(selectedOptions: options)
        XCTAssertEqual(43.35, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testDictionary() throws {
        //struct XYZ {
        //}
        //var productOptionDict = [SafetyCoverPanelSize: SafetyCoverOptionItem]()
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPushToAPI() throws {
        typealias MsgType = (area: Double, safetyCoverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, price: Double)
        var msgs = [MsgType]()
        
        msgs.append(MsgType(area: 88.99, safetyCoverModel: SafetyCoverModel.HighShadeMesh7000M, panelSize: SafetyCoverPanelSize.fivebyfive, price: 123.45))
        msgs.append(MsgType(area: 777.88, safetyCoverModel: SafetyCoverModel.StandardMesh5000M, panelSize: SafetyCoverPanelSize.threebythree, price: 1987.65))

        for msg in msgs {
            printTestResult(area: msg.area, safetyCoverModel: msg.safetyCoverModel, panelSize: msg.panelSize, optionList: nil, price: msg.price)
        }
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
//    func printTestResult(area: Double, safetyCoverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, optionList: [SafetyCoverOptionSelection]?, price: Double) {
//        var optionMsg = ""
//        if optionList != nil {
//            optionMsg = "Selected Options: "
//            for optionItem in optionList! {
//                optionMsg += "\(optionItem.quantity) '\(optionItem.optionItem.name)'; "
//            }
//        }
//        let msg = ">>> Test Passed: For area: \(area); Product: '\(safetyCoverModel)'" + "; Panel Size: '\(panelSize)'" + "\(optionMsg) price: $\(price)"
//        print(msg)
//    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func printTestResult(area: Double, safetyCoverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, optionList: [SafetyCoverOptionSelection]?, price: Double) {
        var optionMsg = ""
        if optionList != nil {
            optionMsg = "Selected Options: "
            for optionItem in optionList! {
                optionMsg += "\(optionItem.quantity) '\(optionItem.optionItem.name)'; "
            }
        }
        let msg = "\(area)\\t'\(safetyCoverModel)'\\t'\(panelSize)'\\t\(optionMsg)\\t$\(price)"
        print(msg)
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
}
