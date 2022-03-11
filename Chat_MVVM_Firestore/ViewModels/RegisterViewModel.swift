//
//  RegisterViewModel.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import Foundation

protocol AuthenticationProtocol {

    /// Checks that model fields are filled
    var formIsValid: Bool { get }
}

struct RegisterViewModel: AuthenticationProtocol {

    var email: String?
    var fullname: String?
    var username: String?
    var password: String?

    var formIsValid: Bool {
        return email?.isEmpty  == false
        && password?.isEmpty == false
        && fullname?.isEmpty == false
        && username?.isEmpty == false
    }
}
