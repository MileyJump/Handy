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
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
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
    
    let buttonTitles = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    
    lazy var categoryView = CategoryButtonView(buttonTitles: buttonTitles)
    
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
        $0.text = "천연 재료로 만든 수제 캔들로, 향기로운 분위기를 연출합니다. 이 캔들은 100% 천연 소이 왁스와 고급 에센셜 오일로 제작되어, 건강하고 지속적인 향을 제공합니다. \n 불을 켜는 순간 은은하게 퍼지는 향이 마음을 편안하게 해주며, 공간을 아늑하게 만듭니다. \n 이 캔들은 집들이 선물이나 특별한 날의 기념품으로도 훌륭하며, 사랑하는 이에게 따뜻한 마음을 전하는 선물이 될 것입니다. 더욱 건강하고 자연 친화적인 생활을 원하는 분들에게 추천드립니다."
        $0.textColor = CraftMate.color.MediumGrayColor
        $0.textAlignment = .left
        $0.font = CraftMate.CustomFont.Light13
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CraftMate.color.LightGrayColor.cgColor
        $0.layer.cornerRadius = 5
   }
    
    let hashTagLabel = UILabel().then {
        $0.text = CraftMate.Phrase.hashTagStirng
        $0.font = CraftMate.CustomFont.bold13
        $0.textAlignment = .left
    }
    
    let hashTagTextField = UITextField().then {
        $0.placeholder = "#리폼가방 #천연섬유 #수공예 #업사이클링 #친환경"
        $0.font = CraftMate.CustomFont.Light13
        $0.borderStyle = .roundedRect
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextField)
        contentView.addSubview(categoryLabel)
        
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceTextField)
        contentView.addSubview(contentsLabel)
        contentView.addSubview(contentTextView)
//        addSubview(categoryCollectionView)
        contentView.addSubview(categoryView)
        
        contentView.addSubview(hashTagLabel)
        contentView.addSubview(hashTagTextField)
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }


        imageCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview()
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
        
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(15)
//            make.leading.equalTo(categoryLabel.snp.leading)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).offset(20)
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
        
        hashTagLabel.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }
        hashTagTextField.snp.makeConstraints { make in
            make.top.equalTo(hashTagLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(titleTextField)
            make.bottom.equalToSuperview().inset(20)
        }
        
    }
    
}
