//
//  MovieDetailTopView.swift
//  DevMovieListApp
//
//  Created by Rahul on 18/06/24.
//

import Foundation
import UIKit

class MovieDetailTopView: UIView {
    private var movieModel: MovieDetailResult
    
    
    init(frame: CGRect, movieModel: MovieDetailResult) {
        self.movieModel = movieModel
        super.init(frame: frame)
        self.movieImage.isHidden = false
        self.movieColumnDetails.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        
        let baseURLString = Bundle.main.infoDictionary?["IMAGE_BASE_URL"] as! String
        if let urlString = movieModel.posterPath,
           let url = URL(string: baseURLString + urlString) {
            imageView.kf.setImage(with: url)
        }
        
        return imageView
    }()
    
    private lazy var movieColumnDetails: MovieDetailColumnView = {
        let columnView = MovieDetailColumnView(frame: .zero, movieModel: movieModel)
        columnView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(columnView)
        columnView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        columnView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        columnView.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        columnView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        return columnView
    }()
}
