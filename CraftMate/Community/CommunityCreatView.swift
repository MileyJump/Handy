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
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageView = UIImageView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
        $0.layer.cornerRadius = 5
    }
    
    let photoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
        $0.backgroundColor = .clear
        $0.tintColor = CraftMate.color.MediumGrayColor
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(photoImageView)
        contentView.addSubview(titleTextField)
        contentView.addSubview(contentsTextView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(40)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.center.equalTo(imageView)
            make.height.equalTo(100)
            make.width.equalTo(120)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(imageView.snp.width)
        }
        
        
        contentsTextView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(200)
            
        }
    }
    
    
    
}
