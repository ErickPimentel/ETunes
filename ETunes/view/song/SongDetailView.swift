//
//  SongDetailView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/27/22.
//

import SwiftUI

struct SongDetailView: View {
    
    let song: Song
    
    var body: some View {
        Text(song.trackName)
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView(song: Song.example())
    }
}
