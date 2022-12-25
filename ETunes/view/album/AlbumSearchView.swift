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
                    SearchPlaceholderView(searchTerm: $albumListViewModel.searchTerm)
                } else {
                    AlbumListView(albumListViewModel: albumListViewModel)
                }
            }
            .searchable(text: $albumListViewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}

struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView()
    }
}
