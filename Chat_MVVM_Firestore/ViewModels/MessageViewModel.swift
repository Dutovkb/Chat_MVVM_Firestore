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

    init(message: Message) {
        self.message = message
    }
}
