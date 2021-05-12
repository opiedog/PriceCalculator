//
//  LinerPriceCalculatorTests.swift
//  PriceCalculatorTests
//
//  Created by John Tafoya on 5/4/21.
//

import XCTest
@testable import PriceCalculator

class LinerPriceCalculatorTests: XCTestCase {
    enum PriceType {
        case adder_only
        case per_unit_area
        case per_pool_size
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // IRREGULAR POOL SHAPE STUFF
    //----------------------------------------------------
    //----------------------------------------------------
    func testIrregularPoolShapeUpchargeAmount() throws {
        let upchargeAmtExpected: Double = 177.00
        
        let calc = LinerPriceCalculator(pool: nil, area: 0, linerBrand: LinerBrand.undefined)
        XCTAssertEqual(upchargeAmtExpected, calc.getFreeformIrregularShapeChargeAmount())
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testCalculatorPoolIrregularity() throws {
        var pool: PoolBase? = nil
        
        let calc_pool_nil = LinerPriceCalculator(pool: pool, area: 0, linerBrand: LinerBrand.undefined)
        XCTAssertFalse(calc_pool_nil.isIrregularPool)

        pool = PoolBase()
        let calc_pool_default = LinerPriceCalculator(pool: pool, area: 0, linerBrand: LinerBrand.undefined)
        XCTAssertFalse(calc_pool_default.isIrregularPool)

        pool!.shapeDescription = .geometric
        let calc_pool_geo = LinerPriceCalculator(pool: pool, area: 0, linerBrand: LinerBrand.undefined)
        XCTAssertFalse(calc_pool_geo.isIrregularPool)

        pool!.shapeDescription = .freeform
        let calc_pool_freeform = LinerPriceCalculator(pool: pool, area: 0, linerBrand: LinerBrand.undefined)
        XCTAssertTrue(calc_pool_freeform.isIrregularPool)
    }
    
    // ADDER PRICE CHECKS
    // Vinyl Over Stairs and Swimouts
    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_VinylOverStairs_Less12ft_SingleTreadBench_1() throws {
        // Set the options
        let optionName: String = "<12' (Rod Pockets, Hook/Loop or Beaded)"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.SingleTreadOrBench

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(313.00, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_VinylOverStairs_Less12ft_SingleTreadBench_3() throws {
        // Set the options
        let optionName: String = "<12' (Rod Pockets, Hook/Loop or Beaded)"
        let quantity: Int = 3
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.SingleTreadOrBench

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual((3 * 313.00), amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_VinylOverStairs_Less12ft_StraightRoman_1() throws {
        // Set the options
        let optionName: String = "<12' (Rod Pockets, Hook/Loop or Beaded)"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.StraightOrRomanStep

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(418.00, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }
    
    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_VinylOverStairs_Less12ft_FreeformWedding_1() throws {
        // Set the options
        let optionName: String = "<12' (Rod Pockets, Hook/Loop or Beaded)"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.FreeformOrWeddingCake

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(441.00, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_VinylOverStairs_12to20ft_SingleTreadBench_1() throws {
        // Set the options
        let optionName: String = "=12' of < 20' (Rod Pockets, Hook/Loop or Beaded)"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.SingleTreadOrBench

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(577, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_VinylOverStairs_20ftPlus_FreeformWedding_1() throws {
        // Set the options
        let optionName: String = "= 20' or Larger (Rod Pockets, Hook/Loop or Beaded)"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.FreeformOrWeddingCake

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(836, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_VinylOverStairs_CustomTileOnRisers_1() throws {
        // Set the options
        let optionName: String = "Custom Tile on Risers or Treads and Risers in Different Colors (Mix and Match)"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.SingleTreadOrBench

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(182, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_VinylOverStairs_StairsSwimOutsHiLiteStripeAtEdge_1() throws {
        // Set the options
        let optionName: String = "Stairs and Swim Outs with Hi-Lite Stripe at Edge of Tread"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.SingleTreadOrBench

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(56, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }
    
    // Add On Charges
    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_AddOnCharges_Depth9ftPlus_1() throws {
        // Set the options
        let optionName: String = "Depth greater than 9 feet"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.SingleTreadOrBench

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(167, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }

    // Special Options
    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_SpecialOptions_FlatBottomDeduction_1() throws {
        // Set the options
        let optionName: String = "Flat Bottom (Depth=wall height up to 60\") (Deduction)"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.SingleTreadOrBench

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.linerDeductionPercentage
        XCTAssertEqual(-0.1, amount)
        
        XCTAssertEqual(PriceUnit.percentage, optionSet.priceUnit)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testSingleItemPrice_AddOnCharges_CantedWallsCovedBottoms_1() throws {
        // Set the options
        let optionName: String = "Canted (Non-Plumb Side Walls) or Coved bottoms"
        let quantity: Int = 1
        let uom = UnitOfMeasure.each
        let stairSwimoutOption = StairAndSwimoutOption.SingleTreadOrBench

        let optionSet: LinerOptionsTotalPriceSet = getAmountSingleItemPrice_base(optionName: optionName, stairSwimoutOption: stairSwimoutOption, uom: uom, quantity: quantity)
        
        let amount: Double = optionSet.optionsTotalPrice
        XCTAssertEqual(139, amount)
        
        XCTAssertEqual(PriceUnit.currency, optionSet.priceUnit)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func getAmountSingleItemPrice_base(optionName: String, stairSwimoutOption: StairAndSwimoutOption, uom: UnitOfMeasure, quantity: Int) -> LinerOptionsTotalPriceSet {
        var option = LinerOptionItem()
        option.name = optionName
        option.stairSwimoutOption = stairSwimoutOption
        option.uom = uom
        
        var optionSel = LinerOptionSelection(optionItem: option)
        optionSel.quantity = quantity
        let options: [LinerOptionSelection] = [optionSel]

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: PoolBase(), area: 0, linerBrand: LinerBrand.undefined)
        
        let linerOptionSet: LinerOptionsTotalPriceSet = calculator.getTotalForOptionsList(selectedOptions: options)
        return linerOptionSet
    }

    // LINER BASE-PRICE CHECKS
    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_Latham_1() throws {
        // Set the dimensions
        // 1x1 pool
        let l: Double = 1
        let w: Double = 1
        let brand = LinerBrand.Latham
        let areaExpected: Double = (l * w)

        let pool = Rectangle(length: l, width: w)

        XCTAssertEqual(areaExpected, pool.areaPool)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: brand)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice: Double = 345
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, linerBrand: brand, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_Latham_100() throws {
        // Set the dimensions
        let l: Double = 1
        let w: Double = 100
        let brand = LinerBrand.Latham
        let areaExpected: Double = (l * w)

        let pool = Rectangle(length: l, width: w)
        XCTAssertEqual(areaExpected, pool.areaPool)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: brand)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice: Double = (3.45 * areaExpected) //345.00
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, linerBrand: brand, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_Latham_1248() throws {
        // Set the dimensions
        // 1x1 pool
        let l: Double = 1
        let w: Double = 1248
        let brand = LinerBrand.Latham
        let areaExpected: Double = (l * w)

        let pool = Rectangle(length: l, width: w)
        XCTAssertEqual(w, pool.areaPool)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: brand)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice: Double = (2.82 * areaExpected) //3519.36
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, linerBrand: brand, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_Premier_1() throws {
        // Set the dimensions
        // 1x1 pool
        let l: Double = 1
        let w: Double = 1
        let brand = LinerBrand.Premier
        let areaExpected: Double = (l * w)

        let pool = Rectangle(length: l, width: w)
        XCTAssertEqual(areaExpected, pool.areaPool)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: brand)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice: Double = 345
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, linerBrand: brand, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_Premier_100() throws {
        // Set the dimensions
        // 1x1 pool
        let l: Double = 1
        let w: Double = 100
        let brand = LinerBrand.Premier
        let areaExpected: Double = (l * w)

        let pool = Rectangle(length: l, width: w)
        XCTAssertEqual(areaExpected, pool.areaPool)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: brand)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice: Double = (3.45 * areaExpected) //1055.70
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, linerBrand: brand, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_Premier_1248() throws {
        // Set the dimensions
        // 1x1 pool
        let l: Double = 1
        let w: Double = 1248
        let brand = LinerBrand.Premier
        let areaExpected: Double = (l * w)

        let pool = Rectangle(length: l, width: w)
        XCTAssertEqual(w, pool.areaPool)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: brand)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice: Double = (2.82 * areaExpected) //$3,519.36
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, linerBrand: brand, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    // FUNCTIONAL TESTS
    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_WithAdders_Latham_100() throws {
        // INPUTS
        let l: Double = 10.25
        let w: Double = 20.5
        let pool = Rectangle(length: l, width: w)
        let brand = LinerBrand.Latham
        let areaExpected: Double = (l * w)
        let discountRate: Double = 0.07 // 7%
        let option_name_qty_Inputs = [(name: "<12' (Rod Pockets, Hook/Loop or Beaded)", stairSwimoutOption: StairAndSwimoutOption.StraightOrRomanStep, qty: 1),
                                      (name: "Solid Color Break Stripe at Shallow End Break-Off", stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, qty: 1)]
        
        //let expectedPrice: Double = (3.45 * areaExpected) //724.9313
        // This is diff from immediately above due to the weird rounding Latham
        // does in the Excel calculator (they round the (l*w) product)
        //let expectedPrice: Double = 724.95    // without options, no discountrate
        //let expectedPrice: Double = 1233.95     // with options, no discountrate
        let expectedPrice: Double = 1147.57     // with options, with discount
        // END INPUTS

        XCTAssertEqual(areaExpected, pool.areaPool)

        // Populate the options
        var options = [LinerOptionSelection]()
        for optInput in option_name_qty_Inputs {
            var optionItem = LinerOptionItem()
            optionItem.name = optInput.name
            optionItem.stairSwimoutOption = optInput.stairSwimoutOption
            var selectedOption = LinerOptionSelection(optionItem: optionItem)
            selectedOption.quantity = optInput.qty
            options.append(selectedOption)
        }

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: brand, dealerDiscountPercentage: discountRate)
        calculator.setSelectedOptions(selectedOptions: options)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)

        XCTAssertEqual(expectedPrice, DoubleHelper.roundToHundredth(value: calculator.priceResult.calculatedPrice))

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, linerBrand: brand, optionList: nil, price: calculator.priceResult.calculatedPrice, discount: discountRate)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPrice_DoubleWidthRectangle_NoAdders_Latham_512() throws {
        // INPUTS
        let l: Double = 16
        let w: Double = 32
        let wLesser: Double = (w - 1)    // Not actually important - just setting to an amt less than "w"
        let pool = DoubleWidthRectangle(length: l, width: w, lesserWidth: wLesser)
        let brand = LinerBrand.Latham
        let areaExpected: Double = (l * w)
        let discountRate: Double = 0
        let expectedPrice: Double = 1718.12
        // END INPUTS

        XCTAssertEqual(areaExpected, pool.areaPool)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: brand, dealerDiscountPercentage: discountRate)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)

        XCTAssertEqual(expectedPrice, DoubleHelper.roundToHundredth(value: calculator.priceResult.calculatedPrice))

        let dict: [String: Double] = ["A": l, "B": w]
        printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, linerBrand: brand, optionList: nil, price: calculator.priceResult.calculatedPrice, discount: discountRate)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    //----------------------------------------------------
    //----------------------------------------------------
    func printTestResultForLathamValidation(priceType: PriceType, shapeDesc: ShapeDescription, shape: PoolShape, area: Double, dimensionDict: [String: Double], linerBrand: LinerBrand, optionList: [SafetyCoverOptionSelection]?, price: Double, discount: Double = 0) {
        var optionMsg = ""
        if optionList != nil {
            optionMsg = "Selected Option(s): "
            for optionItem in optionList! {
                optionMsg += "\(optionItem.quantity) '\(optionItem.optionItem.name)'; "
            }
        }
        
        var prefix: String = ">>> Test Passed (Liner): "
        
        switch priceType {
            case .adder_only:
                prefix = prefix + "Adder Item: "
                break
                
            case .per_unit_area:
                prefix = prefix + "For unit-price lookup for brand '\(linerBrand)' with area '\(area) sq ft' - "
                
            case .per_pool_size:
                let dims: String = getDimensionStringForPoolShapeFromDict(shape: shape, dimensionDict: dimensionDict)
                prefix = prefix + "For \(shapeDesc) \(shape) pool for brand '\(linerBrand)' with area: \(area); Dimensions: \(dims); "
        }
        
        var msg = prefix + "Price: $\(price)"
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

}
