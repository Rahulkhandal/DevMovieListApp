//
//  RouterTests.swift
//  DevMovieListAppTests
//
//  Created by Rahul on 18/06/24.
//

import Foundation
import XCTest

@testable import DevMovieListApp

private final class RouterTestViewController: UIViewController { }

private final class RouterTestSceneFactory: SceneFactoryProtocol {

    let id = UUID().uuidString

    func createViewController<SceneType>(_ scene: SceneType) -> SceneType.ViewControllerType where SceneType: Scene {
        return scene.createViewController()
    }
}

private final class TestRouter: Router<RouterTestViewController> { }

final class RouterTests: XCTestCase {

    func testRouter_shouldInitializeWithCustomController() {
        let controller = RouterTestViewController()
        let factory = RouterTestSceneFactory()

        let router = TestRouter(controller: controller, factory: factory)

        XCTAssertEqual(router.viewController, controller)
        XCTAssertEqual((router.factory as? RouterTestSceneFactory)?.id, factory.id)
    }
}
