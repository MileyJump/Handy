//
//  WritePostView.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import SnapKit
import Then

final class WritePostView: BaseView {
    
    private let postImageView = UIImageView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
    }
    
    private let postLabel = UILabel().then {
        $0.text = "대표 사진을 업로드해주세요."
        $0.textAlignment = .center
        $0.font = CraftMate.CustomFont.bold15
    }
    
    private let cameraImageView = UIImageView().then {
        $0.image = UIImage(systemName: "camera.on.rectangle")
        $0.tintColor = CraftMate.color.MediumGrayColor
    }
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "제목을 작성해주세요!"
        $0.font = CraftMate.CustomFont.bold15
    }
    
    private let contentTextView = UITextView().then {
        $0.text = "내용을 입력해주세요!"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(postImageView)
        addSubview(postLabel)
        addSubview(cameraImageView)
        addSubview(titleTextField)
        addSubview(contentTextView)
    }
    
    override func configureLayout() {
        postImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(postImageView.snp.width)
        }
        
        postLabel.snp.makeConstraints { make in
            make.top.equalTo(cameraImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(postImageView).inset(10)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.centerY.equalTo(postImageView).offset(-20)
            make.centerX.equalTo(postLabel)
            make.height.equalTo(70)
            make.width.equalTo(90)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(35)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(titleTextField)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
}
