//
//  SingUpModel.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation

struct SignUpModel: Decodable {
    let id: String
    let email: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case email, nick
    }
}
