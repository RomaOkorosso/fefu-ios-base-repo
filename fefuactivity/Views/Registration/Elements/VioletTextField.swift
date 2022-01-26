//
//  VioletTextField.swift
//  fefuactivity
//
//  Created by Roma Okoroosso on 25.10.2021.
//

import Foundation
import UIKit

class VioletTextField: UITextField {
    var textPadding = UIEdgeInsets(
            top: 10,
            left: 20,
            bottom: 10,
            right: 20
        )

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: bounds.width - 38, y: bounds.height / 4, width: 30, height: 30)
    }

    init(isSecure: Bool = false) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50)
        ])

        // for dark theme
        self.attributedPlaceholder = NSAttributedString (
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )

        let myColor = UIColor(named: "gray400")
        self.layer.borderColor = (myColor?.cgColor)
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8
        self.textColor = UIColor.label
        


        if isSecure {
            let dasAuge = UIButton()
            dasAuge.setImage(UIImage(named: "openEye"), for: .normal)
            dasAuge.addTarget(self, action: #selector(onTap), for: .touchUpInside)
            //        dasAuge.contentMode = .left


            dasAuge.frame = CGRect(
                origin: .zero,
                size: CGSize(
                    width: self.frame.width - 16,
                    height: self.frame.height
                )
            )

            dasAuge.contentMode = .right
            self.rightView = dasAuge
            self.rightViewMode = .always

        }

    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func onTap() {
        self.isSecureTextEntry.toggle()
    }
}
