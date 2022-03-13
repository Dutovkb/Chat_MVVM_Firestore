//
//  NewMessageController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 13.03.2022.
//

import UIKit

final class NewMessageController: UITableViewController {

    // MARK: Properties

    private var users: [User] = []

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }

    // MARK: Configure UI

    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        configureTableView()
    }

    private func configureNavigationBar() {
        configureNavigationController(withTitle: "New message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
    }

    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.rowHeight = 80
    }

    private func fetchUsers() {
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }

    // MARK: Selectors

    @objc
    private func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell
        else { return UITableViewCell() }
        cell.user = users[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
