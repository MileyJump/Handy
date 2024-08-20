//
//  ProfileModel.swift
//  CraftMate
//
//  Created by 최민경 on 8/20/24.
//

import Foundation

struct ProfileModel: Decodable {
    let id: String
    let email: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case email
        case nick
    }
}

