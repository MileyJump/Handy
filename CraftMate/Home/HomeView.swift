//
//  HomeView.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//
import UIKit
import SnapKit

final class HomeView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.itemCollectionViewLayout())
    let orderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.orderCollectionViewLayout())
    
    
    let floatingButton = FloatingButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(orderCollectionView)
        addSubview(floatingButton)
        
        
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(collectionView.snp.bottom).offset(2)
//            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
//        }
        
        orderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(2)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.size.equalTo(60)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = CraftMate.color.whiteColor
        orderCollectionView.backgroundColor = CraftMate.color.whiteColor
    }
}
