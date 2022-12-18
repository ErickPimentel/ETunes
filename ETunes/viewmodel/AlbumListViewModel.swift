//
//  AlbumListViewModel.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/17/22.
//

import Foundation

class AlbumListViewModel: ObservableObject {
    
    @Published var searchTerm: String = "Jack Johnson"
    @Published var albums: [Album] = [Album]()
    
    func fetchAlbums(for searchTerm: String){
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("urlsession error: \(error.localizedDescription)")
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    self.albums = result.results
                } catch {
                    print("decoding error \(error)")
                }
                 
            }
        }.resume()
    }
}
