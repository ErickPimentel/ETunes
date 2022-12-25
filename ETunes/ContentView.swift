//
//  ContentView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/17/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.note")
                }
            
            MovieSearchView()
                .tabItem {
                    Label("Movie", systemImage: "tv")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
