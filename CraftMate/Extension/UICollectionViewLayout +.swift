//
//  UICollectionView.swift
//  CraftMate
//
//  Created by 최민경 on 8/21/24.
//

import UIKit

extension UICollectionViewLayout {
    
    
    static func itemCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let lineSpacing: CGFloat = 20
        let itemSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (lineSpacing * 2) - (itemSpacing * 5)
        layout.itemSize = CGSize(width: width/5, height: width/4.2)
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    static func categoryCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템의 크기 설정
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(50), // 아이템의 너비는 예상값으로 설정
                heightDimension: .absolute(40)  // 아이템의 높이는 고정값으로 설정
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 그룹의 크기 설정
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(50), // 그룹의 너비는 예상값으로 설정
                heightDimension: .absolute(40)  // 그룹의 높이는 고정값으로 설정
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // 섹션의 설정
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous // 가로 스크롤 설정
            section.interGroupSpacing = 10 // 그룹 간의 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10) // 섹션 여백 설정
            
            return section
        }
        
        return layout
    }

    static func communitySaveCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 2
        let totalSpacing = itemSpacing * 2 // (itemSpacing * (number of items in a row - 1))
        let availableWidth = UIScreen.main.bounds.width - totalSpacing
        let itemWidth = availableWidth / 3 // 3개 셀로 나눔
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth) // 1:1 비율
        
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
    static func orderCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing)
        layout.itemSize = CGSize(width: width/2, height: width)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    static func imageSelectionCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 8
        let width = UIScreen.main.bounds.width / 5
        
        layout.scrollDirection = .horizontal // 가로 스크롤 설정
        layout.itemSize = CGSize(width: width, height: width) // 정사각형 아이템
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        
        return layout
    }
}
