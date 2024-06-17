//
//  MovieDetailService.swift
//  DevMovieListApp
//
//  Created by Rahul on 18/06/24.
//

import Foundation
import DevNetworking


protocol FetchMovieDetailProtocol {
    func fetchMovieDetail(movieId: String,
                              completion: @escaping FetchMovieDetailProtocolUseCaseCompletionHandler)
}

typealias FetchMovieDetailProtocolUseCaseCompletionHandler = (Result<MovieDetailResult, Error>) -> Void


final class MovieDetailService: FetchMovieDetailProtocol {
   
    private let apiClient: NetworkModule

    
    init(networkModule: NetworkModule) {
        self.apiClient = networkModule
    }
    
    func fetchMovieDetail(movieId: String,
                              completion: @escaping FetchMovieDetailProtocolUseCaseCompletionHandler) {
        let request = FetchMovieDetailRequest(movieId: movieId)
        
        apiClient.performAndDecode(request: request,
                          responseType: MovieDetailResult.self) { result in
            switch result {
            case let .success(movieResult):
                completion(.success(movieResult))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
