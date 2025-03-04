//
//  TargetType.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get}
    var header: [String: String] { get }
    var parameters: String? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
//        let url = try baseURL.asURL() // URL로 변경
//        var request = try URLRequest(url: url.appendingPathComponent(path), method: method) // URL에 path를 추가
//        request.allHTTPHeaderFields = header // HTTP헤더를 URLReqeust에 추가
//        request.httpBody = body // 본문 설정
//        return request
        
        let url = try baseURL.asURL()
        var components = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        
        // 쿼리 아이템 추가
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        // 헤더 추가
        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // body 데이터 추가
        request.httpBody = body
        
        return request
    
        
        
    }
}
