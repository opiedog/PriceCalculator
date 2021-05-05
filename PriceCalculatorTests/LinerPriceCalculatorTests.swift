//
//  LinerPriceCalculatorTests.swift
//  PriceCalculatorTests
//
//  Created by John Tafoya on 5/4/21.
//

import XCTest
@testable import PriceCalculator

class LinerPriceCalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // PRICE CHECKS
    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_Latham_1() throws {
        // Set the dimensions
        // 1x1 pool
        let l: Double = 1
        let w: Double = 1

        let pool = Rectangle(length: l, width: w)

        XCTAssertEqual(1, pool.areaPool)

        // Area is the actual size val plus a constant border amount (e.g. 2) - so (1 + 2) x (1 + 2) == 9
        let areaExpected: Double = 9
        XCTAssertEqual(areaExpected, pool.areaCover)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(linerBrand: LinerBrand.Latham)
        calculator.setArea(area: pool.areaCover)
        //calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice: Double = 345
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        //let dict: [String: Double] = ["A": l, "B": w]
        //printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool_Latham_100() throws {
        // Set the dimensions
        // 1x1 pool
        let l: Double = 1
        let w: Double = 100

        let pool = Rectangle(length: l, width: w)

        XCTAssertEqual(100, pool.areaPool)

        // Area is the actual size val plus a constant border amount (e.g. 2) - so (1 + 2) x (1 + 2) == 9
        let areaExpected: Double = 306
        XCTAssertEqual(areaExpected, pool.areaCover)

        let calculator: LinerPriceCalculator = LinerPriceCalculator(linerBrand: LinerBrand.Latham)
        calculator.setArea(area: pool.areaCover)
        //calculator.setPoolCharacteristics(shapeDescription: pool.shapeDescription)

        // Calculate the price
        calculator.calculatePrice()
        XCTAssertTrue(calculator.priceResult.wasSuccessful)
        let expectedPrice: Double = (3.45 * areaExpected) //1055.70
        XCTAssertEqual(expectedPrice, calculator.priceResult.calculatedPrice)

        //let dict: [String: Double] = ["A": l, "B": w]
        //printTestResultForLathamValidation(priceType: PriceType.per_pool_size, shapeDesc: pool.shapeDescription, shape: pool.poolShape, area: pool.areaCover, dimensionDict: dict, safetyCoverModel: scModel, panelSize: scSize, optionList: nil, price: calculator.priceResult.calculatedPrice)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
