//
//  CommunitySaveView.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import SnapKit

final class CommunitySaveView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.communitySaveCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
    }
    override func configureView() {
        backgroundColor = .white
        collectionView.backgroundColor = CraftMate.color.whiteColor
    }
}
