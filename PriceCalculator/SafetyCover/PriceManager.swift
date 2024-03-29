//
//  PriceManager.swift
//  PriceCalculator
//
//  Created by John Tafoya on 4/15/21.
//
//  Implementation of the price calculations for **SAFETY COVERS**
//
//  **THIS MODULE IMPLEMENTS BUSINESS LOGIC**
//

import Foundation

enum CalculatePriceError {
    case ignore
    case validateInputs
    case configureFromPoolShape
}

struct PriceResult {
    var wasSuccessful = true
    var errorType = CalculatePriceError.ignore
    var calculatedPrice = 0.0
    init() {
        wasSuccessful = true
        errorType = CalculatePriceError.ignore
        calculatedPrice = 0.0
    }
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

struct SafetyCoverOptionSelection {
    var optionItem: SafetyCoverOptionItem
    var quantity: Int = 0
}

//====================================
class SafetyCoverPriceCalculator {
    private let _dataLayer: DataLayer = DataLayer()
    private var _area: Double?
    private var _dealerDiscountPercentage: Double
    private var _shapeDescription: ShapeDescription?
    private var _safetyCoverModel: SafetyCoverModel
    private var _safetyCoverPanelSize: SafetyCoverPanelSize
    private var _selectedOptions: [SafetyCoverOptionSelection]?

    var priceResult: PriceResult = PriceResult()

    init(safetyCoverModel: SafetyCoverModel, safetyCoverPanelSize: SafetyCoverPanelSize, dealerDiscountPercentage: Double = 0) {
        _area = nil
        _dealerDiscountPercentage = dealerDiscountPercentage
        _shapeDescription = ShapeDescription.undefined
        _safetyCoverModel = safetyCoverModel
        _safetyCoverPanelSize = safetyCoverPanelSize
        _selectedOptions = nil
    }
    

    func setArea(area: Double) {
        _area = area

        // Biz rule: Large covers require 3x3 spacing
        bizRule_BigPoolMustUse3x3()
    }
    
    func setPoolCharacteristics(shapeDescription: ShapeDescription) {   //, shape: PoolShape
        _shapeDescription = shapeDescription

        // Biz Rule: Per "SC Sq ft.pdf": For freeform shapes:
        bizRule_FreeformShapeMustUse3x3()
    }
    
    func setSelectedOptions(selectedOptions: [SafetyCoverOptionSelection]) {
        _selectedOptions = selectedOptions
    }
    
    // Needed by tests (if nothing else)
    func getSafetyCoverPanelSize() -> SafetyCoverPanelSize {
        return _safetyCoverPanelSize
    }
    
    //--------------------------------
    // BUSINESS RULE IMPLEMENTATIONS
    //--------------------------------
    // Biz Rule: Per "SC Sq ft.pdf": For freeform shapes:
    //  - "All freeform covers will be built with 3' x 3' spacing"
    //--------------------------------
    private func bizRule_FreeformShapeMustUse3x3() {
        if(_shapeDescription == ShapeDescription.freeform) {
            // Force the panel size to 3x3
            if(_safetyCoverPanelSize != SafetyCoverPanelSize.threebythree) {
                // TODO
                // Notify the user to explain why the value the user set
                // cannot be used. This should be controlled by the UI but
                // just in case...
            }
            
            _safetyCoverPanelSize = SafetyCoverPanelSize.threebythree
        }
    }

    //--------------------------------
    // Biz Rule: Per "SC Sq ft.pdf": For freeform shapes:
    //  - "All freeform covers will be built with 3' x 3' spacing"
    //--------------------------------
    private func bizRule_BigPoolMustUse3x3() {
        if(_area == nil) {
            // Log this? Notify the user? Throw? Not sure what to do here...
            return
        }
        
        if(_area! > _dataLayer.getAreaThresholdToMandate3x3Spacing()) {
            if(_safetyCoverPanelSize != SafetyCoverPanelSize.threebythree) {
                // TODO
                // Notify the user to explain why the value the user set
                // cannot be used. This should be controlled by the UI but
                // just in case...
            }
            _safetyCoverPanelSize = SafetyCoverPanelSize.threebythree
        }
    }

    //--------------------------------
    // CORE CALCULATOR
    //--------------------------------
    func calculatePrice() {
        // Validate inputs
        // TODO

        // Get the baseline for the square footage
        let unitPrice: Double = _dataLayer.getUnitPriceForArea(shapeDescription: _shapeDescription!, coverModel: _safetyCoverModel, panelSize: _safetyCoverPanelSize, area: self._area!)
        
        // This is a crappy implementation done just to get this done ASAP
        if(unitPrice >= 0) {
            priceResult.calculatedPrice = self._area! * unitPrice

            // Add the options
            priceResult.calculatedPrice += getTotalForOptionsList(selectedOptions: _selectedOptions)
            
            // Apply any dealer discount
            if(_dealerDiscountPercentage > 0) {
                priceResult.calculatedPrice -= (priceResult.calculatedPrice * _dealerDiscountPercentage)
            }
        }
        else {
            priceResult.wasSuccessful = false
        }
    }
    
    //--------------------------------
    func getTotalForOptionsList(selectedOptions: [SafetyCoverOptionSelection]?) -> Double {
        var optionsTotal: Double = 0.0
        
        if(selectedOptions != nil) {
            for selectedOption in selectedOptions! {
                // Get the item from the data layer
                let rawItem: SafetyCoverOptionItem = _dataLayer.getSafetyCoverOptionItem(name: selectedOption.optionItem.name, safetyCoverPanelSize: _safetyCoverPanelSize)
                
                // Multiple its unit price times the quantity and add it to the total
                switch(rawItem.uom) {
                    case .each:
                        optionsTotal += (rawItem.unitPrice * (Double(selectedOption.quantity)))
                    case .linearfoot:
                        optionsTotal += (rawItem.unitPrice * (Double(selectedOption.quantity)))
                    case .poolarea:
                        optionsTotal += (rawItem.unitPrice * self._area!)
                    case .coverarea:
                        optionsTotal += (rawItem.unitPrice * self._area!)

                    case .perimeter:
                        // TODO
                        optionsTotal += 0
                    case .undefined:
                        // TODO
                        optionsTotal += 0
                }
            }
        }
        
        return optionsTotal
    }
    
    func getUnitPriceForArea() -> Double {
        let unitPrice: Double = _dataLayer.getUnitPriceForArea(shapeDescription: self._shapeDescription!, coverModel: _safetyCoverModel, panelSize: _safetyCoverPanelSize, area: self._area!)
        return unitPrice
    }
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
//func validateInputs() -> Bool {
//    // TODO
//    return true
//}

