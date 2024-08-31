//
//  CommunityCreatView.swift
//  CraftMate
//
//  Created by 최민경 on 8/26/24.
//

import UIKit
import SnapKit
import Then

final class CommunityCreatView: BaseView {
    
    let imageView = UIImageView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
        $0.layer.cornerRadius = 5
    }
    
    let titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력해주세요!"
        $0.textAlignment = .left
        $0.font = CraftMate.CustomFont.SemiBold15
//        $0.backgroundColor = .blue
    }
    
    let contentsTextView = UITextView().then {
        $0.text = "새로운 소식이 있나요?"
        $0.textAlignment = .left
        $0.textColor = CraftMate.color.MediumGrayColor
//        $0.backgroundColor = .blue
        $0.font = CraftMate.CustomFont.regular13
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(titleTextField)
        addSubview(contentsTextView)
    }
    
    override func configureLayout() {
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(25)
            make.height.equalTo(40)
        }
        
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(imageView.snp.width)
        }
        
        
        contentsTextView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(200)
        }
    }
    
    
    
}
