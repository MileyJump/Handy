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
    
    let disposeBag = DisposeBag()
    
    var items = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    var sortImages = ["홈", "공예", "리폼", "아이들", "주방", "박스"]
    private var id = "홈데코"
    
    private let postListSubject = BehaviorSubject<[Post]>(value: [])
    private let nextCursorRelay = BehaviorRelay<String?>(value: nil)
    private let fetchPostErrorSubject = PublishSubject<Error>()
    private let isFetchingRelay = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        let floatingButtonTap: ControlEvent<Void>
        let searchButtonTap: ControlEvent<Void>
        let orderItemSelected: ControlEvent<IndexPath>
        let categoryItemSelected: ControlEvent<IndexPath>
        let prefetchRows: Observable<[IndexPath]>
        let categoryChanged: Observable<String>
    }
    
    struct Output {
        let floatingScreenTrigger: Observable<Void>
        let searchScreenTrigger: Observable<Void>
        let selectedPost: Observable<Post>
        let selectedCategory: Observable<String>
        let posts: Observable<[Post]>
        let fetchPostsError: Observable<Error>
    }
    
    func fetchInitialPosts() {
            // 초기 데이터 로드 시 카테고리 ID를 사용하여 데이터 요청
            fetchPostsIfNeeded()
                .subscribe()
                .disposed(by: disposeBag)
        }
    
    func transform(input: Input) -> Output {
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
        
        // 카테고리 변경 시 데이터 초기화 및 새로운 데이터 fetch
        input.categoryChanged
            .do(onNext: { [weak self] newCategory in
                self?.id = newCategory
                self?.postListSubject.onNext([])
                self?.nextCursorRelay.accept(nil)
            })
            .flatMapLatest { [weak self] _ -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.fetchPostsIfNeeded()
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        // Prefetch 로직
        input.prefetchRows
            .withLatestFrom(postListSubject) { (indexPaths, posts) -> Bool in
                guard let lastIndexPath = indexPaths.last else { return false }
                return lastIndexPath.item == posts.count - 1
            }
            .filter { $0 }
            .withLatestFrom(isFetchingRelay)
            .filter { !$0 }
            .flatMapLatest { [weak self] _ -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.fetchPostsIfNeeded()
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        return Output(
            floatingScreenTrigger: floatingScreenTrigger,
            searchScreenTrigger: searchScreenTrigger,
            selectedPost: selectedPost,
            selectedCategory: selectedCategory,
            posts: postListSubject.asObservable(),
            fetchPostsError: fetchPostErrorSubject.asObservable()
        )
    }
    
    private func fetchPostsIfNeeded() -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            self.isFetchingRelay.accept(true)
            
            let query = FetchPostQuery(next: self.nextCursorRelay.value, limit: "20", product_id: self.id)
            NetworkManager.shared.fetchPost(query: query) { [weak self] result, newCursor in
                guard let self = self else { return }
                
                if let result = result {
                    var currentPosts = (try? self.postListSubject.value()) ?? []
                    currentPosts.append(contentsOf: result.data)
                    print("Fetched posts: \(currentPosts)") // 여기에 로그 추가
                    self.postListSubject.onNext(currentPosts)
                    self.nextCursorRelay.accept(newCursor)
                } else {
                    let error = NSError(domain: "FetchPostError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch posts"])
                    self.fetchPostErrorSubject.onNext(error)
                }
                
                self.isFetchingRelay.accept(false)
                observer.onNext(())
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
