//
//  BaseCollectionViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
    
    
}
