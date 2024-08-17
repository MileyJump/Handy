//
//  PostRetrievalModel.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation

struct PostRetrievalModel: Decodable {
    let data: [PostData]
    
}

struct PostData: Decodable {
    let post_id: String
    let product_id: String
    let title: String
    let content: String
    let content1: String
    let content2: String
    let content3: String
    let content4: String
    let content5: String
    let createdAt: String
    let creator: Creator
//    let files: [
//        "uploads/posts/
//        "uploads/posts/
//        "uploads/posts/
//    ]
    let likes: [Likes]
    let likes2: [Likes2]
    let hashTags: [HashTags]
    let comments: [Comments]
    let next_cursor: String
}


struct Creator: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String
}

struct Files: Decodable {
}

struct Likes: Decodable {
    
}

struct Likes2: Decodable {
}

struct HashTags: Decodable {
    
}

struct Comments: Decodable {
    let comment_id: String
    let createdAt: String
    let creator: Creator
}
