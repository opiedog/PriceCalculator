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
    func testRectanglularPoolArea1() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        //let area: Double = PriceCalculator.getArea_geometric(aFeet: 10, aInches: 0, bFeet: 20, bInches: 6)
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        let w: Double = calculator.convertToFeet(footVal: 20, inchVal: 6)
        XCTAssertEqual(20.5, w)
        
        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        calculator.setAreaDimensions(areaDimensions: areaDims)
        let area: Double = calculator.getArea()
        XCTAssertEqual(270, area)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testRectanglularPoolArea2() throws {
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()

        let B: Double = calculator.convertToFeet(footVal: 38, inchVal: 3)
        XCTAssertEqual(38.25, B)

        let A: Double = calculator.convertToFeet(footVal: 14, inchVal: 7)
        XCTAssertEqual(14.5833, roundToTenThousandth(value: A))
        
        let poolShapeDesc: ShapeDescription = .rectangle
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: B, longWidth: A, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)

        calculator.setAreaDimensions(areaDimensions: areaDims)
        let area: Double = calculator.getArea()
        XCTAssertEqual(roundToTenThousandth(value: 667.4792), roundToTenThousandth(value: area))
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool1() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        let w = calculator.convertToFeet(footVal: 20, inchVal: 6)
        
        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: 10, longWidth: w, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        calculator.setAreaDimensions(areaDimensions: areaDims)

        XCTAssertEqual(270, calculator.getArea())

        // Set the options
        // TODO

        // Calculate the price
        calculator.calculatePrice()

        XCTAssertEqual(1117.8, calculator.priceResult.calculatedPrice)
    }

    //----------------------------------------------------
    //----------------------------------------------------
    func testPriceForRectangularPool2() throws {
        // Set the dimensions
        let poolShapeDesc: ShapeDescription = .rectangle

        // Set the dimensions of the pool and the pool type
        let calculator: SafetyCoverPriceCalculator = SafetyCoverPriceCalculator()
        let A = calculator.convertToFeet(footVal: 19, inchVal: 11)
        let B = calculator.convertToFeet(footVal: 39, inchVal: 10)

        let areaDims: AreaDimensions = AreaDimensions(shapeDescription: poolShapeDesc, longLength: B, longWidth: A, shortLength: 0, shortWidth: 0, longDiagLength: 0, shortDiagLength: 0)
        
        calculator.setAreaDimensions(areaDimensions: areaDims)

        XCTAssertEqual(916.8472, roundToTenThousandth(value: calculator.getArea()))

        // Set the options
        // TODO

        // Calculate the price
        calculator.calculatePrice()

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
