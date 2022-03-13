//
//  InputContainerView.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit

final class InputContainerView: UIView {

    init(image: UIImage, textField: UITextField) {
        super.init(frame: .zero)
        setHeight(height: InputContainerConsts.passwordContainerViewHeight)

        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white
        imageView.alpha = InputContainerConsts.imageViewAlpha

        addSubview(imageView)
        imageView.centerY(inView: self)
        imageView.anchor(left: leftAnchor, paddingLeft: InputContainerConsts.containerImageViewPadding)
        imageView.setDimensions(height: InputContainerConsts.passwordImageViewHeight,
                                width: InputContainerConsts.passwordImageViewWidth)

        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(top: topAnchor,
                         left: imageView.rightAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingLeft: InputContainerConsts.passwordTextFieldPaddingLeft)

        let dividerView = UIView()
        addSubview(dividerView)

        dividerView.backgroundColor = .white
        dividerView.setHeight(height: InputContainerConsts.dividerViewHeight)
        dividerView.anchor(left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           paddingLeft: InputContainerConsts.dividerViewPadding,
                           paddingRight: -InputContainerConsts.dividerViewPadding)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
