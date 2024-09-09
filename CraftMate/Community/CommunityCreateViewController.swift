//
//  CommunityCreateViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/26/24.
//
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI

final class CommunityCreateViewController: BaseViewController<CommunityCreatView> {
    
    private let disposeBag = DisposeBag()
    private let viewModel = CommunityCreateViewModel()
    private let imagePickerResultsSubject = PublishSubject<[PHPickerResult]>()
    private var selectedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configureView()
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
            .subscribe(onNext: { [weak self] in
                self?.uploadButtonTapped()
                print("업로드 버튼 탭드")
            })
            .disposed(by: disposeBag)
        
        xmark.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupBindings() {
        // Observable을 생성하고, ViewModel의 Input과 Output을 구성합니다.
        let imageViewTapped = Observable<Void>.create { observer in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped))
            self.rootView.imageView.addGestureRecognizer(tapGesture)
            self.rootView.imageView.isUserInteractionEnabled = true
            return Disposables.create()
        }
        
        let textViewDidChange = rootView.contentsTextView.rx.text.orEmpty.asObservable()
        let imagePickerResults = imagePickerResultsSubject.asObservable()
        
        let input = CommunityCreateViewModel.Input(
//            uploadButtonTapped: Observable.empty(), // 업로드 버튼에 대한 Observable을 직접 생성
            imageViewTapped: imageViewTapped,
            textViewDidChange: textViewDidChange,
            imagePickerResults: imagePickerResults
        )
        
        let output = viewModel.transform(input: input)
        
        // ViewModel의 output을 View에 바인딩
        output.title
            .drive(rootView.titleTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.content
            .drive(rootView.contentsTextView.rx.text)
            .disposed(by: disposeBag)
        
        output.images
            .drive(onNext: { [weak self] images in
                guard let self = self else { return }
                self.rootView.imageView.image = images.first
            })
            .disposed(by: disposeBag)
        
        output.postCreated
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { error in
                // 에러 처리 (예: 알림 표시)
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func imageViewTapped() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = max(0, 5 - selectedImages.count) // 최대 5개 이미지 선택 가능
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func uploadButtonTapped() {
        // 업로드 버튼에 대한 액션은 ViewModel에 정의된 Input을 통해 처리됨
        // 따로 ViewModel에 input을 통해 호출하거나 사용하지 않음
        print("업로드 버튼 탭드")
    }
}

extension CommunityCreateViewController: UITextViewDelegate {
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
    }
    
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

extension CommunityCreateViewController: PHPickerViewControllerDelegate {
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
                        self?.rootView.imageView.image = self?.selectedImages.first
                        self?.imagePickerResultsSubject.onNext(results)
                    }
                }
            }
        }
    }
}

// UIImagePickerControllerDelegate 및 PHPickerViewControllerDelegate 관련 코드는 그대로 유지됩니다.
//import UIKit
//import RxSwift
//import RxCocoa
//import PhotosUI
//
//final class CommunityCreatViewController: BaseViewController<CommunityCreatView> {
//    
//    private var selectedImages: [UIImage] = []
//    private var selectedImage: [UIView] = []
//    
//    private let disposeBag = DisposeBag()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    override func configureView() {
//        rootView.contentsTextView.delegate = self
//    }
//    
//    override func setupNavigationBar() {
//        
//        let upload = UIBarButtonItem(title: "게시", style: .plain, target: nil, action: nil)
//        navigationItem.rightBarButtonItem = upload
//        
//        let xmark = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: nil, action: nil)
//        navigationItem.leftBarButtonItem = xmark
//        
//        
//        upload.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.uploadButtonTapped()
//            }
//            .disposed(by: disposeBag)
//        
//        xmark.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.dismiss(animated: true)
//            }
//            .disposed(by: disposeBag)
//    }
//    
//    func uploadButtonTapped() {
//        
//        NetworkManager.shared.uploadImage(images: selectedImages) { post in
//            if let post = post {
//                self.uploadPost(post: post)
//            }
//        }
//    }
//    
//    func uploadPost(post: [String]) {
//        
//        let title = rootView.titleTextField.text
//        let content = rootView.contentsTextView.text
//        
//        NetworkManager.shared.createPost(title: title, price: 0, content: "", content1: content, content2: "", content3: "", content4: "", content5: "", product_id: "커뮤니티", files: post) { result, error in
//            self.dismiss(animated: true)
//        }
//        
//    }
//    
//    override func setupAddTarget() {
//        print(#function)
//        rootView.imageView.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
//        rootView.imageView.addGestureRecognizer(tapGesture)
//        
//    }
//    
//    @objc func imageViewTapped() {
//        print(#function)
//        var configuration = PHPickerConfiguration()
//        configuration.selectionLimit = max(0, 5 - selectedImages.count) // 최대 10개 이미지 선택 가능
//        configuration.filter = .images
//        
//        let picker = PHPickerViewController(configuration: configuration)
//        picker.delegate = self
//        present(picker, animated: true)
//    }
//}
//
//
//extension CommunityCreatViewController: UITextViewDelegate {
//    
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
//    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == CraftMate.color.MediumGrayColor {
//            textView.text = nil
//            textView.textColor = CraftMate.color.blackColor
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "새로운 소식이 있나요?"
//            textView.textColor = CraftMate.color.MediumGrayColor
//        }
//    }
//}
//
//
//extension CommunityCreatViewController: PHPickerViewControllerDelegate {
//    
//    // MARK: - PHPickerViewControllerDelegate
//    
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        dismiss(animated: true)
//        
//        let group = DispatchGroup()
//        
//        for result in results {
//            group.enter()
//            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
//                defer { group.leave() }
//                if let image = object as? UIImage {
//                    DispatchQueue.main.async {
//                    self?.selectedImages.append(image)
//                    self?.rootView.imageView.image = self?.selectedImages[0]
//                    }
//                }
//            }
//        }
//        
//    }
//}
