//
//  MessageViewModel.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 15.03.2022.
//

import Foundation
import UIKit

struct MessageViewModel {

    private let message: Message

    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .lightGray : .systemPurple
    }

    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }

    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }

    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }

    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }

    init(message: Message) {
        self.message = message
    }
}
