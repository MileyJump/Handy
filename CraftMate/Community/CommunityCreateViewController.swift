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
    
//    func uploadButtonTapped() {
////        let title = rootView.titleTextField.text
////        let content = rootView.contentsTextView.text
//        
//        
//        var uploadedImageUrls: [String] = []
//             let dispatchGroup = DispatchGroup()
//
//             for (index, imageViewContainer) in selectedImage.enumerated() {
//                 print("처리 중인 이미지 인덱스: \(index)")
//                 
//                 guard let imageView = imageViewContainer.subviews.first as? UIImageView,
//                       let image = imageView.image,
//                       let imageData = image.jpegData(compressionQuality: 0.8) else {
//                     print("이미지 데이터 생성 실패")
//                     continue
//                 }
//                 
//                 print("이미지 데이터 크기: \(imageData.count) bytes")
//                 
//                 dispatchGroup.enter()
//                 
//                 let imageUploadQuery = ImageUploadQuery(files: imageData)
//                 
//                 NetworkManager.shared.uploadPostImage(query: imageUploadQuery) { result in
//                     switch result {
//                     case .success(let imageUrls):
//                         if imageUrls.isEmpty {
//                             print("서버에서 빈 이미지 URL 배열을 반환했습니다.")
//                         } else {
//                             print("이미지 업로드 성공!!: \(imageUrls)")
//                             uploadedImageUrls.append(contentsOf: imageUrls)
//                         }
//                     case .failure(let error):
//                         print("이미지 업로드 실패: \(error.localizedDescription)")
//                     }
//                     dispatchGroup.leave()
//                 }
//             }
//
////             dispatchGroup.notify(queue: .main) {
////                 if uploadedImageUrls.isEmpty {
////                     print("모든 이미지 업로드 실패")
////                     let alert = UIAlertController(title: "오류", message: "모든 이미지 업로드에 실패했습니다.", preferredStyle: .alert)
////                     alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
////                     self.present(alert, animated: true, completion: nil)
////                 } else {
////                     print("모든 이미지 업로드 성공, 업로드된 이미지 URLs: \(uploadedImageUrls)")
////                     self.uploadPost(withImageURLs: uploadedImageUrls)
////                 }
////             }
//        
//        
//        func uploadPost(withImageURLs imageUrls: [String]) {
//                
//              
//               // activityIndicator.startAnimating()
//                
//            guard let title = rootView.titleTextField.text, !title.isEmpty else {
//                    print("게시글 제목이 비어있습니다.")
//                    return
//                }
//            let content = rootView.contentsTextView.text ?? ""
//                let productId: String? = "공예"
//
//                print("업로드할 이미지 URL: \(imageUrls)")
//
//            NetworkManager.createPost(title: title, price: 0, content: "", content1: "", content2: "", content3: "", content4: "", content5: "", product_id: "공예", files: imageUrls) { result, error in
////                    self.activityIndicator.stopAnimating()
//                
////                    switch result {
////                    case .success:
////                        print("게시글 업로드 성공")
////                        self.rootView.titleTextField.text = ""
////                        self.selectedImage.removeAll()
////                        self.updatePhotoCountLabel()
////                        self.updateSubmitButtonState()
////                        
//////                        let readingAllPostHomeVC = AllPostHomeViewController()
//////                        self.navigationController?.pushViewController(readingAllPostHomeVC, animated: true)
////                    case .failure(let error):
////                        print("게시글 업로드 실패: \(error.localizedDescription)")
////                    }
//                }
//            }
//        
////        let image = selectedImages.j
////        NetworkManager.shared.uploadPostImage(query: ImageUploadQuery(files: <#T##Data#>), completion: <#T##(Result<[String], any Error>) -> Void#>)
//        
////        NetworkManager.shared.uploadImage(images: selectedImages) { [weak self] uploadedImageURLs in
////            guard let self = self, let imageURLs = uploadedImageURLs else {
////                print("이미지 업로드 실패 또는 URL 없음")
////                return
////            }
////            
////            NetworkManager.createPost(
////               title: title, price: nil,
////                content: nil,
////                content1: content,
////                content2: nil,
////                content3: nil,
////                content4: nil,
////                content5: nil,
////                product_id: "커뮤니티",
////                files: imageURLs) { post, error in
////                    
////                }
//        
//   }

    
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
