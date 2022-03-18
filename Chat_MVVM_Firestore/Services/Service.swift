//
//  Service.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 13.03.2022.
//

import Foundation
import Firebase

struct Service {

    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        var users: [User] = []
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }

    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        Firebase.collectionMessages.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            Firebase.collectionMessages.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
        }
    }
}
