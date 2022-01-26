//
//  VioletUIButton.swift
//  fefuactivity
//
//  Created by Roma Okorosso on 25.20.2021.
//

import Foundation
import UIKit

class VioletUIButton: UIButton {

    init(text: String) {
        super.init(frame: .zero)

        let myColor = UIColor(named: "violet")
        self.backgroundColor = myColor
        self.setTitleColor(UIColor.systemBackground, for: .normal)
        self.layer.borderColor = myColor?.cgColor
        self.layer.cornerRadius = 8

        self.setTitle(text, for: .normal)
        super.layoutSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
