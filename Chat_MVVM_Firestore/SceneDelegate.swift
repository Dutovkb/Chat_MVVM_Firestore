//
//  SceneDelegate.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private func configureNavigationBar(_ navigationController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        let navigationBar = navigationController.navigationBar

        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPink

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = true
        navigationBar.overrideUserInterfaceStyle = .dark
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let rootViewController = ConversationsController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        configureNavigationBar(navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

