//
//  FloatingButton.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import Then

final class FloatingButton: UIView {
    
    let floatingButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        $0.backgroundColor = CraftMate.color.mainColor
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        $0.setImage(image, for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(.white, for: .normal)
        $0.layer.shadowRadius = 10
        $0.layer.shadowOpacity = 0.2
        $0.layer.cornerRadius = 30
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(floatingButton)
    }
}

