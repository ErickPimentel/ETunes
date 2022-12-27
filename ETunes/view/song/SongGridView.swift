//
//  SongGridView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/27/22.
//

import SwiftUI

struct SongGridView: View {
    
    let songs: [Song]
    let selectedSong: Song?
    
    var body: some View {
        
        Grid(horizontalSpacing: 20) {
                ForEach(songs){ song in
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
                    .foregroundColor(song == selectedSong ? Color.accentColor : Color(.label))
                    .id(song.trackNumber)
                    
                    Divider()
                    
                }
            }
            .padding([.vertical, .leading])
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

struct SongGridView_Previews: PreviewProvider {
    static var previews: some View {
        SongGridView(songs: [Song.example()], selectedSong: nil)
    }
}
