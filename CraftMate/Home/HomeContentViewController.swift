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
    var sortImages = ["홈", "공예", "리폼", "아이들", "주방", "박스"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
        rootView.orderCollectionView.delegate = self
        rootView.orderCollectionView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        rootView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        rootView.orderCollectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
       
        
        rootView.tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        // 네트워크 요청 실행
//        viewModel.fetchPosts()
        bind()
        bindTableView(id: items[0])
    }

    override func viewWillAppear(_ animated: Bool) {
//        bindTableView()
    }
    
    override func setupNavigationBar() {
        
        
        let search = UIBarButtonItem(image: UIImage(systemName: CraftMate.Phrase.searchImage), style: .plain, target: nil, action: nil)
        //let shoppingBag = UIBarButtonItem(image: UIImage(named: "쇼핑백"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [search]
        
        navigationItem.title = "CraftMate"
        if let font = CraftMate.CustomFont.SemiBold20 {
            navigationController?.navigationBar.configureNavigationBarTitle(font: font, textColor: CraftMate.color.mainColor)
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
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
    
    
   
    func bindTableView(id: String) {
        
        NetworkManager.shared.fetchPost(productId: id) { post, error in
            if let postList = post {
                print("포스트 조회 네트워크 통신")
                
                let postData = postList.data
                self.postList.removeAll()
                self.postList.append(contentsOf: postData)
                self.rootView.orderCollectionView.reloadData()
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
        if collectionView == rootView.collectionView {
            print("??")
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
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == rootView.orderCollectionView {
            let result = postList[indexPath.row]
            let vc = DetailViewController()
            vc.post = result
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let sort = items[indexPath.item]
            print(sort)
            bindTableView(id: sort)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 200) // 원하는 크기 설정
//    }
    
    
    
    
}

extension HomeContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.identifier, for: indexPath) as? CommunityTableViewCell else {
             return UITableViewCell() }
        cell.configure(with: postList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let result = postList[indexPath.row]
        let vc = DetailViewController()
        vc.post = result
        navigationController?.pushViewController(vc, animated: true)
    }
}
