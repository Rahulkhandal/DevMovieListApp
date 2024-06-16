//
//  DashboardViewModel.swift
//  DevMovieListApp
//
//  Created by Rahul on 15/06/24.
//

import Foundation
import Combine
import UIKit

enum DashboardTab: Hashable, Identifiable, CaseIterable {
    
    case latest
    case popular
    
    var id: DashboardTab { self }
}

extension DashboardTab {
    
    var label: String {
        switch self {
        case .latest:
            return "Latest"
        case .popular:
            return "Popular"
        }
    }
    
    var image: String {
        switch self {
        case .latest:
            return "Latest"
        case .popular:
            return "Popular"
        }
    }
    
    var tag: Int {
        switch self {
        case .latest: return 0
        case .popular: return 1
        }
    }
}

protocol DashboardViewModelProtocol {
    func getViewControllerForSection(_ section: DashboardTab) -> UIViewController?
}

final class DashboardViewModel: DashboardViewModelProtocol {
    
    private let router: DashboardRouterProtocol?
    
    init(router: DashboardRouterProtocol?) {
        self.router = router
    }
    
    func getViewControllerForSection(_ section: DashboardTab) -> UIViewController? {
        switch section {
        case .latest: return self.router?.instantiateLatestMovieListScene()
        case .popular: return self.router?.instantiateLatestMovieListScene()
        }
    }
    
}

extension DashboardViewModel: TabContainerDelegate {
   
    func sectionSelected(_ section: DashboardTab) {
        // Any api call
    }
}
