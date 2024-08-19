//
//  SignUpView.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//


import UIKit
import Then
import SnapKit

final class SignUpView: BaseView {
    
    private let signUpLabel = UILabel().then {
        $0.text = CraftMate.Phrase.signUp
        $0.font = CraftMate.CustomFont.bold30
        $0.textColor = CraftMate.color.blackColor
        $0.textAlignment = .center
    }
    
    private let emailLabel = UILabel().then {
        $0.text = CraftMate.Phrase.idString
        $0.font = CraftMate.CustomFont.SemiBold13
    }
    
    let emailDuplicateCheckLabel = UILabel().then {
        $0.font = CraftMate.CustomFont.regular13
        $0.textAlignment = .left
    }
    
     let emailTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.PleaseEmail
        $0.font = CraftMate.CustomFont.regular14
        $0.borderStyle = .roundedRect
    }
    
    let emailDuplicateCheckButton = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.titleLabel?.font = CraftMate.CustomFont.regular14
        $0.backgroundColor = CraftMate.color.mainColor
        $0.layer.cornerRadius = 10
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = CraftMate.Phrase.passwordString
        $0.font = CraftMate.CustomFont.SemiBold13
    }
    
    
     let passwordTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.PleasePassword
        $0.font = CraftMate.CustomFont.regular14
        $0.borderStyle = .roundedRect
        
    }
    
    private let nickNameLabel = UILabel().then {
        $0.text = CraftMate.Phrase.nickNameString
        $0.font = CraftMate.CustomFont.SemiBold13
    }
    
     let nickNameTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.PleaseNickName
        $0.font = CraftMate.CustomFont.regular14
        $0.borderStyle = .roundedRect
    }
    
     private let phoneNumberLabel = UILabel().then {
        $0.text = CraftMate.Phrase.phoneNumString
        $0.font = CraftMate.CustomFont.SemiBold13
    }
    
     let phoneNumberTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.pleasephoneNum
        $0.font = CraftMate.CustomFont.regular14
        $0.borderStyle = .roundedRect
    }
    
    private let birthLabel = UILabel().then {
        $0.text = CraftMate.Phrase.birthString
        $0.font = CraftMate.CustomFont.SemiBold13
    }
    
     let birthTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.pleaseBirth
        $0.font = CraftMate.CustomFont.regular14
        $0.borderStyle = .roundedRect
    }
    
    let signUpButton = UIButton().then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(CraftMate.color.whiteColor, for: .normal)
        $0.titleLabel?.font = CraftMate.CustomFont.bold14
        $0.backgroundColor = CraftMate.color.mainColor
        $0.layer.cornerRadius = 10
        $0.isEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(signUpLabel)
        addSubview(emailTextField)
        addSubview(emailLabel)
        addSubview(emailDuplicateCheckLabel)
        addSubview(emailDuplicateCheckButton)
        addSubview(passwordTextField)
        addSubview(passwordLabel)
        addSubview(nickNameLabel)
        addSubview(nickNameTextField)
        addSubview(phoneNumberLabel)
        addSubview(phoneNumberTextField)
        addSubview(birthLabel)
        addSubview(birthTextField)
        addSubview(signUpButton)
    }
    
    override func configureLayout() {
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(emailTextField).inset(5)
        }
        
        emailDuplicateCheckLabel.snp.makeConstraints { make in // 레이아웃 수정하기🍎
            make.top.equalTo(emailLabel.snp.top)
            make.leading.equalTo(emailLabel.snp.trailing).offset(5)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        emailDuplicateCheckButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.trailing.equalTo(emailTextField.snp.trailing).inset(5)
            make.verticalEdges.equalTo(emailTextField).inset(5)
            make.width.equalTo(emailDuplicateCheckButton.snp.height).multipliedBy(2.5)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.height.horizontalEdges.equalTo(emailTextField)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(5)
            make.height.horizontalEdges.equalTo(emailTextField)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(5)
            make.height.horizontalEdges.equalTo(emailTextField)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        birthTextField.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(5)
            make.height.horizontalEdges.equalTo(emailTextField)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(birthTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailTextField)
            make.height.equalTo(40)
        }
        
    }
}
