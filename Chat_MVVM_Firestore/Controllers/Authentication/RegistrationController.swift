//
//  RegistrationController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit
import Firebase

final class RegistrationController: UIViewController {

    // MARK: - Properties

    private var viewModel = RegisterViewModel()
    private var profileImage: UIImage?

    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()

    private lazy var emailContainerView: UIView = {
        guard let image = UIImage(named: "ic_mail_outline_white_2x") else { return UIView() }
        return InputContainerView(image: image, textField: emailTextField)
    }()

    private let emailTextField = CustomTextField(placeholder: "E-mail")

    private lazy var fullNameContainerView: UIView = {
        guard let image = UIImage(named: "ic_person_outline_white_2x") else { return UIView() }
        return InputContainerView(image: image, textField: fullNameTextField)
    }()

    private let fullNameTextField = CustomTextField(placeholder: "Full name")

    private lazy var userNameContainerView: UIView = {
        guard let image = UIImage(named: "ic_person_outline_white_2x") else { return UIView() }
        return InputContainerView(image: image, textField: userNameTextField)
    }()

    private let userNameTextField = CustomTextField(placeholder: "Username")

    private lazy var passwordContainerView: UIView = {
        guard let image = UIImage(named: "ic_lock_outline_white_2x") else { return UIView() }
        return InputContainerView(image: image, textField: passwordTextField)
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
        button.setHeight(height: RegistrationConsts.sighUpButtonHeight)
        button.layer.cornerRadius = RegistrationConsts.signUpCornerRadius
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: RegistrationConsts.sighUpButtonTitleFontSize)
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Allready have an account?",
                                                        attributes: [.font: UIFont.systemFont(ofSize: RegistrationConsts.accountButtonFontSize),
                                                                     .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: " Log in",
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: RegistrationConsts.accountButtonFontSize),
                                                               .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Configure UI

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
        stackView.spacing = RegistrationConsts.stackViewSpacing
        view.addSubview(stackView)
        configureStackViewConstraints(for: stackView)
    }

    private func configureStackViewConstraints(for stackView: UIStackView) {
        stackView.anchor(top: addPhotoButton.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: RegistrationConsts.stackViewPadding,
                         paddingLeft: RegistrationConsts.stackViewPadding,
                         paddingRight: -RegistrationConsts.stackViewPadding)
    }

    private func configureAddPhotoButton() {
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view)
        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: RegistrationConsts.addPhotoButtonPadding)
        addPhotoButton.setDimensions(height: RegistrationConsts.addPhotoButtonHeight, width: RegistrationConsts.addPhotoButtonWidth)
    }

    private func confugireAccountButtonConstraints() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor)
    }

    // MARK: - Configure observers

    private func configureTextFields() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        configureNotificationObnservers()
    }

    private func configureNotificationObnservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Selectors

    @objc
    private func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }

    @objc
    private func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

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
    private func handleRegistration() {
        guard let email = emailTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = userNameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let profileImage = profileImage else { return }

        let credentials = RegistrationCredentials(email: email,
                                                  password: password,
                                                  fullname: fullname,
                                                  username: username,
                                                  profileImage: profileImage)

        showLoader(true, withText: "Signing you up")

        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            self.dismiss(animated: true, completion: nil)
        }

    }
}

    // MARK: - Extensions

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        addPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        addPhotoButton.layer.borderWidth = 3.0
        addPhotoButton.layer.cornerRadius = RegistrationConsts.addPhotoButtonHeight / 2
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
