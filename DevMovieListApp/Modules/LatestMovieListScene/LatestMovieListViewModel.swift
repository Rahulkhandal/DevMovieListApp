//
//  LatestMovieListViewModel.swift
//  DevMovieListApp
//
//  Created by Rahul on 16/06/24.
//

import Foundation
import Combine

enum ViewState {
    case fetching
    case loading
    case finished
    case error(message: String)
}

protocol LatestMovieListViewModelProtocol: AnyObject {
    func fetchNextSetOfData()
    var datasource: [Movie] { get }
    var needsPrefetch: Bool { get }
    
    // Workaround for publisher properties in protocol @Published var viewState: ViewState = .fetching
    var viewState: ViewState { get }
    var viewStatePublished: Published<ViewState> { get }
    var viewStatePublisher: Published<ViewState>.Publisher { get }
}

final class LatestMovieListViewModel: LatestMovieListViewModelProtocol {
    private let router: LatestMovieListRouterProtocol
    private let movieService: FetchLatestMovieListProtocol

    @Published var viewState: ViewState = .fetching
    var viewStatePublished: Published<ViewState> { _viewState }
    var viewStatePublisher: Published<ViewState>.Publisher { $viewState }
    
    var datasource = [Movie]()

    
    private(set) var page = 1
    private(set) var totalPages: Int = 1
  

    var needsPrefetch: Bool {
        totalPages > page
       }
    
    init(router: LatestMovieListRouterProtocol,
         movieService: FetchLatestMovieListProtocol) {
        self.router = router
        self.movieService = movieService
        fetchData()
    }
    
    
    private func fetchData() {
        reset()
        viewState = .loading
                
        self.movieService.fetchLatestMovieList(page: page) {[weak self] result in

            switch result {
            case .success(let response):
                self?.datasource = response.results
                self?.totalPages = response.totalPages
                self?.viewState = .finished
                
            case .failure(let error):
                self?.viewState = .error(message: error.localizedDescription)
                break
            }
        }
    }
    
    
    func fetchNextSetOfData() {
        
        guard page != totalPages else { return }
        
        viewState = .fetching        
        page += 1
        
        self.movieService.fetchLatestMovieList(page: page) {[weak self] result in

            switch result {
            case .success(let response):
                self?.datasource += response.results
                self?.totalPages = response.totalPages
                self?.viewState = .finished
                
            case .failure(let error):
                self?.viewState = .error(message: error.localizedDescription)
                break
            }
        }
    }
    

    
   private func reset() {
        datasource.removeAll()
        page = 1        
    }
    
}
