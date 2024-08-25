//
//  CreatePostQuery.swift
//  CraftMate
//
//  Created by 최민경 on 8/23/24.
//

import Foundation

struct CreatePostQuery: Encodable {
    let title: String?
    let content: String?
    let content1: String?
    let content2: String?
    let content3: String?
    let content4: String?
    let content5: String?
    let product_id: String?
    let files: [Data]?
}
