//
//  HomeViewController.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

private enum Constants {
    static let paddingHorizontal: CGFloat = 15
    static let titlePaddingTop: CGFloat = 25
    static let tablePaddingTop: CGFloat = 10
    static let cellHeight: CGFloat = 55
    static let buttonPadding: CGFloat = 22
    static let buttonDimensions: CGFloat = 55
}

final class HomeViewController: UIViewController {
    
// MARK: - Properties
    
    private let output: HomeOutput
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.boldSystemFont(ofSize: 37)
        return label
    }()
    private lazy var tableView = UITableView(frame: .zero)
    private lazy var dataSource = HomeDataSource(tableView)
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    private lazy var fontButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "font"), for: .normal)
        button.addTarget(self, action: #selector(handleFontButton), for: .touchUpInside)
        return button
    }()
    
// MARK: - Lifecycle
    
    init(output: HomeOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        output.viewIsReady()
    }
    
// MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.anchor(leading: view.leadingAnchor,
                          top: view.safeAreaLayoutGuide.topAnchor,
                          trailing: view.trailingAnchor,
                          paddingLeading: Constants.paddingHorizontal,
                          paddingTop: Constants.titlePaddingTop,
                          paddingTrailing: -Constants.paddingHorizontal)
        configureTable()
        configureAddButton()
        configureFontButton()
        view.backgroundColor = .background
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseIdentifire)
        tableView.delegate = self
        tableView.dataSource = dataSource
        dataSource.delegate = self
        tableView.anchor(leading: view.leadingAnchor,
                         top: titleLabel.bottomAnchor,
                         trailing: view.trailingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         paddingLeading: Constants.paddingHorizontal,
                         paddingTop: Constants.tablePaddingTop,
                         paddingTrailing: -Constants.paddingHorizontal)
        tableView.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        loadingView.anchor(top: tableView.topAnchor)
        tableView.backgroundColor = .background
    }
    
    private func configureAddButton() {
        view.addSubview(addButton)
        addButton.anchor(trailing: view.trailingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         paddingTrailing: -Constants.buttonPadding,
                         paddingBottom: -Constants.buttonPadding,
                         width: Constants.buttonDimensions,
                         height: Constants.buttonDimensions)
    }
    
    private func configureFontButton() {
        view.addSubview(fontButton)
        fontButton.anchor(leading: view.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          paddingLeading: Constants.buttonPadding,
                          paddingBottom: -Constants.buttonPadding,
                          width: Constants.buttonDimensions,
                          height: Constants.buttonDimensions)
    }
        
    private func setupDataSource(_ items: [HomeCell.DisplayData]) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
// MARK: - Selectors
    
    @objc private func handleAddButton() {
        output.createNewNote()
    }
    
    @objc private func handleFontButton() {
        let fonts = UIFont.familyNames
        guard let font = fonts.randomElement() else { return }
        titleLabel.font = UIFont(name: font, size: 37)
    }
}

// MARK: - HomeInput

extension HomeViewController: HomeInput {
    func setLoading(enable: Bool) {
        enable ? loadingView.startAnimating() : loadingView.stopAnimating()
    }
    
    func showData(_ data: [HomeCell.DisplayData]) {
        setupDataSource(data)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.showNote(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}

// MARK: - HomeDataSourceDelegate

extension HomeViewController: HomeDataSourceDelegate {
    func deleteNote(at index: Int) {
        output.delete(at: index)
    }
}
