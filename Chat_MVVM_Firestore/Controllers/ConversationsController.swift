//
//  ConversationsController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit
import Firebase

class ConversationsController: UIViewController {

    // MARK: Properties

    private let tableView = UITableView(frame: .zero)

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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
    }

    // MARK: Configure UI

    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationController(withTitle: "Messages", prefersLargeTitles: true)
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ConversationCell")
    }

    private func configureNewMessageButton() {
        view.addSubview(newMessageButton)
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                right: view.rightAnchor,
                                paddingBottom: ConversationConsts.newMessagePaddingBottom,
                                paddingRight: ConversationConsts.newMessagePaddingRight)
        newMessageButton.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
    }

    // MARK: Configure API

    private func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print("DEBUG: user id is: \(Auth.auth().currentUser?.uid)")
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

    // MARK: Selectors

    @objc
    private func showProfile() {
        logout()
    }

    @objc
    private func showNewMessage() {
        let controller = NewMessageController()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }

    // MARK: Helpers

    private func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}

extension ConversationsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
