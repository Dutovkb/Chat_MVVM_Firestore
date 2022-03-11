//
//  LoginViewModel.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import Foundation

struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?

    var formIsValid: Bool {
        return email?.isEmpty  == false
        && password?.isEmpty == false
    }
}
