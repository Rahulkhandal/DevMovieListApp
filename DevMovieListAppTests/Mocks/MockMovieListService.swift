//
//  MockMovieListService.swift
//  DevMovieListAppTests
//
//  Created by Rahul on 18/06/24.
//

import Foundation
@testable import DevMovieListApp

final class MockMovieListService: FetchLatestMovieListProtocol {
    
    var successResponse: MovieResult?
    var failureResponse: Error?
    
    func fetchLatestMovieList(page: Int,
                              completion: @escaping FetchLatestMovieListProtocolUseCaseCompletionHandler) {
        if let response = successResponse {
            completion(.success(response))
        }
        else if let error = failureResponse {
            completion(.failure(error))
        }
        
    }
}
