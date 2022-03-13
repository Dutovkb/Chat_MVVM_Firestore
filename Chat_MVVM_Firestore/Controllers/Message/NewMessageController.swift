//
//  NewMessageController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 13.03.2022.
//

import UIKit

final class NewMessageController: UITableViewController {

    // MARK: Properties

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewMessageCell")
        tableView.rowHeight = 80
    }

    // MARK: Selectors

    @objc
    private func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewMessageCell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = "New message"
        cell.textLabel?.textColor = .black
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
