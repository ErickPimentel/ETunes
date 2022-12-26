//
//  AlbumDetailView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct AlbumDetailView: View {
    
    let album: Album
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            ImageLoadingView(urlString: album.artworkUrl100, size: 100)
            
            VStack(alignment: .leading){
                Text(album.collectionName)
                    .font(.footnote)
                    .foregroundColor(Color(.label))
                Text(album.artistName)
                    .padding(.bottom, 5)
                    
                
                Text(album.primaryGenreName)
                Text("\(album.trackCount) songs")
                Text("Released: \(formattedDate(value: album.releaseDate))")
            }
            .font(.caption)
            .foregroundColor(.gray)
            .lineLimit(1)
            
            Spacer(minLength: 20)
            
            BuyButtonView(
                urlString: album.collectionViewURL,
                price: album.collectionPrice,
                currency: album.currency)
        }
    }
    
    private func formattedDate(value: String) -> String {
        let dateFormatterGetter = DateFormatter()
        dateFormatterGetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        guard let date = dateFormatterGetter.date(from: value) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album.example())
    }
}
