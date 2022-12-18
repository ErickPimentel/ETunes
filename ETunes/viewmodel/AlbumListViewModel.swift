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
    
    @Published var isLoading: Bool = false
    
    let limit = 20
    var page: Int = 0
    
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
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
        
        guard !isLoading else {
            return
        }
        
        let offset = page * limit
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)&offset=\(offset)") else {
            return
        }
        
        print("start fetching data for \(searchTerm)")
        
        isLoading = true
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                print("urlsession error: \(error.localizedDescription)")
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        for album in result.results{
                            self?.albums.append(album)
                        }
                        self?.page += 1
                    }
                } catch {
                    print("decoding error \(error)")
                }
                 
            }
            
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
        }.resume()
    }
}
