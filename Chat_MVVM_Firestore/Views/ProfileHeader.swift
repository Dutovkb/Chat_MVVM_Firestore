//
//  ProfileHeader.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 27.03.2022.
//

import UIKit

final class ProfileHeader: UIView {
    
    // MARK: - Properties
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4.0
        return imageView
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Kirill Dutov"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "@Kirro"
        return label
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        layer.addSublayer(gradient)
        gradient.frame = bounds
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        backgroundColor = .systemPink
        configureProfileImageview()
        configureStackView()
        configureDismissButton()
    }
    
    private func configureProfileImageview() {
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 200, width: 200)
        profileImageView.layer.cornerRadius = 200 / 2
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: topAnchor, paddingTop: 96)
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
        stackView.centerX(inView: self)
        stackView.anchor(top: profileImageView.bottomAnchor, paddingTop: 16)
    }
    
    private func configureDismissButton() {
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12)
        dismissButton.setDimensions(height: 48, width: 48)
    }
    
    // MARK: - Selectors
    
    @objc
    private func handleDismissal() {
        
    }
}
