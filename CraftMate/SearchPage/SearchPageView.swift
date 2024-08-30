//
//  SearchPageView.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import SnapKit

final class SearchPageView: BaseView {
    
     let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.orderCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    override func configureView() {
        backgroundColor = .white
        collectionView.backgroundColor = CraftMate.color.whiteColor
//        tableView.rowHeight = 400
    }
}
