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
            List(albumListViewModel.albums){ album in
                Text(album.collectionName)
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
