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
    @State private var priceStr: String = ""
    @State private var price: Double = 0
    @State private var selectedLiner = LinerBrand.Latham

    var body: some View {
        Section(header: Text("Liners")) {
            // Liner
            Text("Get liner price for rectanglular pool by brand").padding()
            
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
                    getPrice()
                }) {
                    Text("Get Price")
                }
            }

            TextField("Price", text: $priceStr).padding()

    //        Text("Hello, world!")
    //            .padding()
    //        Toggle(isOn: $toggleState) {
    //            Text("Toggler")
    //                .padding()
    //        }

        }
    }

    //-----------------
    //-----------------
    func getPrice() {
        var pool = PoolBase()
        
        
        pool = getPool_Rectangle()
        
        let price: Double = getPriceForPool(pool: pool)

        priceStr = "$\(price)"
    }

    //-----------------
    //-----------------
    func getPool_Rectangle() -> PoolBase {
        let nf = NumberFormatter()
        let l = nf.number(from: length)
        let w = nf.number(from: width)
        
        let pool = Rectangle(length: l!.doubleValue, width: w!.doubleValue)

        print("areaPool = \(pool.areaPool)")

        return pool
    }

    //-----------------
    //-----------------
    func getPriceForPool(pool: PoolBase) -> Double {
        let b: LinerBrand = selectedLiner
        let calc = LinerPriceCalculator(pool: pool, area: pool.areaPool, linerBrand: b)
        
        calc.calculatePrice()
        
        price = calc.priceResult.calculatedPrice
        
        return price
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
