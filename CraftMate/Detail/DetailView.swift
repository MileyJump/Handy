//
//  DetailView.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import Then
import SnapKit

final class DetailView: BaseView {
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "비즈공예 팔찌")
    }
  
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "기본프로필")
    }
    
     let nickNameLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.SemiBold13
        $0.textColor = CraftMate.color.blackColor
        $0.text = "마일리에요"
        $0.textAlignment = .left
    }
    
    private let followButton = UIButton().then {
        $0.setTitle("팔로우", for: .normal)
        $0.setTitleColor(CraftMate.color.whiteColor, for: .normal)
        $0.backgroundColor = CraftMate.color.mainColor
        $0.titleLabel?.font = CraftMate.CustomFont.SemiBold13
        $0.layer.cornerRadius = 13
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
    }
    
     let titleLabel = UILabel().then {
        $0.text = "비즈공예 팔찌 팔아용"
        $0.textAlignment = .left
        $0.font = CraftMate.CustomFont.bold15
    }
    
     let categoryLabel = UILabel().then {
        $0.text = "공예"
        $0.textAlignment = .left
        $0.font = CraftMate.CustomFont.Light13
    }
    
     let contentLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = CraftMate.CustomFont.regular14
        $0.textAlignment = .left
        $0.text = "아아암ㄹㄴ앎ㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㄷㅇㄹ"
    }
    
     let hashTagLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = CraftMate.CustomFont.Light13
        $0.text = "#팔찌 #비즈공예"
        
    }
    
    let tabBarView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let heartButton = UIButton().then {
        $0.setImage(UIImage(systemName: CraftMate.Phrase.heartImage), for: .normal)
        $0.tintColor = CraftMate.color.whiteColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(profileImageView)
        addSubview(nickNameLabel)
        addSubview(followButton)
        addSubview(titleLabel)
        addSubview(lineView)
        addSubview(categoryLabel)
        addSubview(contentLabel)
        addSubview(hashTagLabel)
        addSubview(tabBarView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
        }
        
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.size.equalTo(40)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(profileImageView.snp.height).multipliedBy(0.7)
            make.width.equalTo(followButton.snp.height).multipliedBy(2)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(14)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
    }
    
    
    
}
