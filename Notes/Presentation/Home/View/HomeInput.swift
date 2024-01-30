//
//  HomeInput.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import Foundation

protocol HomeInput: AnyObject {
    func setLoading(enable: Bool)
    func showData(_ data: [HomeCell.DisplayData])
}
