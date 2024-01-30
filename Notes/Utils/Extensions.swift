//
//  Extensions.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

// MARK: - UIColor

extension UIColor {
    static let background = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 165/255, green: 165/255, blue: 141/255, alpha: 1)
        case .dark:
            UIColor(red: 165/255, green: 165/255, blue: 141/255, alpha: 1)
        @unknown default:
            UIColor(red: 165/255, green: 165/255, blue: 141/255, alpha: 1)
        }
    }
    static let tableBackground = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 183/255, green: 183/255, blue: 164/255, alpha: 1)
        case .dark:
            UIColor(red: 183/255, green: 183/255, blue: 164/255, alpha: 1)
        @unknown default:
            UIColor(red: 183/255, green: 183/255, blue: 164/255, alpha: 1)
        }
    }
}

// MARK: - UIView

extension UIView {
    func anchor(leading: NSLayoutXAxisAnchor? = nil,
                top: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingLeading: CGFloat = 0,
                paddingTop: CGFloat = 0,
                paddingTrailing: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
