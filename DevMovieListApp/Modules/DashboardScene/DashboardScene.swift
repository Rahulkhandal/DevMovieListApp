//
//  DashboardScene.swift
//  DevMovieListApp
//
//  Created by Rahul on 15/06/24.
//

import Foundation

extension DashboardViewController: StoryboardController { }
final class DashboardScene: Scene {
    
    init(){}

    func configure(controller: DashboardViewController,
                   using factory: SceneFactory,
                   context: SceneFactoryContext) {
        let router = DashboardRouter(controller: controller, factory: factory)
        let viewModel = DashboardViewModel(router: router)
        controller.viewModel = viewModel
    }
}
