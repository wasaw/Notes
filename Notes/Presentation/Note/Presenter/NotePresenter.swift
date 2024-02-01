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
    private let notification = NotificationCenter.default
    private let userDefault = UserDefaults.standard
    
// MARK: - Lifecycle
    
    init(note: Note?, notesService: NotesServiceProtocol) {
        self.note = note
        self.notesService = notesService
    }
    
// MARK: - Helpers
    
    private func updateNote(_ note: Note) {
        notesService.updateNote(note) { [weak self] result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self?.notification.post(name: .update, object: nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.input?.showAlert(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateFontSize() {
        guard let fontSize = userDefault.value(forKey: "fontSize") as? Float else { return }
        input?.setFontSize(fontSize)
    }
}

// MARK: - NoteOutput

extension NotePresenter: NoteOutput {
    func viewIsReady() {
        updateFontSize()
        guard let note = note else {
            return
        }
        input?.showNote(note)
    }
    
    func save(title: String?, note: String) {
        guard let title = title,
              title != "" else {
            if note != "Содержание" {
                notesService.saveNote(Note(id: UUID(), title: "Новая заметка", note: note))
            }
            return
        }
        guard let id = self.note?.id else {
            notesService.saveNote(Note(id: UUID(), title: title, note: note))
            return
        }
        updateNote(Note(id: id, title: title, note: note))
    }
    
    func saveFontSize(_ size: Float) {
        userDefault.setValue(size.rounded(), forKey: "fontSize")
    }
}
