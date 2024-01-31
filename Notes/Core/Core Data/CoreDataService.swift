//
//  CoreDataService.swift
//  Notes
//
//  Created by Александр Меренков on 31.01.2024.
//

import CoreData

final class CoreDataService {
    
// MARK: - Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { _, error in
            guard let error = error else { return }
            print(error)
        }
        return persistentContainer
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

// MARK: - CoreDataServiceProtocol

extension CoreDataService: CoreDataServiceProtocol {
    
    func fetchNotes() throws -> [NoteManagedObject] {
        let fetchRequest = NoteManagedObject.fetchRequest()
        return try viewContext.fetch(fetchRequest)
    }
    
    func save(completion: @escaping (NSManagedObjectContext) throws -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.performAndWait {
            do {
                try completion(backgroundContext)
                if backgroundContext.hasChanges {
                    try backgroundContext.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(_ id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            do {
                let fetchRequest = NoteManagedObject.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
                guard let note = try backgroundContext.fetch(fetchRequest).first else { return }
                backgroundContext.delete(note)
                try backgroundContext.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func update(_ note: Note, completion: @escaping (Result<Void, Error>) -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            do {
                let fetchRequest = NoteManagedObject.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
                guard let result = try backgroundContext.fetch(fetchRequest).first else { return }
                result.title = note.title
                result.note = note.note
                try backgroundContext.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
