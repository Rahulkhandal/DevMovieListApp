//
//  MovieDetailResult.swift
//  DevMovieListApp
//
//  Created by Rahul on 18/06/24.
//

import Foundation

struct MovieDetailResult: Codable {
    
    let id: Int
    let title: String
    let genres: [Genre]?
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genres
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
}
