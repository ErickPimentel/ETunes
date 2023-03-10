//
//  SongDetailView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/27/22.
//

import SwiftUI

struct SongDetailView: View {
    
    let song: Song
    
    @StateObject var songsForAlbumListViewModel: SongsForAlbumListViewModel
    @StateObject var albumForSongViewModel = AlbumForSongViewModel()
    
    init(song: Song){
        print("init song detail \(song.id)")
        self.song = song
        self._songsForAlbumListViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: song.collectionID))
    }
    
    var body: some View {
        VStack{
            if let album = albumForSongViewModel.album{
                AlbumHeaderDetailView(album: album)
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            SongsForAlbumListView(songsForAlbumListViewModel: songsForAlbumListViewModel, selectedSong: song)
        }.onAppear{
            songsForAlbumListViewModel.fetch()
            albumForSongViewModel.fetch(song: song)
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView(song: Song.example())
    }
}
