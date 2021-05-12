//
//  LinerLookups.swift
//  PriceCalculator
//
//  Created by John Tafoya on 5/4/21.
//

import Foundation

enum PriceUnit {
    case currency
    case percentage
    case undefined
}

struct LinerOptionItem {
    var name: String = ""
    var uom: UnitOfMeasure = UnitOfMeasure.undefined
    var stairSwimoutOption: StairAndSwimoutOption = StairAndSwimoutOption.undefined
    var unitPrice: Double = 0.0
    var priceUnit: PriceUnit = .currency
}

struct UnitOfMeasurePrice {
    var uom: UnitOfMeasure = UnitOfMeasure.undefined
    var price: Double = 0.0
}

class DataLayer_Liner {
    private var _linerOptionsList = [LinerOptionItem]()
    init() {
        populateOptions()
    }
    
    func getFreeformIrregularShapeChargeAmount() -> Double {
        return 177
    }
    
    //------------------------------------------------------------
    // Base product price
    //------------------------------------------------------------
    func getUnitPriceForArea(linerBrand: LinerBrand, area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice

        switch linerBrand {
            case .Latham:
                result = getUnitPrice_Latham(area: area)
            case .LathamModel2:
                result = getUnitPrice_LathamModel2(area: area)
            case .LathamModel3:
                result = getUnitPrice_LathamModel3(area: area)
            case .Premier:
                result = getUnitPrice_Premier(area: area)
            case .Signature:
                result = getUnitPrice_Signature(area: area)
            case .undefined:
                // TODO
                result = UnitOfMeasurePrice()
        }
        
        return result
    }

    // Latham
    func getUnitPrice_Latham(area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice = UnitOfMeasurePrice()
        result.uom = UnitOfMeasure.poolarea

        if(area >= 0 && area < 100) { result.price = 345; result.uom = UnitOfMeasure.each }
        else if(area >= 100 && area < 500) { result.price = 3.45 }
        else if(area >= 500 && area < 641) { result.price = 3.01 }
        else if(area >= 641 && area < 800) { result.price = 2.88 }
        else if(area >= 800 && area < 1249) { result.price = 2.82 }
        else if(area >= 1249) { result.price = 2.82 }

        return result
    }

    // Latham Model 2
    func getUnitPrice_LathamModel2(area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice = UnitOfMeasurePrice()
        result.uom = UnitOfMeasure.poolarea

        if(area >= 0 && area < 100) { result.price = 3.45; result.uom = UnitOfMeasure.each }
        else if(area >= 100 && area < 500) { result.price = 2.9 }
        else if(area >= 500 && area < 641) { result.price = 2.9 }
        else if(area >= 641 && area < 800) { result.price = 2.9 }
        else if(area >= 800 && area < 1249) { result.price = 2.9 }
        else if(area >= 1249) { result.price = 2.9 }
        
        return result
    }

    // Latham Model 3
    func getUnitPrice_LathamModel3(area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice = UnitOfMeasurePrice()
        result.uom = UnitOfMeasure.poolarea

        if(area >= 0 && area < 100) { result.price = 3.45; result.uom = UnitOfMeasure.each }
        else if(area >= 100 && area < 500) { result.price = 2.9 }
        else if(area >= 500 && area < 641) { result.price = 2.9 }
        else if(area >= 641 && area < 800) { result.price = 2.9 }
        else if(area >= 800 && area < 1249) { result.price = 2.9 }
        else if(area >= 1249) { result.price = 2.9 }
        
        return result
    }

    // Premier
    func getUnitPrice_Premier(area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice = UnitOfMeasurePrice()
        result.uom = UnitOfMeasure.poolarea

        if(area >= 0 && area < 100) { result.price = 345; result.uom = UnitOfMeasure.each }
        else if(area >= 100 && area < 500) { result.price = 3.45 }
        else if(area >= 500 && area < 641) { result.price = 3.01 }
        else if(area >= 641 && area < 800) { result.price = 2.88 }
        else if(area >= 800 && area < 1249) { result.price = 2.82 }
        else if(area >= 1249) { result.price = 2.82 }
        
        return result
    }

