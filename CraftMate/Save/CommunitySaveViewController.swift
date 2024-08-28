//
//  CommunitySaveViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit

final class CommunitySaveViewController: BaseViewController<CommunitySaveView> {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        
        rootView.collectionView.register(CommunitySaveCollectionViewCell.self, forCellWithReuseIdentifier: CommunitySaveCollectionViewCell.identifier)
    }
}


extension CommunitySaveViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunitySaveCollectionViewCell.identifier, for: indexPath) as? CommunitySaveCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    
    
}
