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
        ScrollView {
            
            if songsForAlbumListViewModel.state == .isLoading{
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Grid(horizontalSpacing: 20) {
                        ForEach(songsForAlbumListViewModel.songs){ song in
                            GridRow{
                                Text("\(song.trackNumber)")
                                    .font(.footnote)
                                    .gridColumnAlignment(.trailing)
                                
                                Text(song.trackName)
                                    .gridColumnAlignment(.leading)
                                
                                Spacer()
                                
                                Text(formattedDuration(time: song.trackTimeMillis))
                                    .font(.footnote)
                                
                                BuySongButtonView(
                                    urlString: song.previewURL,
                                    price: song.trackPrice,
                                    currency: song.currency)
                            }
                            Divider()
                            
                        }
                    }
                    .padding([.vertical, .leading])
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
