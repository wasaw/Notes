//
//  SceneDelegate.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private let coreData = CoreDataService()
    
    private let homeAssembly = HomeAssembly()
    private let noteAssembly = NoteAssembly()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let notesService = NotesService(coreData: coreData)
        notesService.isFirstLaunce()

        let honeCoordinator = HomeCoordinator(homeAssembly: homeAssembly,
                                              noteAssembly: noteAssembly,
                                              notesService: notesService)
        window = UIWindow(windowScene: scene)
        window?.rootViewController = honeCoordinator.start()
        window?.makeKeyAndVisible()
    }
}

