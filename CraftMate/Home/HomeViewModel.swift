//
//  HomeViewModel.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import Foundation
import RxSwift
import RxCocoa


final class HomeViewModel {
    
    let posts = BehaviorRelay<[Post]>(value: [])
    let disposeBag = DisposeBag()
    
    func fetchPosts() {
        NetworkManager.fetchPost { [weak self] post, errorMessage in
            if let post = post {
                self?.posts.accept([post])  // 하나의 Post를 배열로 만들어 전달
            } else if let errorMessage = errorMessage {
                print("Error: \(errorMessage)")
            }
        }
    }
}
