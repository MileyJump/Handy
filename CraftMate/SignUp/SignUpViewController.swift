//
//  SignUpViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa


class SignUpViewContoller: BaseViewController<SignUpView> {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        rootView.loginButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                
                owner.changeRootViewController(MainTabBarController())
                
            }
            .disposed(by: disposeBag)
    }
    
}
