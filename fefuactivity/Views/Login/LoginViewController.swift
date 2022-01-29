//
//  LoginViewController.swift
//  fefuactivity
//
//  Created by Roman Okorosso on 23.20.2021.
//

import UIKit
import SwiftUI

class LoginViewConstroller: UIViewController {
    let loginTextField = VioletTextField()
    let passwordTextField = VioletTextField(isSecure: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Вход"

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8

        loginTextField.placeholder = "Login"
        passwordTextField.placeholder = "Password"

        let continueButton = VioletUIButton(text: "Продолжить")
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(self.continueBtnClicked), for: .touchUpInside)

        let peopleBicyclesImg = UIImage(named: "peopleBicycles")
        let imageView = UIImageView()

        imageView.image = peopleBicyclesImg
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false


        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)

        view.addSubview(stackView)
        view.addSubview(continueButton)
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            ])

        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 96),
            continueButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 40),
            continueButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 54)
        ])

        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: -26),
            imageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: 26),
        ])
    }
    @IBAction func continueBtnClicked(sender: UIButton) {
        let login = self.loginTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""

        let loginData = LoginRequestModel(login: login, password: password)

        do {
            let data = try AuthService.encoder.encode(loginData)
            AuthService.login(data) { auth in
                DispatchQueue.main.async {
                    UserDefaults.standard.set(auth.token, forKey: "token")

                    let swiftUIView = MainTabBar()
                    let hosting = UIHostingController(rootView: swiftUIView)

                    guard let window = UIApplication.shared.keyWindow else { return }
                    window.rootViewController = hosting

                    UIView.transition(with: window, duration: 0.2, options: .curveEaseInOut) { }
                }
            } reject: { err in
                DispatchQueue.main.async {
                    let alertMessage = AuthService.errorMessage(error: err)
                    let alert = UIAlertController(title: "Error",message:alertMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    self.present(alert, animated: true, completion: nil)
                    print(alertMessage)
                }
            }
        } catch {
            print(error)
        }
    }
}


