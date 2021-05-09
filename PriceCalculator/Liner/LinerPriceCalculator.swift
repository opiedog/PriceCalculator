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
    case undefined
}

enum StairAndSwimoutOption {
    case SingleTreadOrBench
    case StraightOrRomanStep
    case FreeformOrWeddingCake
    case SingleTreadOrBenchEx
    case StraightOrRomanStepEx
    case FreeformOrWeddingCakeEx
    case undefined
}

struct LinerOptionSelection {
    var optionItem: LinerOptionItem
    var quantity: Int = 0
}

struct LinerOptionsTotalPriceSet {
    // Sum total of the options that were inspected
    var optionsTotalPrice: Double = 0
    
    // Sum total of the discount items
    var linerDeductionPercentage: Double = 0
    
    // This is used to facilitate processing
    var priceUnit: PriceUnit = PriceUnit.currency
}

//====================================
class LinerPriceCalculator {
    private let _dataLayer: DataLayer_Liner = DataLayer_Liner()
    
    private var _area: Double
    //private var _shapeDescription: ShapeDescription?
    private var _linerBrand: LinerBrand
    private var _selectedOptions: [LinerOptionSelection]?

    var priceResult: PriceResult = PriceResult()

    init(linerBrand: LinerBrand) {
        _area = 0
        //_shapeDescription = ShapeDescription.undefined
        _linerBrand = linerBrand
        _selectedOptions = nil
    }

    func setArea(area: Double) {
        //_area = area
        
        // This is done to match Latham's Excel price calculator implementation
        _area = DoubleHelper.roundToHundredth(value: area)
    }
    
//    func setPoolCharacteristics(shapeDescription: ShapeDescription) {   //, shape: PoolShape
//        _shapeDescription = shapeDescription
//        //_poolShape = shape
//    }

    func setSelectedOptions(selectedOptions: [LinerOptionSelection]) {
        _selectedOptions = selectedOptions
    }

    //--------------------------------
    func calculatePrice() {
        // Validate inputs
        // TODO

        // Get the baseline for the square footage
        let uomPrice: UnitOfMeasurePrice = _dataLayer.getUnitPriceForArea(linerBrand: self._linerBrand, area: self._area)
        
        // This is a crappy implementation done just to get this done ASAP
        if(uomPrice.uom == UnitOfMeasure.each) {
            // The price is a set amount independent of the exact area in this scenario
            priceResult.calculatedPrice = uomPrice.price
        }
        else if(uomPrice.price >= 0) {
            // It's not .each so calculate based on area
            priceResult.calculatedPrice = self._area * uomPrice.price
        }
        else {
            priceResult.wasSuccessful = false
        }

        // Add the options
        //priceResult.calculatedPrice += getTotalForOptionsList(selectedOptions: _selectedOptions)
        let optionsPriceSet = getTotalForOptionsList(selectedOptions: _selectedOptions)
        
        // Deal with prices first with % discounts off the baseline
        if(optionsPriceSet.linerDeductionPercentage > 0) {
            if(optionsPriceSet.linerDeductionPercentage > 1) {
                // This really should check against a total discount of maybe 50%+
                // but for now we'll make sure it's at least not more than 100%.
                //throw
                //let ex: NSException = NSException()
                //throw ex
            }
            
            // FYI: Latham defines discounts as negative values
            let discountAmt: Double = (priceResult.calculatedPrice * optionsPriceSet.linerDeductionPercentage)
            priceResult.calculatedPrice = priceResult.calculatedPrice - abs(discountAmt)
        }
        
        // Now add in the adders
        priceResult.calculatedPrice += optionsPriceSet.optionsTotalPrice
    }

    //--------------------------------
    // This returns a value instead of just updating a class property
    // to facilitate testing.
    //--------------------------------
    func getTotalForOptionsList(selectedOptions: [LinerOptionSelection]?) -> LinerOptionsTotalPriceSet {
        var linerOptionSet = LinerOptionsTotalPriceSet()
        linerOptionSet.optionsTotalPrice = 0.0
        
        if(selectedOptions != nil) {
            for selectedOption in selectedOptions! {
                // Get the item from the data layer
                let rawItem: LinerOptionItem = _dataLayer.getLinerOptionItem(name: selectedOption.optionItem.name, stairSwimoutOption: selectedOption.optionItem.stairSwimoutOption)
                
                // Multiple its unit price times the quantity and add it to the total
                let unitPrice = rawItem.unitPrice
                if(rawItem.priceUnit == PriceUnit.percentage) {
                    // This is a percentage value so capture it as such
                    // and move on to the next item.
                    linerOptionSet.linerDeductionPercentage += unitPrice
                    linerOptionSet.priceUnit = PriceUnit.percentage
                    continue
                }
                
                switch(rawItem.uom) {
                    case .each:
                        linerOptionSet.optionsTotalPrice += (unitPrice * (Double(selectedOption.quantity)))
                    case .linearfoot:
                        linerOptionSet.optionsTotalPrice += (unitPrice * (Double(selectedOption.quantity)))
                    case .poolarea:
//                        optionsTotal += (unitPrice * self._area!)
                        linerOptionSet.optionsTotalPrice += 0
                    case .coverarea:
//                        optionsTotal += (unitPrice * self._area!)
                        linerOptionSet.optionsTotalPrice += 0

                    case .perimeter:
                        // TODO
                        linerOptionSet.optionsTotalPrice += 0
                    case .undefined:
                        // TODO
                        linerOptionSet.optionsTotalPrice += 0
                }
            }
        }
        
        return linerOptionSet
    }
}
