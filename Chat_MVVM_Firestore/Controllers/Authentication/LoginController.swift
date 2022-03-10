//
//  LoginController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit

final class LoginController: UIViewController {
    
    private enum Constants {
        static let iconHeight: CGFloat = 120
        static let iconWidth: CGFloat = 120
    }
    
    private let iconImage: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "bubble.right")
        icon.tintColor = .white
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        configureNavigationController()
        configureGradientLayer()
        configureIconConstraints()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureIconConstraints() {
        view.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: Constants.iconHeight).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: Constants.iconWidth).isActive = true
    }
    
    private func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}
