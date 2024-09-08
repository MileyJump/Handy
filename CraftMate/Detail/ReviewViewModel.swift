//
//  ReviewViewModel.swift
//  CraftMate
//
//  Created by 최민경 on 9/8/24.
//

import RxSwift
import RxCocoa

final class ReviewViewModel {
    
    struct Input {
        let sendButtonTap: Observable<Void>  // 버튼 탭 이벤트 처리
        let textFieldInput: Observable<String?>  // 텍스트필드 입력 처리
    }
    
    struct Output {
        let postDetails: Driver<Post?>  // 받아온 게시물 정보
        let comments: Driver<[Comment]>  // 댓글 정보
        let sendButtonEnabled: Driver<Bool>  // 버튼 활성화 여부
    }
    
    private let postSubject = BehaviorSubject<Post?>(value: nil)  // 게시물 정보 저장
    private let disposeBag = DisposeBag()
    
    // transform 함수는 Input을 받아 Output을 생성하는 핵심 로직
    func transform(input: Input) -> Output {
        let postDetails = postSubject
            .asDriver(onErrorJustReturn: nil)
        
        let comments = postSubject
            .compactMap { $0?.comments }
            .asDriver(onErrorJustReturn: [])
        
        let sendButtonEnabled = input.textFieldInput
            .map { text in
                return !(text?.isEmpty ?? true)  // 텍스트가 비어있지 않을 때만 버튼 활성화
            }
            .asDriver(onErrorJustReturn: false)
        
        input.sendButtonTap
            .withLatestFrom(input.textFieldInput)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] comment in
                self?.sendComment(comment)
            })
            .disposed(by: disposeBag)
        
        return Output(
            postDetails: postDetails,
            comments: comments,
            sendButtonEnabled: sendButtonEnabled
        )
    }
    
    func loadPostDetails(postId: String) {
        NetworkManager.shared.fetchPostDetails(postId: postId) { [weak self] post in
            self?.postSubject.onNext(post)
        }
    }
    
    private func sendComment(_ comment: String) {
        if let post = try? postSubject.value() {
            NetworkManager.shared.writeComments(comments: comment, postid: post.postId)
            loadPostDetails(postId: post.postId)  // 댓글을 보낸 후 다시 게시물 정보 업데이트
        }
    }
}
