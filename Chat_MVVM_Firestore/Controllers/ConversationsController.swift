//
//  ConversationsController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit
import Firebase

class ConversationsController: UIViewController {

    // MARK: - Properties

    private let tableView = UITableView(frame: .zero)
    private var conversations: [Conversation] = []

    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.setDimensions(height: ConversationConsts.newMessageButtonHeight,
                             width: ConversationConsts.newMessageButtonWidth)
        button.layer.cornerRadius = ConversationConsts.newMessageButtonCornerRadius
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchConversations()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationController(withTitle: "Messages", prefersLargeTitles: true)
    }

    // MARK: - Configure UI

    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationItem()
        configureTableView()
        configureNewMessageButton()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Messages"
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(showProfile))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.identifier)
    }

    private func configureNewMessageButton() {
        view.addSubview(newMessageButton)
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                right: view.rightAnchor,
                                paddingBottom: ConversationConsts.newMessagePaddingBottom,
                                paddingRight: ConversationConsts.newMessagePaddingRight)
        newMessageButton.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
    }

    // MARK: - Configure API

    private func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print("DEBUG: user id is: \(Auth.auth().currentUser?.uid)")
        }
    }

    private func fetchConversations() {
        Service.fetchConversations { conversations in
            self.conversations = conversations
            self.tableView.reloadData()
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("DEBUG: Error signing out")
        }
    }

    // MARK: - Selectors

    @objc
    private func showProfile() {
        logout()
    }

    @objc
    private func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }

    // MARK: - Helpers

    private func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }

    private func showChatController(forUser user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

    // MARK: - Extensions

extension ConversationsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.identifier, for: indexPath) as? ConversationCell else { return UITableViewCell() }
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
    }
}

extension ConversationsController: NewMessageControllerDelegate {

    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
    }
}
