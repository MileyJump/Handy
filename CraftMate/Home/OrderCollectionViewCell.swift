//
//  OrderCollectionViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/26/24.
//

import UIKit
import Then
import SnapKit



final class OrderCollectionViewCell: BaseCollectionViewCell {
    
    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "기본프로필")
        $0.isUserInteractionEnabled = false
    }
    
    let nickNameLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.SemiBold12
        $0.textColor = CraftMate.color.blackColor
        $0.text = "마일리에요"
        $0.textAlignment = .left
    }
    
    let ellipsisButton = UIButton().then {
        $0.setImage(UIImage(systemName: CraftMate.Phrase.ellipsisIcon), for: .normal)
        $0.tintColor = CraftMate.color.MediumGrayColor
    }
    
    let heartButton = UIButton().then {
        $0.setImage(UIImage(systemName: CraftMate.Phrase.heartImage), for: .normal)
        $0.tintColor = CraftMate.color.whiteColor
    }
    
    let contentImageView = UIImageView().then {
        $0.image = UIImage(named: "비즈공예 팔찌")
        $0.contentMode = .scaleAspectFill
    }
    
    let titleLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.Medium14
        $0.numberOfLines = 1
        $0.textColor = CraftMate.color.blackColor
    }
    
    let contentLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.Light13
        $0.numberOfLines = 1
        $0.textColor = CraftMate.color.blackColor
    }
    
    let priceLabel = UILabel().then {
        $0.text = "88,880"
        $0.textColor = CraftMate.color.blackColor
        $0.numberOfLines = 1
        $0.font = CraftMate.CustomFont.bold14
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureCell(data: Post) {
        titleLabel.text = data.title
        contentLabel.text = data.content1
        nickNameLabel.text = data.creator.nick
        let price = Formatter.decimalNumberFormatter(number: data.price ?? 0)
        priceLabel.text = "\(price)원"
        
        
        if let data = data.files {
            data.forEach { link in
                print("--")
                NetworkManager.shared.readImage(urlString: link) { [weak self] data in
                    if let data {
                        DispatchQueue.main.async {
                            self?.contentImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentImageView.layer.cornerRadius = 5
        contentImageView.clipsToBounds = true
    }
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(nickNameLabel)
        addSubview(ellipsisButton)
        
        addSubview(contentImageView)
        addSubview(heartButton)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(priceLabel)
    }
    
    override func configureLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().offset(5)
            make.size.equalTo(25)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(4)
        }
        
        ellipsisButton.snp.makeConstraints { make in
            make.centerY.equalTo(nickNameLabel)
            make.trailing.equalToSuperview().inset(5)
            make.size.equalTo(20)
        }
        
        heartButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentImageView.snp.trailing)
            make.bottom.equalTo(contentImageView.snp.bottom)
            make.size.equalTo(40)
            
        }
        
        
        contentImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(5)
            make.height.equalTo(contentImageView.snp.width).multipliedBy(1.2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(5)
            //            make.height.equalTo(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(titleLabel)
            //            make.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(titleLabel)
            //            make.bottom.equalToSuperview().inset(10)
        }
    }
}
