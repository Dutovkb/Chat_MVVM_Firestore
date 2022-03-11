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

    private var viewModel = RegisterViewModel()

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
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: Constants.sighUpButtonHeight)
        button.layer.cornerRadius = Constants.signUpCornerRadius
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.sighUpButtonTitleFontSize)
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.isEnabled = false
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
        configureTextFields()
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

    private func configureTextFields() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    // MARK: Selectors

    @objc
    private func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    @objc
    private func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func textDidChange(sender: UITextField) {

        switch sender {
            case emailTextField: viewModel.email = sender.text
            case fullNameTextField: viewModel.fullname = sender.text
            case userNameTextField: viewModel.username = sender.text
            case passwordTextField: viewModel.password = sender.text
            default:
                return
        }
        checkFormStatus()
    }

    @objc
    private func handleSignup() {
        print("Email: \(viewModel.email?.lowercased()), full name: \(viewModel.fullname), username: \(viewModel.username), password: \(viewModel.password)")
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        addPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        addPhotoButton.layer.borderWidth = 3.0
        addPhotoButton.layer.cornerRadius = Constants.addPhotoButtonHeight / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationController: AuthenticationControllerProtocol {

    func checkFormStatus() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .systemPink
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .systemPurple
        }
    }
}
