//
//  TableViewDataSourcePrefetching.swift
//  DevMovieListApp
//
//  Created by Rahul on 17/06/24.
//

import Foundation
import UIKit


protocol DataSourcePrefetching {

    var cellCount: Int { get }
    var needsPrefetch: Bool { get }
    var prefetchHandler: (() -> Void) { get }

    func isLoadingCell(for indexPath: IndexPath) -> Bool
    func prefetchIfNeeded(for indexPaths: [IndexPath])

}

extension DataSourcePrefetching {

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        indexPath.row >= cellCount - 1
    }

    func prefetchIfNeeded(for indexPaths: [IndexPath]) {
        guard needsPrefetch else { return }
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }

}

final class TableViewDataSourcePrefetching: NSObject, DataSourcePrefetching, UITableViewDataSourcePrefetching {

    let cellCount: Int
    let needsPrefetch: Bool
    let prefetchHandler: (() -> Void)

    // MARK: - Initializers

    init(cellCount: Int, needsPrefetch: Bool, prefetchHandler: @escaping (() -> Void)) {
        self.cellCount = cellCount
        self.needsPrefetch = needsPrefetch
        self.prefetchHandler = prefetchHandler
    }

    // MARK: - UITableViewDataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        prefetchIfNeeded(for: indexPaths)
    }

}
