//
//  SongListViewModel.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/18/22.
//

import Foundation

class SongListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var songs: [Song] = [Song]()
    @Published var state: FetchState = .good
    
    private let apiService = APIService()
    
    let limit = 20
    var page: Int = 0
    
    func fetchSongs(for searchTerm: String){
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
        apiService.fetchSongs(for: searchTerm, page: page, limit: limit){ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        for song in results.results {
                            self?.songs.append(song)
                        }
                        self?.page += 1
                        self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                        print("fetched \(results.resultCount)")
                    
                    case .failure(let error):
                        self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
}
