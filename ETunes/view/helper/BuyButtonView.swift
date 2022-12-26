//
//  BuyButtonView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct BuyButtonView: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let url = URL(string: urlString),
           let priceText = formattedPrice() {
            Link(destination: url){
                Text(priceText)
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
    
    private func formattedPrice() -> String? {
        
        guard let price = price else {
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        let priceString = formatter.string(from: NSNumber(value: price))
        return priceString ?? ""
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        let example = Song.example()
        BuyButtonView(
            urlString: example.previewURL,
            price: example.trackPrice,
            currency: example.currency)
    }
}
