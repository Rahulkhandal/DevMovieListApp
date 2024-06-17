//
//  MovieDetailViewController.swift
//  DevMovieListApp
//
//  Created by Rahul on 18/06/24.
//

import Foundation
import UIKit
import Combine

final class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModelViewModelProtocol!
    private var disposables = Set<AnyCancellable>()

    
    private lazy var movieTopView: UIView = {
        guard let datasource = viewModel.datasource else {
            return UIView()
        }
            let topView = MovieDetailTopView(frame: .zero, movieModel: datasource)
            topView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(topView)
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            topView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            return topView
        }()
        
        private lazy var movieOverview: UIView = {
            guard let datasource = viewModel.datasource else {
                return UIView()
            }
            
            let overview = MovieDetailOverview(frame: .zero, movieModel: datasource)
            overview.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(overview)
            overview.topAnchor.constraint(equalTo: movieTopView.bottomAnchor, constant: 20).isActive = true
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            return overview
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundView()
        monitorUpdates()
    }
    
    private func setupBackgroundView() {
        view.backgroundColor = .white
    }
    
    private func setUpView() {
        movieTopView.isHidden = false
        movieOverview.isHidden = false
    }
    
    private func monitorUpdates() {
        self.viewModel.viewStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (state) in
                guard let self = self else { return }
            
                switch state {
                case .finished:
                  setUpView()

                case .fetching:
                    break
                    
                case .error:
                    break
                case .loading:
                    break
                }
            }.store(in: &self.disposables)
        
    }
    
}
