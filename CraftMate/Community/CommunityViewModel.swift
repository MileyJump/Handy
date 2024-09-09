//
//  CommunityViewModel.swift
//  CraftMate
//
//  Created by 최민경 on 9/1/24.
//


import Foundation
import RxSwift
import RxCocoa

final class CommunityViewModel {

    struct CommunityInput {
        let viewWillAppear: Observable<Void>
        let floatingButtonTapped: Observable<Void>
        let ellipsisButtonTapped: Observable<Int>
        let commentsViewButtonTapped: Observable<Void>
    }

    struct CommunityOutput {
        let posts: Observable<[Post]>
        let error: Observable<String>
    }

    private let disposeBag = DisposeBag()

    // Input
    private let fetchPostsSubject = PublishSubject<String?>()

    // Output
    let posts: Observable<[Post]>
    let error: Observable<String>

    init() {
        // fetchPostObservable: API 호출을 관리하는 Observable
        let fetchPostsObservable = fetchPostsSubject
            .flatMapLatest { cursor in
                return Observable.create { observer in
                    NetworkManager.shared.fetchPost(query: FetchPostQuery(next: cursor, limit: "20", product_id: "커뮤니티")) { result, error in
                        if let posts = result?.data {
                            observer.onNext((posts, ""))
                        } else if let error = error {
                            observer.onNext(([], error))
                        }
                        observer.onCompleted()
                    }
                    return Disposables.create()
                }
            }
            .share(replay: 1, scope: .whileConnected)

        // posts: Post 배열을 방출
        self.posts = fetchPostsObservable
            .map { $0.0 } // 첫 번째 튜플 요소 (Post 배열)
            .asObservable()

        // error: 에러 메시지를 방출
        self.error = fetchPostsObservable
            .map { $0.1 } // 두 번째 튜플 요소 (에러 메시지)
            .filter { !$0.isEmpty }
            .asObservable()
    }
    
    func transform(input: CommunityInput) -> CommunityOutput {
        // viewWillAppear 이벤트에 반응하여 fetchPostsSubject에 트리거
        input.viewWillAppear
            .map { _ in nil } // 초기 fetch에 nil을 전달
            .bind(to: fetchPostsSubject)
            .disposed(by: disposeBag)

        input.floatingButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.presentCommunityCreateViewController()
            })
            .disposed(by: disposeBag)

        input.ellipsisButtonTapped
            .subscribe(onNext: { [weak self] index in
                self?.showOptions(for: index)
            })
            .disposed(by: disposeBag)

        input.commentsViewButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.showCommentsViewController()
            })
            .disposed(by: disposeBag)

        return CommunityOutput(posts: self.posts, error: self.error)
    }

    private func presentCommunityCreateViewController() {
        // 커뮤니티 생성 화면 표시 로직
    }

    private func showOptions(for index: Int) {
        // 선택 옵션 표시 로직 (수정/삭제 등)
    }

    private func showCommentsViewController() {
        // 댓글 화면 표시 로직
    }
    
    func onCommentsViewButtonTapped() {
        // 댓글 보기 로직 처리
        print("댓글 보기 버튼 클릭됨")
    }
    
    func onEllipsisButtonTapped(row: Int) {
        // 엘립시스 버튼 클릭 처리 로직
        print("옵션 버튼 클릭됨")
    }

}
