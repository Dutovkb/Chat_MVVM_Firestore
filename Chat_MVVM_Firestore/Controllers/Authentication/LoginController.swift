//
//  LoginController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit
import Firebase
import JGProgressHUD

protocol AuthenticationControllerProtocol {

    /// Checks that form fields are filled out
    func checkFormStatus()
}

final class LoginController: UIViewController {

    // MARK: - Properties

    private var viewModel = LoginViewModel()
    
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
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: LoginConsts.loginButtonHeight)
        button.layer.cornerRadius = LoginConsts.buttonCornerRadius
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: LoginConsts.buttonTitleFontSize)
        button.backgroundColor = .systemPurple
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?",
                                                        attributes: [.font: UIFont.systemFont(ofSize: LoginConsts.accountButtonFontSize),
                                                                     .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: " Sign up",
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: LoginConsts.accountButtonFontSize),
                                                               .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    // MARK: - Configure UI

    private func configureUI() {
        view.backgroundColor = .systemPink
        setupNavigationController()
        configureGradientLayer()
        configureIconConstraints()
        configureStackView()
        confugireAccountButtonConstraints()
        configureTextFields()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureIconConstraints() {
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: LoginConsts.iconPaddingTop)
        iconImage.setDimensions(height: LoginConsts.iconHeight, width: LoginConsts.iconWidth)
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView,
                                                       loginButton])
        stackView.axis = .vertical
        stackView.spacing = LoginConsts.stackViewSpacing
        view.addSubview(stackView)
        configureStackViewConstraints(for: stackView)
    }
    
    private func configureStackViewConstraints(for stackView: UIStackView) {
        stackView.anchor(top: iconImage.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: LoginConsts.stackViewPadding,
                         paddingLeft: LoginConsts.stackViewPadding,
                         paddingRight: -LoginConsts.stackViewPadding)
    }

    private func confugireAccountButtonConstraints() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor)
    }

    private func configureTextFields() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    // MARK: - Selectors

    @objc
    private func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc
    private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }

    @objc
    private func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        showLoader(true)

        AuthService.shared.logUserInWith(email: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to log in with error: \(error.localizedDescription)")
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

    // MARK: - Extension

extension LoginController: AuthenticationControllerProtocol {

    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemPink
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .systemPurple
        }
    }
}
