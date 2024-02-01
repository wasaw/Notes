//
//  NoteOutput.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

protocol NoteOutput: AnyObject {
    func viewIsReady()
    func save(title: String?, note: String)
    func saveFontSize(_ size: Float)
}
