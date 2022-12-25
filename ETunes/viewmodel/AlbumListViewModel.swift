//
//  AlbumListViewModel.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/17/22.
//
import Combine
import Foundation

class AlbumListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    @Published var state: FetchState = .good
    
    private let apiService = APIService()
    
    let limit = 20
    var page: Int = 0
    
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchAlbums(for: term)
        }.store(in: &subscriptions)
    }
    
    func clear(){
        state = .good
        albums = []
        page = 0
    }
    
    func loadMore(){
        fetchAlbums(for: searchTerm )
    }
    
    func fetchAlbums(for searchTerm: String){
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
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
                        print("fetched albums - \(results.resultCount)")
                    
                    case .failure(let error):
                        self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> AlbumListViewModel{
        let vm = AlbumListViewModel()
        vm.albums = [Album.example()]
        return vm
    }
}
