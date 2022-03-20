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
        Firebase.collectionUsers.getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }

    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firebase.collectionUsers.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }

    static func fetchConversations(completion: @escaping([Conversation]) -> Void) {
        var conversations: [Conversation] = []
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = Firebase.collectionMessages.document(uid).collection("recent-messages").order(by: "timestamp")
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictioanry: dictionary)

                self.fetchUser(withUid: message.toId) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }

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
            Firebase.collectionMessages.document(currentUid).collection("recent-messages").document(user.uid).setData(data)
            Firebase.collectionMessages.document(user.uid).collection("recent-messages").document(currentUid).setData(data)
        }
    }

    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var messages: [Message] = []
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        let query = Firebase.collectionMessages.document(currentUid).collection(user.uid).order(by: "timestamp")
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictioanry: dictionary))
                    completion(messages)
                }
            })
        }
    }
}
