//
//  SongsForAlbumListView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var songsForAlbumListViewModel: SongsForAlbumListViewModel
    
    
    var body: some View {
        VStack {
            ForEach(songsForAlbumListViewModel.songs){ song in
                HStack{
                    Text("\(song.trackNumber)")
                    Text(song.trackName)
                    Text(formattedDuration(time: song.trackTimeMillis))
                    
                    BuySongButtonView(
                        urlString: song.previewURL,
                        price: song.trackPrice,
                        currency: song.currency)
                }
            }
        }
    }
    
    func formattedDuration(time: Int) -> String {
        
        let timeInSeconds = time / 1000
        
        let interval = TimeInterval(timeInSeconds)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        
        return formatter.string(from: interval) ?? ""
    }
}

struct SongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsForAlbumListView(songsForAlbumListViewModel: SongsForAlbumListViewModel.example())
    }
}
