//
//  ChatController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 14.03.2022.
//

import UIKit

final class ChatController: UICollectionViewController {

    private let user: User

    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("DEBUG: User in chat controller is \(user.username)")
    }

    private func configureUI() {

    }
}
