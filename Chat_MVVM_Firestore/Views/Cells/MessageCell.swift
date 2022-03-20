//
//  MessageCell.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 14.03.2022.
//

import UIKit

final class MessageCell: UICollectionViewCell {
    static let identifier = "\(MessageCell.self)"

    // MARK: - Properties

    var message: Message? {
        didSet { configure() }
    }

    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!


    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textColor = .black
        return textView
    }()

    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Configure cell

    private func configure() {
        guard let message = message else { return }
        let viewmodel = MessageViewModel(message: message)

        bubbleContainer.backgroundColor = viewmodel.messageBackgroundColor
        textView.textColor = viewmodel.messageTextColor
        textView.text = message.text

        bubbleLeftAnchor.isActive = viewmodel.leftAnchorActive
        bubbleRightAnchor.isActive = viewmodel.rightAnchorActive

        profileImageView.isHidden = viewmodel.shouldHideProfileImage
        profileImageView.sd_setImage(with: viewmodel.profileImageUrl)
    }

    // MARK: - Configure UI

    private func configureUI() {
        configureProfileImageView()
        configureBubbleContainer()
    }

    private func configureProfileImageView() {
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -4)
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
    }

    private func configureBubbleContainer() {
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        bubbleContainer.addSubview(textView)

        textView.anchor(top: bubbleContainer.topAnchor,
                        left: bubbleContainer.leftAnchor,
                        bottom: bubbleContainer.bottomAnchor,
                        right: bubbleContainer.rightAnchor,
                        paddingTop: 4,
                        paddingLeft: 12,
                        paddingBottom: -4,
                        paddingRight: -12)
    }
}
