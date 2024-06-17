//
//  MovieListTableViewCell.swift
//  DevMovieListApp
//
//  Created by Rahul on 17/06/24.
//

import Foundation
import UIKit

final class MovieListTableViewCell: UITableViewCell {
    
    enum UIConstants {
        static let reuseIdentifier = "MovieListTableViewCell"
    }
    
    private var movieInfoView: MovieInfoView?
    
    override func prepareForReuse() {
        movieInfoView?.removeFromSuperview()
        movieInfoView = nil
        super.prepareForReuse()
    }
    
    func configure(with movieModel: Movie) {
        backgroundColor = .clear
        selectionStyle = .none
        setupMovieInfoView(with: movieModel)
    }
    
    private func setupMovieInfoView(with movieModel: Movie) {
        let view = MovieInfoView(frame: .zero, movieModel: movieModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        movieInfoView = view
    }
}
