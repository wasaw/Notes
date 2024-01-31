//
//  NotesService.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

final class NotesService {
    
}

// MARK: - NotesServiceProtocol

extension NotesService: NotesServiceProtocol {
    func getNotes(completion: @escaping (Result<[Note], Error>) -> Void) {
        var note: [Note] = []
        note.append(Note(id: UUID(), title: "New title", note: "Note"))
        completion(.success(note))
    }
    
    func saveNote(_ note: Note) {
        print("DEBUG: save \(note)")
    }
}
