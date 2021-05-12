//
//  PriceCalculatorTests.swift
//  PriceCalculatorTests
//
//  Created by John Tafoya on 4/15/21.
//
//  THIS MODULE IS FOR SAFETY COVERS - I should have named it SafetyCoverPriceCalculatorTests...
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

    // SAFETY COVER BIZ RULE TEST
    //----------------------------------------------------
    //----------------------------------------------------
    func testSafetyCoverSizeOverrideHappens() throws {
        // INPUTS
        let shapeDescription = ShapeDescription.freeform
        let scSize = SafetyCoverPanelSize.fivebyfive        // Not allowed by rule
        // END INPUTS

        let calc: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.undefined, safetyCoverPanelSize: scSize)
        calc.setPoolCharacteristics(shapeDescription: shapeDescription)
        
        XCTAssertEqual(SafetyCoverPanelSize.threebythree, calc.getSafetyCoverPanelSize())
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testSafetyCoverSizeOverrideNotNeededFreeform3x3() throws {
        // INPUTS
        let shapeDescription = ShapeDescription.freeform
        let scSize = SafetyCoverPanelSize.threebythree
        // END INPUTS

        let calc: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.undefined, safetyCoverPanelSize: scSize)
        calc.setPoolCharacteristics(shapeDescription: shapeDescription)
        
        XCTAssertEqual(SafetyCoverPanelSize.threebythree, calc.getSafetyCoverPanelSize())
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testSafetyCoverSizeOverrideNotNeededGeometric5x5() throws {
        // INPUTS
        let shapeDescription = ShapeDescription.geometric
        let scSize = SafetyCoverPanelSize.fivebyfive
        // END INPUTS

        let calc: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.undefined, safetyCoverPanelSize: scSize)
        calc.setPoolCharacteristics(shapeDescription: shapeDescription)
        
        XCTAssertEqual(SafetyCoverPanelSize.fivebyfive, calc.getSafetyCoverPanelSize())
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testSafetyCoverSizeOverrideNotNeededGeometric3x3() throws {
        // INPUTS
        let shapeDescription = ShapeDescription.geometric
        let scSize = SafetyCoverPanelSize.threebythree
        // END INPUTS

        let calc: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: SafetyCoverModel.undefined, safetyCoverPanelSize: scSize)
        calc.setPoolCharacteristics(shapeDescription: shapeDescription)
        
        XCTAssertEqual(SafetyCoverPanelSize.threebythree, calc.getSafetyCoverPanelSize())
    }

    // FUNCTIONAL TESTS
    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool1() throws {
        // INPUTS
        // 1x1 pool
        let l: Double = 1
        let w: Double = 1
        let pool = Rectangle(length: l, width: w)
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive

        // Area is the actual size val plus a constant border amount (e.g. 2) - so (1 + 2) x (1 + 2) == 9
        let areaExpected: Double = 9
        let dealerDiscountRate: Double = 0.06
        let expectedPriceNoDiscount = 37.26         // Without discount
        let expectedPriceWithDiscount = 35.0244     // With 6% discount
        // END INPUTS
                
        let area: Double = pool.areaCover
        XCTAssertEqual(areaExpected, area)
        
        // Test w/o discount
        let calculatorNoDiscount: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize, dealerDiscountPercentage: 0)
        calculatorNoDiscount.setArea(area: pool.areaCover)
        calculatorNoDiscount.setPoolCharacteristics(shapeDescription: pool.shapeDescription)
        
        calculatorNoDiscount.calculatePrice()
        XCTAssertTrue(calculatorNoDiscount.priceResult.wasSuccessful)
        XCTAssertEqual(expectedPriceNoDiscount, calculatorNoDiscount.priceResult.calculatedPrice)

        // Test with discount
        let calculatorWithDiscount: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize, dealerDiscountPercentage: dealerDiscountRate)
        calculatorWithDiscount.setArea(area: pool.areaCover)
        calculatorWithDiscount.setPoolCharacteristics(shapeDescription: pool.shapeDescription)
        
        calculatorWithDiscount.calculatePrice()
        XCTAssertTrue(calculatorWithDiscount.priceResult.wasSuccessful)
        XCTAssertEqual(expectedPriceWithDiscount, calculatorWithDiscount.priceResult.calculatedPrice)
        
        let dict: [String: Double] = ["A": l, "B": w]

        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: calculatorWithDiscount.priceResult.calculatedPrice, discount: dealerDiscountRate)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool2() throws {
        // INPUTS
        let l: Double = 10
        let helper = MeasurementHelper()
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        
        let pool = Rectangle(length: l, width: w)
        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive

        let area: Double = pool.areaCover
        let areaExpected: Double = 270

        let expectedPrice = 1117.8
        // END INPUTS

        XCTAssertEqual(areaExpected, area)

        // Calculate the price
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool3() throws {
        let helper = MeasurementHelper()

        // INPUTS
        let l: Double = 10
        let w = helper.feetAndInchesToFeet(footVal: 20, inchVal: 6)
        let pool = Rectangle(length: l, width: w)
        let areaExpected: Double = 270
        let option_name_qty_Inputs = [(name: "Step w/pads <= 8'", qty: 1),
                                      (name: "Lawn Tubes: (18\" aluminum for non secure/no sub-deck)", qty: 1),
                                      (name: "Partial Perimeter Anchor - Lawn Tubes", qty: 15)]
        let expectedPrice = 1432.83
        // END INPUTS

        let area: Double = pool.areaCover
        XCTAssertEqual(areaExpected, area)

        let scModel = SafetyCoverModel.StandardMesh5000M
        let scSize = SafetyCoverPanelSize.fivebyfive
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        // Set the options
        var options = [SafetyCoverOptionSelection]()
        for optInput in option_name_qty_Inputs {
            var optionItem = SafetyCoverOptionItem()
            optionItem.name = optInput.name
            var selectedOption = SafetyCoverOptionSelection(optionItem: optionItem)
            selectedOption.quantity = optInput.qty
            options.append(selectedOption)
        }

        calculator.setSelectedOptions(selectedOptions: options)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        XCTAssertTrue(calculator.priceResult.wasSuccessful)

        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: options, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool4() throws {
        // INPUTS
        let helper = MeasurementHelper()
        let A = helper.feetAndInchesToFeet(footVal: 19, inchVal: 11)
        let B = helper.feetAndInchesToFeet(footVal: 39, inchVal: 10)
        let areaExpected: Double = 916.8472

        let pool = Rectangle(length: B, width: A)
        let scModel: SafetyCoverModel = SafetyCoverModel.StandardMesh5000M
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.fivebyfive

        let area: Double = pool.areaCover
        let priceExpected: Double = 2099.5801
        // END INPUTS
        
        XCTAssertEqual(areaExpected, DoubleHelper.roundToTenThousandth(value: area))

        // Calculate the price
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        XCTAssertEqual(priceExpected, DoubleHelper.roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        
        let dict: [String: Double] = ["A": DoubleHelper.roundToHundredth(value: A), "B": DoubleHelper.roundToHundredth(value: B)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: DoubleHelper.roundToHundredth(value: area), dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: DoubleHelper.roundToHundredth(value: calculator.priceResult.calculatedPrice))
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceFor_TrueL_1() throws {
        let helper = MeasurementHelper()

        // INPUTS
        let A = helper.feetAndInchesToFeet(footVal: 13, inchVal: 2)
        let A1 = helper.feetAndInchesToFeet(footVal: 21, inchVal: 4)
        let B = helper.feetAndInchesToFeet(footVal: 42, inchVal: 5)
        let B7 = helper.feetAndInchesToFeet(footVal: 9, inchVal: 0)
        let scModel: SafetyCoverModel = SafetyCoverModel.HighShadeMesh7000MS
        let scSize: SafetyCoverPanelSize = SafetyCoverPanelSize.threebythree

        let areaCoverExpected: Double = 763.4861
        let coverPriceExpected: Double = 2962.3261
        // END INPUTS

        let pool = TrueL(longLength: B, longWidth: A1, shortLength: B7, shortWidth: A)

        let area: Double = pool.areaCover
        XCTAssertEqual(areaCoverExpected, DoubleHelper.roundToTenThousandth(value: area))

        // Calculate the price
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator(safetyCoverModel: scModel, safetyCoverPanelSize: scSize)
        calculator.setArea(area: pool.areaCover)
        calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        XCTAssertEqual(coverPriceExpected, DoubleHelper.roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        
        let dict: [String: Double] = ["A": DoubleHelper.roundToHundredth(value: A), "A1": DoubleHelper.roundToHundredth(value: A1), "B": DoubleHelper.roundToHundredth(value: B), "B7": DoubleHelper.roundToHundredth(value: B7)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: DoubleHelper.roundToHundredth(value: area), dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: DoubleHelper.roundToHundredth(value: calculator.priceResult.calculatedPrice))
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
            XCTAssertEqual(489.3507, DoubleHelper.roundToTenThousandth(value: area))
        }
        else {
            XCTAssertEqual(523.1806, DoubleHelper.roundToTenThousandth(value: area))
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
            XCTAssertEqual(2618.0262, DoubleHelper.roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        }
        else {
            XCTAssertEqual(2563.5847, DoubleHelper.roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        }

        let dict: [String: Double] = ["A": DoubleHelper.roundToHundredth(value: A), "A1": DoubleHelper.roundToHundredth(value: A1), "T": DoubleHelper.roundToHundredth(value: T), "V3": DoubleHelper.roundToHundredth(value: V3), "W1": DoubleHelper.roundToHundredth(value: W1), "X1": DoubleHelper.roundToHundredth(value: X1)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: DoubleHelper.roundToHundredth(value: area), dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: DoubleHelper.roundToHundredth(value: calculator.priceResult.calculatedPrice))
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
            XCTAssertEqual(576, DoubleHelper.roundToTenThousandth(value: area))
        }
        else {
            XCTAssertEqual(612, DoubleHelper.roundToTenThousandth(value: area))
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
            XCTAssertEqual((1612.80 + selectedOptionCostExpected), DoubleHelper.roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        }
        else {
            XCTAssertEqual((1646.28 + selectedOptionCostExpected), DoubleHelper.roundToTenThousandth(value: calculator.priceResult.calculatedPrice))
        }

        let dict: [String: Double] = ["A": DoubleHelper.roundToHundredth(value: A), "A1": DoubleHelper.roundToHundredth(value: A1), "T": DoubleHelper.roundToHundredth(value: T), "V3": DoubleHelper.roundToHundredth(value: V3), "W1": DoubleHelper.roundToHundredth(value: W1), "X1": DoubleHelper.roundToHundredth(value: X1)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: DoubleHelper.roundToHundredth(value: area), dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: DoubleHelper.roundToHundredth(value: calculator.priceResult.calculatedPrice))
    }

    // SINGLE ITEM ADDER UNIT TESTS
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
        let roundedAmount: Double = DoubleHelper.roundToHundredth(value: amount)
        
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
        
        let dict: [String: Double] = ["A": DoubleHelper.roundToHundredth(value: lengthFractionalFoot), "B": DoubleHelper.roundToHundredth(value: widthFractionalFoot)]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: DoubleHelper.roundToHundredth(value: pool.areaCover), dimensionDict: dict, safetyCoverModel: safetyCoverModel, panelSize: safetyCoverPanelSize, optionList: options, price: amount)
        
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
        let roundedAmount: Double = DoubleHelper.roundToHundredth(value: amount)
        
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

        let roundedAmount: Double = DoubleHelper.roundToHundredth(value: actualPrice)
        
        let dict: [String: Double] = ["A": l, "B": sqFeet]
        printTestResultForLathamValidation(priceType: PriceType.per_unit_area, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: sqFeet, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: roundedAmount)

        return actualPrice
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func printTestResultForLathamValidation(priceType: PriceType, shapeDesc: ShapeDescription, shape: PoolShape, area: Double, dimensionDict: [String: Double], safetyCoverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, optionList: [SafetyCoverOptionSelection]?, price: Double, discount: Double = 0) {
        var optionMsg = ""
        if optionList != nil {
            optionMsg = "Selected Option(s): "
            for optionItem in optionList! {
                optionMsg += "\(optionItem.quantity) '\(optionItem.optionItem.name)'; "
            }
        }
        
        var prefix: String = ">>> Test Passed (Cover): "
        
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
        
        var msg = prefix + "Panel Size: '\(panelSize)'; \(optionMsg) Price: $\(price)"
        if(discount > 0) {
            msg += " (with \(DoubleHelper.roundToHundredth(value: discount) * 100)% discount)."
        }
        else {
            msg += "."
        }
        
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

    
//    //----------------------------------------------------
//    //----------------------------------------------------
//    func roundToHundredth(value: Double) -> Double {
//        let rounded: Double = round(value * 100) / 100.0
//        return rounded
//    }
//
//    func roundToHundredth(value: Double) -> Double {
//        return DoubleHelper.roundToHundredth(value: value)
//    }
//
//    //----------------------------------------------------
//    //----------------------------------------------------
//    func roundToTenThousandth(value: Double) -> Double {
//        let rounded: Double = round(value * 10000) / 10000.0
//        return rounded
//    }
//    func roundToTenThousandth(value: Double) -> Double {
//        return DoubleHelper.roundToTenThousandth(value: value)
//    }

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
