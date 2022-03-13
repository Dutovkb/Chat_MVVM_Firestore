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
        view.backgroundColor = .systemPink
    }

}
