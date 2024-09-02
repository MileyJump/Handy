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
import iamport_ios
import WebKit

final class DetailViewController: BaseViewController<DetailView> {

    var post: Post?

    let userCode = "imp57573124"
    
    var delegate: SortedSeletedProtocol?

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        if let productId = post?.productId {
            delegate?.sortsletedString(productId)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func setupNavigationBar() {

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.clear
        appearance.shadowColor = .clear
        appearance.backgroundEffect = nil
        appearance.backgroundImage = UIImage()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = CraftMate.color.mainColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

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
        navigationController?.popViewController(animated: true)
    }

    override func setupAddTarget() {
        rootView.reviewButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = ReviewViewController()
                vc.post = self.post
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)

        rootView.followButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.followButtonTapped()
            }
            .disposed(by: disposeBag)

        rootView.payButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.payButtonTapped()
            }
            .disposed(by: disposeBag)
    }

    func payButtonTapped() {

        guard let post = post, let price = post.price, let title = post.title else {
            print("post, price, or title is nil")
            return
        }

        let payment = IamportPayment(
            pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
            merchant_uid: "ios_\(Key.key)_\(Int(Date().timeIntervalSince1970))",
            amount: "\(price)").then {
                $0.pay_method = PayMethod.card.rawValue
                $0.name = title
                $0.buyer_name = "최민경"
                $0.app_scheme = "miley"
            }

        // WKWebView를 초기화하고, 현재 뷰 계층에 추가합니다.
        let wkWebView = WKWebView(frame: view.bounds)
        wkWebView.backgroundColor = UIColor.clear
        view.addSubview(wkWebView)

        Iamport.shared.paymentWebView(
            webViewMode: wkWebView,
            userCode: userCode,
            payment: payment) { iamportResponse in
                guard let imp = iamportResponse?.imp_uid else { return  }
                NetworkManager.shared.paymentsValidation(impUId: imp, postId: post.postId)
                
                
            }
        
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
        
        let price = Formatter.decimalNumberFormatter(number: post.price ?? 0)
        rootView.priceLabel.text = "\(price)원"
        
        if let hashTags = post.hashTags {
            //        let hashTag = post.hashTags?.joined(separator: " ")
            let hashTag = hashTags.map { "#\($0)" }.joined(separator: " ")
            rootView.hashTagLabel.text = "#\(String(describing: hashTag))"
        }

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
