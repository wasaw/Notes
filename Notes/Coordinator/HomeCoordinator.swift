//
//  HomeCoordinator.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

final class HomeCoordinator {
    
// MARK: - Properties
    
    private var navigation: UINavigationController?
    private let homeAssembly: HomeAssembly
    private let noteAssembly: NoteAssembly
    
// MARK: - Lifecycle
    
    init(homeAssembly: HomeAssembly, noteAssembly: NoteAssembly) {
        self.homeAssembly = homeAssembly
        self.noteAssembly = noteAssembly
    }
    
// MARK: - Helpers
    
    func start() -> UINavigationController {
        let viewController = homeAssembly.makeHomeModule(moduleOutput: self)
        let nav = UINavigationController(rootViewController: viewController)
        navigation = nav
        return nav
    }
    
    private func showAddNote() {
        let viewContoller = noteAssembly.makeNoteModule()
        navigation?.pushViewController(viewContoller, animated: true)
    }
}

// MARK: - HomePresenterOutput

extension HomeCoordinator: HomePresenterOutput {
    func openAddNote() {
        showAddNote()
    }
}
