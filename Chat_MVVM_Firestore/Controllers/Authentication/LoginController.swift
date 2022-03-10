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
        static let iconPaddingTop: CGFloat = 32
        
        static let buttonCornerRadius: CGFloat = 5
        static let buttonTitleFontSize: CGFloat = 16
        
        static let stackViewSpacing: CGFloat = 16
        static let stackViewPadding: CGFloat = 32
        
        static let emailContainerViewHeight: CGFloat = 50
        static let passwordContainerViewHeight: CGFloat = 50
        static let loginButtonHeight: CGFloat = 50
    }
    
    private let iconImage: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "bubble.right")
        icon.tintColor = .white
        return icon
    }()
    
    private let emailContainerView: UIView = {
        let view = UIView()
        view.setHeight(height: Constants.emailContainerViewHeight)
        view.backgroundColor = .cyan
        return view
    }()
    
    private let passwordContainerView: UIView = {
        let view = UIView()
        view.setHeight(height: Constants.passwordContainerViewHeight)
        view.backgroundColor = .yellow
        return view
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setHeight(height: Constants.loginButtonHeight)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonTitleFontSize)
        button.backgroundColor = .systemRed
        return button
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
        configureStackView()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureIconConstraints() {
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: Constants.iconPaddingTop)
        iconImage.setDimensions(height: Constants.iconHeight, width: Constants.iconWidth)
    }
    
    private func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView,
                                                       loginButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        view.addSubview(stackView)
        configureStackViewConstraints(for: stackView)
    }
    
    private func configureStackViewConstraints(for stackView: UIStackView) {
        stackView.anchor(top: iconImage.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: Constants.stackViewPadding,
                         paddingLeft: Constants.stackViewPadding,
                         paddingRight: -Constants.stackViewPadding)
    }
}
