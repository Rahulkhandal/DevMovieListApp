//
//  DashboardViewController.swift
//  DevMovieListApp
//
//  Created by Rahul on 16/06/24.
//

import Foundation
import UIKit

protocol TabContainerDelegate: AnyObject {
    func sectionSelected(_ section: DashboardTab)
}

final class DashboardViewController: UIViewController {
    private typealias MainViewController = UIViewController
        
    var viewModel: DashboardViewModel!
    
    /// Lazy variable that will choose what's the correct VC to embed
    /// We're downcasting to UIViewController because embedding doesn't care about it
    private lazy var mainController: MainViewController = {
        let sections = DashboardTab.allCases
        let mainController: MainViewController =
                MoviesTabController(sections: sections,
                                                 viewControllers: self.controllers,
                                                 delegate: self.viewModel)
        
        return mainController
    }()
    
    /// These are the viewControllers that should be managed by either the Split or the TabBar
    /// We're setting the `tabBarItem` regardless of UIDevice, because they're only used on iPhone anyway
    private lazy var controllers: [UIViewController] = {
        DashboardTab.allCases.compactMap {
            let viewController = self.viewModel.getViewControllerForSection($0)
            let item = UITabBarItem(title: $0.label, image: UIImage(named: $0.image), selectedImage: nil)
            item.tag = $0.tag
            viewController?.tabBarItem = item
            return viewController
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.mainController.view)
        self.view.bounds = self.mainController.view.bounds
        self.addChild(self.mainController)        
    }
}
