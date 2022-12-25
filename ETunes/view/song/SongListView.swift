//
//  SongListView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var songListViewModel: SongListViewModel
    
    var body: some View {
        List{
            ForEach(songListViewModel.songs){ song in
                Text(song.trackName)
            }
            
            switch songListViewModel.state {
            case .good:
                Color.clear
                    .onAppear{
                        songListViewModel.loadMore()
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

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView(songListViewModel: SongListViewModel())
    }
}
