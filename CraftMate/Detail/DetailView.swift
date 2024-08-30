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
    
     let followButton = UIButton().then {
        $0.setTitle("팔로우", for: .normal)
//        $0.setTitleColor(CraftMate.color.whiteColor, for: .normal)
        $0.setTitleColor(CraftMate.color.mainColor, for: .normal)
//        $0.backgroundColor = CraftMate.color.mainColor
        $0.titleLabel?.font = CraftMate.CustomFont.SemiBold13
        $0.layer.cornerRadius = 5
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
    }
    
     let titleLabel = UILabel().then {
        $0.text = "비즈공예 팔찌 팔아용"
        $0.textAlignment = .left
        $0.font = CraftMate.CustomFont.regular15
    }
    
     let categoryLabel = UILabel().then {
        $0.text = "공예"
        $0.textAlignment = .left
         $0.textColor = CraftMate.color.MediumGrayColor
        $0.font = CraftMate.CustomFont.Light13
    }
    
    let categoryLine = UIView().then {
        $0.backgroundColor = CraftMate.color.MediumGrayColor
    }
    
    let priceLabel = UILabel().then {
       $0.text = "26,900원"
       $0.textAlignment = .left
       $0.font = CraftMate.CustomFont.bold17
   }
    
    let contentLineView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
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
    let heartImage = UIImage(systemName: CraftMate.Phrase.heartImage)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12))
    
    lazy var heartButton = UIButton().then {
        $0.setImage(heartImage, for: .normal)
        $0.tintColor = CraftMate.color.darkGrayColor
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top // 이미지를 상단에 배치
        config.imagePadding = 4 // 이미지와 텍스트 사이의 간격
        
        var titleAttr = AttributedString("0")
        titleAttr.font = CraftMate.CustomFont.Light13
        config.attributedTitle = titleAttr
        
        config.baseForegroundColor = CraftMate.color.blackColor
        $0.configuration = config
    }
    
    let payButton = UIButton().then {
        $0.backgroundColor = CraftMate.color.mainColor
        $0.setTitle("구매하기", for: .normal)
        $0.setTitleColor(CraftMate.color.whiteColor, for: .normal)
        $0.titleLabel?.font = CraftMate.CustomFont.bold14
        $0.layer.cornerRadius = 5
    }
    
    let reviewButton = UIButton(type: .system).then { button in
            // 버튼의 기본 설정
            button.titleLabel?.numberOfLines = 2
            button.titleLabel?.textAlignment = .center
            button.backgroundColor = .clear
        }
    
    let tabLineView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
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
        addSubview(categoryLine)
        addSubview(priceLabel)
        addSubview(contentLineView)
        addSubview(contentLabel)
        addSubview(hashTagLabel)
        addSubview(tabBarView)
        addSubview(heartButton)
        addSubview(payButton)
        addSubview(reviewButton)
        addSubview(tabLineView)
    }
    
    func updateReviewButton(with reviewCount: Int) {
        let reviewTitle = NSMutableAttributedString(string: "리뷰\n", attributes: [
            .font: CraftMate.CustomFont.regular13 ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: CraftMate.color.blackColor
        ])
        let reviewSubtitle = NSAttributedString(string: "\(reviewCount)", attributes: [
            .font: CraftMate.CustomFont.Light13 ?? UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: CraftMate.color.MediumGrayColor
        ])
        reviewTitle.append(reviewSubtitle)
        reviewButton.setAttributedTitle(reviewTitle, for: .normal)
    }
    

    
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(self.snp.top)
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
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(titleLabel)
        }
        
        categoryLine.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(2)
            make.horizontalEdges.equalTo(categoryLabel)
            make.height.equalTo(1)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        contentLineView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(lineView)
            make.height.equalTo(1)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLineView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        tabBarView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(55)
        }
        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalTo(tabBarView)
            make.leading.equalTo(tabBarView.snp.leading).offset(10)
            make.size.equalTo(40)
        }
        
        payButton.snp.makeConstraints { make in
            make.trailing.equalTo(tabBarView.snp.trailing).inset(10)
            make.verticalEdges.equalTo(tabBarView).inset(5)
//            make.width.equalTo(150)
            make.leading.equalTo(reviewButton.snp.trailing).offset(10)
        }
        
        tabLineView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(tabBarView).inset(5)
            make.width.equalTo(1)
            make.leading.equalTo(heartButton.snp.trailing).offset(4)
        }
        
        reviewButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(tabBarView).inset(5)
            make.leading.equalTo(tabLineView.snp.trailing).offset(10)
            make.width.equalTo(50)
        }
        
        
    }
    
    
    
}
