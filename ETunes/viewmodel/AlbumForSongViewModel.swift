//
//  AlbumForSongViewModel.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/27/22.
//

import Foundation

class AlbumForSongViewModel: ObservableObject {
    
    @Published var album: Album? = nil
    @Published var state: FetchState = .good
    
    let apiService = APIService()
    
    func fetch(song: Song){
        
        let albumId = song.collectionID
        
        state = .isLoading
        
        apiService.fetchAlbum(for: albumId){ [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                    case .failure(let error):
                        print("error when fetching album with id: \(error)")
                        self?.state = .error(error.localizedDescription)
                case .success(let results):
                    print("succesfully fetched album for song \(song.trackName)")
                    self?.album = results.results.first
                }
            }
            
        }
    }
}
