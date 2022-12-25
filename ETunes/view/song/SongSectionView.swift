//
//  SongSectionView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct SongSectionView: View {
    
    let songs: [Song]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SongSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SongSectionView(songs: [Song.example()])
    }
}
