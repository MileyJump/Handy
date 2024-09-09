//
//  CommunityViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit
import RxSwift
import RxCocoa

final class CommunityViewController: BaseViewController<CommunityView> {

    private let viewModel = CommunityViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func setupUI() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        
        rootView.tableView.allowsSelection = false
        
        rootView.floatingButton.floatingButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.transform(input: .init(
                    viewWillAppear: Observable.just(()),
                    floatingButtonTapped: owner.rootView.floatingButton.floatingButton.rx.tap.asObservable(),
                    ellipsisButtonTapped: Observable.empty(),
                    commentsViewButtonTapped: Observable.empty()
                ))
            }
            .disposed(by: disposeBag)
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "커뮤니티"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: CraftMate.color.blackColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
    }
    
    private func bindViewModel() {
        let input = CommunityInput(
            viewWillAppear: Observable.just(()),
            floatingButtonTapped: rootView.floatingButton.floatingButton.rx.tap.asObservable(),
            ellipsisButtonTapped: Observable.empty(), // Initialize with empty, will be updated in cellForRowAt
            commentsViewButtonTapped: Observable.empty() // Initialize with empty, will be updated in cellForRowAt
        )
        
        let output = viewModel.transform(input: input)
        
        output.posts
            .bind(to: rootView.tableView.rx.items(cellIdentifier: CommunityTableViewCell.identifier, cellType: CommunityTableViewCell.self)) { row, post, cell in
                cell.configureCell(with: post)
                cell.commentsViewButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.viewModel.transform(input: .init(
                            viewWillAppear: Observable.empty(),
                            floatingButtonTapped: Observable.empty(),
                            ellipsisButtonTapped: Observable.empty(),
                            commentsViewButtonTapped: Observable.just(())
                        ))
                    }
                    .disposed(by: owner.disposeBag)
                
                cell.ellipsisButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.viewModel.transform(input: .init(
                            viewWillAppear: Observable.empty(),
                            floatingButtonTapped: Observable.empty(),
                            ellipsisButtonTapped: Observable.just(row),
                            commentsViewButtonTapped: Observable.empty()
                        ))
                    }
                    .disposed(by: owner.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        output.error
            .subscribe(onNext: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.identifier, for: indexPath) as? CommunityTableViewCell else {
            return UITableViewCell()
        }
        
        let post = viewModel.posts[indexPath.row]
        cell.configureCell(with: post)
        
        cell.commentsViewButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.transform(input: .init(
                    viewWillAppear: Observable.empty(),
                    floatingButtonTapped: Observable.empty(),
                    ellipsisButtonTapped: Observable.empty(),
                    commentsViewButtonTapped: Observable.just(())
                ))
            }
            .disposed(by: disposeBag)
        
        cell.ellipsisButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.transform(input: .init(
                    viewWillAppear: Observable.empty(),
                    floatingButtonTapped: Observable.empty(),
                    ellipsisButtonTapped: Observable.just(indexPath.row),
                    commentsViewButtonTapped: Observable.empty()
                ))
            }
            .disposed(by: disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 560
    }
}


//final class CommunityViewController: BaseViewController<CommunityView> {
//
//    private var nextCursor: String? // 다음 페이지를 위한 커서
//    private var isFetching: Bool = false // 중복 요청 방지
//    
//    var postList: [Post] = []
//    
//    var selectedIndex: Int = 0
//    
//    private let disposeBag = DisposeBag()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        bind()
//        fetchAllPosts(cursor: nil)
//    }
//    
//    override func setupUI() {
//
//        rootView.tableView.delegate = self
//        rootView.tableView.dataSource = self
////        rootView.tableView.prefetchDataSource = self
//        
//        rootView.tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
//        
//        rootView.tableView.allowsSelection = false
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        fetchPosts()
//        
//    }
//    
//    override func setupNavigationBar() {
//        navigationItem.title = "커뮤니티"
//        view.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = UIColor.white // 원하는 배경 색상으로 설정
//        
//        // 네비게이션 바 타이틀 색상 및 폰트 설정
//        navigationController?.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: CraftMate.color.blackColor, // 원하는 타이틀 색상으로 설정
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold) // 원하는 폰트 설정
//        ]
//    }
//    
//    
//    func fetchAllPosts(cursor: String?) {
//        guard !isFetching else { return } // 중복 요청 방지
//        isFetching = true
//        
//        let query = FetchPostQuery(next: cursor, limit: "20", product_id: "커뮤니티")
//        NetworkManager.shared.fetchPost(query: query) { [weak self] result, error in
//            guard let self = self else { return }
//            self.isFetching = false
//            
//            if let result = result {
//                self.postList.append(contentsOf: result.data)
//                self.nextCursor = result.nextCursor // 다음 페이지를 위한 커서 업데이트
//                self.rootView.tableView.reloadData()
//            } else {
//                print("Error: \(String(describing: error))")
//            }
//        }
//    }
//    
//    func bind() {
//        rootView.floatingButton.floatingButton
//            .rx
//            .tap
//            .bind(with: self) { owner, _ in
//                let vc = CommunityCreatViewController()
//                let naviVc = UINavigationController(rootViewController: vc)
//                naviVc.modalPresentationStyle = .fullScreen
//                owner.present(naviVc, animated: true)
//                
//            }
//            .disposed(by: disposeBag)
//
//    }
//    
//    @objc func commentsViewButtonTapped() {
//        let vc = ReviewViewController()
////        vc.post = postList
//        present(vc, animated: true)
//    }
//    
//    @objc func ellipsisButtonTapped(_ sender: UIButton) {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        let edit = UIAlertAction(title: "게시글 수정", style: .default) { _ in
//            self.editButtonTapped()
//            
//        }
//        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
//            self.deleteButtonTapped(sender.tag)
//        }
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        
//
//        alert.addAction(cancel)
//        alert.addAction(edit)
//        alert.addAction(delete)
//
//        present(alert, animated: true)
//        
//        
//    }
//    
//    func editButtonTapped() {
//        
//    }
//    
//    func deleteButtonTapped(_ tag: Int) {
//        NetworkManager.shared.deletePost(postId: postList[tag].postId)
//    }
//    
////    func scrollToSeletedPost() {
////        print(#function)
////        let indexPath = IndexPath(row: selectedIndex, section: 0)
////        
////        rootView.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
////    }
//    
//    override func configureView() {
//    
//    }
//    
//}
//
//extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return postList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.identifier, for: indexPath) as? CommunityTableViewCell else {
//             return UITableViewCell() }
//        cell.configureCell(with: postList[indexPath.row])
//        cell.commentsViewButton.addTarget(self, action: #selector(commentsViewButtonTapped), for: .touchUpInside)
//        cell.commentsButton.addTarget(self, action: #selector(commentsViewButtonTapped), for: .touchUpInside)
//        cell.ellipsisButton.tag = indexPath.row
//        cell.ellipsisButton.addTarget(self, action: #selector(ellipsisButtonTapped), for: .touchUpInside)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 560
//    }
//}
//extension CommunityViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        guard let maxIndex = indexPaths.map({ $0.row }).max() else { return }
//           
//           // 현재 postList의 마지막 항목에 근접한 경우 추가 데이터를 로드
//           if maxIndex >= postList.count - 1 {
//               fetchAllPosts(cursor: nextCursor)
//           }
//    }
//}
//
