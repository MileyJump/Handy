//
//  SingUpModel.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation

struct SignUpModel: Decodable {
    let email: String
    let password: String
    let nick: String
    let phoneNum: String
    let birthDay: String
}
