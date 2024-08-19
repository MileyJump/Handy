//
//  SingUpModel.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation

//struct SignUpModel: Decodable {
//    let email: String
//    let password: String
//    let nick: String
//    let phoneNum: String
//    let birthDay: String
//}

struct SignUpModel: Decodable {
    let id: String
//    let user_id: String
    let email: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case email, nick
    }
}
