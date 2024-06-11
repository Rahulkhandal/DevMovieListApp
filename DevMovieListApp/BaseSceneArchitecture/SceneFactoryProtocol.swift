//
//  SceneFactoryProtocol.swift
//  DevMovieListApp
//
//  Created by Rahul on 11/06/24.
//

import Foundation

protocol SceneFactoryProtocol {

    func createViewController<SceneType: Scene>(_ scene: SceneType) -> SceneType.ViewControllerType
}

struct SceneFactoryContext {
}

final class SceneFactory: SceneFactoryProtocol {

    let context: SceneFactoryContext

    init() {
        self.context = SceneFactoryContext()
    }

    /// Takes a Scene instance, creates it's view controller and then calls configure with the model objects (in the Context).
    func createViewController<SceneType: Scene>(_ scene: SceneType) -> SceneType.ViewControllerType {
        let controller = scene.createViewController()
        scene.configure(controller: controller, using: self, context: self.context)
        return controller
    }
}
