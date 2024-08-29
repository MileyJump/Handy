//
//  HashTagQuery.swift
//  CraftMate
//
//  Created by 최민경 on 8/29/24.
//

import Foundation

struct HashTagQuery: Encodable {
    let next: String?
    let limit: String?
    let product_id: String?
    let hashTag: String
    
}
