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

        static let accountButtonFontSize: CGFloat = 16
        
        static let stackViewSpacing: CGFloat = 16
        static let stackViewPadding: CGFloat = 32

        static let loginButtonHeight: CGFloat = 50
    }
    
    private let iconImage: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "bubble.right")
        icon.tintColor = .white
        return icon
    }()
    
    private lazy var emailContainerView: UIView = {
        if let image = UIImage(named: "ic_mail_outline_white_2x") {
            let containerView = InputContainerView(image: image, textField: emailTextField)
            return containerView
        }
        return InputContainerView(image: UIImage(), textField: emailTextField)
    }()

    private let emailTextField = CustomTextField(placeholder: "E-mail")
    
    private lazy var passwordContainerView: InputContainerView = {
        if let image = UIImage(named: "ic_lock_outline_white_2x") {
            let containerView = InputContainerView(image: image, textField: passwordTextField)
            return containerView
        }
        return InputContainerView(image: UIImage(), textField: passwordTextField)
    }()

    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setHeight(height: Constants.loginButtonHeight)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonTitleFontSize)
        button.backgroundColor = .systemPink
        return button
    }()

    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?",
                                                        attributes: [.font: UIFont.systemFont(ofSize: Constants.accountButtonFontSize),
                                                                     .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: " Sign up",
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: Constants.accountButtonFontSize),
                                                               .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
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
        confugireAccountButtonConstraints()
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

    private func confugireAccountButtonConstraints() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor)
    }

    @objc
    private func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
