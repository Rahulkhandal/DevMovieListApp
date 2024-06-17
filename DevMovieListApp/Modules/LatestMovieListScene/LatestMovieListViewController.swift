//
//  LatestMovieListViewController.swift
//  DevMovieListApp
//
//  Created by Rahul on 16/06/24.
//

import Foundation
import UIKit
import Combine

final class LatestMovieListViewController: UIViewController {
    
    
    var viewModel: LatestMovieListViewModelProtocol!
    private var prefetchDataSource: TableViewDataSourcePrefetching?
    private var disposables = Set<AnyCancellable>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        monitorUpdates()
    }
    
    private func setupTableView() {
        prefetchDataSource = TableViewDataSourcePrefetching(cellCount: viewModel.datasource.count,
                                                            needsPrefetch: viewModel.needsPrefetch,
                                                            prefetchHandler: { [weak self] in
            self?.viewModel?.fetchNextSetOfData()
        })
        tableView.prefetchDataSource = prefetchDataSource
    }
    
    private func setupBackgroundView() {
        view.backgroundColor = .white
    }
    
    private func monitorUpdates() {
        self.viewModel.viewStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (state) in
                guard let self = self else { return }
            
                switch state {
                case .finished:
                    if (self.tableView.prefetchDataSource == nil) {
                        setupTableView()
                    }
                    self.tableView.reloadData()


                case .fetching:
                    break
                    
                case .error:
                    break
                case .loading:
                    break
                }
            }.store(in: &self.disposables)
        
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MovieListTableViewCell.self,
                           forCellReuseIdentifier: MovieListTableViewCell.UIConstants.reuseIdentifier)
        
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        return tableView
    }()
}

extension LatestMovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func updateView() {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.UIConstants.reuseIdentifier) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        let movieModel = viewModel.datasource[indexPath.row]
        cell.configure(with: movieModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.indexTapped(index: indexPath.row)
    }
}
