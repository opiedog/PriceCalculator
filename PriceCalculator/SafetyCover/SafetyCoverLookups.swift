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

// Was ShapeCharacterization
enum ShapeDescription {
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
    private var _safetyCoverOptionsList = [SafetyCoverOptionItem]()
    init() {
        populateOptions()
    }
    
    //------------------------------------------------------------
    // Product options
    //  I was going to create a dictionary but I wasn't sure how to
    //  make that happen in Swift so I just did this quickly.
    //------------------------------------------------------------
    func getSafetyCoverOptionItem(name: String, safetyCoverPanelSize: SafetyCoverPanelSize) -> SafetyCoverOptionItem {
        var foundOptionItem: SafetyCoverOptionItem? = nil
        
        for item in _safetyCoverOptionsList {
            if((item.name == name) && (item.panelSize == safetyCoverPanelSize)) {
                foundOptionItem = item
                break
            }
        }
        
        if(foundOptionItem != nil) {
            return foundOptionItem!
        }
        else {
            return SafetyCoverOptionItem()
        }
    }

    //
    func populateOptions() {
        var optName: String = ""
        // STEPS
        optName = "Step w/pads <= 8'"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 171.78))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 177.55))
        optName = "Step w/pads over > 8'"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 221.36))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 247.88))

        // FULL PERIMETER ANCHORS
        optName = "Lawn Tubes: (18\" aluminum for non secure/no sub-deck)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0.37))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0.55))
        optName = "Deck Tubes (10\" stainless steel for secure/sub deck)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0.58))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0.77))
        optName = "RDM system (Anchor system for 20\" decks)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0.49))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0.76))
        optName = "Wood Deck Anchors (includes 4 screws)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0.21))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0.32))
        optName = "Brass Collars"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0.1))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0.15))
        optName = "Buckles"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0))
        optName = "Upgrade to 2\" Long Brass Anchors"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0.11))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0.16))
        optName = "No Anchors (Cover will ship without anchors or tamping tool)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: -0.07))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.coverarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: -0.09))

        // PARTIAL PERIMETER ANCHORS
        optName = "Partial Perimeter Anchor - Lawn Tubes"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 2.89))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 4.33))
        optName = "Deck Tube (10\" stainless steel for secure/sub deck)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 4.73))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 7.09))
        optName = "RDM System  (Anchor system for decks 20\" - 35\")"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 6.35))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 9.52))
        optName = "Wood Deck Anchors (includes 4 screws)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 2.42))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 3.64))
        optName = "Brass Collars"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0.87))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.linearfoot, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 1.19))
        
        // CUT-OUTS
        optName = "Over Deck < 18\" Wide"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 81.29))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 81.29))
        optName = "Over Deck >=18\" Wide"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 172.93))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 172.93))
        optName = "Over Water <3' from waters edge"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 80.71))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 80.71))
        optName = "Over Water >= 3' from waters edge"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 547.63))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 547.63))

        // PERIMETER VARIATIONS
        optName = "Cut Corner (Limited Deck, Grecian, Large Radius)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 50.73))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0))
        optName = "Oval End"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 74.95))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0))
        optName = "Roman End (includes nose pads)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 121.06))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 83.01))
        
        // FASTENING SYSTEM
        optName = "Double D-Rings (Non-buckle) Option/not updgrade"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.poolarea, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 0.3))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.poolarea, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 0.35))
        // TODO

        // UP AND OVER OBSTRUCTION / MULTI-LEVEL DECK / RISER
        // TODO
        optName = "Obstruction/Multilevel Deck/Riser <24\" High 1 Level"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 518.8))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 518.8))
        optName = "Obstruction/Multilevel Deck/Riser <24\" High 2 Level"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 910.77))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 910.77))
        optName = "Obstruction/Multilevel Deck/Riser <24\" High 3 Level"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 1383.46))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 1383.46))

        // PADDING
        optName = ""
        // TODO

        // COVER DRAINING (SOLID COVERS ONLY)
        optName = "Cover Pump (Fully Electronic)"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 297.45))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 297.45))
        
        // SPA APPLICATIONS
        optName = "Spa Not Covered/Flush Mount/ 8\"-11.99\" of deck between pool and spa"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 605.27))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 605.27))
        optName = "Spa/Not Covered/Flush Mount/ 12\"-17.99\" of deck between pool and spa"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 380.46))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 380.46))
        optName = "Spa/Covered/Flush Mount"
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 391.99))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 466.92))
        optName = "Spa/Covered/Raised: Up to 4\""
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 807.02))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 876.19))
        optName = "Spa/Covered/Raised: >4\"<12\""
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 1383.46))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 1452.64))
        optName = "Spa/Covered/Raised: >12\">16\""
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 1135.6))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 1204.76))
        optName = "Spa/Covered/Raised: >=16\""
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.fivebyfive, unitPrice: 1671.68))
        _safetyCoverOptionsList.append(SafetyCoverOptionItem(name: optName, uom: UnitOfMeasure.each, panelSize: SafetyCoverPanelSize.threebythree, unitPrice: 1758.15))
        
        // OTHER
        optName = ""
        // TODO
    }

    //------------------------------------------------------------
    // Base product price
    //------------------------------------------------------------
    func getUnitPriceForArea(shapeDescription: ShapeDescription, coverModel: SafetyCoverModel, panelSize: SafetyCoverPanelSize, area: Double) -> Double {
        var price: Double = 0.0
        
        switch coverModel {
            // 5000
            case .StandardMesh5000M:
                if(shapeDescription == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_StandardMesh5000M_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_StandardMesh5000M_3x3_geometric(area: area)
                    }
                }
                else if(shapeDescription == .freeform) {
                    price = getUnitPrice_StandardMesh5000M_3x3_freeform(area: area)
                }
                
            // 7000
            case .HighShadeMesh7000MS:
                if(shapeDescription == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_HighShadeMesh7000MS_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_HighShadeMesh7000MS_3x3_geometric(area: area)
                    }
                }
                else if(shapeDescription == .freeform) {
                    price = getUnitPrice_HighShadeMesh7000MS_3x3_freeform(area: area)
                }
                
            // 9000
            case .MaxShadeMesh9000MX:
                if(shapeDescription == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_MaxShadeMesh9000MX_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_MaxShadeMesh9000MX_3x3_geometric(area: area)
                    }
                }
                else if(shapeDescription == .freeform) {
                    price = getUnitPrice_MaxShadeMesh9000MX_3x3_freeform(area: area)
                }

            // 1000
            case .HeavyDutySolid1000V:
                if(shapeDescription == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_HeavyDutySolid1000V_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_HeavyDutySolid1000V_3x3_geometric(area: area)
                    }
                }
                else if(shapeDescription == .freeform) {
                    price = getUnitPrice_HeavyDutySolid1000V_3x3_freeform(area: area)
                }
         
            // 500
            case .LiteSolid500P:
                if(shapeDescription == .geometric) {
                    if(panelSize == .fivebyfive) {
                        price = getUnitPrice_LiteSolid500P_5x5_geometric(area: area)
                    }
                    else if(panelSize == .threebythree) {
                        price = getUnitPrice_LiteSolid500P_3x3_geometric(area: area)
                    }
                }
                else if(shapeDescription == .freeform) {
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
