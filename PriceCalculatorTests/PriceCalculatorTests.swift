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

        let poolShape: PoolShape = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: 1, longWidth: 1, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
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
        
        let poolShape: PoolShape = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

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
        
        let poolShape: PoolShape = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: B, longWidth: A, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.areaCover
        XCTAssertEqual(roundToTenThousandth(value: 667.4792), roundToTenThousandth(value: area))
        
        let perimeter: Double = areaDims.perimeter
        XCTAssertEqual((B * 2) + (A * 2), perimeter)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool1() throws {
        // Set the dimensions
        let poolShape: PoolShape = .rectangle

        // 1x1 pool
        let l: Double = 1
        let w: Double = 1
        let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: l, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

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
        
        printTestResult(length: l, width: w, area: calculator.priceResult.calculatedPrice, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: expectedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool2() throws {
        // Set the dimensions
        let poolShape: PoolShape = .rectangle

        // Set the dimensions of the pool and the pool type
        let l: Double = 10
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: l, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

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

        printTestResult(length: l, width: w, area: calculator.priceResult.calculatedPrice, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: expectedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool3() throws {
        // Set the dimensions
        let poolShape: PoolShape = .rectangle

        // Set the dimensions of the pool and the pool type
        let l: Double = 10
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: l, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.areaCover
        let areaExpected: Double = 270
        XCTAssertEqual(areaExpected, area)

        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setAreaDimensions(areaDimensions: areaDims)
        
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

        let expectedPrice = 1432.83
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        printTestResult(length: l, width: w, area: calculator.priceResult.calculatedPrice, safetyCoverModel: scModel, panelSize: scSize, optionList: options, price: expectedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool4() throws {
        // Set the dimensions
        let poolShape: PoolShape = .rectangle

        // Set the dimensions of the pool and the pool type
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 19, inchVal: 11)
        let B = helper.feetAndInchesToFeet(footVal: 39, inchVal: 10)

        let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: B, longWidth: A, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        let area: Double = areaDims.areaCover
        XCTAssertEqual(916.8472, roundToTenThousandth(value: area))

        // Calculate the price
        let scModel: SafetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setAreaDimensions(areaDimensions: areaDims)

        calculator.calculatePrice()
        XCTAssertEqual(2099.5801, roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        
        printTestResult(length: B, width: A, area: roundToHundredth(value: area), safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: roundToHundredth(value: calculator.priceResult.calculatedPrice))
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_FullPerimeter_LawnTube_geo_270() throws {
        let l: Double = 10.0
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let safetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let safetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        
        let optionName = "Lawn Tubes: (18\" aluminum for non secure/no sub-deck)"
        let qty = 1
        
        let amount = singleItemPrice_rect_area_core(lengthFractionalFoot: l, widthFractionalFoot: w, safetyCoverModel: safetyCoverModel, safetyCoverPanelSize: safetyCoverPanelSize, optionName: optionName, quantity: qty)
        
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
        
        let amount = singleItemPrice_rect_area_core(lengthFractionalFoot: l, widthFractionalFoot: w, safetyCoverModel: safetyCoverModel, safetyCoverPanelSize: safetyCoverPanelSize, optionName: optionName, quantity: qty)
        
        XCTAssertEqual(81.0, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func singleItemPrice_rect_area_core(lengthFractionalFoot: Double, widthFractionalFoot: Double, safetyCoverModel: SafetyCoverModel, safetyCoverPanelSize: SafetyCoverPanelSize, optionName: String, quantity: Int) -> Double {
        let poolShape: PoolShape = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: lengthFractionalFoot, longWidth: widthFractionalFoot, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

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
        let optionName: String = "Partial Perimeter Anchor - Lawn Tubes"
        let quantity: Int = 1
        let coverPanelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        let amount: Double = getPriceForSingleItem_PartialPerimeter_base(optionItemName: optionName, quantity: quantity, safetyCoverPanelSize: coverPanelSize)

        XCTAssertEqual(2.89, amount)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_PartialPerimeter_LawnTube_15() throws {
        // Set the options
        let optionName: String = "Partial Perimeter Anchor - Lawn Tubes"
        let quantity: Int = 15
        let coverPanelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive
        let amount: Double = getPriceForSingleItem_PartialPerimeter_base(optionItemName: optionName, quantity: quantity, safetyCoverPanelSize: coverPanelSize)

        XCTAssertEqual(43.35, amount)
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
        
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.undefined, safetyCoverPanelSize: safetyCoverPanelSize)

        // Set a 1x1 area
        let poolShape: PoolShape = .rectangle
        var areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: 1, longWidth: 1, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        // This avoids using the adjusted area (i.e. the area for the cover is greater than the area of the pool surface) in
        // the calculation since we're just testing the raw lookup value.
        areaDims.areaCover = areaDims.areaPool
        //areaDims.shapeDescription = shapeDescription
        calculator.setAreaDimensions(areaDimensions: areaDims)

        let amount: Double = calculator.getTotalForOptionsList(selectedOptions: options)
        
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
        let poolShape: PoolShape = .rectangle
        var areaDims: AreaDimensions = AreaDimensions(poolShape: poolShape, longLength: 1, longWidth: sqFeet, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        // This avoids using the adjusted area (i.e. the area for the cover is greater than the area of the pool surface) in
        // the calculation since we're just testing the raw lookup value.
        areaDims.areaCover = areaDims.areaPool

        areaDims.shapeDescription = shapeDescription

        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setAreaDimensions(areaDimensions: areaDims)
        
        // Get the price
        let actualPrice: Double = calculator.getUnitPriceForArea()
        
        return actualPrice
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func printTestResult(length: Double, width: Double, area: Double, safetyCoverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, optionList: [SafetyCoverOptionSelection]?, price: Double) {
        var optionMsg = ""
        if optionList != nil {
            optionMsg = "Selected Options: "
            for optionItem in optionList! {
                optionMsg += "\(optionItem.quantity) '\(optionItem.optionItem.name)'; "
            }
        }
        let msg = ">>> Test Passed: For pool [length, width, area]: [\(length), \(width), \(area)]; Product: '\(safetyCoverModel)'" + "; Panel Size: '\(panelSize)'" + "\(optionMsg) price: $\(price)"
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
//            printTestResult(area: msg.area, safetyCoverModel: msg.safetyCoverModel, panelSize: msg.panelSize, optionList: nil, price: msg.price)
//        }
//    }
}
