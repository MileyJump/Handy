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
    private var selectedImage: [UIView] = []
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        rootView.contentsTextView.delegate = self
    }
    
    override func setupNavigationBar() {
        
        let upload = UIBarButtonItem(title: "게시", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = upload
        
        let xmark = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = xmark
        
        
        upload.rx.tap
            .bind(with: self) { owner, _ in
//                owner.uploadButtonTapped()
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
}


extension CommunityCreatViewController: UITextViewDelegate {
    
//    func textViewDidChange(_ textView: UITextView) {
//        let size = CGSize(width: textView.frame.width, height: .infinity)
//        let estimatedSize = textView.sizeThatFits(size)
//        
//        // 최소 높이를 200으로 설정
//        let minHeight: CGFloat = 200
//        let newHeight = max(estimatedSize.height, minHeight)
//        
//        // Update constraints with the new height
//        textView.snp.updateConstraints { make in
//            make.height.equalTo(newHeight)
//        }
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == CraftMate.color.MediumGrayColor {
            textView.text = nil
            textView.textColor = CraftMate.color.blackColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "새로운 소식이 있나요?"
            textView.textColor = CraftMate.color.MediumGrayColor
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
        
    }
}
