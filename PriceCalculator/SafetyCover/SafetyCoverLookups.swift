//
//  SafetyCoverLookups.swift
//  PriceCalculator
//
//  Created by John Tafoya on 4/18/21.
//

import Foundation


enum SafetyCoverPanelSize {
    case fivebyfive
    case threebythree
    case undefined
}

enum SafetyCoverModel {
//    let HighShadeMesh7000M: String = "7000M HIGH SHADE MESH - Green/Blue/Tan/Grey"
//    let StandardMesh5000M: String = "5000M STANDARD MESH - Green/Blue/Tan/Grey"
    case HighShadeMesh7000M
    case StandardMesh5000M
    case undefined
}

enum UnitOfMeasure {
    case each
    case perimeter
    case coverarea
    case undefined
}

struct SafetyCoverOptionItem {
    var name: String = ""
    var uom: UnitOfMeasure = UnitOfMeasure.undefined
    var panelSize: SafetyCoverPanelSize = SafetyCoverPanelSize.undefined
    var unitPrice: Double = 0.0
}

class DataLayer {
    //------------------------------------------------------------
    // Product options
    //------------------------------------------------------------ , unitOfMeasure: UnitOfMeasure
    func getSafetyCoverOptionItem(name: String, safetyCoverPanelSize: SafetyCoverPanelSize) -> SafetyCoverOptionItem {
        let lcaseName: String = name.lowercased()
        
        var item: SafetyCoverOptionItem = SafetyCoverOptionItem()
        
        if(lcaseName == "Step w/pads <= 8".lowercased()) {
            item.uom = UnitOfMeasure.each
            if(safetyCoverPanelSize == SafetyCoverPanelSize.fivebyfive) {
                item.unitPrice = 171.78
            }
            else if(safetyCoverPanelSize == SafetyCoverPanelSize.threebythree) {
                item.unitPrice = 177.55
            }
        }
        else if(lcaseName == "Full Perimeter Anchor - Lawn Tubes".lowercased()) {
            item.uom = UnitOfMeasure.coverarea
            if(safetyCoverPanelSize == SafetyCoverPanelSize.fivebyfive) {
                item.unitPrice = 99.90
            }
            else if(safetyCoverPanelSize == SafetyCoverPanelSize.threebythree) {
                item.unitPrice = 148.50
            }
        }
        else if(lcaseName == "Partial Perimeter Anchor - Lawn Tubes".lowercased()) {
            item.uom = UnitOfMeasure.perimeter
            if(safetyCoverPanelSize == SafetyCoverPanelSize.fivebyfive) {
                item.unitPrice = 2.89
            }
            else if(safetyCoverPanelSize == SafetyCoverPanelSize.threebythree) {
                item.unitPrice = 4.33
            }
        }

        return item
    }
    
    //------------------------------------------------------------
    // Base product price
    //------------------------------------------------------------
    func getPriceForArea(shapeCharacterization: ShapeCharacterization, coverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, area: Double) -> Double {
        var price: Double = 0.0
        
        switch coverModel {
            case SafetyCoverModel.StandardMesh5000M:
                if(shapeCharacterization == ShapeCharacterization.geometric) {
                    price = getPriceForArea(area: area)
                }
                
            default:
                price = -1
        }
        
        return price
    }

    // 5000M STANDARD MESH - Green/Blue/Tan/Grey
    func getPriceForArea(area: Double) -> Double {
        var pricePerSqFoot: Double = -1
        var finalPrice: Double = -1
        
        if((0 < area) && (area <= 300)) {
            pricePerSqFoot = 4.14
        }
        else if((301 < area) && (area <= 400)) {
            pricePerSqFoot = 3.35
        }
        else if((401 < area) && (area <= 500)) {
            pricePerSqFoot = 3.06
        }
        else if((501 < area) && (area <= 600)) {
            pricePerSqFoot = 2.80
        }
        else if((601 < area) && (area <= 650)) {
            pricePerSqFoot = 2.69
        }
        else if((651 < area) && (area <= 700)) {
            pricePerSqFoot = 2.57
        }
        else if((701 < area) && (area <= 800)) {
            pricePerSqFoot = 2.52
        }
        else if((801 < area) && (area <= 900)) {
            pricePerSqFoot = 2.41
        }
        else if((901 < area) && (area <= 1000)) {
            pricePerSqFoot = 2.29
        }
        else if((1001 < area) && (area <= 1100)) {
            pricePerSqFoot = 2.24
        }
        else if((1201 < area) && (area <= 1300)) {
            pricePerSqFoot = 2.17
        }
        else if((1301 < area) && (area <= 1600)) {
            pricePerSqFoot = 2.16
        }
        else if((1601 < area) && (area <= 1900)) {
            pricePerSqFoot = 2.00
        }
        else if((1901 < area) && (area <= 2000)) {
            pricePerSqFoot = 1.94
        }
        //    2001    10000 Call for Quote
        //else if((2001 < area) && (area <= 10000)) {
        //    pricePerSqFoot = N/A
        //}

        if( pricePerSqFoot > 0) {
            finalPrice = pricePerSqFoot * area
        }
        else {
            // TODO
        }
        
        return finalPrice
    }
}
