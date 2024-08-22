//
//  OrderView.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit
import SnapKit

final class OrderView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.orderCollectionViewLayout())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaInsets)
        }
    }
}
