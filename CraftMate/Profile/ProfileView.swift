//
//  ProfileView.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import Then
import SnapKit

final class ProfileView: BaseView {
    
    private let topLineView = UIView().then {
        $0.backgroundColor = CraftMate.color.LightGrayColor
    }
    
    let profileImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
