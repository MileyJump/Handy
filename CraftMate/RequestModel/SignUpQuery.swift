//
//  SignUpQuery.swift
//  CraftMate
//
//  Created by 최민경 on 8/18/24.
//

import Foundation

struct SignUpQuery: Encodable {
    let email: String
    let password: String
    let nick: String
    let phoneNum: String?
    let birthDay: String?
}
