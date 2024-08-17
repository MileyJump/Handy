//
//  Router.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation
import Alamofire

enum Router {
    case signUp
    case login(query: LoginQuery)
    case fetchProfile
    case editProfile
    case refresh
    case createPost
    case postRetrieval
    
}

extension Router: TargetType {
    var baseURL: String {
        return BaseURL.baseURL
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signUp:
            return .post
        case .login:
            return .post
        case .fetchProfile: // 프로필 조회
            return .get
        case .editProfile: // 내 프로필 수정
            return .put
        case .refresh:
            return .get
        case .createPost:
            return .post
        case .postRetrieval:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/users/join"
        case .login:
            return "/users/login"
        case .fetchProfile, .editProfile:
            return "/users/me/profile"
        case .refresh:
            return "/auth/refresh"
        case .createPost:
            return "/posts"
        case .postRetrieval:
            return "/post"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .signUp,.login:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: Key.key
            ]
        case .fetchProfile:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
//                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: Key.key
            ]
        case .editProfile:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.sesacKey.rawValue: Key.key
                // 멀티파티폼? 이거 해야 됨!!! 근데 까먹음 ㅎㅎ 🍎
            ]
        case .refresh:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.refresh.rawValue: UserDefaultsManager.shared.refreshToken,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: Key.key
            ]
        case .createPost:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: Key.key
            ]
        case .postRetrieval:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.sesacKey.rawValue: Key.key
            ]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .login(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        default:
            return nil
        }
    }
    
    
}
