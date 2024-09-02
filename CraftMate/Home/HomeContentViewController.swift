//
//  HomeContentViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol SortedSeletedProtocol  {
    func sortsletedString(_ sort: String)
}

final class HomeContentViewController: BaseViewController<HomeView>, SortedSeletedProtocol {
    
    private var nextCursor: String? // 다음 페이지를 위한 커서
    private var isFetching: Bool = false // 중복 요청 방지
    
    private var isNavigationBarHidden = false
    
    let disposeBag = DisposeBag()
    
    let viewModel = HomeViewModel()
    
    var postList: [Post] = []
    
    var dataImage: [Data] = [ ]
    
    private var isHearted: Bool = false // 하트 상태를 추적하는 변수
    
    // 나중에 Rx로 수정
    var items = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    var sortImages = ["홈", "공예", "리폼", "아이들", "주방", "박스"]
    
    var sort = "홈데코"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
        rootView.orderCollectionView.delegate = self
        rootView.orderCollectionView.dataSource = self
        rootView.orderCollectionView.prefetchDataSource = self
        
        rootView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        rootView.orderCollectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
        
        
        // 네트워크 요청 실행
        //        viewModel.fetchPosts()
        bind()
        fetchPost(id: sort, cursor: nil)
        //        fetchPost(id: sort)
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        bindTableView(id: items[0])
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
//        fetchPost(id: sort, cursor: nil)
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func sortsletedString(_ sort: String) {
        self.sort = sort
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView)
        if translation.y < 0 {
            hideNavigationBar()
        } else {
            showNavigationBar()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let offsetY = scrollView.contentOffset.y
           let contentHeight = scrollView.contentSize.height
           let height = scrollView.frame.size.height
           
           if offsetY > contentHeight - height * 2 {
               fetchPost(id: sort, cursor: nextCursor)
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
    
//    func fetchPost(id: String, cursor: String?) {
//        guard !isFetching else { return } // 중복 요청 방지
//        isFetching = true
//        
//        let query = FetchPostQuery(next: cursor, limit: "20", product_id: id)
//        NetworkManager.shared.fetchPost(query: query) { [weak self] result, error in
//            guard let self = self else { return }
//            self.isFetching = false
//            
//            if let result = result {
//                self.postList.append(contentsOf: result.data)
//                self.nextCursor = result.nextCursor // 다음 페이지를 위한 커서 업데이트
//                self.rootView.orderCollectionView.reloadData()
//            } else {
//                print("Error: \(String(describing: error))")
//            }
//        }
//    }
    
    func fetchPost(id: String, cursor: String?) {
        guard !isFetching else { return } // 중복 요청 방지
        isFetching = true
        
        let query = FetchPostQuery(next: cursor, limit: "20", product_id: id)
        NetworkManager.shared.fetchPost(query: query) { [weak self] result, error in
            guard let self = self else { return }
            self.isFetching = false
            
            if let result = result {
                // 중복된 postId가 있는지 확인
                let newPosts = result.data.filter { newPost in
                    !self.postList.contains(where: { $0.postId == newPost.postId })
                }
                self.postList.append(contentsOf: newPosts)
                self.nextCursor = result.nextCursor // 다음 페이지를 위한 커서 업데이트
                self.rootView.orderCollectionView.reloadData()
            } else {
                print("Error: \(String(describing: error))")
            }
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
//    
//    @objc func heartButtonTapped(_ sender: UIButton) {
//        
//        isHearted.toggle() // 하트 상태 토글
//        let postid =  postList[sender.tag].postId
//        print(sender.tag)
//        print("\(postid): postid)")
//        print(isHearted)
//        NetworkManager.shared.likePost(status: isHearted, postID: postid)
//        
//        fetchPost(id: self.sort)
//        
//        rootView.orderCollectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
//        print("하트버튼 탭드")
//    }
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        let post = postList[sender.tag]
        guard let likes = post.likes else { return }
        let status = !likes.contains(post.creator.userId)
        print(status)
        NetworkManager.shared.likePost(status: status, postID: post.postId) { [weak self] success in
            self?.fetchPost(id: self?.sort ?? "홈데코", cursor: self?.nextCursor)
            
        }

        
//        let post = postList[sender.tag]
//        let currentUserId = post.creator.userId
//        let isHearted = post.isLiked(byUser: currentUserId)
//
//        NetworkManager.shared.likePost(status: !isHearted, postID: post.postId) { [weak self] success in
//            guard let self = self else { return }
//            if success {
//                if let index = self.postList.firstIndex(where: { $0.postId == post.postId }) {
//                    if isHearted {
//                        // 좋아요 취소된 상태로 업데이트
//                        self.postList[index].likes?.removeAll(where: { $0 == currentUserId })
//                    } else {
//                        // 좋아요 추가된 상태로 업데이트
//                        self.postList[index].likes?.append(currentUserId)
//                    }
//                    self.rootView.orderCollectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
//                }
//            }
////            print(success)
////            print("======\(success)")
//        }
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

            let post = postList[indexPath.item]
            cell.configureCell(data: post)
            
            let status = post.likes?.contains(post.creator.userId) ?? false

//            let isHearted = post.isLiked(byUser: currentUser.id)
            let heartImageName = status ? CraftMate.Phrase.heartFillImage : CraftMate.Phrase.heartImage
            cell.heartButton.setImage(UIImage(systemName: heartImageName), for: .normal)

            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
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
            self.sort = items[indexPath.item]
            fetchPost(id: sort, cursor: nextCursor)
        }
    }
    
    
    
    
}

extension HomeContentViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let maxIndex = indexPaths.map({ $0.row }).max() else { return }
           
           // 현재 postList의 마지막 항목에 근접한 경우 추가 데이터를 로드
           if maxIndex >= postList.count - 1 {
               fetchPost(id: sort, cursor: nextCursor)
           }
    }
    
    
}


