//
//  CategoryCollectionViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/26/24.
//

import UIKit
import Then
import SnapKit

final class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    // `Then`을 사용하여 UIButton 초기화
    let button = UIButton(type: .system).then {
        $0.titleLabel?.font = CraftMate.CustomFont.regular13
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CraftMate.color.MediumGrayColor.cgColor
        $0.layer.cornerRadius = 15
    }
    
    let categoryLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.regular13
//        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CraftMate.color.MediumGrayColor.cgColor
        $0.layer.cornerRadius = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    override func configureHierarchy() {
        contentView.addSubview(categoryLabel)
        
    }
    override func configureLayout() {
        categoryLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: attributes.frame.height)
        let size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .defaultLow, verticalFittingPriority: .required)
        let frame = CGRect(origin: attributes.frame.origin, size: size)
        attributes.frame = frame
        return attributes
    }
}
