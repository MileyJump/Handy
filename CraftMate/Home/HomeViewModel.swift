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
    
    var postsList: [Post] = []
    let disposeBag = DisposeBag()
    
    struct Input {
        let recentData: BehaviorSubject<Post>
    }
    
    struct Output {
        let postsList: Observable<[Post]>
    }
    
//    func transform(input: Input) -> Output {
//        let postsLists = BehaviorSubject(value: postsList)
////        
////        NetworkManager.fetchPost { value, error in
////            if let posts = value {
////                self.postsList.append(posts)
////            }
//        }
//        
//        
//        input.recentData
//            .subscribe(with: self) { owner, value in
//                owner.postsList.append(value)
//                postsLists.onNext(owner.postsList)
//            }
//            .disposed(by: disposeBag)
//        
//     return Output(postsList: postsLists)
//    }
    
//    func fetchPosts() {
//        NetworkManager.fetchPost { post, errorMessage in
//            if let posts = post {
//                self.posts.append(posts)
//                
//            }
//        }
//    }
}
