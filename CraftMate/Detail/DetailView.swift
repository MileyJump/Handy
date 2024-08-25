//
//  DetailView.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import Then

final class DetailView: BaseView {
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "비즈공예 팔찌")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
