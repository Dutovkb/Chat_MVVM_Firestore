//
//  CustomInputAccessoryView.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 14.03.2022.
//

import UIKit

final class CustomInputAccessoryView: UIView {

    // MARK: Properties

    private lazy var messageInputTextView: UITextView = {
        let textview = UITextView()
        textview.font = UIFont.systemFont(ofSize: 16)
        textview.textColor = .black
        textview.isScrollEnabled = false
        textview.backgroundColor = .white
        return textview
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()

    // MARK: Lifycycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addObserver()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configure UI

    private func configureUI() {
        autoresizingMask = .flexibleHeight
        backgroundColor = .white

        configureSendButton()
        configureTextView()
        configurePlaceholderLabel()
        congigureShadow()
    }

    private func configureSendButton() {
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: -8)
        sendButton.setDimensions(height: 50, width: 50)
    }

    private func configureTextView() {
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor,
                                    left: leftAnchor,
                                    bottom: safeAreaLayoutGuide.bottomAnchor,
                                    right: sendButton.leftAnchor,
                                    paddingTop: 12,
                                    paddingLeft: 8,
                                    paddingBottom: -8,
                                    paddingRight: -8)
    }

    private func configurePlaceholderLabel() {
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 4)
        placeholderLabel.centerY(inView: messageInputTextView)
    }

    private func congigureShadow() {
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
    }

    // MARK: Add observers

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }

    override var intrinsicContentSize: CGSize {
        return .zero
    }

    // MARK: Selectors

    @objc
    private func handleSendMessage() {

    }

    @objc
    private func handleTextInputChange() {
        placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
}
