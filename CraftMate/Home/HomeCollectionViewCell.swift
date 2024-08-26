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
    
    let bgView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
        $0.layer.cornerRadius = 8
    }
    
    let titleLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.regular12
        $0.textColor = CraftMate.color.blackColor
        $0.textAlignment = .center
        $0.text = "홈 데코"
        
    }
    
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureCell(title: String, image: String ) {
        titleLabel.text = title
        iconImageView.image = UIImage(named: image)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(bgView)
        contentView.addSubview(titleLabel)
        bgView.addSubview(iconImageView)
        
    }
    
    override func configureLayout() {
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2)
            make.horizontalEdges.equalToSuperview().inset(5)
            make.height.equalTo(bgView.snp.width)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.edges.equalTo(bgView).inset(10)
//            make.height.equalTo(20)
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(4)
//            make.horizontalEdges.equalTo(imageButton)
            make.horizontalEdges.equalToSuperview()
        }
        
        
        
        
    }
    
}
