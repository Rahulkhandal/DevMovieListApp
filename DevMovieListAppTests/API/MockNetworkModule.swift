//
//  MockNetworkModule.swift
//  DevMovieListAppTests
//
//  Created by Rahul on 18/06/24.
//

import Foundation

import DevNetworking


final class MockNetworkModule: NetworkModule {
    var simulatedNetworkResponse: NetworkResponse?
    var simulatedNetworkError: NetworkError?
    
    func perform(request: NetworkRequest, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) -> URLSessionTask? {
        call(completion: completion)
        return nil
    }
    
    func perform(urlRequest: URLRequest, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) -> URLSessionTask {
        call(completion: completion)
        return URLSession.shared.dataTask(with: urlRequest)
    }
    
    func call(completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) {
        if let response = simulatedNetworkResponse {
            completion?(.success(response))
        } else if let error = simulatedNetworkError {
            completion?(.failure(error))
        }
    }
}
