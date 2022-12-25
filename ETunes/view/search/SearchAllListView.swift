//
//  SearchAllListView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct SearchAllListView: View {
    
    @ObservedObject var albumListViewModel: AlbumListViewModel
    @ObservedObject var songListViewModel: SongListViewModel
    @ObservedObject var movieListViewModel: MovieListViewModel
    
    var body: some View {
        VStack{
            Text("Search All")
    
            Text("Albums: \(albumListViewModel.albums.count)")
            Text("Songs: \(songListViewModel.songs.count)")
            Text("Movie: \(movieListViewModel.movies.count)")
        }
        
    }
}

//struct SearchAllListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchAllListView()
//    }
//}