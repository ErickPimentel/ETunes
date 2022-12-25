//
//  MovieListView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/18/22.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var movieListViewModel: MovieListViewModel
    
    var body: some View {
        List{
            ForEach(movieListViewModel.movies){ movie in
                MovieRowView(movie: movie)
            }
            
            switch movieListViewModel.state {
            case .good:
                Color.clear
                    .onAppear{
                        movieListViewModel.loadMore()
                    }
                
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .loadedAll:
                //EmptyView()
                Color.gray
                
            case .error(let message):
                Text(message)
                    .foregroundColor(.pink)
            }
        }
        .listStyle(.plain)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movieListViewModel: MovieListViewModel())
    }
}
