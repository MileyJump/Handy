//
//  NetworkManager.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation
import Alamofire
import UIKit

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
//                    print(success.message)
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
                        //                        print(success)
                        UserDefaultsManager.shared.token = success.access
                        UserDefaultsManager.shared.refreshToken = success.refresh
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
    
    static func fetchProfile() {
        
        do {
            let request = try Router.fetchProfile.asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: ProfileModel.self) { response in
                    
                    if response.response?.statusCode == 419 {
                        self.refreshToken()
                    } else {
                        switch response.result {
                        case .success(let success):
                            print("OK", success)
                            //                        self.profileView.emailLabel.text = success.email
                            //                        self.profileView.userNameLabel.text = success.nick
                        case .failure(let failure):
                            print("Fail", failure)
                        }
                    }
                }
        } catch {
            print(error, "URLRequestConvertible 에서 asURLRequest 로 요청 만드는거 실패!!")
        }
        
    }
    
    static func refreshToken() {
        
        do {
            let request = try Router.refresh.asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: RefreshModel.self) { response in
                    
                    if response.response?.statusCode == 418 {
                        //리프레시 토큰 만료
                    } else {
                        switch response.result {
                        case .success(let success):
//                            print("OK", success)
                            
                            UserDefaultsManager.shared.token = success.accessToken
                            
                            self.fetchProfile()
                            
                        case .failure(let failure):
                            print("Fail", failure)
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    
    
    static func fetchPost(productId: String, completionHandler: @escaping (FetchPostModel?, String?) -> Void)  {
        do {
            let request = try Router.fetchPost(query: FetchPostQuery(next: nil, limit: nil, product_id: productId)).asURLRequest()
            AF.request(request).responseDecodable(of: FetchPostModel.self) { response in
                guard let statusCode = response.response?.statusCode else {
                    print("Failed to get statusCode !!")
                    return
                }
                switch statusCode {
                case 200:
                    switch response.result {
                    case .success(let success):
                        completionHandler(success, nil)
                    case .failure(let failure):
                        print(failure)
                        print("실패!!")
                    }
                case 400:
                    completionHandler(nil, "필수값을 채워주세요")
                    print("400번 : 필수값을 채워주세요")
                case 401:
                    print("401번: 계정을 확인해주세요!")
                    completionHandler(nil, "계정을 확인해주세요")
                case 419:
                    print("??????")
                    self.refreshToken()
                    
                default:
                    print("fetchPost5")
                    print("상태코드 : \(statusCode)")
                }
            }
        } catch {
            print("error \(error)")
        }
    }
    
    static func createPost(title: String?, price: Int?, content: String?, content1: String?, content2: String?, content3: String?, content4: String?, content5: String?, product_id: String?, files: [String]?, completionHandler: @escaping (Post?, String?) -> Void)  {
        do {
            
            let query = CreatePostQuery(title: title, price: price, content: content, content1: content1, content2: content2, content3: content3, content4: content4, content5: content5, product_id: product_id, files: files)
            let request = try Router.createPost(query: query).asURLRequest()
            AF.request(request).responseDecodable(of: Post.self) { response in
                guard let statusCode = response.response?.statusCode else {
                    print("Failed to get statusCode !!")
                    return
                }
                switch statusCode {
                case 200:
                    switch response.result {
                    case .success(let success):
                        completionHandler(success, nil)
                    case .failure(let failure):
                        print(failure)
                        print("실패!!")
                    }
                case 401:
                    completionHandler(nil, "로그인이 만료 되었어요!")
                    print("401번 : 필수값을 채워주세요")
                case 410:
                    print("410번: DB서버 장애로 게시글이 저장되지 않았을 때")
                    completionHandler(nil, " 저장된 게시글이 없어요")
                case 419:
                    print("??????")
                    self.refreshToken()
                    
                default:
                    print("fetchPost5")
                    print("상태코드 : \(statusCode)")
                }
            }
        } catch {
            print("error \(error)")
        }
    }
    
    func uploadImage(images: [UIImage], completionHandler: @escaping ([String]?) -> Void){
        
        var temp = [Data]()
        for image in images {
            if let imageData = image.pngData() {
                print("Image data size: \(imageData.count) bytes")
                temp.append(imageData)
            } else {
                print("Failed to convert UIImage to Data")
            }
        }
        
        do {
            
            let request = try Router.imageUpload(query: ImageUploadQuery(files: temp)).asURLRequest()
            
            AF.upload(multipartFormData: { multipartFormData in
                for (index, imageData) in temp.enumerated() {
                    print(temp)
                    print("============")
                    let fileName = "image\(index + 1).png"
                    multipartFormData.append(imageData, withName: "files", fileName: fileName, mimeType: "image/png")
                }
            }, with: request).responseDecodable(of: ImageUploadModel.self) { response in
                guard let statusCode = response.response?.statusCode else {
                    print("Failed to get statusCode !!")
                    return
                }
                
                switch statusCode {
                case 200:
                    switch response.result {
                    case .success(let success):
                        print("성공!!")
                        let uploadedImageURLs = success.files
                        completionHandler(uploadedImageURLs)
                    case .failure(let failure):
                        print(failure)
                        print("실패!!")
                    }
                default:
                    print("상태코드 : \(statusCode)")
                }
            }
        } catch {
            print("error \(error)")
        }
    }

    
    //MARK: - 이미지 업로드🔥
//       func uploadPostImage(query: ImageUploadQuery, completion: @escaping (Result<[String], Error>) -> Void) {
//           let router = Router.imageUpload(query: ImageUploadQuery(files: query.files))
//           let urlRequest = router.asURLRequest
//           
//           AF.upload(multipartFormData: { multipartFormData in
//               multipartFormData.append(query.files, withName: "files", fileName: "postImage.jpeg", mimeType: "image/jpeg")
//           }, with: urlRequest)
//           .response { response in
//               if let data = response.data {
//                   let jsonString = String(data: data, encoding: .utf8)
//                   print("서버 응답 데이터: \(jsonString ?? "데이터 없음")")
//               }
//               
//               switch response.result {
//               case .success(let data):
//                   do {
//                       guard let data = data else {
//                           completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "데이터가 없습니다."])))
//                           return
//                       }
//                       
//                       let result = try JSONDecoder().decode(PostImageModel.self, from: data)
//                       print("🩵이미지 업로드 성공: \(result.files ?? [])")  // 성공 메시지 출력
//                       completion(.success(result.files ?? []))
//                   } catch {
//                       print("디코딩 실패: \(error)")
//                       completion(.failure(error))
//                   }
//               case .failure(let error):
//                   print("이미지 업로드 실패: \(error.localizedDescription)")
//                   completion(.failure(error))
//               }
//           }
//       }
  
    
    static func deletePost(postId: String) {
        do {
            let request = try Router.deletePost(query: postId).asURLRequest()
           print("게시글 삭제 완료")
        } catch {
            print("error \(error)")
        }
    }
}
