//
//  Router.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation
import Alamofire

enum Router {
    case signUp(query: SignUpQuery)
    case login(query: LoginQuery)
    case fetchProfile
    case editProfile
    case refresh
    case createPost(query: CreatePostQuery)
    case fetchPost(query: FetchPostQuery)
    case imageUpload(query: ImageUploadQuery)
    case emailDuplicateCheck(query: EmailDuplicateCheckQuery)
    case deletePost(query: String)
    case readImage(query: String)
}

extension Router: TargetType {
    var baseURL: String {
        return BaseURL.baseURL
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .emailDuplicateCheck, .signUp, .login, .createPost, .imageUpload:
            return .post
        case .fetchProfile, .refresh, .fetchPost, .readImage:
            return .get
        case .editProfile: // 내 프로필 수정
            return .put
        case .deletePost:
            return .delete
        }
    }
    
   
    
    var path: String {
        switch self {
        case .emailDuplicateCheck:
            return "v1/validation/email"
        case .signUp:
            return "v1/users/join"
        case .login:
            return "v1/users/login"
        case .fetchProfile, .editProfile:
            return "/users/me/profile"
        case .refresh:
            return "v1/auth/refresh"
        case .createPost:
            return "v1/posts"
        case .fetchPost:
            return "v1/posts"
        case .imageUpload:
            return "v1/posts/files"
        case .deletePost(let query):
            return "v1/posts/\(query)"
        case .readImage(let query):
            return "v1/\(query)"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .emailDuplicateCheck,.signUp,.login:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: Key.key
            ]
        case .fetchProfile, .fetchPost, .editProfile, .deletePost, .readImage:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.sesacKey.rawValue: Key.key
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
        case .imageUpload:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.multipart.rawValue,
                Header.sesacKey.rawValue: Key.key
            ]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        
        switch self {
        case .fetchPost(let query):
            return [
                //                URLQueryItem(name: "limit", value: String(query.)),
//                URLQueryItem(name: "nextCursor", value: query.nextCursor),
                URLQueryItem(name: "product_id", value: query.product_id)
            ]
        default:
            return nil
        }
        
    }
    
    var body: Data? {
        switch self {
        case .emailDuplicateCheck(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .signUp(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .login(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .createPost(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .imageUpload(let query):
           return nil
        default:
            return nil
        }
    }
    
    



    var routerbaseURL: String {
        return BaseURL.baseURL + "v1"
        }
    
    var asURLRequest: URLRequest {
            do {
                var url = URL(string: routerbaseURL)!.appendingPathComponent(path)
                
                if let queryItems = queryItems {
                    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    components?.queryItems = queryItems
                    url = components?.url ?? url
                }
                
                var request = URLRequest(url: url)
                request.method = method
                request.headers = HTTPHeaders(header)
                
                if method != .get {
                    request.httpBody = body
                }
                
                return request
            } catch {
                fatalError("URL 요청 생성 중 오류 발생: \(error)")
            }
        }
}

