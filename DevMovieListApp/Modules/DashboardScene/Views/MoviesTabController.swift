//
//  MoviesTabController.swift
//  DevMovieListApp
//
//  Created by Rahul on 16/06/24.
//

import Foundation
import UIKit

final class MoviesTabController: UITabBarController {

    private let sections: [DashboardTab]

    private weak var tabContainerDelegate: TabContainerDelegate?

    init(sections: [DashboardTab],
         viewControllers: [UIViewController],
         delegate: TabContainerDelegate) {
        self.sections = sections
        self.tabContainerDelegate = delegate

        super.init(nibName: nil, bundle: nil)

        self.viewControllers = viewControllers

    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .ambience(1)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let section = self.sections.first(where: { $0.tag == item.tag }) else { return }
        self.tabContainerDelegate?.sectionSelected(section)
    }
}
