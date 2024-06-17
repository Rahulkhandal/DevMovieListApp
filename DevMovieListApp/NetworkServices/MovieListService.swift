//
//  MovieListService.swift
//  DevMovieListApp
//
//  Created by Rahul on 12/06/24.
//

import Foundation
import DevNetworking


protocol FetchLatestMovieListProtocol {
    func fetchLatestMovieList(page: Int,
                              completion: @escaping FetchLatestMovieListProtocolUseCaseCompletionHandler)
}

typealias FetchLatestMovieListProtocolUseCaseCompletionHandler = (Result<MovieResult, Error>) -> Void


final class MovieListService: FetchLatestMovieListProtocol {
   
    private let apiClient: NetworkModule

    
    init(networkModule: NetworkModule) {
        self.apiClient = networkModule
    }
    
    func fetchLatestMovieList(page: Int,
                              completion: @escaping FetchLatestMovieListProtocolUseCaseCompletionHandler) {
        let request = FetchLatestMovieListRequest(page: page)
        apiClient.performAndDecode(request: request,
                          responseType: MovieResult.self) { result in
            switch result {
            case let .success(movieResult):
                completion(.success(movieResult))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
