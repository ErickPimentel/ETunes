//
//  AlbumListViewModel.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/17/22.
//
import Combine
import Foundation

class AlbumListViewModel: ObservableObject {
    
    enum State: Comparable {
        case good
        case isLoading
        case loadedAll
        case error(String)
    }
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    
    @Published var state: State = .good {
        didSet {
            print("state changed to: \(state)")
        }
    }
    
    let limit = 20
    var page: Int = 0
    
    let apiService = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.albums = []
                self?.fetchAlbums(for: term)
        }.store(in: &subscriptions)
    }
    
    func loadMore(){
        fetchAlbums(for: searchTerm )
    }
    
    func fetchAlbums(for searchTerm: String){
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == State.good else {
            return
        }
        
        state = .isLoading
        
        apiService.fetchAlbums(for: searchTerm, page: page, limit: limit){ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        for album in results.results {
                            self?.albums.append(album)
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
