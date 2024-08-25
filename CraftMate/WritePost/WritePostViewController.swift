//
//  WritePostViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import PhotosUI
import RxSwift
import RxCocoa

final class WritePostViewController: BaseViewController<WritePostView> {
    
    let disposeBag = DisposeBag()
    
//    private var selectedImageViews: [UIImageView] = []
    private var selectedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpToolBar()
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
    
    override func setupUI() {
        rootView.imageCollectionView.register(WrithePostCollectionViewCell.self, forCellWithReuseIdentifier: WrithePostCollectionViewCell.identifier)
        rootView.imageCollectionView.delegate = self
        rootView.imageCollectionView.dataSource = self
    }
    
//    func setUpToolBar() {
//        navigationController?.isToolbarHidden = false
//        
//        let appearance = UIToolbarAppearance()
//        // 불투명한 그림자를 한겹 쌓습니다.
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .systemOrange
//        
//        navigationController?.toolbar.scrollEdgeAppearance = appearance
//        
//        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: nil, action: nil)
//        
//        
//        let barItems = [cameraButton]
//        
//        self.toolbarItems = barItems
//        
//        cameraButton.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.cameraButtonTapped()
//            }
//            .disposed(by: disposeBag)
//        
//        
//    }
    

    
    func imageViewTapped() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = max(0, 5 - selectedImages.count) // 최대 10개 이미지 선택 가능
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
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
         }
         
         NetworkManager.shared.uploadImage(images: selectedImages)
    }
    
    func xMarkButtonTapped() {
        dismiss(animated: true)
    }
}

extension WritePostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + selectedImages.count // 첫 번째 셀 + 선택된 이미지 수
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WrithePostCollectionViewCell.identifier, for: indexPath) as? WrithePostCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.item == 0 {
            cell.configureAsUploadCell(count: selectedImages.count) // 첫 번째 셀을 업로드 셀로 구성
        } else {
            let imageIndex = indexPath.item - 1
            cell.configureWithImage(selectedImages[imageIndex])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            imageViewTapped()
        }
    }
    
}

extension WritePostViewController: PHPickerViewControllerDelegate {
    
    // MARK: - PHPickerViewControllerDelegate
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let group = DispatchGroup()
        
        for result in results {
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                defer { group.leave() }
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.selectedImages.append(image)
                    }
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.rootView.imageCollectionView.reloadData()
        }
    }
}
