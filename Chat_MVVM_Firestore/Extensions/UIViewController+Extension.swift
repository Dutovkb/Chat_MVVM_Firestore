//
//  UIViewController+Extension.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit
import JGProgressHUD

extension UIViewController {

    static let hud = JGProgressHUD(style: .dark)

    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }

    func showLoader(_ show: Bool, withText text: String? = "Loading") {
        view.endEditing(true)
        UIViewController.hud.textLabel.text = text
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }

    func configureNavigationController(withTitle title: String, prefersLargeTitles: Bool) {
        let appearance = UINavigationBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPink

        if let navigationController = navigationController {
            let navigationBar = navigationController.navigationBar
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.prefersLargeTitles = prefersLargeTitles
            navigationBar.tintColor = .white
            navigationBar.isTranslucent = true
            navigationBar.overrideUserInterfaceStyle = .dark
        }
        navigationItem.title = title
    }
}
