//
//  CustomTextField.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit

final class CustomTextField: UITextField {

    private enum Constants {
        static let fontSize: CGFloat = 16
    }

    init(placeholder: String) {
        super.init(frame: .zero)

        borderStyle = .none
        font = UIFont.systemFont(ofSize: Constants.fontSize)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [.foregroundColor : UIColor.white])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
