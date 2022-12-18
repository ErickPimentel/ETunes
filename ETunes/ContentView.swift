//
//  ContentView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/17/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Search")
                .padding()
            
            AlbumListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
