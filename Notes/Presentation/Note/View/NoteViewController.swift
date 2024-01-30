//
//  NoteViewController.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

final class NoteViewController: UIViewController {
    
// MARK: - Properties
    
    private let output: NoteOutput
    
// MARK: - Lifecycle
    
    init(output: NoteOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
}

// MARK: - NoteInput

extension NoteViewController: NoteInput {
    
}
