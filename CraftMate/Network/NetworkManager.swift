//
//  NetworkManager.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    static func emailDuplicateCheck(email: String, completionHandler: @escaping (String, Bool) -> Void ) {
        do {
            let query = EmailDuplicateCheckQuery(email: email)
            let request = try Router.emailDuplicateCheck(query: query).asURLRequest()
            
            AF.request(request).responseDecodable(of: EmailDuplicateCheckModel.self) { response in
                switch response.result {
                case .success(let success):
                    print(success.message)
                    let isSuccess = response.response?.statusCode == 200
                    completionHandler(success.message, isSuccess)
                case .failure(let failure):
                    print(failure)
                }
            }
        } catch {
            print("error \(error)")
        }
    }
    
    static func createSignUp(email: String, password: String, nick: String, phoneNum: String?, birthDay: String?) {
        do {
            let query = SignUpQuery(email: email, password: password, nick: nick, phoneNum: phoneNum, birthDay: birthDay)
            let request = try Router.signUp(query: query).asURLRequest()
            
            AF.request(request).responseDecodable(of: SignUpModel.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        } catch {
            print("error \(error)")
        }
    }
    
    static func createLogin(email: String, password: String, completionHandler: @escaping (String, Bool) -> Void ) {
        do {
            let query = LoginQuery(email: email, password: password)
            let request = try Router.login(query: query).asURLRequest()
            
            AF.request(request).responseDecodable(of: LoginModel.self) { response in
                guard let statusCode = response.response?.statusCode else {
                    print("Failed to get statusCode !!")
                    return
                }
                switch statusCode {
                case 200:
                    switch response.result {
                    case .success(let success):
                        print(success)
                        completionHandler("", true)
                    case .failure(let failure):
                        print(failure)
                    }
                case 400:
                    completionHandler("필수값을 채워주세요", false)
                    print("400번 : 필수값을 채워주세요")
                case 401:
                    print("401번: 계정을 확인해주세요!")
                    completionHandler("계정을 확인해주세요", false)
                default:
                    print("상태코드 : \(statusCode)")
                }
            }
        } catch {
            print("error \(error)")
        }
    }
    
    
    func postRetrieval() {
        do {
            let request = try Router.postRetrieval.asURLRequest()
            
            AF.request(request).responseDecodable(of: PostData.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func createPost() {
        
        do {
          
            
        }
    }
}
