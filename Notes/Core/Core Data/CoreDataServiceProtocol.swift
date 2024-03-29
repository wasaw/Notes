//
//  CoreDataServiceProtocol.swift
//  Notes
//
//  Created by Александр Меренков on 31.01.2024.
//

import CoreData

protocol CoreDataServiceProtocol: AnyObject {
    func save(completion: @escaping (NSManagedObjectContext) throws -> Void)
    func fetchNotes() throws -> [NoteManagedObject]
    func delete(_ id: UUID, completion: @escaping (Result<Void, Error>) -> Void)
    func update(_ note: Note, completion: @escaping (Result<Void, Error>) -> Void)
}
