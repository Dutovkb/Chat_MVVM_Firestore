//
//  Constants.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 13.03.2022.
//

import UIKit
import Firebase

enum LoginConsts {

    static let iconHeight: CGFloat = 120
    static let iconWidth: CGFloat = 120
    static let iconPaddingTop: CGFloat = 32

    static let buttonCornerRadius: CGFloat = 5
    static let buttonTitleFontSize: CGFloat = 16

    static let accountButtonFontSize: CGFloat = 16

    static let stackViewSpacing: CGFloat = 16
    static let stackViewPadding: CGFloat = 32

    static let loginButtonHeight: CGFloat = 50
}

enum RegistrationConsts {

    static let addPhotoButtonHeight: CGFloat = 120
    static let addPhotoButtonWidth: CGFloat = 120
    static let addPhotoButtonPadding: CGFloat = 32

    static let sighUpButtonHeight: CGFloat = 50
    static let signUpCornerRadius: CGFloat = 5
    static let sighUpButtonTitleFontSize: CGFloat = 16

    static let stackViewSpacing: CGFloat = 16
    static let stackViewPadding: CGFloat = 32

    static let accountButtonFontSize: CGFloat = 16
}

enum InputContainerConsts {

    static let passwordContainerViewHeight: CGFloat = 50
    static let containerImageViewPadding: CGFloat = 8

    static let passwordImageViewHeight: CGFloat = 28
    static let passwordImageViewWidth: CGFloat = 28
    static let passwordTextFieldPaddingLeft: CGFloat = 8

    static let dividerViewHeight: CGFloat = 0.75
    static let dividerViewPadding: CGFloat = 8

    static let imageViewAlpha: CGFloat = 0.87
}

enum ConversationConsts {

    static let newMessageButtonHeight: CGFloat = 56
    static let newMessageButtonWidth: CGFloat = 56
    static let newMessagePaddingBottom: CGFloat = -16
    static let newMessagePaddingRight: CGFloat = -24

    static let newMessageButtonCornerRadius = newMessageButtonHeight / 2
}

enum UserCellConsts {
    static let profileImageViewPaddingLeft: CGFloat = 12
    static let profileImageViewHeight: CGFloat = 56
    static let profileImageViewWidth: CGFloat = 56
    static let profileImageViewCornerRadius = profileImageViewHeight / 2

    static let stackViewSpacing: CGFloat = 2
    static let stackViewPaddingLeft: CGFloat = 12

    static let fontSize: CGFloat = 14
}

enum Firebase {
    static let collectionMessages = Firestore.firestore().collection("messages")
    static let collectionUsers = Firestore.firestore().collection("users")
}
