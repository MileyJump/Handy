//
//  HomeContentViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeContentViewController: BaseViewController<HomeView> {
    
    private var isNavigationBarHidden = false
    
    let disposeBag = DisposeBag()
    
    let viewModel = HomeViewModel()
    
    var postList: [Post] = []
    
    var dataImage: [Data] = [ ]
    
    private var isHearted: Bool = false // 하트 상태를 추적하는 변수
    
    // 나중에 Rx로 수정
    var items = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    var sortImages = ["홈", "공예", "리폼", "아이들", "주방", "박스"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
        rootView.orderCollectionView.delegate = self
        rootView.orderCollectionView.dataSource = self
        
        rootView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        rootView.orderCollectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
        
        
        // 네트워크 요청 실행
        //        viewModel.fetchPosts()
        bind()
        bindTableView(id: items[0])
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        bindTableView(id: items[0])
//    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
            bindTableView(id: items[0])
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }

       
        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
            let translation = scrollView.panGestureRecognizer.translation(in: scrollView)
            if translation.y < 0 {
                hideNavigationBar()
            } else {
                showNavigationBar()
            }
        }

        private func hideNavigationBar() {
            if !isNavigationBarHidden {
                isNavigationBarHidden = true
                navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }

        private func showNavigationBar() {
            if isNavigationBarHidden {
                isNavigationBarHidden = false
                navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    
    override func setupNavigationBar() {
        
        
        let search = UIBarButtonItem(image: UIImage(systemName: CraftMate.Phrase.searchImage), style: .plain, target: nil, action: nil)
        //let shoppingBag = UIBarButtonItem(image: UIImage(named: "쇼핑백"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [search]
        
        navigationItem.title = "CraftMate"
        if let font = CraftMate.CustomFont.SemiBold20 {
            navigationController?.navigationBar.configureNavigationBarTitle(font: font, textColor: CraftMate.color.mainColor)
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        
        search.rx.tap
            .bind(with: self) { owner, _ in
                let vc = SearchPageViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        } else {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }
    
    
    func bind() {
        rootView.floatingButton.floatingButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                let vc = WritePostViewController()
                let naviVc = UINavigationController(rootViewController: vc)
                naviVc.modalPresentationStyle = .fullScreen
                owner.present(naviVc, animated: true)
                
            }
            .disposed(by: disposeBag)
    }
    
    func bindTableView(id: String) {
        
        NetworkManager.shared.fetchPost(productId: id) { post, error in
            guard let post else { return }
            let postData = post.data
            
            self.postList = postData
            print(postData)
            
            self.rootView.orderCollectionView.reloadData()
        }
    }
    
    @objc func ellipsisButtonTapped(sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 신고하기 버튼을 추가합니다.
        let reportAction = UIAlertAction(title: "신고하기", style: .default) { _ in
            print("reportAction")
        }
        
        // 닫기 버튼을 추가합니다.
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel)
        
        // 액션 시트에 버튼들을 추가합니다.
        alert.addAction(reportAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    @objc func profileImageViewTapped() {
        print(#function)
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        
        isHearted.toggle() // 하트 상태 토글
        let postid =  postList[sender.tag].postId
        print(sender.tag)
        print("\(postid): postid)")
        print(isHearted)
        NetworkManager.shared.likePost(status: isHearted, postID: postid)
 
        rootView.orderCollectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
        print("하트버튼 탭드")
    }
    
}


extension HomeContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == rootView.collectionView {
            return items.count
        } else if collectionView == rootView.orderCollectionView {
            return postList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rootView.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(title: items[indexPath.row], image: sortImages[indexPath.row])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as? OrderCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(data: postList[indexPath.item])
            cell.ellipsisButton.tag = indexPath.item
            cell.ellipsisButton.addTarget(self, action: #selector(ellipsisButtonTapped), for: .touchUpInside)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
            cell.profileImageView.addGestureRecognizer(tapGesture)
            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
            if isHearted {
                cell.heartButton.setImage(UIImage(systemName: CraftMate.Phrase.heartFillImage), for: .normal)
            } else {
                cell.heartButton.setImage(UIImage(systemName: CraftMate.Phrase.heartImage), for: .normal)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == rootView.orderCollectionView {
            let result = postList[indexPath.item]
            let vc = DetailViewController()
            vc.post = result
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let sort = items[indexPath.item]
            print(sort)
            bindTableView(id: sort)
        }
    }
    
    
    
    
}


