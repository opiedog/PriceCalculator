//
//  LinerPriceCalculator.swift
//  PriceCalculator
//
//  Created by John Tafoya on 5/4/21.
//

import Foundation

enum LinerBrand {
    case Latham
    case LathamModel2
    case LathamModel3
    case Premier
    case Signature
}

struct LinerOptionSelection {
    var optionItem: LinerOptionItem
    var quantity: Int = 0
}

//====================================
class LinerPriceCalculator {
    private let _dataLayer: DataLayer_Liner = DataLayer_Liner()
    
    private var _area: Double
    //private var _shapeDescription: ShapeDescription?
    private var _linerBrand: LinerBrand
    //private var _selectedOptions: [LinerOptionSelection]?

    var priceResult: PriceResult = PriceResult()

    init(linerBrand: LinerBrand) {
        _area = 0
        //_shapeDescription = ShapeDescription.undefined
        _linerBrand = linerBrand
        //_selectedOptions = nil
    }

    func setArea(area: Double) {
        _area = area
    }
    
//    func setPoolCharacteristics(shapeDescription: ShapeDescription) {   //, shape: PoolShape
//        _shapeDescription = shapeDescription
//        //_poolShape = shape
//    }
//
//    func setSelectedOptions(selectedOptions: [LinerOptionSelection]) {
//        _selectedOptions = selectedOptions
//    }

    //--------------------------------
    func calculatePrice() {
        // Validate inputs
        // TODO

        // Get the baseline for the square footage
        let uomPrice: UnitOfMeasurePrice = _dataLayer.getUnitPriceForArea(linerBrand: self._linerBrand, area: self._area)
        //var uom: UnitOfMeasure = UnitOfMeasure
        
        // This is a crappy implementation done just to get this done ASAP
        if(uomPrice.uom == UnitOfMeasure.each) {
            priceResult.calculatedPrice = uomPrice.price
        }
        else if(uomPrice.price >= 0) {
            priceResult.calculatedPrice = self._area * uomPrice.price

            // Add the options
            //priceResult.calculatedPrice += getTotalForOptionsList(selectedOptions: _selectedOptions)
        }
        else {
            priceResult.wasSuccessful = false
        }
    }
 }
