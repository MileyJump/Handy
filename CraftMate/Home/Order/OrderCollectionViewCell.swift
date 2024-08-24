//
//  OrderCollectionViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/24/24.
//

import UIKit
import Then
import SnapKit

final class OrderCollectionViewCell: BaseCollectionViewCell {
    
    let contentImageView = UIImageView().then {
        $0.image = UIImage(named: "비즈공예 팔찌")
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.Medium14
    }
    
    let contentLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.Light13
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentImageView.layer.cornerRadius = 15
    }
    
    override func configureHierarchy() {
        addSubview(contentImageView)
        addSubview(titleLabel)
        addSubview(contentLabel)
    }
    
    override func configureLayout() {
        contentImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(5)
            make.height.equalTo(contentImageView.snp.width).multipliedBy(1.1)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(5)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(titleLabel)
        }
    }
    
    func configureCell(with post: Post) {
        titleLabel.text = post.title
        contentLabel.text = post.content1
        
    }
    
    
    
    
}
