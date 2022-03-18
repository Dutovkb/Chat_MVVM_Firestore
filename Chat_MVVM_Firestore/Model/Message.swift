//
//  Message.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 14.03.2022.
//

import Foundation
import Firebase

struct Message {
    let text: String
    let toId: String
    let fromId: String
    var timestamp: Timestamp!
    var user: User?
    let isFromCurrentUser: Bool

    init(dictioanry: [String: Any]) {
        self.text = dictioanry["text"] as? String ?? ""
        self.toId = dictioanry["toId"] as? String ?? ""
        self.fromId = dictioanry["fromId"] as? String ?? ""
        self.timestamp = dictioanry["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    }
}
