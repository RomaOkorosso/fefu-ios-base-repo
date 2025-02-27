//
//  AuthModels.swift
//  fefuactivity
//
//  Created by RomaOkorosso on 29.01.2022.
//

import Foundation

struct RegisterRequestModel: Encodable {
    let login: String
    let password: String
    let name: String
    let gender: Int
}

struct LoginRequestModel: Encodable {
    let login: String
    let password: String
}

struct LoginErrorModel: Decodable {
    let login: [String]
}

struct AuthResponseModel: Decodable {
    let token: String
    let user: UserModel
}
