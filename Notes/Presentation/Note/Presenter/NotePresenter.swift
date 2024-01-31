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
    private let note: Note?
    private let notesService: NotesServiceProtocol
    
// MARK: - Lifecycle
    
    init(note: Note?, notesService: NotesServiceProtocol) {
        self.note = note
        self.notesService = notesService
    }
}

// MARK: - NoteOutput

extension NotePresenter: NoteOutput {
    func viewIsReady() {
        guard let note = note else {
            return
        }
        input?.showNote(note)
    }
    
    func save(title: String?, note: String) {
        guard let title = title,
              title != "",
              (title != self.note?.title && note != self.note?.note) else {
            if note != "Содержание" {
                notesService.saveNote(Note(id: UUID(), title: "Новая заметка", note: note))
            }
            return
        }
        
        notesService.saveNote(Note(id: UUID(), title: title, note: note))
    }
}
