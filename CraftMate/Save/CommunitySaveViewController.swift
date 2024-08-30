//
//  CommunitySaveViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit

final class CommunitySaveViewController: BaseViewController<CommunitySaveView> {
    
    var likePsot: FetchPostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLike()
    }
    
    override func configureView() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        
        rootView.collectionView.register(CommunitySaveCollectionViewCell.self, forCellWithReuseIdentifier: CommunitySaveCollectionViewCell.identifier)
    }
    
    func fetchLike() {
        NetworkManager.shared.fetchLikePost { response in
            // 특정 조건 (예: productId가 "community"가 아닌 것) 을 필터링하여 likePsot에 담음
            let filteredData = response.data.filter { post in
                return post.productId == "커뮤니티"  // 원하는 조건에 맞게 변경
            }
        
            // 필터링된 데이터를 새로운 FetchPostModel에 담음
            self.likePsot = FetchPostModel(data: filteredData, nextCursor: "")
            print(self.likePsot)
            
            // 데이터를 받아온 후, 컬렉션 뷰를 갱신
            DispatchQueue.main.async {
                self.rootView.collectionView.reloadData()
            }
        }
    }
}


extension CommunitySaveViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let likePsot else { return 0 }
        return likePsot.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunitySaveCollectionViewCell.identifier, for: indexPath) as? CommunitySaveCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .blue
        if let likePsot{
            cell.configureCell(likePsot.data[indexPath.item])
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CommunityViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


