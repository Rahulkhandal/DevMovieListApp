//
//  MovieDetailViewModel.swift
//  DevMovieListApp
//
//  Created by Rahul on 18/06/24.
//

import Foundation

protocol MovieDetailViewModelViewModelProtocol: AnyObject {

    var datasource: MovieDetailResult? { get }

    
    // Workaround for publisher properties in protocol @Published var viewState: ViewState = .fetching
    var viewState: ViewState { get }
    var viewStatePublished: Published<ViewState> { get }
    var viewStatePublisher: Published<ViewState>.Publisher { get }
}

final class MovieDetailViewModel: MovieDetailViewModelViewModelProtocol {
    
    @Published var viewState: ViewState = .fetching
    var viewStatePublished: Published<ViewState> { _viewState }
    var viewStatePublisher: Published<ViewState>.Publisher { $viewState }
    
    var datasource: MovieDetailResult?

    
    private let router: MovieDetailRouterProtocol
    private let service: FetchMovieDetailProtocol
    private let movieId: String
    
    init(router: MovieDetailRouterProtocol,
         service: FetchMovieDetailProtocol,
         movieId: String) {
        self.router = router
        self.service = service
        self.movieId = movieId
        fetchData()
    }
    
    private func fetchData() {
        viewState = .loading
        
        self.service.fetchMovieDetail(movieId: movieId){[weak self] result in

            switch result {
            case .success(let response):
                self?.datasource = response
                self?.viewState = .finished
                
            case .failure(let error):
                self?.viewState = .error(message: error.localizedDescription)
                break
            }
        }
    }
    
    
}
