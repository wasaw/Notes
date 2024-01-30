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
    private let moduleOutput: HomePresenterOutput
    private let displayData: [HomeCell.DisplayData] = [HomeCell.DisplayData(title: "New title", note: "Note")]
    
// MARK: - Lifecycle
    
    init(moduleOutput: HomePresenterOutput) {
        self.moduleOutput = moduleOutput
    }
}

// MARK: - HomeOutput

extension HomePresenter: HomeOutput {
    func viewIsReady() {
        input?.setLoading(enable: true)
        input?.showData(displayData)
        input?.setLoading(enable: false)
    }
    
    func createNewNote() {
        moduleOutput.openAddNote()
    }
}
