//
//  ConversationViewModel.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 20.03.2022.
//

import Foundation

struct ConversationViewModel {

    private let conversation: Conversation

    var profileImageUrl: URL? {
        return URL(string: conversation.user.profileImageUrl)
    }

    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }

    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
