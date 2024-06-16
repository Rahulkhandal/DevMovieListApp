//
//  DashboardRouter.swift
//  DevMovieListApp
//
//  Created by Rahul on 15/06/24.
//

import Foundation
import UIKit

protocol DashboardRouterProtocol {
    func instantiateLatestMovieListScene() -> UIViewController
}

final class DashboardRouter: Router<DashboardViewController>, DashboardRouterProtocol {
    
    func instantiateLatestMovieListScene() -> UIViewController {
        let scene = LatestMovieListScene()
        let sceneVC = self.factory.createViewController(scene)
        let navigationVC = UINavigationController(rootViewController: sceneVC)
        return navigationVC
    }
    
}
