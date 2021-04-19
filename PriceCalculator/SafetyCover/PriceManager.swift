//
//  PriceManager.swift
//  PriceCalculator
//
//  Created by John Tafoya on 4/15/21.
//

import Foundation

enum CalculatePriceError {
    case ignore
    case validateInputs
    case configureFromPoolShape
}

struct PriceResult {
    var success = true
    var errorType = CalculatePriceError.ignore
    var calculatedPrice = 0.0
}

enum ShapeCharacterization {
    case undefined
    case freeform
    case geometric
}

enum ShapeDescription {
    case undefined
    case rectangle
    case truel
    case lazyl
}

struct AreaDimensions {
    var shapeCharacterization: ShapeCharacterization = .undefined
    var shapeDescription: ShapeDescription = .undefined

    //                              // These values/names are re "2021 US Safety Cover Calculator.xlsm" on the 'Setup' tab
    //                              // Rect     // TrueL    // LazyL
    // Something described by an enclosing rectangle
    var longLength: Double = 0      // B        // B        // X1
    var longWidth: Double = 0       // A        // A1       // A
    
    // True L
    var shortLength: Double = 0     //          // B7       // T
    var shortWidth: Double = 0      //          // A        // A1

    // Lazy L
    var longDiagLength: Double = 0  //          //          // W1
    var shortDiagLength: Double = 0 //          //          // V3

    init(shapeDescription: ShapeDescription, longLength: Double, longWidth: Double, shortLength: Double, shortWidth: Double, longDiagLength: Double, shortDiagLength: Double) {
        
        if(shapeDescription == ShapeDescription.undefined) {
            return
        }
        else {
            self.shapeDescription = shapeDescription
        }
        
        switch shapeDescription {
            case ShapeDescription.rectangle:
                self.longLength = longLength
                self.longWidth = longWidth

                self.shapeCharacterization = .geometric

            case ShapeDescription.truel:
                self.longLength = longLength
                self.longWidth = longWidth

                self.shortLength = shortLength
                self.shortWidth = shortWidth

                self.shapeCharacterization = .geometric

            case ShapeDescription.lazyl:
                self.longLength = longLength
                self.longWidth = longWidth

                self.shortLength = shortLength
                self.shortWidth = shortWidth
                
                self.longDiagLength = longDiagLength
                self.shortDiagLength = shortDiagLength

                self.shapeCharacterization = .geometric

            default:
                return
        }
    }
}

//====================================
class SafetyCoverPriceCalculator {
    var priceResult: PriceResult = PriceResult()
    private var _areaDimensions: AreaDimensions?
    private var _areaSqFt: Double = 0.0
    
    init() {
        _areaDimensions = nil
        _areaSqFt = 0.0
    }
//    init(areaDimensions: AreaDimensions) {
//        _area = areaDimensions
//        // Verify the input
//        if (!validateAreaDimensions(areaDimensions: areaDimensions)) {
//            priceResult.success = false
//            priceResult.errorType = CalculatePriceError.validateInputs
//            return
//        }
//    }
    
    func convertToFeet(footVal: Int, inchVal: Int) -> Double {
        let val1 = (Double)(footVal)
        let val2 = (Double)(inchVal) / 12.0
        let val3 = val1 + val2
        return val3
    }
    
    func setAreaDimensions(areaDimensions: AreaDimensions) {
        _areaDimensions = areaDimensions
    }
    
    func validateAreaDimensions(areaDimensions: AreaDimensions) -> Bool {
        //guard areaDimensions != nil else {
        //    return false
        //}
        
        // TODO
        return true
    }

