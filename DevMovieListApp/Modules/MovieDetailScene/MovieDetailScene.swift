//
//  MovieDetailScene.swift
//  DevMovieListApp
//
//  Created by Rahul on 18/06/24.
//

import Foundation

extension MovieDetailViewController: StoryboardController { }

final class MovieDetailScene: Scene {
    let movieId: String
    init(movieId: String) {
        self.movieId = movieId
    }
    
    // Method to configure the ViewController after it's creation(i.e., create the ViewModel)
    // This is used by SceneFactory's `createViewController` method which in turn should be called by a Router instance
    func configure(controller: MovieDetailViewController, using factory: SceneFactory, context: SceneFactoryContext) {
        let router = MovieDetailRouter(controller: controller, factory: factory)
        let viewModel = MovieDetailViewModel(router: router,
                                             service: context.movieDetailService,
                                             movieId: movieId)
        controller.viewModel = viewModel
    }
    
}
