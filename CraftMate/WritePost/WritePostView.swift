//
//  WritePostView.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import SnapKit
import Then

final class WritePostView: BaseView {
    
    let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.imageSelectionCollectionViewLayout())
    
    let titleLabel = UILabel().then {
        $0.text = CraftMate.Phrase.titleString
        $0.font = CraftMate.CustomFont.bold13
        $0.textAlignment = .left
    }
    
    let titleTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.titlePlaceholder
        $0.font = CraftMate.CustomFont.Light13
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
    }
    
    let categoryLabel = UILabel().then {
        $0.text = CraftMate.Phrase.categoryString
        $0.font = CraftMate.CustomFont.bold13
        $0.textAlignment = .left
    }
    
    
    let categoryButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("버튼!", for: .normal)
    }
    
    let priceLabel = UILabel().then {
        $0.text = CraftMate.Phrase.priceString
        $0.font = CraftMate.CustomFont.bold13
        $0.textAlignment = .left
    }
    
    let priceTextField = UITextField().then {
        $0.placeholder = CraftMate.Phrase.pricePlaceholder
        $0.font = CraftMate.CustomFont.Light13
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
    }
    
    let contentsLabel = UILabel().then {
        $0.text = CraftMate.Phrase.explanationString
        $0.font = CraftMate.CustomFont.bold13
        $0.textAlignment = .left
    }
    
    let contentTextView = UITextView().then {
        $0.text = "설명설명설명설명"
        $0.textAlignment = .left
        $0.font = CraftMate.CustomFont.Light13
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CraftMate.color.LightGrayColor.cgColor
        $0.layer.cornerRadius = 5
   }
    
     let postImageView = UIImageView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(postImageView)
        addSubview(imageCollectionView)
        addSubview(titleLabel)
        addSubview(titleTextField)
        addSubview(categoryLabel)
        addSubview(categoryButton)
        addSubview(priceLabel)
        addSubview(priceTextField)
        addSubview(contentsLabel)
        addSubview(contentTextView)
    }
    
    override func configureLayout() {
//        postImageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
//            make.height.equalTo(30)
//        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.equalTo(categoryLabel.snp.leading)
            make.size.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(titleTextField)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(priceTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }

        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(contentsLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(200)
        }
        
    }
    
}
