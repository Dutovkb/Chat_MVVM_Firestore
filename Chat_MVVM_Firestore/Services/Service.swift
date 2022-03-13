//
//  Service.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 13.03.2022.
//

import Foundation
import Firebase

struct Service {

    static func fetchUsres() {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                print(document.data())
            })
        }
    }
}
