//
//  CategoryButtonView.swift
//  CraftMate
//
//  Created by 최민경 on 8/26/24.
//

import UIKit
import SnapKit

class CategoryButtonView: BaseView {
    
    // 버튼 타이틀 배열을 저장하는 프로퍼티
    private var buttonTitles: [String]
    private var selectedButton: UIButton?
       var onButtonSelected: ((String) -> Void)?
    
    // CustomView의 초기화 메서드에서 버튼 타이틀을 전달받음
    init(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        super.init(frame: .zero)
        setupButtons() // 버튼을 설정하는 메서드 호출
    }
    
    
    
    
    
    private func setupButtons() {
   
        // 스택 뷰 생성
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        
        // 각 버튼 생성 후 스택 뷰에 추가
        buttonTitles.forEach { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = .clear
            button.setTitleColor(CraftMate.color.blackColor, for: .normal)
            button.titleLabel?.font = CraftMate.CustomFont.regular12
            button.layer.borderWidth = 1
            button.layer.borderColor = CraftMate.color.MediumGrayColor.cgColor
            button.layer.cornerRadius = 18
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttonStackView.addArrangedSubview(button)
        }
        
        // 스택 뷰를 뷰에 추가
        addSubview(buttonStackView)
        
        // SnapKit을 사용하여 스택 뷰 제약 설정
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)   // 왼쪽 여백 20
            make.trailing.equalToSuperview().inset(20)  // 오른쪽 여백 20
            make.centerY.equalToSuperview()              // 세로 중앙 정렬
            make.height.equalTo(40)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        // 기존에 선택된 버튼이 있다면 배경색 복원
        selectedButton?.backgroundColor = .clear
        selectedButton?.setTitleColor(CraftMate.color.blackColor, for: .normal)
        
        // 현재 클릭된 버튼의 배경색 변경
        sender.backgroundColor = CraftMate.color.darkGrayColor
        sender.setTitleColor(CraftMate.color.whiteColor, for: .normal)
        
        // 선택된 버튼 저장
        selectedButton = sender
        
        // 클릭된 버튼의 타이틀 전달
        if let title = sender.title(for: .normal) {
            onButtonSelected?(title)
        }
    }
}
