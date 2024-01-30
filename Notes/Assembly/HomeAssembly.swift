//
//  HomeAssembly.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

final class HomeAssembly {
    func makeHomeModule() -> UIViewController {
        let presenter = HomePresenter()
        let vc = HomeViewController(output: presenter)
        presenter.input = vc
        return vc
    }
}
