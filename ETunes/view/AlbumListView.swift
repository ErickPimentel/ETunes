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
        NavigationView{
            List{
                ForEach(albumListViewModel.albums){ album in
                    Text(album.collectionName)
                }
                
                if albumListViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    Color.red
                        .onAppear {
                            albumListViewModel.loadMore()
                        }
                }
                
            }
            .listStyle(.plain)
            .searchable(text: $albumListViewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
