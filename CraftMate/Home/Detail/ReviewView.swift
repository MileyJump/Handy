//
//  ReviewView.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import Then
import SnapKit

final class ReviewView: BaseView {

    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "기본프로필")
        
    }
    
    let bgTextFieldView = UIView().then {
        $0.layer.borderColor = CraftMate.color.LightGrayColor.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
    }
    
    let textField = UITextField().then {
        $0.placeholder = "Enter text"
        $0.font = CraftMate.CustomFont.regular14
    }
    
    let sendButton = UIButton().then {
        if let image = UIImage(systemName: "arrow.up.circle.fill") {
            let resizedImage = image.withRenderingMode(.alwaysTemplate).resize(to: CGSize(width: 30, height: 30))
            $0.setImage(resizedImage, for: .normal)
        }
        
        $0.tintColor = CraftMate.color.mainColor
    }
    
    let tableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.clipsToBounds = true
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
        addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(bgTextFieldView)
        bgTextFieldView.addSubview(textField)
        containerView.addSubview(sendButton)
    }
    
    override func configureLayout() {

        containerView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(60) // 높이는 원하는 대로 설정
        }
        
        // ImageView 위치와 크기 설정
        profileImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(10)
            make.width.equalTo(60) // 원하는 비율로 설정
        }
        
        // TextField 위치와 크기 설정
        bgTextFieldView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(2)
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.equalTo(sendButton.snp.leading).inset(5)
        }
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            
//            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
//            make.trailing.verticalEdges.equalToSuperview().inset(10)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalToSuperview().inset(5)
            make.width.equalTo(sendButton.snp.height)
        }
        
        
        // TableView 위치와 크기 설정
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(containerView.snp.top)
        }
    }
}
