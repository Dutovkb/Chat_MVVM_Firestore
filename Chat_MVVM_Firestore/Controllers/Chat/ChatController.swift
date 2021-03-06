//
//  ChatController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 14.03.2022.
//

import UIKit

final class ChatController: UICollectionViewController {

    // MARK: - Properties

    private let user: User
    private var messages: [Message] = []
    private var fromCurrentUser = false

    private lazy var customInputView: CustomInputAccessoryView = {
        let inputView = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        inputView.delegate = self
        return inputView
    }()

    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: - Inits

    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchMessages()
    }

    // MARK: - API

    func fetchMessages() {
        Service.fetchMessages(forUser: user) { messages in
            self.messages = messages
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1],
                                             at: .bottom, animated: true)
        }
    }

    // MARK: - Configure UI

    private func configureUI() {
        configureNavigationController(withTitle: user.username, prefersLargeTitles: false)
        configureCollectionView()
    }

    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.identifier, for: indexPath) as? MessageCell else { return UICollectionViewCell() }
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        return cell
    }
}

    // MARK: - Extensions

extension ChatController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimatedSizeCell = MessageCell(frame: frame)
        estimatedSizeCell.message = messages[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()

        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)

        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

extension ChatController: CustomInputAccessoryViewDelegate {

    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
        Service.uploadMessage(message, to: user) { error in
            if let error = error {
                print("DEBUG: Failed to upload message with error \(error.localizedDescription)")
                return
            }
            inputView.clearMessageText()
        }
    }
}
