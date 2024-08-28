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
    
    var postList: [Post] = []
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setupUI() {

        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        rootView.tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindTableView()
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "커뮤니티"
    }
    
    func bindTableView() {
        
        NetworkManager.shared.fetchPost(productId: "커뮤니티") { post, error in
            if let postList = post {
                print(postList)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}
