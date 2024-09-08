//
//  ReviewViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ReviewViewController: BaseViewController<ReviewView> {
    
    var postSubject = BehaviorSubject<Post?>(value: nil)  // Post 데이터를 전달받을 Subject 추가
    
    private let viewModel = ReviewViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        postSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] post in
                self?.viewModel.loadPostDetails(postId: post?.postId ?? "")
            })
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        rootView.textField.delegate = self
        
        rootView.tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
    }
    
    func bindViewModel() {
        let input = ReviewViewModel.Input(
            sendButtonTap: rootView.sendButton.rx.tap.asObservable(),
            textFieldInput: rootView.textField.rx.text.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.postDetails
            .drive(onNext: { [weak self] post in
                self?.rootView.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.comments
            .drive(rootView.tableView.rx.items(cellIdentifier: ReviewTableViewCell.identifier, cellType: ReviewTableViewCell.self)) { row, comment, cell in
                cell.configureCell(comment)
            }
            .disposed(by: disposeBag)
        
        output.sendButtonEnabled
            .drive(rootView.sendButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

extension ReviewViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, let post = try? postSubject.value() {
            NetworkManager.shared.writeComments(comments: text, postid: post.postId)
//            self.fetchPostDetails()
            viewModel.loadPostDetails(postId: post.postId)
            print("=========")
            self.rootView.tableView.reloadData()
            
            textField.text = ""  // 전송 후 텍스트 필드 초기화
            
            NotificationCenter.default.post(name: .postDetailsChanged, object: nil, userInfo: ["postId": post.postId])
        }
        return true
    }
}
