//
//  SongsForAlbumListViewModel.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import Foundation


class SongsForAlbumListViewModel: ObservableObject {
    
    let albumID: Int
    @Published var songs = [Song]()
    @Published var state: FetchState = .good
    
    private let apiService = APIService()
    
    init(albumID: Int){
        self.albumID = albumID
        print("init for songs for album \(albumID)")
    }
    
    func fetch(){
        fetchSongs(for: albumID)
    }
    
    private func fetchSongs(for albumID: Int){
        apiService.fetchSongs(for: albumID){ [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let results):
                        
                            var songs = results.results
                            if results.resultCount > 0 {
                                _ = songs.removeFirst()
                            }
                        
                            self?.songs = songs
                            self?.state = .good
                            print("fetched \(results.resultCount) songs for albumID: \(albumID) ")
                        
                        case .failure(let error):
                            self?.state = .error("Could not load: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    static func example() -> SongsForAlbumListViewModel {
        let vm = SongsForAlbumListViewModel(albumID: 1)
        vm.songs = [Song.example(), Song.example2()]
        return vm
    }
}
