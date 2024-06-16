//
//  FetchLatestMovieListRequest.swift
//  DevMovieListApp
//
//  Created by Rahul on 14/06/24.
//

import Foundation
import DevNetworking

struct FetchLatestMovieListRequest: NetworkRequest {
    private enum KeyPaths {
        static let language = "language"
        static let page = "page"
    }
    
    var page: Int = 1
    var language: String = "en-US"
    
    let path = "/3/movie/now_playing"
    let method = NetworkRequestType.get
    
    var parameters: [String : String]? {
        [KeyPaths.language: language, KeyPaths.page: String(page)]
    }
    
    var requiresAuthenticationToken: Bool {
        return true
    }
    
    var additionalHeaderFields: [String : String] {
        return ["accept": "application/json"]
    }
}
