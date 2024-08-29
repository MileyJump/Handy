//
//  SearchPageViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

final class SearchPageViewController: BaseViewController<SearchPageView> {
    
    var searchTimer: Timer?
    var postData: FetchPostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        navigationItem.titleView = rootView.searchBar
        navigationItem.backButtonTitle = ""
    }
    
    
    
    
    override func configureView() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        
        rootView.collectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
        
        rootView.searchBar.delegate = self
    }
}

extension SearchPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           // 이전 타이머를 무효화 (이미 타이머가 동작 중이면 중지)
           searchTimer?.invalidate()
           
           // 새로운 타이머 설정
           searchTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
               // 2초 동안 입력이 없을 경우 실행할 코드
               print(searchText)
               self?.performSearch(with: searchText)
           }
       }
       
       // 검색 실행 함수
       func performSearch(with searchText: String) {
           NetworkManager.shared.hashTagSearch(query: HashTagQuery(next: "", limit: "", product_id: "", hashTag: searchText)) { [weak self ] response in
               print(response)
               self?.postData = response
               self?.rootView.collectionView.reloadData()
           }
       }
}

extension SearchPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let postData else { return 0 }
        return postData.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as? OrderCollectionViewCell else { return UICollectionViewCell() }
        if let postData {
            cell.configureCell(data: postData.data[indexPath.item])
        }
        return cell
    }
    
   
}
