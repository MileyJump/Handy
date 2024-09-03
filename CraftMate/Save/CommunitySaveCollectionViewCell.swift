//
//  CommunitySaveCollectionViewCell.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import Then
import SnapKit

final class CommunitySaveCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "비즈공예 팔찌")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func configureCell(_ data: Post) {
        
        if let data = data.files {
            data.forEach { link in
                NetworkManager.shared.readImage(urlString: link) { [weak self] data in
                    if let data {
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    
    }
    
    override func configureHierarchy() {
        addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
