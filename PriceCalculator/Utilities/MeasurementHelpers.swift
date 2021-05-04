//
//  MeasurementHelpers.swift
//  PriceCalculator
//
//  Created by John Tafoya on 4/20/21.
//

import Foundation

struct MeasurementHelper {
    //--------------------------------
    func feetAndInchesToFeet(footVal: Int, inchVal: Int) -> Double {
        let val1 = (Double)(footVal)
        let val2 = (Double)(inchVal) / 12.0
        let val3 = val1 + val2
        return val3
    }
}

//---------------------------------------------------------------------
//---------------------------------------------------------------------
func getArea_geometric(aFeet: Double, aInches: Double, bFeet: Double, bInches: Double) -> Double {
    let aVal: Double = (2 + (aFeet + (aInches / 12)))
    let bVal: Double = (2 + (bFeet + (bInches / 12)))
    let area = aVal * bVal
    
    return area
}
