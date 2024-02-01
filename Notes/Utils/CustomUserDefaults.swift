//
//  CustomUserDefaults.swift
//  Notes
//
//  Created by Александр Меренков on 01.02.2024.
//

import Foundation

final class CustomUserDefaults {
    static let shared = CustomUserDefaults()
    
// MARK: - Properties
    
    private let userDefault = UserDefaults.standard
    
    enum DefaultKey: String {
        case isNotFirstLaunce
        case fontSize
    }
    
// MARK: - Helpers
    
    func setValue(_ value: Any?, for key: DefaultKey) {
        userDefault.setValue(value, forKey: key.rawValue)
    }
    
    func getValue(for key: DefaultKey) -> Any? {
        return userDefault.value(forKey: key.rawValue)
    }
}
