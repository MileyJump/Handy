//
//  PostRetrievalModel.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation

// MARK: - Root Model

struct FetchPostModel: Decodable {
    let data: [Post]
    let nextCursor: String?

    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}

// MARK: - Post Model
struct Post: Decodable {
    let postId: String
    let productId: String?
    let title: String?
    let price: Int?
    let content: String?
    let content1: String?
    let content2: String?
    let content3: String?
    let content4: String?
    let content5: String?
    let createdAt: String
    let creator: Creator
    let files: [String]?
    let likes: [String]?
    let likes2: [String]?
    let hashTags: [String]?
    let comments: [Comment]?

    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case productId = "product_id"
        case title
        case price
        case content
        case content1
        case content2
        case content3
        case content4
        case content5
        case createdAt = "createdAt"
        case creator
        case files
        case likes
        case likes2
        case hashTags = "hashTags"
        case comments
    }
}

// MARK: - Creator Model
struct Creator: Decodable {
    let userId: String
    let nick: String
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nick
        case profileImage = "profileImage"
    }
}

// MARK: - Comment Model
struct Comment: Decodable {
    let commentId: String
    let content: String
    let createdAt: String
    let creator: Creator

    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case content
        case createdAt = "createdAt"
        case creator
    }
}


