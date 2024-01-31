//
//  NotesServiceProtocol.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

protocol NotesServiceProtocol: AnyObject {
    func getNotes(completion: @escaping (Result<[Note], Error>) -> Void)
    func saveNote(_ note: Note)
    func deleteNote(_ id: UUID, comletion: @escaping (Result<Void, Error>) -> Void)
}