    // Signature
    func getUnitPrice_Signature(area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice = UnitOfMeasurePrice()
        result.uom = UnitOfMeasure.poolarea

        if(area >= 0 && area < 100) { result.price = 323; result.uom = UnitOfMeasure.each }
        else if(area >= 100 && area < 500) { result.price = 2.04 }
        else if(area >= 500 && area < 641) { result.price = 2.04 }
        else if(area >= 641 && area < 800) { result.price = 2.04 }
        else if(area >= 800 && area < 1249) { result.price = 2.04 }
        else if(area >= 1249) { result.price = 2.04 }
        
        return result
    }

    //---------------------
    //---------------------
    func getLinerOptionItem(name: String, stairSwimoutOption: StairAndSwimoutOption) -> LinerOptionItem {
        var foundOptionItem: LinerOptionItem? = nil
        
        for item in _linerOptionsList {
            if((item.name == name) && ((stairSwimoutOption != StairAndSwimoutOption.undefined) ? item.stairSwimoutOption == stairSwimoutOption : true)) {
                    foundOptionItem = item
                    break
                }
        }
        
        if(foundOptionItem != nil) {
            return foundOptionItem!
        }
        else {
            return LinerOptionItem()
        }
    }

    func populateOptions() {
        var optName: String = ""
        
        // Vinyl Over Stairs and Swimouts
        optName = "<12' (Rod Pockets, Hook/Loop or Beaded)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 313))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.StraightOrRomanStep, unitPrice: 418))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.FreeformOrWeddingCake, unitPrice: 441))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBenchEx, unitPrice: 0))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.StraightOrRomanStepEx, unitPrice: 0))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.FreeformOrWeddingCakeEx, unitPrice: 0))
        
        optName = "=12' of < 20' (Rod Pockets, Hook/Loop or Beaded)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 577))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.StraightOrRomanStep, unitPrice: 764))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.FreeformOrWeddingCake, unitPrice: 800))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBenchEx, unitPrice: 0))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.StraightOrRomanStepEx, unitPrice: 0))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.FreeformOrWeddingCakeEx, unitPrice: 0))
        
        optName = "= 20' or Larger (Rod Pockets, Hook/Loop or Beaded)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 605))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.StraightOrRomanStep, unitPrice: 800))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.FreeformOrWeddingCake, unitPrice: 836))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBenchEx, unitPrice: 0))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.StraightOrRomanStepEx, unitPrice: 0))
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.FreeformOrWeddingCakeEx, unitPrice: 0))
        
        optName = "4 or More Tread Steps"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 67))
        optName = "Custom Tile on Risers or Treads and Risers in Different Colors (Mix and Match)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 182))
        optName = "Material Step Upgrade to 27mil"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 111))
        optName = "Tread-Tex Textured Vinyl"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 111))
        optName = "Stairs and Swim Outs with Hi-Lite Stripe at Edge of Tread"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 56))
        optName = "Templated Stair Fee"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 0))

        // Add On Charges
        optName = "Free Form / Irregular shape (doesn't include True 'L' or Lazy 'L')"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 177))
        optName = "Depth greater than 9 feet"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 167))
        optName = "All Print Liner (no tile border)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 226))
        optName = "Custom Tile (Mix and Match)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 339))
        optName = "Solid Color Break Stripe at Shallow End Break-Off"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 91))
        optName = "Modify for Autocover or Vanishing Edge"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 339))

        // Special Options
        optName = "TruTile (all print liner, no tile borderwith patented bead)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 339))
        optName = "Safety Ledge over 6\" wide"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 226))
        optName = "Wall Height Less than 36\""
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 226))
        optName = "Wall Height >42 to Less than 96\""
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 226))
        optName = "Overlap"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 226))
        optName = "Straight Slope Pool and/or Uneven Sidewalls(max. 96\")"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 167))
        optName = "Flat Bottom (Depth=wall height up to 60\") (Deduction)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: -0.1, priceUnit: PriceUnit.percentage))
        optName = "Solid Color Shallow End"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 219))
        optName = "Multi-Depth Pools (more than 2 depths)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 167))
        optName = "Commercial Clarity or Diving Target (installed)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 110))
        optName = "Non Conforming Concrete / Gunite Pools (Disclaimers apply)"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 625))
        optName = "Canted (Non-Plumb Side Walls) or Coved bottoms"
        _linerOptionsList.append(LinerOptionItem(name: optName, uom: UnitOfMeasure.each, stairSwimoutOption: StairAndSwimoutOption.SingleTreadOrBench, unitPrice: 139))
    }
}
