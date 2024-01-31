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
    private let notesService: NotesServiceProtocol
    
// MARK: - Lifecycle
    
    init(homeAssembly: HomeAssembly,
         noteAssembly: NoteAssembly,
         notesService: NotesServiceProtocol) {
        self.homeAssembly = homeAssembly
        self.noteAssembly = noteAssembly
        self.notesService = notesService
    }
    
// MARK: - Helpers
    
    func start() -> UINavigationController {
        let viewController = homeAssembly.makeHomeModule(moduleOutput: self, notesService: notesService)
        let nav = UINavigationController(rootViewController: viewController)
        navigation = nav
        return nav
    }
    
    private func showAddNote() {
        let viewContoller = noteAssembly.makeNoteModule(notesService: notesService)
        navigation?.pushViewController(viewContoller, animated: true)
    }
}

// MARK: - HomePresenterOutput

extension HomeCoordinator: HomePresenterOutput {
    func openAddNote() {
        showAddNote()
    }
}
