//
//  UserCell.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 13.03.2022.
//

import UIKit
import SDWebImage

final class UserCell: UITableViewCell {
    static let identifier = "\(UserCell.self)"
    
    // MARK: - Properties

    var user: User? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UserCellConsts.fontSize)
        label.textColor = .black
        return label
    }()

    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UserCellConsts.fontSize)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure cell

    private func configure() {
        guard let user = user,
              let url = URL(string: user.profileImageUrl) else { return }
        fullnameLabel.text = user.fullname
        usernameLabel.text = user.username
        profileImageView.sd_setImage(with: url)
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        self.backgroundColor = .clear
        configureProfileImageView()
        configureStackView()
    }
    
    private func configureProfileImageView() {
        addSubview(profileImageView)
        profileImageView.centerY(inView: self,
                                 leftAnchor: leftAnchor,
                                 paddingLeft: UserCellConsts.profileImageViewPaddingLeft)
        profileImageView.setDimensions(height: UserCellConsts.profileImageViewHeight,
                                       width: UserCellConsts.profileImageViewWidth)
        profileImageView.layer.cornerRadius = UserCellConsts.profileImageViewCornerRadius
    }

    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stackView.axis = .vertical
        stackView.spacing = UserCellConsts.stackViewSpacing

        addSubview(stackView)
        stackView.centerY(inView: profileImageView,
                          leftAnchor: profileImageView.rightAnchor,
                          paddingLeft: UserCellConsts.stackViewPaddingLeft)
        stackView.anchor(right: self.rightAnchor, paddingRight: -UserCellConsts.stackViewPaddingLeft)
    }
}
