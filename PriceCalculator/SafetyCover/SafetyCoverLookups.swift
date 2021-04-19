//
//  SafetyCoverLookups.swift
//  PriceCalculator
//
//  Created by John Tafoya on 4/18/21.
//

import Foundation

//    Sq Feet       Price for 5000M STANDARD MESH - Green/Blue/Tan/Grey
//    0    300      $4.14
//    301    400    $3.35
//    401    500    $3.06
//    501    600    $2.80
//    601    650    $2.69
//    651    700    $2.57
//    701    800    $2.52
//    801    900    $2.41
//    901    1000   $2.29
//    1001    1200  $2.24
//    1201    1300  $2.17
//    1301    1600  $2.16
//    1601    1900  $2.00
//    1901    2000  $1.94
//    2001    10000 Call for Quote
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
//    else if((2001 < area) && (area <= 2000)) {
//        pricePerSqFoot = 3.35
//    }

    if( pricePerSqFoot > 0) {
        finalPrice = pricePerSqFoot * area
    }
    
    return finalPrice
}
