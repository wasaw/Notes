//
//  HomeViewController.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
// MARK: - Properties
    
    private let output: HomeOutput
    
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
        
        view.backgroundColor = .yellow
    }
}

// MARK: - HomeInput

extension HomeViewController: HomeInput {
    
}
