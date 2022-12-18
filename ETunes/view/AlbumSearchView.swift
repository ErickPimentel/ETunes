//
//  AlbumSearchView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/18/22.
//

import SwiftUI

struct AlbumSearchView: View {
    @StateObject var albumListViewModel = AlbumListViewModel()
    
    var body: some View {
        NavigationView{
            
            Group {
                if albumListViewModel.searchTerm.isEmpty {
                    AlbumPlaceholderView(searchTerm: $albumListViewModel.searchTerm)
                } else {
                    AlbumListView(albumListViewModel: albumListViewModel)
                }
            }
            .searchable(text: $albumListViewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}

struct AlbumPlaceholderView: View {
    
    @Binding var searchTerm: String
    let suggestions = ["Midnights", "Dangerous", "Highlights"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
            ForEach(suggestions, id: \.self){ text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                        .font(.title3)
                }
                
            }
        }
    }
}

struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView()
    }
}
