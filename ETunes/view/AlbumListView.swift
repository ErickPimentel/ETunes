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
                
                switch albumListViewModel.state {
                case .good:
                    Color.clear
                        .onAppear{
                            albumListViewModel.loadMore()
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
