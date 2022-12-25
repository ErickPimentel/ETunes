//
//  MovieListViewModel.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/18/22.
//
import Combine
import Foundation

class MovieListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var movies: [Movie] = [Movie]()
    @Published var state: FetchState = .good
    
    private let apiService = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchMovies(for: term)
        }.store(in: &subscriptions)
    }
    
    func clear(){
        state = .good
        movies = []
        //page = 0
    }
    
    func loadMore(){
        fetchMovies(for: searchTerm )
    }
    
    func fetchMovies(for searchTerm: String){
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
        apiService.fetchMovies(for: searchTerm){ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        self?.movies = results.results
                        self?.state = .good
                            print("fetched movies - \(results.resultCount)")
                    
                    case .failure(let error):
                        print("error loading movies: \(error)")
                        self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> MovieListViewModel{
        let vm = MovieListViewModel()
        vm.movies = [Movie.example()]
        return vm
    }
}
