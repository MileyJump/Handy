//
//  HomeController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController<HomeView> {
    
    let disposeBag = DisposeBag()
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.tableView.delegate = self
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        // 네트워크 요청 실행
        viewModel.fetchPosts()
        
        bindTableView()
        bind()
    }
    
  
  
    
    func bind() {
        rootView.floatingButton.floatingButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(WritePostViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        // 수정하기..
        rootView.segmentControl.rx.selectedSegmentIndex
            .bind(with: self, onNext: { owner, index in
              owner.rootView.updateSelectionIndicatorPosition(for: index)
                print(index)
            })
            .disposed(by: disposeBag)
        
        
    }

    func bindTableView() {
        // ViewModel의 posts와 TableView 바인딩
        viewModel.posts
            .bind(to: rootView.tableView.rx.items(cellIdentifier: HomeTableViewCell.identifier, cellType: HomeTableViewCell.self)) { row, post, cell in
                cell.configure(with: post)
            }
            .disposed(by: disposeBag)
    }
    
    override func setupNavigationBar() {
        let search = UIBarButtonItem(image: UIImage(systemName: CraftMate.Phrase.searchImage), style: .plain, target: nil, action: nil)
//        let shoppingBag = UIBarButtonItem(image: UIImage(named: "쇼핑백"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [search]
        
        navigationItem.title = "CraftMate"
        if let font = CraftMate.CustomFont.SemiBold20 {
            navigationController?.navigationBar.configureNavigationBarTitle(font: font, textColor: CraftMate.color.mainColor)
        }
    }
    
     func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedPost = viewModel.posts.value[indexPath.row]
        // 선택된 포스트에 대한 처리 추가
    }
}

//final class HomeViewController: BaseViewController<HomeView> {
//    
//    var posts = BehaviorRelay<[Post]>(value: [])
//      let disposeBag = DisposeBag()
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        rootView.tableView.delegate = self
//        rootView.tableView.dataSource = self
//        
//       
//        fetchPost()
//        bind()
//    }
//    
//    func fetchPost() {
//     
//    }
//    
//    func bind() {
//        rootView.floatingButton.floatingButton
//            .rx
//            .tap
//            .bind(with: self) { owner, _ in
//                owner.navigationController?.pushViewController(WritePostViewController(), animated: true)
//            }
//            .disposed(by: disposeBag)
//    }
//    
//    override func setupNavigationBar() {
//        navigationItem.title = "CraftMate"
//        if let font = CraftMate.CustomFont.SemiBold20 {
//            navigationController?.navigationBar.configureNavigationBarTitle(font: font, textColor: CraftMate.color.mainColor)
//        }
//    }
//    
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        } else {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }
//    
//    
//    
//}
//
//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = rootView.tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
////        cell.nickNameLabel.text = posts?.title
//        return cell
//    }
//    
//    
//}
