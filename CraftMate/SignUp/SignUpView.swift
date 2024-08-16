//
//  SignUpView.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import Then
import SnapKit

final class SignUpView: BaseView {
    
    private let serviceNameLabel = UILabel().then {
        $0.text = CraftMate.Phrase.serviceName
        $0.font = CraftMate.CustomFont.bold40
//        $0.textColor = CraftMate.color.blackColor
        $0.textColor = CraftMate.color.mainColor
        $0.textAlignment = .center
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.email
        $0.font = CraftMate.CustomFont.regular15
    }
    
    private let emailLineView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.password
        $0.font = CraftMate.CustomFont.regular15
    }
    
    private let passwordLineView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
    }
    
     let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = CraftMate.CustomFont.bold14
        $0.backgroundColor = CraftMate.color.mainColor
        $0.layer.cornerRadius = 20
    }
    
     let signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(CraftMate.color.blackColor, for: .normal)
        $0.titleLabel?.font = CraftMate.CustomFont.bold14
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(serviceNameLabel)
        addSubview(emailTextField)
        addSubview(emailLineView)
        addSubview(passwordTextField)
        addSubview(passwordLineView)
        addSubview(loginButton)
        addSubview(signUpButton)
    }
    
    override func configureLayout() {
        serviceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(80)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(serviceNameLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(45)
            make.height.equalTo(40)
        }
        
        emailLineView.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom)
            make.horizontalEdges.equalTo(emailTextField)
            make.height.equalTo(1)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLineView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(emailTextField)
            make.height.equalTo(40)
        }
        
        passwordLineView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom)
            make.horizontalEdges.equalTo(passwordTextField)
            make.height.equalTo(1)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLineView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(loginButton)
            make.height.equalTo(40)
        }
    }
    
}
