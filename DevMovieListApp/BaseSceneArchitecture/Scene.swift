//
//  Scene.swift
//  DevMovieListApp
//
//  Created by Rahul on 11/06/24.
//

import UIKit
import Foundation

/// A  Scene  is a type used to create and configure a view controller
protocol Scene {
    associatedtype ViewControllerType: UIViewController

    /// Implement this to return a new instance of the view controller representing this scene.
    ///
    func createViewController() -> ViewControllerType

    /// Implement this to configure your view controller i.e. set it's view model if it's MVVM etc.
    ///
    func configure(controller: ViewControllerType, using factory: SceneFactory, context: SceneFactoryContext)
}

extension Scene where ViewControllerType: StoryboardController {

    private var sceneName: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }

    func createViewControllerFromStoryboard(bundle: Bundle?) -> ViewControllerType {
        do {
            return try ViewControllerType.instanceFromStoryboard(named: self.sceneName, bundle: bundle)
        } catch {
            fatalError("Failed to create view controller from storyboard: \(error)")
        }
    }

    /*
     Unhide this if we use storyboard to create view controller
    /// Default implementation of createViewController
    func createViewController() -> ViewControllerType {
        return self.createViewControllerFromStoryboard(bundle: nil)
    }
     */
    
    /// Default implementation of createViewController
    func createViewController() -> ViewControllerType {
        return ViewControllerType(nibName:nil, bundle:nil)
    }
}
