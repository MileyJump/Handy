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
    
    let disposeBag = DisposeBag()
    
    let viewModel = HomeViewModel()
    
    var postList: [Post] = []
    
    // 나중에 Rx로 수정
    var items = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    var sortImages = ["홈", "비즈", "비즈", "홈", "주방", "비즈"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        rootView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        
        rootView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        // 네트워크 요청 실행
//        viewModel.fetchPosts()
        bind()
//        bindTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        bindTableView()
    }
    
    
    
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
   
    func bindTableView() {
        
        NetworkManager.fetchPost { post, error in
            if let postList = post {
//                print(postList)
                let postData = postList.data
                self.postList.append(contentsOf: postData)
                self.rootView.tableView.reloadData()
            }
        }
        //           let input = viewModel.
        
        //           viewModel.postsList.
        //               .bind(to: rootView.tableView.rx.items(cellIdentifier: HomeTableViewCell.identifier, cellType: HomeTableViewCell.self)) { row, post, cell in
        //
        //                   cell.configure(with: post.data[row])
        //               }
        //               .disposed(by: disposeBag)
        //       }
        
    }
    
}
   
   
   
extension HomeContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(title: items[indexPath.row], image: sortImages[indexPath.row])
        
        
        return cell
    }
}

extension HomeContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
             return UITableViewCell() }
        cell.configure(with: postList[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedPost = viewModel.posts.value[indexPath.row]
//        // 선택된 포스트에 대한 처리 추가
//    }
}
