//
//  OrderSaveView.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit

final class OrderSaveView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.orderCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    override func configureView() {
        backgroundColor = CraftMate.color.whiteColor
        collectionView.backgroundColor = CraftMate.color.whiteColor
        
        
    }
    
    
    
}
