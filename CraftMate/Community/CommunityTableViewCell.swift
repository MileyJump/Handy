//
//  HomeTableViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import Then
import SnapKit

final class CommunityTableViewCell: BaseTableViewCell {
    
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
        $0.setTitleColor(CraftMate.color.mainColor, for: .normal)
        $0.titleLabel?.font = CraftMate.CustomFont.SemiBold14
    }
    
     let ellipsisButton = UIButton().then {
         $0.setImage(UIImage(systemName: CraftMate.Phrase.ellipsisIcon), for: .normal)
         $0.tintColor = CraftMate.color.blackColor
         $0.titleLabel?.font = CraftMate.CustomFont.SemiBold14
    }
    
    private let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = .blue
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "비즈공예 팔찌")
    }

    
    lazy var heartButton = UIButton().then {
        // 심볼 이미지를 설정하고, 렌더링 모드를 템플릿으로 변경
        let heartImage = UIImage(systemName: CraftMate.Phrase.heartFillImage)?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 12))
            .withRenderingMode(.alwaysTemplate) // 이미지 색상 변경을 위해 템플릿 모드로 설정
        
        // 이미지와 이미지 색상 설정
        $0.setImage(heartImage, for: .normal)
        $0.tintColor = .red // 이미지 색상을 빨간색으로 설정
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading // 이미지를 상단에 배치
        config.imagePadding = 4 // 이미지와 텍스트 사이의 간격 설정
        
        // 제목 텍스트의 색상과 폰트 설정
        var titleAttr = AttributedString("0")
        titleAttr.font = CraftMate.CustomFont.Light13
        titleAttr.foregroundColor = CraftMate.color.darkGrayColor // 제목 텍스트 색상을 다크 그레이로 설정
        
        config.attributedTitle = titleAttr
        
        $0.configuration = config
        $0.configuration?.contentInsets = .zero // 버튼의 콘텐츠 인셋 설정 (여백 없애기)
        $0.contentHorizontalAlignment = .center // 이미지와 텍스트를 버튼의 중앙에 정렬
    }
    
     let commentsButton = UIButton().then {
        var config = UIButton.Configuration.plain() // 기본 스타일 사용
        
        config.image = UIImage(systemName: "bubble.right") // 이미지 설정
        config.title = "0"
        config.imagePadding = 4 // 이미지와 텍스트 간의 간격 설정
        config.baseForegroundColor = CraftMate.color.blackColor // 이미지와 텍스트 색상 설정
        
        // 이미지 크기 조정
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 15) // 이미지 크기를 20 포인트로 설정

        // 폰트 설정
        config.attributedTitle = AttributedString("0", attributes: AttributeContainer([
            .font: CraftMate.CustomFont.Light14 ??
            UIFont.systemFont(ofSize: 14, weight: .medium)
        ]))
        
        $0.configuration = config
        $0.configuration?.contentInsets = .zero // 버튼의 콘텐츠 인셋 설정 (여백 없애기)
        $0.contentHorizontalAlignment = .center // 이미지와 텍스트를 버튼의 중앙에 정렬
    }
    
    
    
    private let contentsLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.regular14
        $0.textColor = CraftMate.color.blackColor
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
     let commentsViewButton = UIButton().then {
        $0.setTitleColor(CraftMate.color.MediumGrayColor, for: .normal)
        $0.titleLabel?.font = CraftMate.CustomFont.SemiBold13
        $0.contentHorizontalAlignment = .leading
    }
    
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    func configureCell(with post: Post) {
        contentsLabel.text = post.content1
        nickNameLabel.text = post.creator.nick
        
        if let data = post.files {
            data.forEach { link in
                print("--")
                NetworkManager.shared.readImage(urlString: link) { [weak self] data in
                    if let data {
                        DispatchQueue.main.async {
                            self?.thumbnailImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        
        if let comments = post.comments {
            commentsViewButton.setTitle("댓글 \(comments.count)개 모두 보기", for: .normal)
            commentsButton.setTitle("\(comments.count)", for: .normal)
        }
        
        if let like = post.likes {
            heartButton.setTitle("\(like.count)", for: .normal)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.clipsToBounds = true
//        thumbnailImageView.layer.cornerRadius = 5
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(followButton)
        contentView.addSubview(ellipsisButton)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(contentsLabel)
        contentView.addSubview(heartButton)
        contentView.addSubview(commentsButton)
        contentView.addSubview(commentsViewButton)
        
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
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
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
//            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(thumbnailImageView.snp.width).multipliedBy(1)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom)
            make.leading.equalTo(thumbnailImageView.snp.leading).offset(12)
            make.width.height.equalTo(40)
        }
        
        
        commentsButton.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.top)
            make.leading.equalTo(heartButton.snp.trailing).offset(10)
            make.size.equalTo(40)
        }
        
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(thumbnailImageView).inset(14)
        }
        
        commentsViewButton.snp.makeConstraints { make in
            make.top.equalTo(contentsLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentsLabel)
            make.height.equalTo(35)
        }
     
    }
    
    override func configureView() {
        backgroundColor = CraftMate.color.whiteColor
    }
    
}
