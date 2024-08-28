//
//  CommunitySaveCollectionViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import Then
import SnapKit

final class CommunitySaveCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.backgroundColor = .red
        $0.image = UIImage(named: "비즈공예 팔찌")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    override func configureHierarchy() {
        addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
