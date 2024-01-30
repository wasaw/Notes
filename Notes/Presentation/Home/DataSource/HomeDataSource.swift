//
//  HomeDataSource.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

final class HomeDataSource: UITableViewDiffableDataSource<Int, HomeCell.DisplayData> {
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifire, for: indexPath) as? HomeCell else { return UITableViewCell() }
            cell.configure(itemIdentifier)
            return cell
        }
    }
}
