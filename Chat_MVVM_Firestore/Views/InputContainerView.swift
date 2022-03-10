//
//  InputContainerView.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit

final class InputContainerView: UIView {

    private enum Constants {
        static let passwordContainerViewHeight: CGFloat = 50
        static let containerImageViewPadding: CGFloat = 8

        static let passwordImageViewHeight: CGFloat = 28
        static let passwordImageViewWidth: CGFloat = 28
        static let passwordTextFieldPaddingLeft: CGFloat = 8

        static let dividerViewHeight: CGFloat = 0.75
        static let dividerViewPadding: CGFloat = 8

        static let imageViewAlpha: CGFloat = 0.87
    }

    init(image: UIImage, textField: UITextField) {
        super.init(frame: .zero)
        setHeight(height: Constants.passwordContainerViewHeight)

        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white
        imageView.alpha = Constants.imageViewAlpha

        addSubview(imageView)
        imageView.centerY(inView: self)
        imageView.anchor(left: leftAnchor, paddingLeft: Constants.containerImageViewPadding)
        imageView.setDimensions(height: Constants.passwordImageViewHeight, width: Constants.passwordImageViewWidth)

        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(top: topAnchor,
                         left: imageView.rightAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingLeft: Constants.passwordTextFieldPaddingLeft)

        let dividerView = UIView()
        addSubview(dividerView)

        dividerView.backgroundColor = .white
        dividerView.setHeight(height: Constants.dividerViewHeight)
        dividerView.anchor(left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           paddingLeft: Constants.dividerViewPadding,
                           paddingRight: -Constants.dividerViewPadding)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
