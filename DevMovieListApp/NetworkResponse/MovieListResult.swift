//
//  MovieListResult.swift
//  DevMovieListApp
//
//  Created by Rahul on 17/06/24.
//

import Foundation

struct MovieResult: Codable, Paginable {

    let results: [Movie]
    let currentPage: Int
    let totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case results
        case currentPage = "page"
        case totalPages = "total_pages"
    }

}
