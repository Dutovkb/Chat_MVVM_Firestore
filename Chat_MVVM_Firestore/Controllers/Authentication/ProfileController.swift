//
//  ProfileController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 20.03.2022.
//

import UIKit
import Firebase

final class ProfileController: UITableViewController {

    // MARK: - Properties
    private var user: User? {
        didSet { headerView.user = user }
    }
    private lazy var headerView = ProfileHeader(frame: .init(x: 0,
                                                             y: 0,
                                                             width: view.frame.width,
                                                             height: 380))

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }

    // MARK: - Configure UI

    private func configureUI() {
    }
    
    // MARK: - Configure tableview
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell.identifier")
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        headerView.delegate = self
    }

    // MARK: - API

    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }

    // MARK: - Selectors

    //MARK: - Helpers
}

extension ProfileController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell.identifier", for: indexPath)
        return cell
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
