//
//  SearchView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchTerm: String = ""
    @State private var selectedEntityType = EntityType.all
    
    @StateObject private var albumListViewModel = AlbumListViewModel()
    @StateObject private var songListViewModel = SongListViewModel()
    @StateObject private var movieListViewModel = MovieListViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                Picker("Select the media", selection: $selectedEntityType) {
                    ForEach(EntityType.allCases) { type in
                        Text(type.name())
                            .tag(type)
                    }
                    
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Divider()
                
                if searchTerm.count == 0 {
                    SearchPlaceholderView(searchTerm: $searchTerm)
                        .frame(maxHeight: .infinity)
                }
                
                switch selectedEntityType {
                     case .all:
                         SearchAllListView(
                            albumListViewModel:albumListViewModel,
                            songListViewModel: songListViewModel,
                            movieListViewModel: movieListViewModel)
                         .onAppear{
                             albumListViewModel.searchTerm = searchTerm
                             songListViewModel.searchTerm = searchTerm
                             movieListViewModel.searchTerm = searchTerm
                         }
                         
                     case .album:
                         AlbumListView(albumListViewModel: albumListViewModel)
                            .onAppear{
                                albumListViewModel.searchTerm = searchTerm
                            }
                     case .song:
                         SongListView(songListViewModel: songListViewModel)
                            .onAppear{
                                songListViewModel.searchTerm = searchTerm
                            }
                     case .movie:
                         MovieListView(movieListViewModel: movieListViewModel)
                            .onAppear{
                                movieListViewModel.searchTerm = searchTerm
                            }
                 }

            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: searchTerm){ newValue in
                
                switch selectedEntityType {
                case .all:
                    albumListViewModel.searchTerm = newValue
                    songListViewModel.searchTerm = newValue
                    movieListViewModel.searchTerm = newValue
                    
                case .album:
                    albumListViewModel.searchTerm = newValue
                    
                case .song:
                    songListViewModel.searchTerm = newValue
                    
                case .movie:
                    movieListViewModel.searchTerm = newValue
                    
                }
                
            }
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
