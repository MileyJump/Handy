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
    
//    var postsList: [Post] = []
    let disposeBag = DisposeBag()
    
//    let screenTransitionTrigger = PublishSubject<Void>()
    var items = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    var sortImages = ["홈", "공예", "리폼", "아이들", "주방", "박스"]
    
    let postListSubject = BehaviorSubject<[Post]>(value: [])
    
    struct Input {
//        let recentData: BehaviorSubject<Post>
        let floatingButtonTap: ControlEvent<Void>
        let searchButtonTap: ControlEvent<Void>
        let orderItemSelected: ControlEvent<IndexPath>
        let categoryItemSelected: ControlEvent<IndexPath>
//        let searchButtonTap: ControlEvent<Void>
        
    }
    
    struct Output {
//        let postsList: Observable<[Post]>
        let floatingScreenTrigger: Observable<Void>
        let searchScreenTrigger: Observable<Void>
        let selectedPost: Observable<Post>
        let selectedCategory: Observable<String>
    }
    
    
    func transForm(input: Input) -> Output {
        
        let searchScreenTrigger = input.searchButtonTap.asObservable()
        let floatingScreenTrigger = input.floatingButtonTap.asObservable()
        
        let selectedPost = input.orderItemSelected
            .withLatestFrom(postListSubject) { (indexPath, posts) in
                posts[indexPath.item]
            }
            .asObservable()
        
        let selectedCategory = input.categoryItemSelected
            .map { [unowned self] indexPath in
                self.items[indexPath.item]
            }
            .asObservable()
        
        
//        input.floatingButtonTap
//            .subscribe(with: self, onNext: { owner, _ in
//                owner.screenTransitionTrigger.onNext(())
//            })
//            .disposed(by: disposeBag)
        
        
        return Output(floatingScreenTrigger: floatingScreenTrigger, searchScreenTrigger: searchScreenTrigger, selectedPost: selectedPost, selectedCategory: selectedCategory)
    }
    
}
