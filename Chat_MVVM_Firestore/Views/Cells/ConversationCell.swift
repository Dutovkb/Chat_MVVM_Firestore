//
//  ConversationCell.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 20.03.2022.
//

import UIKit

final class ConversationCell: UITableViewCell {
    static let identifier = "\(ConversationCell.self)"

    // MARK: - Properties

    var conversation: Conversation? {
        didSet { configure() }
    }

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "2h"
        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    private let messagetextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure cell

    private func configure() {
        guard let conversation = conversation else { return }
        let viewModel = ConversationViewModel(conversation: conversation)
        usernameLabel.text = conversation.user.username
        messagetextLabel.text = conversation.message.text
        timestampLabel.text = viewModel.timestamp
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)

    }

    // MARK: - Configure UI

    private func configureUI() {
        self.backgroundColor = .clear
        configureProfileImage()
        configureStackView()
        configureTimestampLabel()
    }

    private func configureProfileImage() {
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerY(inView: self)
    }

    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [usernameLabel, messagetextLabel])
        stack.axis = .vertical
        stack.spacing = 4
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: -16)
    }

    private func configureTimestampLabel() {
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 20, paddingRight: -12)
    }
}
