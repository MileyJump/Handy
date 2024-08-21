//
//  HomeCollectionViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/21/24.
//

import UIKit
import Then
import SnapKit

final class HomeCollectionViewCell: BaseCollectionViewCell {
    
    let titleLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.regular13
        $0.textColor = CraftMate.color.blackColor
        $0.textAlignment = .center
        $0.text = "홈 데코"
        
    }
    
    let imageButton = UIButton().then {
        $0.setImage(UIImage(named: "집"), for: .normal)
        $0.backgroundColor = CraftMate.color.LightGrayColor
        $0.layer.cornerRadius = 8
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageButton)
        
    }
    
    override func configureLayout() {
        imageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.horizontalEdges.equalToSuperview().offset(4)
            make.height.equalTo(35)
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(imageButton)
        }
        
        
        
        
    }
    
}
