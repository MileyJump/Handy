//
//  WritePostViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import RxSwift
import RxCocoa

final class WritePostViewController: BaseViewController<WritePostView> {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpToolBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isToolbarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isToolbarHidden = false
    }
    
    func setUpToolBar() {
        navigationController?.isToolbarHidden = false
        
        let appearance = UIToolbarAppearance()
        // 불투명한 그림자를 한겹 쌓습니다.
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemOrange
        
        navigationController?.toolbar.scrollEdgeAppearance = appearance
        
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: nil, action: nil)
        
        
        let barItems = [cameraButton]
        
        self.toolbarItems = barItems
        
        cameraButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.cameraButtonTapped()
            }
            .disposed(by: disposeBag)
    }
    
    func cameraButtonTapped() {
        print("==")
    }
    
    func bind() {
        
    }
}
