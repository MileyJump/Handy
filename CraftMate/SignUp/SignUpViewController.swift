//
//  SignUpViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: BaseViewController<SignUpView> {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {  // 🍎
        rootView.emailDuplicateCheckButton.rx.tap
            .bind(with: self) { owner, _ in
                let email = owner.rootView.emailTextField.text ?? ""
                print(email)
                print("---")
                NetworkManager.emailDuplicateCheck(email: email) { value, isEnabled  in
                    owner.rootView.emailDuplicateCheckLabel.text = value
                    owner.rootView.signUpButton.isEnabled = isEnabled
                }
            }
            .disposed(by: disposeBag)
        
        rootView.signUpButton.rx.tap
            .bind(with: self) { owner, _ in // 🍎
                let email = owner.rootView.emailTextField.text ?? ""
                let password = owner.rootView.passwordTextField.text ?? ""
                let nick = owner.rootView.nickNameTextField.text ?? ""
                let phoneNum = owner.rootView.phoneNumberTextField.text ?? ""
                let birthday = owner.rootView.birthTextField.text ?? ""
                print("=====\(email),, \(password),, \(nick)")
                
                NetworkManager.createSignUp(email: email, password: password, nick: nick, phoneNum: phoneNum, birthDay: birthday)
            }
            .disposed(by: disposeBag)
    }
    
    
}


