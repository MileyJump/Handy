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
    
    override func setupNavigationBar() {
        
        let upload = UIBarButtonItem(title: "게시", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = upload
        
        let xmark = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = xmark
        
        
        upload.rx.tap
            .bind(with: self) { owner, _ in
                owner.uploadButtonTapped()
            }
            .disposed(by: disposeBag)
        
        xmark.rx.tap
            .bind(with: self) { owner, _ in
                owner.xMarkButtonTapped()
            }
            .disposed(by: disposeBag)
    }
    
     func uploadButtonTapped() {
         let title = rootView.titleTextField.text
         let content = rootView.contentTextView.text
         NetworkManager.createPost(title: title, content: nil, content1: content, content2: nil, content3: nil, content4: nil, content5: nil, product_id: nil, files: nil) { owner, _ in
             print(owner)
            
         }
    }
    
    func xMarkButtonTapped() {
        dismiss(animated: true)
    }
}
