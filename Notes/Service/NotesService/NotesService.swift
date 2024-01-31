//
//  NotesService.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

final class NotesService {
    
// MARK: - Properties
    
    private let coreData: CoreDataServiceProtocol
    
// MARK: - Lifecycle
    
    init(coreData: CoreDataServiceProtocol) {
        self.coreData = coreData
    }
}

// MARK: - NotesServiceProtocol

extension NotesService: NotesServiceProtocol {
    func getNotes(completion: @escaping (Result<[Note], Error>) -> Void) {
        do {
            let notesManagedObject = try coreData.fetchNotes()
            let notes: [Note] = notesManagedObject.compactMap { note in
                guard let id = note.id,
                      let title = note.title,
                      let noteText = note.note else { return nil }
                return Note(id: id, title: title, note: noteText)
            }
            completion(.success(notes))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveNote(_ note: Note) {
        coreData.save { context in
            let noteManagedObject = NoteManagedObject(context: context)
            noteManagedObject.id = note.id
            noteManagedObject.title = note.title
            noteManagedObject.note = note.note
        }
    }
    
    func deleteNote(_ id: UUID, comletion: @escaping (Result<Void, Error>) -> Void) {
        coreData.delete(id, completion: comletion)
    }
    
    func updateNote(_ note: Note, comletion: @escaping (Result<Void, Error>) -> Void) {
        coreData.update(note, completion: comletion)
    }
}
