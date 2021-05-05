//
//  LinerLookups.swift
//  PriceCalculator
//
//  Created by John Tafoya on 5/4/21.
//

import Foundation

struct LinerOptionItem {
    var name: String = ""
    var uom: UnitOfMeasure = UnitOfMeasure.undefined
    var unitPrice: Double = 0.0
}

struct UnitOfMeasurePrice {
    var uom: UnitOfMeasure = UnitOfMeasure.undefined
    var price: Double = 0.0
}

class DataLayer_Liner {
    //private var _linerOptionsList = [LinerOptionItem]()
    init() {
        //populateOptions()
    }
    
    //------------------------------------------------------------
    // Base product price
    //------------------------------------------------------------
    func getUnitPriceForArea(linerBrand: LinerBrand, area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice
        
        switch linerBrand {
            case .Latham:
                result = getUnitPrice_Latham(area: area)
            default:
                result = UnitOfMeasurePrice()
                result.uom = UnitOfMeasure.undefined
                result.price = -1
        }

//        switch coverModel {
//            // 5000
//            case .StandardMesh5000M:
//                if(shapeDescription == .geometric) {
//                    if(panelSize == .fivebyfive) {
//                        price = getUnitPrice_StandardMesh5000M_5x5_geometric(area: area)
//                    }
//                    else if(panelSize == .threebythree) {
//                        price = getUnitPrice_StandardMesh5000M_3x3_geometric(area: area)
//                    }
//                }
//                else if(shapeDescription == .freeform) {
//                    price = getUnitPrice_StandardMesh5000M_3x3_freeform(area: area)
//                }
//
        
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


        
        return result
    }

    // Latham Model 3
    func getUnitPrice_LathamModel3(area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice = UnitOfMeasurePrice()
        result.uom = UnitOfMeasure.poolarea


        
        return result
    }

    // Premier
    func getUnitPrice_Premier(area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice = UnitOfMeasurePrice()
        result.uom = UnitOfMeasure.poolarea


        
        return result
    }

    // Signature
    func getUnitPrice_Signature(area: Double) -> UnitOfMeasurePrice {
        var result: UnitOfMeasurePrice = UnitOfMeasurePrice()
        result.uom = UnitOfMeasure.poolarea


        
        return result
    }
}
