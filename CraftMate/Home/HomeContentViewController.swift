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
    
    // 나중에 Rx로 수정
    var items = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    var sortImages = ["홈", "공예", "리폼", "아이들", "주방", "박스"]
    
    var sort = "홈데코"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        fetchPost(id: sort, cursor: nil)
        configureViewCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func configureView() {
        view.backgroundColor = .white
        
        rootView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        rootView.orderCollectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
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
 
        navigationItem.rightBarButtonItems = [search]
        
        navigationItem.title = CraftMate.Phrase.serviceName

        let customFont = UIFont(name: "UhBee Se_hyun Bold", size: 27) ?? UIFont.systemFont(ofSize: 24)
        self.navigationController?.navigationBar.titleTextAttributes = [
              NSAttributedString.Key.font: customFont,
              NSAttributedString.Key.foregroundColor: CraftMate.color.mainColor
          ]
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    
    func bind() {
        
        let searchTap = navigationItem.rightBarButtonItems?.first?.rx.tap ?? ControlEvent(events: Observable.empty())
        
        let input = HomeViewModel.Input(floatingButtonTap: rootView.floatingButton.floatingButton.rx.tap, searchButtonTap: searchTap, orderItemSelected: rootView.orderCollectionView.rx.itemSelected, categoryItemSelected: rootView.collectionView.rx.itemSelected)
        let output = viewModel.transForm(input: input)
        
        output.floatingScreenTrigger
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, _ in
                print("플로팅 버튼 클릭")
                let vc = WritePostViewController()
                let naviVc = UINavigationController(rootViewController: vc)
                naviVc.modalPresentationStyle = .fullScreen
                owner.present(naviVc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.searchScreenTrigger
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, _ in
                print("검색 버튼 탭드")
                let vc = SearchPageViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.selectedPost
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, post in
                let vc = DetailViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.selectedCategory
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, category in
                owner.sort = category
                owner.fetchPost(id: category, cursor: owner.nextCursor)
            }
            .disposed(by: disposeBag)
    }
    
//    func fetchPost(id: String, cursor: String?) {
//        guard !isFetching else {
//            // 중복 요청 방지
//            return
//        }
//        
//        // 처음에 cursor가 nil인 경우는 호출을 허용
//        if cursor != nil {
//            // 동일한 nextCursor로 인해 과호출이 발생하지 않도록 방지
//            guard cursor != self.nextCursor else {
//                print("동일한 커서로 호출 되지 않습니다!")
//                return
//            }
//        }
//        
//        isFetching = true
//        
//        let query = FetchPostQuery(next: cursor, limit: "20", product_id: id)
//        NetworkManager.shared.fetchPost(query: query) { [weak self] result, newCursor in
//            guard let self = self else { return }
//            self.isFetching = false
//            
//            if let result = result {
//                // 중복된 postId가 있는지 확인
//                let newPosts = result.data.filter { newPost in
//                    !self.postList.contains(where: { $0.postId == newPost.postId })
//                }
//                
//                // 새로운 게시물을 기존 리스트에 추가
//                self.postList.append(contentsOf: newPosts)
//                
//                // 만약 newCursor가 nil이거나 이전과 동일하다면 추가 요청을 중지
//                if newCursor == nil || newCursor == self.nextCursor {
//                    print("Reached end of data or cursor has not changed.")
//                    return
//                }
//                
//                // nextCursor 업데이트
//                self.nextCursor = newCursor
//                print("------------------------\(String(describing: newCursor))------------------------")
//                print(self.postList)
//                
//                // UI 업데이트
//                self.rootView.orderCollectionView.reloadData()
//            } else {
//                print("오류")
//            }
//        }
//    }
    
    func fetchPost(id: String, cursor: String?) {
        guard !isFetching else {
            // 중복 요청 방지
            return
        }
        
        // 처음에 cursor가 nil인 경우는 호출을 허용
        if cursor != nil {
            // 동일한 nextCursor로 인해 과호출이 발생하지 않도록 방지
            guard cursor != self.nextCursor else {
                print("동일한 커서로 호출 되지 않습니다!")
                return
            }
        }
        
        isFetching = true
        
        let query = FetchPostQuery(next: cursor, limit: "20", product_id: id)
        NetworkManager.shared.fetchPost(query: query) { [weak self] result, newCursor in
            guard let self = self else { return }
            self.isFetching = false
            
            if let result = result {
                // 중복된 postId가 있는지 확인
                let newPosts = result.data.filter { newPost in
                    !self.postList.contains(where: { $0.postId == newPost.postId })
                }
                
                // 새로운 게시물을 기존 리스트에 추가
                self.postList.append(contentsOf: newPosts)
                
                // **여기서 postListSubject에 값을 emit**
                var currentPosts = try? self.viewModel.postListSubject.value()
                currentPosts?.append(contentsOf: newPosts)
                self.viewModel.postListSubject.onNext(currentPosts ?? [])
                
                // 만약 newCursor가 nil이거나 이전과 동일하다면 추가 요청을 중지
                if newCursor == nil || newCursor == self.nextCursor {
                    print("Reached end of data or cursor has not changed.")
                    return
                }
                
                // nextCursor 업데이트
                self.nextCursor = newCursor
                print("------------------------\(String(describing: newCursor))------------------------")
                print(self.postList)
                
                // UI 업데이트
                self.rootView.orderCollectionView.reloadData()
            } else {
                print("오류")
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
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        let post = postList[sender.tag]
        guard let likes = post.likes else { return }
        let status = !likes.contains(post.creator.userId)
        print(status)
        NetworkManager.shared.likePost(status: status, postID: post.postId) { [weak self] success in
            self?.fetchPost(id: self?.sort ?? "홈데코", cursor: self?.nextCursor)
            
        }
    }
    
    func configureViewCell() {

        // 카테고리 CollectionView 바인딩
        Observable.just(viewModel.items)
            .bind(to: rootView.collectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier, cellType: HomeCollectionViewCell.self)) { row, element, cell in
                cell.configureCell(title: element, image: self.viewModel.sortImages[row])
            }
            .disposed(by: disposeBag)

        
        // 포스트 CollectionView 바인딩
        viewModel.postListSubject
            .observe(on: MainScheduler.instance) // UI 업데이트는 메인 스레드에서
            .bind(to: rootView.orderCollectionView.rx.items(cellIdentifier: OrderCollectionViewCell.identifier, cellType: OrderCollectionViewCell.self)) { row, post, cell in
                
                cell.configureCell(data: post)
                
                let status = post.likes?.contains(post.creator.userId) ?? false
                let heartImageName = status ? CraftMate.Phrase.heartFillImage : CraftMate.Phrase.heartImage
                cell.heartButton.setImage(UIImage(systemName: heartImageName), for: .normal)
                cell.heartButton.tintColor = status ? CraftMate.color.pinkColor : CraftMate.color.whiteColor
                
                cell.heartButton.tag = row
                cell.heartButton.addTarget(self, action: #selector(self.heartButtonTapped), for: .touchUpInside)
            }
            .disposed(by: disposeBag)
    }
}



extension HomeContentViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let maxIndex = indexPaths.map({ $0.row }).max() else { return }
        
        // 현재 postList의 마지막 항목에 근접한 경우 추가 데이터를 로드
        if maxIndex >= postList.count - 2 {
            fetchPost(id: sort, cursor: nextCursor)
            print("되고 있어요?")
        }
    }
}


