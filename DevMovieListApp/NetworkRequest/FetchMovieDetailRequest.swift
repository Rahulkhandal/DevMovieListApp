//
//  FetchMovieDetailRequest.swift
//  DevMovieListApp
//
//  Created by Rahul on 18/06/24.
//

import Foundation
import DevNetworking

struct FetchMovieDetailRequest: NetworkRequest {
   
    private enum KeyPaths {
        static let language = "language"
    }
    
    var language: String = "en-US"
    let movieId: String
    
    var path: String { "/3/movie/\(movieId)" }
    
    let method = NetworkRequestType.get
    
    var requiresAuthenticationToken: Bool {
        return true
    }
    
    var additionalHeaderFields: [String : String] {
        return ["accept": "application/json"]
    }
}
