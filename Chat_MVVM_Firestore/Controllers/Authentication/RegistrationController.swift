//
//  RegistrationController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit

final class RegistrationController: UIViewController {

    private enum Constants {
        static let addPhotoButtonHeight: CGFloat = 120
        static let addPhotoButtonWidth: CGFloat = 120
        static let addPhotoButtonPadding: CGFloat = 32

        static let sighUpButtonHeight: CGFloat = 50
        static let signUpCornerRadius: CGFloat = 5
        static let sighUpButtonTitleFontSize: CGFloat = 16

        static let stackViewSpacing: CGFloat = 16
        static let stackViewPadding: CGFloat = 32

        static let accountButtonFontSize: CGFloat = 16
    }

    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()

    private lazy var emailContainerView: UIView = {
        if let image = UIImage(named: "ic_mail_outline_white_2x") {
            let containerView = InputContainerView(image: image, textField: emailTextField)
            return containerView
        }
        return InputContainerView(image: UIImage(), textField: emailTextField)
    }()

    private let emailTextField = CustomTextField(placeholder: "E-mail")

    private lazy var fullNameContainerView: UIView = {
        if let image = UIImage(named: "ic_person_outline_white_2x") {
            let containerView = InputContainerView(image: image, textField: fullNameTextField)
            return containerView
        }
        return InputContainerView(image: UIImage(), textField: fullNameTextField)
    }()

    private let fullNameTextField = CustomTextField(placeholder: "Full name")

    private lazy var userNameContainerView: UIView = {
        if let image = UIImage(named: "ic_person_outline_white_2x") {
            let containerView = InputContainerView(image: image, textField: userNameTextField)
            return containerView
        }
        return InputContainerView(image: UIImage(), textField: userNameTextField)
    }()

    private let userNameTextField = CustomTextField(placeholder: "Username")

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

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.setHeight(height: Constants.sighUpButtonHeight)
        button.layer.cornerRadius = Constants.signUpCornerRadius
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.sighUpButtonTitleFontSize)
        button.backgroundColor = .systemPink
        return button
    }()

    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Allready have an account?",
                                                        attributes: [.font: UIFont.systemFont(ofSize: Constants.accountButtonFontSize),
                                                                     .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: " Log in",
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: Constants.accountButtonFontSize),
                                                               .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .systemPurple
        configureGradientLayer()
        configureAddPhotoButton()
        configureStackView()
        confugireAccountButtonConstraints()
    }

    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       fullNameContainerView,
                                                       userNameContainerView,
                                                       passwordContainerView,
                                                       signUpButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        view.addSubview(stackView)
        configureStackViewConstraints(for: stackView)
    }

    private func configureStackViewConstraints(for stackView: UIStackView) {
        stackView.anchor(top: addPhotoButton.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: Constants.stackViewPadding,
                         paddingLeft: Constants.stackViewPadding,
                         paddingRight: -Constants.stackViewPadding)
    }

    private func configureAddPhotoButton() {
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view)
        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: Constants.addPhotoButtonPadding)
        addPhotoButton.setDimensions(height: Constants.addPhotoButtonHeight, width: Constants.addPhotoButtonWidth)
    }

    private func confugireAccountButtonConstraints() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor)
    }

    @objc
    private func handleSelectPhoto() {
        
    }

    @objc
    private func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }
}
