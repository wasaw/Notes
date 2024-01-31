//
//  NoteInput.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

protocol NoteInput: AnyObject {
    func showNote(_ displayData: Note)
    func showAlert(_ message: String)
}
