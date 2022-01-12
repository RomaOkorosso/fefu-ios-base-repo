//
//  RegistrationController.swift
//  fefuactivity
//
//  Created by Roman Okorosso on 22.10.2021.
//

import Foundation
import UIKit

class RegController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.becomeFirstResponder()
    }

    @objc func doneBtnFromKeyboardClicked() {
        textFieldForPicker.text = genders[self.genderPicker.selectedRow(inComponent: 0)]

        textFieldForPicker.resignFirstResponder()
    }


    // MARK: -props

    let genders = ["Male", "Female"]

    let textFieldForPicker = VioletTextField()

    let genderPicker = UIPickerView()

    // MARK: end props-


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        self.title = "Регистрация"

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8



        let loginTextField = VioletTextField()
        loginTextField.placeholder = "Login"

        let passwordTextField = VioletTextField(isSecure: true)
        passwordTextField.placeholder = "Password"

        let repeatPasswordTextField = VioletTextField(isSecure: true)
        repeatPasswordTextField.placeholder = "Repeat password"
        passwordTextField.textContentType = .newPassword
        repeatPasswordTextField.textContentType = .newPassword

        let nameTextField = VioletTextField()
        nameTextField.placeholder = "Name or nickname"

        genderPicker.dataSource = self
        genderPicker.delegate = self

        textFieldForPicker.placeholder = "Choose your gender"
        textFieldForPicker.inputView = genderPicker
        textFieldForPicker.delegate = self
        textFieldForPicker.allowsEditingTextAttributes = false

        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapGender))
        textFieldForPicker.addGestureRecognizer(gesture)
        
        let ViewForDoneButtonOnPikcer = UIToolbar()
        ViewForDoneButtonOnPikcer.sizeToFit()
        let btnDoneOnKeyboard = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneBtnFromKeyboardClicked))
        ViewForDoneButtonOnPikcer.items = [btnDoneOnKeyboard]
        textFieldForPicker.inputAccessoryView = ViewForDoneButtonOnPikcer
        view.addSubview(textFieldForPicker)

        let continueButton = VioletUIButton(text: "Продолжить")
        continueButton.translatesAutoresizingMaskIntoConstraints = false


        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(repeatPasswordTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(textFieldForPicker)


        let confirmPolitics = UILabel()

        let violetColor = UIColor(named: "violet") ?? .blue
        let policyText: ColoredText = "Нажимая на кнопку, вы соглашаетесь с \("политикой конфиденциальности", color: violetColor) и обработки персональных данных, а также  принимаете \("пользовательское соглашение", color: violetColor)"
        confirmPolitics.attributedText = policyText.output
        confirmPolitics.translatesAutoresizingMaskIntoConstraints = false
        confirmPolitics.textAlignment = .center
        confirmPolitics.numberOfLines = 0

        confirmPolitics.sizeThatFits(CGSize(width: confirmPolitics.frame.size.width, height: confirmPolitics.frame.height))


        let imageView = UIImageView()
        let buttomImg = UIImage(named: "grayLogo")!

        imageView.image = buttomImg
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        view.addSubview(continueButton)
        view.addSubview(confirmPolitics)
        view.addSubview(imageView)


        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 400),
        ])

        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 26),
            continueButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 40),
            continueButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 54)
        ])

        NSLayoutConstraint.activate([
            confirmPolitics.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 78),
            confirmPolitics.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            confirmPolitics.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62),
            imageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }

    @objc func didTapGender() {
        self.textFieldForPicker.becomeFirstResponder()
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldForPicker.text = genders[self.genderPicker.selectedRow(inComponent: 0)]
    }
}