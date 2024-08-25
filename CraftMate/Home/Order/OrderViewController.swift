//
//  OrderViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit

final class OrderViewController: BaseViewController<OrderView> {
    
    var postList: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        rootView.collectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindTableView()
    }
    
    func bindTableView() {
        
        NetworkManager.fetchPost(productId: "공예") { post, error in
            if let postList = post {
                print(postList)
                let postData = postList.data
                self.postList.append(contentsOf: postData)
                self.rootView.collectionView.reloadData()
            }
        }
        
    }
}

extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as? OrderCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: postList[indexPath.row])
        return cell
    }
}
