//
//  NotePresenter.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

final class NotePresenter {
    
// MARK: - Properties
    
    weak var input: NoteInput?
    private let notesService: NotesServiceProtocol
    
// MARK: - Lifecycle
    
    init(notesService: NotesServiceProtocol) {
        self.notesService = notesService
    }
}

// MARK: - NoteOutput

extension NotePresenter: NoteOutput {
    func save(title: String?, note: String) {
        guard let title = title,
              title != "" else {
            notesService.saveNote(Note(id: UUID(), title: "Новая заметка", note: note))
            return
        }
        notesService.saveNote(Note(id: UUID(), title: title, note: note))
    }
}