    //--------------------------------
    func getArea() -> Double {
        //var area: Double = 0
        
        switch self._areaDimensions!.shapeDescription {
            case .rectangle:
                let borderWidth: Double = 2.0
                _areaSqFt = (Double)((borderWidth + _areaDimensions!.longLength) * (borderWidth + _areaDimensions!.longWidth))

            case .truel:
                let area1 = (Double)(_areaDimensions!.longLength * _areaDimensions!.shortWidth)
                let area2 = (Double)(_areaDimensions!.shortLength * (_areaDimensions!.longWidth - _areaDimensions!.shortWidth))
                _areaSqFt = area1 + area2

            case .lazyl:
                // TODO
//                self.longLength = longLength
//                self.longWidth = longWidth
//
//                self.shortLength = shortLength
//                self.shortWidth = shortWidth
//
//                self.longDiagLength = longDiagLength
//                self.shortDiagLength = shortDiagLength
                _areaSqFt = 0

            case .undefined:
                _areaSqFt = 0
        }
        
        return _areaSqFt
    }

    //--------------------------------
    func calculatePrice() {
        // Validate inputs
        //if (!validateInputs()) {
        //    priceResult.success = false
        //    priceResult.errorType = CalculatePriceError().validateInputs
        //    return
        //}
        
//        //
//        var configResult = false
//        switch _area.shapeCharacterization {
//            case .freeform:
//                configResult = configureFreeformPoolShape()
//            case .geometric:
//                configResult = configureGeometricPoolShape()
//            case .undefined:
//                configResult = false
//        }
//
//        if (!configResult) {
//            if (!priceResult.success) {
//                priceResult.errorType = CalculatePriceError.validateInputs
//                return
//            }
//        }
        

        //
        
        // All done
        
        priceResult.calculatedPrice = getPriceForArea(area: self._areaSqFt)
        let asdf = priceResult.calculatedPrice + 1
    }
//
//    //--------------------------------
//    func setPoolAreaDimensions_Rect(lengthFeet: Int, lengthInches: Double, widthFeet: Int, widthInches: Double) {
//        // Validate inputs
//        if(!areValid_PoolAreaDimensions_rect(lengthFeet: lengthFeet, lengthInches: lengthInches, widthFeet: widthFeet, widthInches: widthInches)) {
//            return
//        }
//
//        // Populate the struct
//        _area.longLengthFeet = lengthFeet
//        _area.longLengthInches = lengthInches
//        _area.longWidthFeet = widthFeet
//        _area.longWidthInches = widthInches
//
//        _area.shapeDescription = .geometric
//    }
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
//func calculatePrice(shapeDescription: ShapeDescription) -> PriceResult {
//    // Validate inputs
//    if (!validateInputs()) {
//        var priceResult = PriceResult()
//        priceResult.success = false
//        priceResult.errorType = CalculatePriceError().validateInputs
//        return priceResult
//    }
//
//    //
//    //var area = 0
//    var configResult = false
//
//    switch shapeDescription {
//        case .freeform:
//            configResult = configureFreeformPoolShape()
//        case .geometric:
//            configResult = configureGeometricPoolShape()
//        case .undefined:
//            configResult = false
//    }
//
//    if (!configResult) {
//        var priceResult = testConfigResult(configResult: configResult)
//        if (!priceResult.success) {
//            return priceResult
//        }
//    }
//
//
//    //
//
//    // All done
//
//    // TODO
//    return PriceResult()
//}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func getArea_geometric(aFeet: Double, aInches: Double, bFeet: Double, bInches: Double) -> Double {
    let aVal: Double = (2 + (aFeet + (aInches / 12)))
    let bVal: Double = (2 + (bFeet + (bInches / 12)))
    var area = aVal * bVal
    
    return area
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
//func validateInputs() -> Bool {
//    // TODO
//    return true
//}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func testConfigResult(configResult: Bool) -> PriceResult {
    var priceResult = PriceResult()
    if (!configResult) {
        priceResult.success = false
        priceResult.errorType = CalculatePriceError.configureFromPoolShape
        return priceResult
    }
    else {
        priceResult.success = true
        return priceResult
    }
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func configureFreeformPoolShape() -> Bool {
    // TODO
    return true
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func configureGeometricPoolShape() -> Bool {
    // TODO
    return true
}
