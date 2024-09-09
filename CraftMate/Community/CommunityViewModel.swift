//
//  CommunityViewModel.swift
//  CraftMate
//
//  Created by 최민경 on 9/1/24.
//


import Foundation
import RxSwift
import RxCocoa
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
    private let deletePostSubject = PublishSubject<String>()

    // Output
    let posts: Observable<[Post]>
    let error: Observable<String>

    init() {
        let fetchPostsObservable = fetchPostsSubject
            .flatMapLatest { cursor in
                Observable.create { observer in
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

        self.posts = fetchPostsObservable
            .map { $0.0 } // Post data
            .asObservable()

        self.error = fetchPostsObservable
            .map { $0.1 } // Error messages
            .filter { !$0.isEmpty }
            .map { $0 }
            .asObservable()

        deletePostSubject
            .subscribe(onNext: { postId in
                NetworkManager.shared.deletePost(postId: postId)
            })
            .disposed(by: disposeBag)
    }

    func transform(input: CommunityInput) -> CommunityOutput {
        input.viewWillAppear
            .map { _ in nil }
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
        // Implementation for presenting the CommunityCreateViewController
    }

    private func showOptions(for index: Int) {
        // Implementation for showing options (edit/delete) for a post at the given index
    }

    private func showCommentsViewController() {
        // Implementation for showing the CommentsViewController
    }
}
