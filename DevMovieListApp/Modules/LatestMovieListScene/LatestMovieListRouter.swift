//
//  LatestMovieListRouter.swift
//  DevMovieListApp
//
//  Created by Rahul on 16/06/24.
//

import Foundation

protocol LatestMovieListRouterProtocol {
    func navigateToDetail(movieId: String)
}

final class LatestMovieListRouter: Router<LatestMovieListViewController>, LatestMovieListRouterProtocol {
    func navigateToDetail(movieId: String) {
        let detailScene = MovieDetailScene(movieId: movieId)
        let controller = factory.createViewController(detailScene)
        self.viewController?.navigationController?.pushViewController(controller, animated: false)
    }
}
