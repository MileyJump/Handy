//
//  DetailViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class DetailViewController: BaseViewController<DetailView> {
    
    var post: Post?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
   
    
    override func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        
        let ellipsis = UIBarButtonItem(image: UIImage(systemName: CraftMate.Phrase.ellipsisIcon), style: .plain, target: nil, action: nil)
      
        navigationItem.rightBarButtonItem = ellipsis
        
        ellipsis.rx.tap
            .bind(with: self) { owner, _ in
                owner.ellipsisTapped()
            }
            .disposed(by: disposeBag)
        
        navigationItem.backButtonTitle = ""
    }
    
    
    func ellipsisTapped() {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let edit = UIAlertAction(title: "게시글 수정", style: .default) { _ in
            self.editButtonTapped()
        }
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.deleteButtonTapped()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        

        alert.addAction(cancel)
        alert.addAction(edit)
        alert.addAction(delete)

        present(alert, animated: true)
    }
    
    func editButtonTapped() {
        print(#function)
    }
    
    func deleteButtonTapped() {
        print(#function)
        if let postId = post?.postId {
            NetworkManager.shared.deletePost(postId: postId)
            print("\(postId)삭제 완료")
        }
    }
    
    override func setupAddTarget() {
        rootView.reviewButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = ReviewViewController()
                vc.post = self.post
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
//        rootView.heartButton.rx.tap
//            .bind(with: self) { owner, _ in
//                
//            }
//            .disposed(by: disposeBag)
        
        rootView.followButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.followButtonTapped()
            }
            .disposed(by: disposeBag)
    }
    
    func followButtonTapped() {
        let currentTitle = rootView.followButton.title(for: .normal)
        
        if currentTitle == "팔로우" {
            rootView.followButton.setTitle("팔로잉", for: .normal)
            rootView.followButton.backgroundColor = CraftMate.color.LightGrayColor
            rootView.followButton.setTitleColor(CraftMate.color.blackColor, for: .normal)
            
        } else if currentTitle == "팔로잉" {
            rootView.followButton.setTitle("팔로우", for: .normal)
            rootView.followButton.backgroundColor = .clear
            rootView.followButton.setTitleColor(CraftMate.color.mainColor, for: .normal)
            
        }
    }
    
    
    override func setupUI() {
       
        guard let post = self.post else { return }
        
        let reviewCount = post.comments?.count ?? 0
        rootView.updateReviewButton(with: reviewCount)
        
        
        rootView.nickNameLabel.text = post.creator.nick
        rootView.titleLabel.text = post.title
        rootView.categoryLabel.text = post.productId
        rootView.contentLabel.text = post.content1
        rootView.hashTagLabel.text = post.content
        let price = Formatter.decimalNumberFormatter(number: post.price ?? 0)
        rootView.priceLabel.text = "\(price)원"
      
        if let data = post.files {
            data.forEach { link in
                NetworkManager.shared.readImage(urlString: link) { [weak self] data in
                    if let data {
                        DispatchQueue.main.async {
                            self?.rootView.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
}
