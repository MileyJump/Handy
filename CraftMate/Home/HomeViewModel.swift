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
    
    let screenTransitionTrigger = PublishSubject<Void>()
    
    struct Input {
//        let recentData: BehaviorSubject<Post>
        let floatingButtonTap: ControlEvent<Void>
//        let searchButtonTap: ControlEvent<Void>
        
    }
    
    struct Output {
//        let postsList: Observable<[Post]>
        let screenTransitionTrigger: Observable<Void>
    }
    
    func transForm(input: Input) -> Output {
        
        input.floatingButtonTap
            .subscribe(with: self, onNext: { owner, _ in
                owner.screenTransitionTrigger.onNext(())
            })
            .disposed(by: disposeBag)
        
        
        return Output(screenTransitionTrigger: screenTransitionTrigger.asObserver())
    }
    
}
