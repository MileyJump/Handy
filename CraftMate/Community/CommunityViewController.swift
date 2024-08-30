//
//  CommunityViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit
import RxSwift
import RxCocoa

//enum CommunityMode {
//    case allPosts
//    case likedPosts
//}


final class CommunityViewController: BaseViewController<CommunityView> {
    
//    var mode: CommunityMode = .allPosts
    
    var postList: [Post] = []
    var saveList: [Post] = []
    
    var selectedIndex: Int = 0
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()

    }
    
    override func setupUI() {

        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        rootView.tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        
        rootView.tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchPosts()
        fetchAllPosts()
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "커뮤니티"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.white // 원하는 배경 색상으로 설정
        
        // 네비게이션 바 타이틀 색상 및 폰트 설정
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: CraftMate.color.blackColor, // 원하는 타이틀 색상으로 설정
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold) // 원하는 폰트 설정
        ]
    }
    
//    private func fetchPosts() {
//        switch mode {
//        case .allPosts:
//            fetchAllPosts()
//        case .likedPosts:
//            // 여기서 좋아요한 게시물들을 가져옵니다.
//            postList = saveList
//            scrollToSeletedPost()
//        }
//    }
    
    func fetchAllPosts() {
        
        NetworkManager.shared.fetchPost(productId: "커뮤니티") { post, error in
            if let postList = post {
                let postData = postList.data
                self.postList.append(contentsOf: postData)
                self.rootView.tableView.reloadData()
            }
        }
    }
    
    func bind() {
        rootView.floatingButton.floatingButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                let vc = CommunityCreatViewController()
                let naviVc = UINavigationController(rootViewController: vc)
                naviVc.modalPresentationStyle = .fullScreen
                owner.present(naviVc, animated: true)
                
            }
            .disposed(by: disposeBag)

    }
    
    @objc func commentsViewButtonTapped() {
        let vc = ReviewViewController()
        
        present(vc, animated: true)
    }
    
    @objc func ellipsisButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let edit = UIAlertAction(title: "게시글 수정", style: .default) { _ in
            self.editButtonTapped()
            
        }
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.deleteButtonTapped(sender.tag)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        

        alert.addAction(cancel)
        alert.addAction(edit)
        alert.addAction(delete)

        present(alert, animated: true)
    }
    
    func editButtonTapped() {
        
    }
    
    func deleteButtonTapped(_ tag: Int) {
        NetworkManager.shared.deletePost(postId: postList[tag].postId)
    }
    
//    func scrollToSeletedPost() {
//        print(#function)
//        let indexPath = IndexPath(row: selectedIndex, section: 0)
//        
//        rootView.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
//    }
    
    override func configureView() {
    
    }
    
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.identifier, for: indexPath) as? CommunityTableViewCell else {
             return UITableViewCell() }
        cell.configureCell(with: postList[indexPath.row])
        cell.commentsViewButton.addTarget(self, action: #selector(commentsViewButtonTapped), for: .touchUpInside)
        cell.commentsButton.addTarget(self, action: #selector(commentsViewButtonTapped), for: .touchUpInside)
        cell.ellipsisButton.tag = indexPath.row
        cell.ellipsisButton.addTarget(self, action: #selector(ellipsisButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}
