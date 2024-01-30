//
//  NoteAssembly.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

final class NoteAssembly {
    func makeNoteModule() -> UIViewController {
        let presenter = NotePresenter()
        let viewController = NoteViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
