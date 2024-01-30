//
//  HomeAssembly.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

final class HomeAssembly {
    func makeHomeModule(moduleOutput: HomePresenterOutput) -> UIViewController {
        let presenter = HomePresenter(moduleOutput: moduleOutput)
        let viewController = HomeViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
