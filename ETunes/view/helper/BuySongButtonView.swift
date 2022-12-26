//
//  BuySongButtonView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/26/22.
//

import SwiftUI

struct BuySongButtonView: View {
    
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let price = price{
            BuyButtonView(
                urlString: urlString,
                price: price,
                currency: currency
            )
        } else {
            Text("ALBUM ONLY")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct BuySongButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let example = Song.example()
        BuySongButtonView(
            urlString: example.previewURL,
            price: example.trackPrice,
            currency: example.currency)
    }
}
