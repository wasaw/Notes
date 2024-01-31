//
//  NoteAssembly.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

final class NoteAssembly {
    func makeNoteModule(notesService: NotesServiceProtocol) -> UIViewController {
        let presenter = NotePresenter(notesService: notesService)
        let viewController = NoteViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
