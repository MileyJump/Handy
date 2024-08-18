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
    
    func bind() {
        print("==")
        rootView.emailDuplicateCheckButton.rx.tap
            .bind(with: self) { owner, _ in
                let email = owner.rootView.emailTextField.text ?? ""
                print(email)
                print("---")
                NetworkManager.emailDuplicateCheck(email: email)
            }
            .disposed(by: disposeBag)
    }
}


