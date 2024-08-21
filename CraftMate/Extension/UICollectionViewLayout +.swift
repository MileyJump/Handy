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
        let itemSpacing: CGFloat = 20
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        layout.scrollDirection = .horizontal
        return layout
    }
}
