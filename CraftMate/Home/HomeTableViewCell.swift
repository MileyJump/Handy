//
//  HomeTableViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import Then
import SnapKit

final class HomeTableViewCell: BaseTableViewCell {
    
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
     let nickNameLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.regular13
        $0.textColor = CraftMate.color.blackColor
        $0.text = "마일리에요"
        $0.textAlignment = .left
    }
    
    private let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = .blue
        $0.contentMode = .scaleAspectFill
    }
    
     let titleLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.SemiBold14
        $0.text = "오늘은 저의 첫 비즈공예 목걸이를 보여드릴게요!"
        $0.textColor = CraftMate.color.blackColor
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let heartButton = UIButton().then {
        $0.setImage(UIImage(systemName: CraftMate.Phrase.heartImage), for: .normal)
        $0.tintColor = CraftMate.color.whiteColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    func configure(with post: Post) {
        titleLabel.text = post.title ?? "No Title"  // Post의 title을 셀에 표시
        
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 5
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(heartButton)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(30)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(6)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(thumbnailImageView.snp.width).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(thumbnailImageView)
        }
        
        heartButton.snp.makeConstraints { make in
            make.bottom.equalTo(thumbnailImageView.snp.bottom).offset(-8)
            make.leading.equalTo(thumbnailImageView.snp.leading).offset(8)
            make.size.equalTo(35)
        }
        
    }
    
}
