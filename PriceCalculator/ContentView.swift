//
//  ContentView.swift
//  PriceCalculator
//
//  Created by John Tafoya on 4/15/21.
//

import SwiftUI

struct ContentView: View {
    //@State private var toggleState = true
    @State private var length: String = ""
    @State private var width: String = ""
    @State private var p: String = ""
    @State private var price: Double = 0
    @State private var selectedLiner = LinerBrand.Latham

    //let upchargeAmtExpected: Double = 177.00
    //let calc = LinerPriceCalculator(pool: nil, area: 0, linerBrand: LinerBrand.undefined)

    var body: some View {
//        let chgAmt = calc.getFreeformIrregularShapeChargeAmount()
//        let s = DoubleHelper.roundToHundredth(value: chgAmt)
//        Text("chgAmt=\(s)").padding()
        
        Text("Get liner price for rectanglular pool by brand").padding()
        Spacer()
        
        Picker("Liner", selection: $selectedLiner) {
            Text("Latham").tag(LinerBrand.Latham)
            Text("LathamModel2").tag(LinerBrand.LathamModel2)
            Text("LathamModel3").tag(LinerBrand.LathamModel3)
            Text("Premier").tag(LinerBrand.Premier)
            Text("Signature").tag(LinerBrand.Signature)
        }
        
        TextField("Length", text: $length).padding()
        TextField("Width", text: $width).padding()

        Section {
            Button(action: {
//                //print("l:\(length), w:\(width)")
//                let nf = NumberFormatter()
//                let l = nf.number(from: length)
//                let w = nf.number(from: width)
//                price = (l!.doubleValue * w!.doubleValue)
//                p = "$\(price)"
                print("selectedLinerStr='\($selectedLiner)'")
                getPrice()
            }) {
                Text("Get Price")
            }
        }

        TextField("Price", text: $p).padding()

//        Text("Hello, world!")
//            .padding()
//        Toggle(isOn: $toggleState) {
//            Text("Toggler")
//                .padding()
//        }
    }

    //-----------------
    //-----------------
    func getPrice() {
        let nf = NumberFormatter()
        
        let l = nf.number(from: length)
        let w = nf.number(from: width)
        
        //price = (l!.doubleValue * w!.doubleValue)
        
        let pool = Rectangle(length: l!.doubleValue, width: w!.doubleValue)
        print("areaPool = \(pool.areaPool)")
        
        let b: LinerBrand = selectedLiner
        let calc = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: b)
        
        calc.calculatePrice()
        
        price = calc.priceResult.calculatedPrice
        p = "$\(price)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
