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
    
    let categories = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    
    var sortSeleted = "공예"
    
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
        
        rootView.categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        rootView.categoryCollectionView.delegate = self
        rootView.categoryCollectionView.dataSource = self
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
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
     func uploadButtonTapped() {
         let title = rootView.titleTextField.text
         let content = rootView.contentTextView.text
         let hashTag = rootView.hashTagTextField.text
//         let price = Int(rootView.priceTextField.text ?? "0")
        
         
         print("\(selectedImages) :::: 사진!!")
         
         NetworkManager.shared.uploadImage(images: selectedImages) { [weak self] uploadedImageURLs in
             guard let self = self, let imageURLs = uploadedImageURLs else {
                 print("이미지 업로드 실패 또는 URL 없음")
                 return
             }
             
             
             
             // 이미지 URL을 이용해 게시물 생성
//             NetworkManager.createPost(
//                title: title, price: 20,
//                 content: hashTag,
//                 content1: content,
//                 content2: nil,
//                 content3: nil,
//                 content4: nil,
//                 content5: nil,
//                 product_id: self.sortSeleted,
//                 files: imageURLs) { post, error in
//                     
//                 }
         }
    }
    
    func xMarkButtonTapped() {
        dismiss(animated: true)
    }
}

extension WritePostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == rootView.imageCollectionView {
            return 1 + selectedImages.count // 첫 번째 셀 + 선택된 이미지 수
        } else {
            return 5
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rootView.imageCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WrithePostCollectionViewCell.identifier, for: indexPath) as? WrithePostCollectionViewCell else { return UICollectionViewCell() }
            
            if indexPath.item == 0 {
                cell.configureAsUploadCell(count: selectedImages.count) // 첫 번째 셀을 업로드 셀로 구성
            } else {
                let imageIndex = indexPath.item - 1
                cell.configureWithImage(selectedImages[imageIndex])
            }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.isUserInteractionEnabled = true
//            cell.button.isUserInteractionEnabled = true
//            cell.button.setTitle(categories[indexPath.item], for: .normal)
            cell.categoryLabel.text = categories[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == rootView.imageCollectionView {
            if indexPath.item == 0 {
                imageViewTapped()
            }
        } else if collectionView == rootView.categoryCollectionView {
            sortSeleted = categories[indexPath.item]
            
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
