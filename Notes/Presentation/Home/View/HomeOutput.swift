//
//  HomeOutput.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

protocol HomeOutput: AnyObject {
    func viewIsReady()
    func createNewNote()
    func showNote(at index: Int)
    func delete(at index: Int)
}
