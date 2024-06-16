//
//  Paginable.swift
//  DevMovieListApp
//
//  Created by Rahul on 17/06/24.
//

import Foundation

protocol Paginable {

    var currentPage: Int { get }
    var totalPages: Int { get }

}

extension Paginable {

    var hasMorePages: Bool {
        currentPage < totalPages
    }

    var nextPage: Int {
        hasMorePages ? currentPage + 1 : currentPage
    }

}
