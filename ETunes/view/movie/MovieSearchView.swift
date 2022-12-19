//
//  MovieListView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/18/22.
//

import SwiftUI

struct MovieSearchView: View {
    
    @StateObject private var movieListViewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView{
            
            Group {
                if movieListViewModel.searchTerm.isEmpty {
                    AlbumPlaceholderView(searchTerm: $movieListViewModel.searchTerm)
                } else {
                    MovieListView(movieListViewModel: movieListViewModel)
                }
            }
            .searchable(text: $movieListViewModel.searchTerm)
            .navigationTitle("Search Movies")
        }
    }
}

struct MovieSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
