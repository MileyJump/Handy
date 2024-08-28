//
//  WrithePostCollectionViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/25/24.
//

import UIKit
import Then
import SnapKit

final class WrithePostCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 5
       
    }
    
    private let cameraImageView = UIImageView()
    
    private let countLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = CraftMate.CustomFont.Light13
        $0.textColor = CraftMate.color.MediumGrayColor
    }
    
    private let deleteButton = UIButton()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func prepareForReuse() {
           super.prepareForReuse()
           imageView.image = nil
           countLabel.isHidden = true
           deleteButton.isHidden = true
       }
       
       func configureAsUploadCell(count: Int) {
           cameraImageView.image = UIImage(systemName: "camera.fill")
           cameraImageView.tintColor = CraftMate.color.MediumGrayColor
           imageView.layer.borderWidth = 1
           imageView.layer.borderColor = CraftMate.color.MediumGrayColor.cgColor
           countLabel.isHidden = false
           countLabel.text = "\(count)/5"
           deleteButton.isHidden = true
           cameraImageView.isHidden = false
       }
       
       func configureWithImage(_ image: UIImage) {
           imageView.image = image
           countLabel.isHidden = true
           cameraImageView.isHidden = true
           deleteButton.isHidden = false
           imageView.layer.borderColor = UIColor.clear.cgColor
           imageView.layer.borderWidth = 0.0
       }

    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(cameraImageView)
        addSubview(countLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.bottom.equalTo(countLabel.snp.top).offset(-5)
            make.height.equalTo(20)
            make.width.equalTo(25)
            make.centerX.equalTo(imageView)
        }
        
        countLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).offset(-6)
            make.horizontalEdges.equalTo(imageView)
        }
    }
}
