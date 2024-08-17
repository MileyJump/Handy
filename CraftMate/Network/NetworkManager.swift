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
