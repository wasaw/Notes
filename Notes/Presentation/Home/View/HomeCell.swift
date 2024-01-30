//
//  HomeCell.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

private enum Constants {
    static let leadingPadding: CGFloat = 10
}

final class HomeCell: UITableViewCell {
    static let reuseIdentifire = "HomeCell"
    
// MARK: - Properties
    
    struct DisplayData: Hashable {
        let id = UUID()
        let title: String
        let note: String
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        return label
    }()
    
// MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.anchor(leading: contentView.leadingAnchor, paddingLeading: Constants.leadingPadding)
        
        contentView.backgroundColor = .tableBackground
    }
    
    func configure(_ model: HomeCell.DisplayData) {
        titleLabel.text = model.title
    }
}
