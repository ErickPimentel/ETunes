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
        
        guard let url = createURL(for: searchTerm) else {
            return
        }
        print(url.absoluteString)
        print("start fetching data for \(searchTerm)")
        
        state = .isLoading
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                print("urlsession error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        for album in result.results{
                            self?.albums.append(album)
                        }
                        self?.page += 1
                        self?.state = (result.results.count == self?.limit) ? .good : .loadedAll
                    }
                } catch {
                    print("decoding error \(error)")
                    DispatchQueue.main.async {
                        self?.state = .error("Could not get data: \(error.localizedDescription)")
                    }
                }
                 
            }
            
        }.resume()
    }
    
    func createURL(for searchTerm: String) -> URL?{
        let baseURL = "https://itunes.apple.com/search?"
        
        let offset = page * limit
        
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: "album"),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
            
        ]
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    
    }
}
