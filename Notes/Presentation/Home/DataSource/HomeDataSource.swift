//
//  HomeDataSource.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

protocol HomeDataSourceDelegate: AnyObject {
    func deleteNote(at index: Int)
}

final class HomeDataSource: UITableViewDiffableDataSource<Int, HomeCell.DisplayData> {
    
    weak var delegate: HomeDataSourceDelegate?
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifire, for: indexPath) as? HomeCell else { return UITableViewCell() }
            cell.configure(itemIdentifier)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.deleteNote(at: indexPath.row)
        }
    }
}
