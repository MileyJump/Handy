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
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "기본프로필")
    }
    
     let nickNameLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.regular13
        $0.textColor = CraftMate.color.blackColor
        $0.text = "마일리에요"
        $0.textAlignment = .left
    }
    
    private let followButton = UIButton().then {
        $0.setTitle("팔로우", for: .normal)
        $0.setTitleColor(CraftMate.color.mainColor, for: .normal)
        $0.titleLabel?.font = CraftMate.CustomFont.SemiBold14
    }
    
    private let ellipsisButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = CraftMate.color.blackColor
        $0.titleLabel?.font = CraftMate.CustomFont.SemiBold14
    }
    
    private let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = .blue
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "비즈공예 팔찌")
    }
    
    private let titleLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.SemiBold14
        $0.textColor = CraftMate.color.blackColor
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.regular13
        $0.textAlignment = .left
        $0.textColor = CraftMate.color.blackColor
        $0.numberOfLines = 1
    }
    
    private let heartButton = UIButton().then {
//        $0.configureIconButton(icon: "하트", size: 2)
//        $0.backgroundColor = .blue
        $0.setImage(UIImage(systemName: CraftMate.Phrase.heartImage), for: .normal)
        $0.tintColor = CraftMate.color.whiteColor
        $0.tintColor = CraftMate.color.blackColor
        $0.setImage(UIImage(named: "하트"), for: .normal)
    }
    
    private let heartCount = UILabel().then {
        $0.text = "0"
        $0.textAlignment = .left
        $0.font = CraftMate.CustomFont.Light13
        $0.numberOfLines = 1
    }
    
      private let commentsButton = UIButton().then {
//          $0.configureIconButton(icon: "댓글", size: 20)
//          $0.backgroundColor = .blue
        $0.setImage(UIImage(named: "댓글"), for: .normal)
//        $0.tintColor = CraftMate.color.whiteColor
        $0.tintColor = CraftMate.color.blackColor
    }
    
    private let commentsLabel = UILabel().then {
        $0.text = "0"
        $0.font = CraftMate.CustomFont.Light13
        $0.textAlignment = .left
        $0.numberOfLines = 1
  }
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    func configure(with post: Post) {
        titleLabel.text = post.title ?? "No Title"  // Post의 title을 셀에 표시
        descriptionLabel.text = post.content1
        nickNameLabel.text = post.creator.nick
        
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
        contentView.addSubview(followButton)
        contentView.addSubview(ellipsisButton)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(heartButton)
        contentView.addSubview(heartCount)
        contentView.addSubview(commentsButton)
        contentView.addSubview(commentsLabel)
        contentView.addSubview(descriptionLabel)
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
        
        ellipsisButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(-3)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(35)
        }
        
        followButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.trailing.equalTo(ellipsisButton.snp.leading).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        
       
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView).inset(10)
//            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(thumbnailImageView.snp.width).multipliedBy(0.6)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            make.leading.equalTo(thumbnailImageView.snp.leading).offset(8)
            make.width.height.equalTo(20)
        }
        
        heartCount.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.leading.equalTo(heartButton.snp.trailing).offset(4)
            
            
        }
        
        commentsButton.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.top)
            make.leading.equalTo(heartCount.snp.trailing).offset(14)
            make.size.equalTo(20)
        }  
        
        commentsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.leading.equalTo(commentsButton.snp.trailing).offset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(thumbnailImageView).inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        
    }
    
}
