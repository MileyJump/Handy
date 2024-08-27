//
//  CommunityCreateViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/26/24.
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI

final class CommunityCreatViewController: BaseViewController<CommunityCreatView> {
    
    private var selectedImages: [UIImage] = []
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func setupAddTarget() {
        print(#function)
        rootView.imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        rootView.imageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func imageViewTapped() {
        print(#function)
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = max(0, 5 - selectedImages.count) // 최대 10개 이미지 선택 가능
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func uploadButtonTapped() {
        let title = rootView.titleTextField.text
        let content = rootView.contentsTextView.text
        
        NetworkManager.shared.uploadImage(images: selectedImages) { [weak self] uploadedImageURLs in
            guard let self = self, let imageURLs = uploadedImageURLs else {
                print("이미지 업로드 실패 또는 URL 없음")
                return
            }
            
            NetworkManager.createPost(
               title: title, price: nil,
                content: nil,
                content1: content,
                content2: nil,
                content3: nil,
                content4: nil,
                content5: nil,
                product_id: "커뮤니티",
                files: imageURLs) { post, error in
                    
                }
        }
   }

    
}

extension CommunityCreatViewController: PHPickerViewControllerDelegate {
    
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
                    self?.rootView.imageView.image = self?.selectedImages[0]
                    }
                }
            }
        }
        
//        group.notify(queue: .main) { [weak self] in
//            self?.rootView.imageCollectionView.reloadData()
//        }
    }
}
