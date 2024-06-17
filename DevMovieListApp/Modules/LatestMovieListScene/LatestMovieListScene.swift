//
//  LatestMovieListScene.swift
//  DevMovieListApp
//
//  Created by Rahul on 16/06/24.
//

import Foundation

extension LatestMovieListViewController: StoryboardController { }

final class LatestMovieListScene: Scene {
    
    init() {}
    
    // Method to configure the ViewController after it's creation(i.e., create the ViewModel)
    // This is used by SceneFactory's `createViewController` method which in turn should be called by a Router instance
    func configure(controller: LatestMovieListViewController, using factory: SceneFactory, context: SceneFactoryContext) {
        let router = LatestMovieListRouter(controller: controller, factory: factory)
        let viewModel = LatestMovieListViewModel(router: router, 
                                                 movieService: context.movieListService)
        controller.viewModel = viewModel
    }
    
}
