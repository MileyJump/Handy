//
//  ReviewTableViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import Then
import SnapKit

final class ReviewTableViewCell: BaseTableViewCell {

    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "기본프로필")
    }

    let nicknameLabel = UILabel().then {
        $0.text = "마일리"
        $0.font = CraftMate.CustomFont.SemiBold12
    }

    let reviewLabel = UILabel().then {
        $0.text = "너무 예뻐서 깜짝 놀랐어요.. 사장님 부자 되세요!! :D"
        $0.font = CraftMate.CustomFont.regular14
        $0.numberOfLines = 0
    }
    
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    func configureCell(_ data: Comment) {
        nicknameLabel.text = data.creator.nick
        reviewLabel.text = data.content
        
        if let image = data.creator.profileImage {
            NetworkManager.shared.readImage(urlString: image) { [weak self] data in
                if let data {
                    DispatchQueue.main.async {
                        self?.profileImageView.image = UIImage(data: data)
                    }
                }
            }
        }   
    }

    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(reviewLabel)
    }

    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(40)
        }

        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualToSuperview().inset(10) // 내용에 맞게 trailing 제약
            make.height.equalTo(25)
        }
        
       
        

        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nicknameLabel.snp.leading)
            
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
