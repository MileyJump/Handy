//
//  ProfileView.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import Then
import SnapKit

final class ProfileView: BaseView {
    
    private let topLineView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
    }
    
    let profileImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
//    
//    let nextButton = UIButton().then {
//        $0.nextButton(title: "완료")
//        $0.updateNextButtonState(isEnabled: false)
//    }
//    
//    let nicknameTextField = UITextField().then {
//        $0.placeholder = Resource.Phrase.profileNickNamePlaceholder
//        $0.font = .systemFont(ofSize: 14)
//    }
//    
//    let lineView = UIView().then {
//        $0.backgroundColor = UIColor.picFaveLightGrayColor
//    }
//    
//    let nicknameLabel = UILabel().then {
//        $0.textColor = UIColor.picFaveRedColor
//        $0.font =  Resource.SystemFont.regular13
//        $0.text = "테스트 입력"
//    }
//    
//    let mbtiLabel = UILabel().then {
//        $0.text = "MBTI"
//        $0.font = Resource.SystemFont.bold16
//        $0.textAlignment = .left
//    }
//    
//    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.mbtiCollectionViewLayout())
//    
//    let deleteAccount = UIButton().then {
//        $0.setTitle("회원탈퇴", for: .normal)
//        $0.setTitleColor(.picFaveMainBlueColor, for: .normal)
//        $0.isHidden = true
//        $0.titleLabel?.font = Resource.SystemFont.regular13
//    }
//    
//    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
//    
//    override func configureHierarchy() {
//        addSubview(topLineView)
//        addSubview(profileImageView)
//        addSubview(nicknameTextField)
//        addSubview(lineView)
//        addSubview(nicknameLabel)
//        addSubview(nextButton)
//        addSubview(mbtiLabel)
//        addSubview(collectionView)
//        addSubview(deleteAccount)
//    }
//    
//    override func configureLayout() {
//        topLineView.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide)
//            make.height.equalTo(1)
//            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
//        }
//        
//        
//        profileImageView.snp.makeConstraints { make in
//            make.top.equalTo(topLineView.snp.bottom).offset(20)
//            make.centerX.equalToSuperview()
//            make.width.height.equalTo(snp.width).multipliedBy(0.3)
//        }
//        
//        nicknameTextField.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
//            make.top.equalTo(profileImageView.snp.bottom).offset(30)
//            make.height.equalTo(40)
//        }
//        
//        lineView.snp.makeConstraints { make in
//            make.top.equalTo(nicknameTextField.snp.bottom)
//            make.trailing.equalTo(nicknameTextField.snp.trailing).offset(5)
//            make.leading.equalTo(nicknameTextField.snp.leading).offset(-5)
//            make.height.equalTo(1)
//        }
//        
//        nicknameLabel.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(nicknameTextField)
//            make.top.equalTo(lineView.snp.bottom).offset(15)
//        }
//        
//        
//        nextButton.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
//            make.height.equalTo(40)
//            make.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
//        }
//        
//        mbtiLabel.snp.makeConstraints { make in
//            make.top.equalTo(nicknameLabel.snp.bottom).offset(30)
//            make.leading.equalTo(nicknameTextField.snp.leading)
//        }
//        
//        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(mbtiLabel.snp.top)
//            make.leading.equalTo(mbtiLabel.snp.trailing).offset(40)
//            make.trailing.equalTo(safeAreaLayoutGuide)
//            make.height.equalTo(collectionView.snp.width).multipliedBy(1) // 높이를 너비의 절반으로 설정
//        }
//        
//        deleteAccount.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalTo(nextButton)
//        }
//    }
}
