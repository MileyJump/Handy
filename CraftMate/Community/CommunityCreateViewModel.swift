//
//  CommunityCreateViewModel.swift
//  CraftMate
//
//  Created by 최민경 on 9/9/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import PhotosUI

final class CommunityCreateViewModel {
    private let disposeBag = DisposeBag()
    
    private let titleSubject = BehaviorSubject<String>(value: "")
    private let contentSubject = BehaviorSubject<String>(value: "")
    private let imagesSubject = BehaviorSubject<[UIImage]>(value: [])
    private let postCreatedSubject = PublishSubject<Void>()
    private let errorSubject = PublishSubject<Error>()
    
    struct Input {
//        let uploadButtonTapped: Observable<Void>
        let imageViewTapped: Observable<Void>
        let textViewDidChange: Observable<String>
        let imagePickerResults: Observable<[PHPickerResult]>
    }
    
    struct Output {
        let title: Driver<String>
        let content: Driver<String>
        let images: Driver<[UIImage]>
        let postCreated: Driver<Void>
        let error: Driver<Error>
    }
    
    func transform(input: Input) -> Output {
        // Handle image picker results
        // Handle image picker results
        input.imagePickerResults
            .flatMap { results -> Observable<[UIImage]> in
                let observables = results.map { result -> Observable<UIImage?> in
                    return Observable.create { observer in
                        result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                            if let image = object as? UIImage {
                                observer.onNext(image)
                            } else if let error = error {
                                observer.onError(error)
                            }
                            observer.onCompleted()
                        }
                        return Disposables.create()
                    }
                }
                return Observable.merge(observables)
                    .toArray() // 결과를 [UIImage?]로 반환합니다.
                    .map { $0.compactMap { $0 } } // [UIImage?]을 [UIImage]으로 변환합니다.
                    .asObservable() // Single을 Observable로 변환합니다.
            }
            .bind(to: imagesSubject)
            .disposed(by: disposeBag)
        
        // Handle text view changes
        input.textViewDidChange
            .withLatestFrom(titleSubject) { (content: $0, title: $1) }
            .subscribe(onNext: { [weak self] in
                self?.contentSubject.onNext($0.content)
                self?.titleSubject.onNext($0.title)
            })
            .disposed(by: disposeBag)
        
//        // Handle upload button tap
//        input.uploadButtonTapped
//            .withLatestFrom(Observable.combineLatest(titleSubject, contentSubject, imagesSubject))
//            .flatMap { title, content, images -> Observable<Void> in
//                return self.uploadImage(images: images)
//                    .flatMap { post -> Observable<Void> in
//                        return self.createPost(title: title, content: content, files: post)
//                            .map { _ in }
//                            .catch { error in
//                                self.errorSubject.onNext(error)
//                                return Observable.empty()
//                            }
//                    }
//            }
//            .bind(to: postCreatedSubject)
//            .disposed(by: disposeBag)
        
        return Output(
            title: titleSubject.asDriver(onErrorJustReturn: ""),
            content: contentSubject.asDriver(onErrorJustReturn: ""),
            images: imagesSubject.asDriver(onErrorJustReturn: []),
            postCreated: postCreatedSubject.asDriver(onErrorDriveWith: .empty()),
            error: errorSubject.asDriver(onErrorJustReturn: NSError(domain: "", code: -1, userInfo: nil))
        )
    }
    
    private func uploadImage(images: [UIImage]) -> Observable<[String]> {
        return Observable.create { observer in
            NetworkManager.shared.uploadImage(images: images) { uploadedImageURLs in
                if let urls = uploadedImageURLs {
                    observer.onNext(urls)
                    observer.onCompleted()
                } else {
                    observer.onError(NSError(domain: "UploadError", code: -1, userInfo: nil))
                }
            }
            return Disposables.create()
        }
    }
    
    private func createPost(title: String, content: String, files: [String]) -> Observable<Void> {
        return Observable.create { observer in
            NetworkManager.shared.createPost(title: title, price: 0, content: content, content1: "", content2: "", content3: "", content4: "", content5: "", product_id: "커뮤니티", files: files) { post, error in
                if let _ = post {
                    observer.onNext(())
                    observer.onCompleted()
                } else if let error = error {
                    observer.onError(NSError(domain: "CreatePostError", code: -1, userInfo: [NSLocalizedDescriptionKey: error]))
                }
            }
            return Disposables.create()
        }
    }
}
