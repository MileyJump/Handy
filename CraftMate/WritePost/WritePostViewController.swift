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
    
    var selectedImage: [UIView] = []
    private var selectedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func setupUI() {
        rootView.imageCollectionView.register(WrithePostCollectionViewCell.self, forCellWithReuseIdentifier: WrithePostCollectionViewCell.identifier)
        rootView.imageCollectionView.delegate = self
        rootView.imageCollectionView.dataSource = self
        
        rootView.contentTextView.delegate = self
        

    }
    
    func imageViewTapped() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = max(0, 5 - selectedImages.count) // 최대 5개 이미지 선택 가능
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    override func setupNavigationBar() {
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 하단에 커스텀 라인 추가
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = CraftMate.color.LightGrayColor
        navigationController?.navigationBar.addSubview(bottomBorder)
        
        bottomBorder.snp.makeConstraints { make in
            make.height.equalTo(1) // 라인의 두께
            make.bottom.equalToSuperview() // 네비게이션 바의 하단에 위치
            make.leading.trailing.equalToSuperview()
        }
        
        navigationItem.title = "판매하기"
        
        let upload = UIBarButtonItem(title: "올리기", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = upload
        
        let xmark = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = xmark
        
        upload.tintColor = CraftMate.color.mainColor
        xmark.tintColor = CraftMate.color.blackColor
        
        upload.rx.tap
            .bind(with: self) { owner, _ in
                owner.uploadButtonTapped()
            }
            .disposed(by: disposeBag)
        
        xmark.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func uploadButtonTapped() {
        
        NetworkManager.shared.uploadImage(images: selectedImages) { post in
            if let post = post {
                self.uploadPost(post: post)
            }
        }
    }
    
    func uploadPost(post: [String]) {
        
        let title = rootView.titleTextField.text
        let price = Int(rootView.priceTextField.text ?? "")
        let content = rootView.contentTextView.text
        let hashTags = rootView.hashTagTextField.text
        
        
        NetworkManager.shared.createPost(title: title, price: price, content: hashTags, content1: content, content2: "", content3: "", content4: "", content5: "", product_id: sortSeleted, files: post) { result, error in
            self.dismiss(animated: true)
        }
        
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
            cell.categoryLabel.text = categories[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == rootView.imageCollectionView {
            if indexPath.item == 0 {
                imageViewTapped()
            }
//        } else if collectionView == rootView.categoryCollectionView {
//            sortSeleted = categories[indexPath.item]
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

extension WritePostViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        // 최소 높이를 200으로 설정
        let minHeight: CGFloat = 200
        let newHeight = max(estimatedSize.height, minHeight)
        
        // Update constraints with the new height
        textView.snp.updateConstraints { make in
            make.height.equalTo(newHeight)
        }

        // Adjust the scroll view content size
        rootView.scrollView.layoutIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == CraftMate.color.MediumGrayColor {
            textView.text = nil
            textView.textColor = CraftMate.color.blackColor
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = CraftMate.color.MediumGrayColor
        }
    }
}
