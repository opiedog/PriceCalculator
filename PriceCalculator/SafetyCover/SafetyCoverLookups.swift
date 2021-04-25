//
//  SafetyCoverLookups.swift
//  PriceCalculator
//
// NOTE
//  This is a hack to put something in place to represent a proper DAL.
//  This is not meant to be a proposed implementation of a data layer. It's just a hack to
//  "provide data" to the rest of the code to demonstrate calculations.
//
//

import Foundation

enum ShapeCharacterization {
    case undefined
    case freeform
    case geometric
}

enum SafetyCoverPanelSize {
    case fivebyfive
    case threebythree
    case undefined
}

enum SafetyCoverModel {
    case StandardMesh5000M
    case HighShadeMesh7000MS
    case MaxShadeMesh9000MX
    case HeavyDutySolid1000V
    case LiteSolid500P
    case undefined
}

enum UnitOfMeasure {
    case each
    case perimeter
    case poolarea
    case coverarea
    case linearfoot
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
    //  I was going to create a dictionary but I wasn't sure how to
    //  make that happen in Swift so I just did this quickly.
    //------------------------------------------------------------
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
                item.unitPrice = 0.37
            }
            else if(safetyCoverPanelSize == SafetyCoverPanelSize.threebythree) {
                item.unitPrice = 0.55
            }
        }
        else if(lcaseName == "Partial Perimeter Anchor - Lawn Tubes".lowercased()) {
            item.uom = UnitOfMeasure.linearfoot
            if(safetyCoverPanelSize == SafetyCoverPanelSize.fivebyfive) {
                item.unitPrice = 2.89
            }
            else if(safetyCoverPanelSize == SafetyCoverPanelSize.threebythree) {
                item.unitPrice = 4.33
            }
        }
        else if(lcaseName == "Double D-Rings (Non-buckle) Option/not updgrade".lowercased()) {
            item.uom = UnitOfMeasure.poolarea
            if(safetyCoverPanelSize == SafetyCoverPanelSize.fivebyfive) {
                item.unitPrice = 0.3
            }
            else if(safetyCoverPanelSize == SafetyCoverPanelSize.threebythree) {
                item.unitPrice = 0.35
            }
        }

        return item
    }
    
    //------------------------------------------------------------
    // Base product price
    //------------------------------------------------------------
    func getUnitPriceForArea(shapeCharacterization: ShapeCharacterization, coverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, area: Double) -> Double {
        var price: Double = 0.0
        
        switch coverModel {
            // 5000
            case .StandardMesh5000M:
                if(shapeCharacterization == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_StandardMesh5000M_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_StandardMesh5000M_3x3_geometric(area: area)
                    }
                }
                else if(shapeCharacterization == .freeform) {
                    price = getUnitPrice_StandardMesh5000M_3x3_freeform(area: area)
                }
                
            // 7000
            case .HighShadeMesh7000MS:
                if(shapeCharacterization == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_HighShadeMesh7000MS_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_HighShadeMesh7000MS_3x3_geometric(area: area)
                    }
                }
                else if(shapeCharacterization == .freeform) {
                    price = getUnitPrice_HighShadeMesh7000MS_3x3_freeform(area: area)
                }
                
            // 9000
            case .MaxShadeMesh9000MX:
                if(shapeCharacterization == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_MaxShadeMesh9000MX_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_MaxShadeMesh9000MX_3x3_geometric(area: area)
                    }
                }
                else if(shapeCharacterization == .freeform) {
                    price = getUnitPrice_MaxShadeMesh9000MX_3x3_freeform(area: area)
                }

            // 1000
            case .HeavyDutySolid1000V:
                if(shapeCharacterization == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_HeavyDutySolid1000V_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_HeavyDutySolid1000V_3x3_geometric(area: area)
                    }
                }
                else if(shapeCharacterization == .freeform) {
                    price = getUnitPrice_HeavyDutySolid1000V_3x3_freeform(area: area)
                }
         
            // 500
            case .LiteSolid500P:
                if(shapeCharacterization == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_LiteSolid500P_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_LiteSolid500P_3x3_geometric(area: area)
                    }
                }
                else if(shapeCharacterization == .freeform) {
                    price = getUnitPrice_LiteSolid500P_3x3_freeform(area: area)
                }

            default:
                price = -1
        }
        
        return price
    }

    // StandardMesh5000M
    func getUnitPrice_StandardMesh5000M_5x5_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0
        
        if(area >= 0 && area <= 300) { unitPrice = 4.14 }
        else if(area >= 301 && area <= 400) { unitPrice = 3.35 }
        else if(area >= 401 && area <= 500) { unitPrice = 3.06 }
        else if(area >= 501 && area <= 600) { unitPrice = 2.8 }
        else if(area >= 601 && area <= 650) { unitPrice = 2.69 }
        else if(area >= 651 && area <= 700) { unitPrice = 2.57 }
        else if(area >= 701 && area <= 800) { unitPrice = 2.52 }
        else if(area >= 801 && area <= 900) { unitPrice = 2.41 }
        else if(area >= 901 && area <= 1000) { unitPrice = 2.29 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 2.24 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 2.17 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 2.16 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 2 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 1.94 }
        
        return unitPrice
    }
    //
    func getUnitPrice_StandardMesh5000M_3x3_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0
        
        if(area >= 0 && area <= 300) { unitPrice = 4.88 }
        else if(area >= 301 && area <= 400) { unitPrice = 4.11 }
        else if(area >= 401 && area <= 500) { unitPrice = 3.78 }
        else if(area >= 501 && area <= 600) { unitPrice = 3.53 }
        else if(area >= 601 && area <= 650) { unitPrice = 3.4 }
        else if(area >= 651 && area <= 700) { unitPrice = 3.3 }
        else if(area >= 701 && area <= 800) { unitPrice = 3.25 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.15 }
        else if(area >= 901 && area <= 1000) { unitPrice = 3.03 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 2.96 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 2.91 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 2.86 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 2.71 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 2.67 }
        
        return unitPrice
    }
    //
    func getUnitPrice_StandardMesh5000M_3x3_freeform(area: Double) -> Double {
        var unitPrice: Double = 0.0
        
        if(area >= 0 && area <= 300) { unitPrice = 5.99 }
        else if(area >= 301 && area <= 400) { unitPrice = 4.71 }
        else if(area >= 401 && area <= 500) { unitPrice = 4.22 }
        else if(area >= 501 && area <= 600) { unitPrice = 3.98 }
        else if(area >= 601 && area <= 650) { unitPrice = 3.86 }
        else if(area >= 651 && area <= 700) { unitPrice = 3.72 }
        else if(area >= 701 && area <= 800) { unitPrice = 3.65 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.57 }
        else if(area >= 901 && area <= 1000) { unitPrice = 3.47 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 3.34 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 3.28 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 3.19 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 3.12 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 3.03 }
        
        return unitPrice
    }

    // HighShadeMesh7000MS
    func getUnitPrice_HighShadeMesh7000MS_5x5_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0
        
        if(area >= 0 && area <= 300) { unitPrice = 4.9 }
        else if(area >= 301 && area <= 400) { unitPrice = 4.49 }
        else if(area >= 401 && area <= 500) { unitPrice = 3.78 }
        else if(area >= 501 && area <= 600) { unitPrice = 3.62 }
        else if(area >= 601 && area <= 650) { unitPrice = 3.33 }
        else if(area >= 651 && area <= 700) { unitPrice = 3.27 }
        else if(area >= 701 && area <= 800) { unitPrice = 3.15 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.07 }
        else if(area >= 901 && area <= 1000) { unitPrice = 2.94 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 2.9 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 2.82 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 2.75 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 2.68 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 2.48 }
        
        return unitPrice
    }
    //
    func getUnitPrice_HighShadeMesh7000MS_3x3_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0

        if(area >= 0 && area <= 300) { unitPrice = 5.54 }
        else if(area >= 301 && area <= 400) { unitPrice = 5.22 }
        else if(area >= 401 && area <= 500) { unitPrice = 4.36 }
        else if(area >= 501 && area <= 600) { unitPrice = 4.31 }
        else if(area >= 601 && area <= 650) { unitPrice = 4.03 }
        else if(area >= 651 && area <= 700) { unitPrice = 3.99 }
        else if(area >= 701 && area <= 800) { unitPrice = 3.88 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.75 }
        else if(area >= 901 && area <= 1000) { unitPrice = 3.72 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 3.65 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 3.59 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 3.45 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 3.38 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 3.17 }
        
        return unitPrice
    }
    //
    func getUnitPrice_HighShadeMesh7000MS_3x3_freeform(area: Double) -> Double {
        var unitPrice: Double = 0.0
        
        if(area >= 0 && area <= 300) { unitPrice = 7.66 }
        else if(area >= 301 && area <= 400) { unitPrice = 5.77 }
        else if(area >= 401 && area <= 500) { unitPrice = 5.7 }
        else if(area >= 501 && area <= 600) { unitPrice = 5.32 }
        else if(area >= 601 && area <= 650) { unitPrice = 5 }
        else if(area >= 651 && area <= 700) { unitPrice = 4.89 }
        else if(area >= 701 && area <= 800) { unitPrice = 4.81 }
        else if(area >= 801 && area <= 900) { unitPrice = 4.7 }
        else if(area >= 901 && area <= 1000) { unitPrice = 4.5 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 4.34 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 4.2 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 4.14 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 4.07 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 3.98 }
        
        return unitPrice
    }

    // MaxShadeMesh9000MX
    func getUnitPrice_MaxShadeMesh9000MX_5x5_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0
        
        if(area >= 0 && area <= 300) { unitPrice = 5.72 }
        else if(area >= 301 && area <= 400) { unitPrice = 5.16 }
        else if(area >= 401 && area <= 500) { unitPrice = 4.58 }
        else if(area >= 501 && area <= 600) { unitPrice = 4.13 }
        else if(area >= 601 && area <= 650) { unitPrice = 3.84 }
        else if(area >= 651 && area <= 700) { unitPrice = 3.74 }
        else if(area >= 701 && area <= 800) { unitPrice = 3.62 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.5 }
        else if(area >= 901 && area <= 1000) { unitPrice = 3.38 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 3.26 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 3.15 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 3.05 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 3.05 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 3.03 }
        
        return unitPrice
    }
    //
    func getUnitPrice_MaxShadeMesh9000MX_3x3_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0

        if(area >= 0 && area <= 300) { unitPrice = 6.48 }
        else if(area >= 301 && area <= 400) { unitPrice = 5.93 }
        else if(area >= 401 && area <= 500) { unitPrice = 5.35 }
        else if(area >= 501 && area <= 600) { unitPrice = 4.9 }
        else if(area >= 601 && area <= 650) { unitPrice = 4.6 }
        else if(area >= 651 && area <= 700) { unitPrice = 4.5 }
        else if(area >= 701 && area <= 800) { unitPrice = 4.37 }
        else if(area >= 801 && area <= 900) { unitPrice = 4.26 }
        else if(area >= 901 && area <= 1000) { unitPrice = 4.14 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 4.03 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 3.9 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 3.8 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 3.8 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 3.78 }
        
        return unitPrice
    }
    //
    func getUnitPrice_MaxShadeMesh9000MX_3x3_freeform(area: Double) -> Double {
        var unitPrice: Double = 0.0

        if(area >= 0 && area <= 300) { unitPrice = 8.55 }
        else if(area >= 301 && area <= 400) { unitPrice = 7.72 }
        else if(area >= 401 && area <= 500) { unitPrice = 6.85 }
        else if(area >= 501 && area <= 600) { unitPrice = 6.17 }
        else if(area >= 601 && area <= 650) { unitPrice = 5.73 }
        else if(area >= 651 && area <= 700) { unitPrice = 5.56 }
        else if(area >= 701 && area <= 800) { unitPrice = 5.39 }
        else if(area >= 801 && area <= 900) { unitPrice = 5.22 }
        else if(area >= 901 && area <= 1000) { unitPrice = 5.04 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 4.89 }
        else if(area >= 1201 && area <= 1300) { unitPrice = 4.71 }
        else if(area >= 1301 && area <= 1600) { unitPrice = 4.54 }
        else if(area >= 1601 && area <= 1900) { unitPrice = 4.54 }
        else if(area >= 1901 && area <= 2000) { unitPrice = 4.53 }
        
        return unitPrice
    }


    // HeavyDutySolid1000V
    func getUnitPrice_HeavyDutySolid1000V_5x5_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0
        
        if(area >= 0 && area <= 300) { unitPrice = 5.12 }
        else if(area >= 301 && area <= 400) { unitPrice = 4.46 }
        else if(area >= 401 && area <= 500) { unitPrice = 3.81 }
        else if(area >= 501 && area <= 600) { unitPrice = 3.48 }
        else if(area >= 601 && area <= 650) { unitPrice = 3.35 }
        else if(area >= 651 && area <= 700) { unitPrice = 3.21 }
        else if(area >= 701 && area <= 800) { unitPrice = 3.11 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.07 }
        else if(area >= 901 && area <= 1000) { unitPrice = 2.92 }
        
        return unitPrice
    }
    //
    func getUnitPrice_HeavyDutySolid1000V_3x3_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0

        if(area >= 0 && area <= 300) { unitPrice = 5.73 }
        else if(area >= 301 && area <= 400) { unitPrice = 5 }
        else if(area >= 401 && area <= 500) { unitPrice = 4.26 }
        else if(area >= 501 && area <= 600) { unitPrice = 4.03 }
        else if(area >= 601 && area <= 650) { unitPrice = 3.87 }
        else if(area >= 651 && area <= 700) { unitPrice = 3.71 }
        else if(area >= 701 && area <= 800) { unitPrice = 3.65 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.57 }
        else if(area >= 901 && area <= 1000) { unitPrice = 3.4 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 3.24 }
        
        return unitPrice
    }
    //
    func getUnitPrice_HeavyDutySolid1000V_3x3_freeform(area: Double) -> Double {
        var unitPrice: Double = 0.0

        if(area >= 0 && area <= 300) { unitPrice = 6.85 }
        else if(area >= 301 && area <= 400) { unitPrice = 4.71 }
        else if(area >= 401 && area <= 500) { unitPrice = 4.64 }
        else if(area >= 501 && area <= 600) { unitPrice = 4.59 }
        else if(area >= 601 && area <= 650) { unitPrice = 4.53 }
        else if(area >= 651 && area <= 700) { unitPrice = 4.45 }
        else if(area >= 701 && area <= 800) { unitPrice = 4.35 }
        else if(area >= 801 && area <= 900) { unitPrice = 4.25 }
        else if(area >= 901 && area <= 1000) { unitPrice = 4.11 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 3.98 }
        
        return unitPrice
    }


    // LiteSolid500P
    func getUnitPrice_LiteSolid500P_5x5_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0
        
        if(area >= 0 && area <= 300) { unitPrice = 4.86 }
        else if(area >= 301 && area <= 400) { unitPrice = 3.89 }
        else if(area >= 401 && area <= 500) { unitPrice = 3.47 }
        else if(area >= 501 && area <= 600) { unitPrice = 3.15 }
        else if(area >= 601 && area <= 650) { unitPrice = 3.03 }
        else if(area >= 651 && area <= 700) { unitPrice = 2.85 }
        else if(area >= 701 && area <= 800) { unitPrice = 2.84 }
        else if(area >= 801 && area <= 900) { unitPrice = 2.7 }
        else if(area >= 901 && area <= 1000) { unitPrice = 2.58 }
        
        return unitPrice
    }
    //
    func getUnitPrice_LiteSolid500P_3x3_geometric(area: Double) -> Double {
        var unitPrice: Double = 0.0

        if(area >= 0 && area <= 300) { unitPrice = 5.41 }
        else if(area >= 301 && area <= 400) { unitPrice = 4.39 }
        else if(area >= 401 && area <= 500) { unitPrice = 3.88 }
        else if(area >= 501 && area <= 600) { unitPrice = 3.62 }
        else if(area >= 601 && area <= 650) { unitPrice = 3.51 }
        else if(area >= 651 && area <= 700) { unitPrice = 3.36 }
        else if(area >= 701 && area <= 800) { unitPrice = 3.33 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.19 }
        else if(area >= 901 && area <= 1000) { unitPrice = 3.07 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 2.98 }
        
        return unitPrice
    }
    //
    func getUnitPrice_LiteSolid500P_3x3_freeform(area: Double) -> Double {
        var unitPrice: Double = 0.0

        if(area >= 0 && area <= 300) { unitPrice = 6.39 }
        else if(area >= 301 && area <= 400) { unitPrice = 4.61 }
        else if(area >= 401 && area <= 500) { unitPrice = 4.57 }
        else if(area >= 501 && area <= 600) { unitPrice = 4.31 }
        else if(area >= 601 && area <= 650) { unitPrice = 4.13 }
        else if(area >= 651 && area <= 700) { unitPrice = 4.08 }
        else if(area >= 701 && area <= 800) { unitPrice = 4.02 }
        else if(area >= 801 && area <= 900) { unitPrice = 3.85 }
        else if(area >= 901 && area <= 1000) { unitPrice = 3.77 }
        else if(area >= 1001 && area <= 1200) { unitPrice = 3.63 }
        
        return unitPrice
    }
}
