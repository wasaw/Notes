//
//  HomePresenterOutput.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

protocol HomePresenterOutput: AnyObject {
    func openNote(with note: Note?)
}
