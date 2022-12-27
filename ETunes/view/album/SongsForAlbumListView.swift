//
//  SongsForAlbumListView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var songsForAlbumListViewModel: SongsForAlbumListViewModel
    let selectedSong: Song?
    
    var body: some View {
        
        ScrollViewReader{ proxy in
            
            ScrollView {
                if songsForAlbumListViewModel.state == .isLoading{
                    ProgressView()
                        .progressViewStyle(.circular)
                } else if songsForAlbumListViewModel.songs.count > 0 {
                    SongGridView(songs: songsForAlbumListViewModel.songs, selectedSong: selectedSong).onAppear{
                        print("scroll in list with \(songsForAlbumListViewModel.songs.count) songs")
                        proxy.scrollTo(selectedSong?.trackNumber, anchor: .center)
                    }
                }
            }
        }
    }
}

struct SongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsForAlbumListView(songsForAlbumListViewModel: SongsForAlbumListViewModel.example(), selectedSong: nil)
    }
}
