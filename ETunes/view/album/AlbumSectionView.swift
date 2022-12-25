//
//  AlbumSectionView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct AlbumSectionView: View {
    
    let albums: [Album]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AlbumSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSectionView(albums: [Album.example()])
    }
}
