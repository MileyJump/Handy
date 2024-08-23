//
//  FetchPostQuery.swift
//  CraftMate
//
//  Created by 최민경 on 8/23/24.
//

import Foundation

struct FetchQuery: Encodable {
    let next: String?
    let limit: String?
    let product_id: String?
}
