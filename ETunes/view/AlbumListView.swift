//
//  AlbumListView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/17/22.
//

import SwiftUI

struct AlbumListView: View {
    
    @StateObject var albumListViewModel = AlbumListViewModel()
    
    var body: some View {
        List(albumListViewModel.albums){ album in
            Text(album.collectionName)
        }
        .onAppear{
            albumListViewModel.fetchAlbums(for: albumListViewModel.searchTerm)
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
