//
//  AlbumDetailView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct AlbumDetailView: View {
    
    let album: Album
    
    @StateObject var songsForAlbumListViewModel: SongsForAlbumListViewModel
    
    init(album: Album){
        print("init album detail \(album.id)")
        self.album = album
        self._songsForAlbumListViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: album.id))
    }
    
    var body: some View {
        VStack {
            
            AlbumHeaderDetailView(album: album)
            
            SongsForAlbumListView(songsForAlbumListViewModel: songsForAlbumListViewModel, selectedSong: nil)
        }
        .onAppear {
            songsForAlbumListViewModel.fetch()
        }
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album.example())
    }
}
