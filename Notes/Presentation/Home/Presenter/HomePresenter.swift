//
//  HomePresenter.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

final class HomePresenter {
    
// MARK: - Properties
    
    weak var input: HomeInput?
    private let notesService: NotesServiceProtocol
    private let moduleOutput: HomePresenterOutput
    private var notes: [Note] = []
    
// MARK: - Lifecycle
    
    init(moduleOutput: HomePresenterOutput, notesService: NotesServiceProtocol) {
        self.moduleOutput = moduleOutput
        self.notesService = notesService
    }
}

// MARK: - HomeOutput

extension HomePresenter: HomeOutput {
    func viewIsReady() {
        input?.setLoading(enable: true)
        notesService.getNotes { [weak self] result in
            switch result {
            case .success(let notes):
                self?.notes = notes
                let displayData: [HomeCell.DisplayData] = notes.compactMap { note in
                    return HomeCell.DisplayData(title: note.title, note: note.note)
                }
                self?.input?.showData(displayData)
                self?.input?.setLoading(enable: false)
            case .failure(let error):
                self?.input?.showAlert(error.localizedDescription)
            }
        }
    }
    
    func createNewNote() {
        moduleOutput.openNote(with: nil)
    }
    
    func showNote(at index: Int) {
        if notes.indices.contains(index) {
            moduleOutput.openNote(with: notes[index])
        }
    }
    
    func delete(at index: Int) {
        if notes.indices.contains(index) {
            notesService.deleteNote(notes[index].id) { [weak self] result in
                switch result {
                case .success:
                    self?.notes.remove(at: index)
                    guard let notes = self?.notes else { return }
                    let displayData: [HomeCell.DisplayData] = notes.compactMap { note in
                        return HomeCell.DisplayData(title: note.title, note: note.note)
                    }
                    DispatchQueue.main.async {
                        self?.input?.showData(displayData)
                    }
                case .failure(let error):
                    self?.input?.showAlert(error.localizedDescription)
                }
            }
        }
    }
}
