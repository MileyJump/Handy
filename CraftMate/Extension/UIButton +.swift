//
//  UIButton +.swift
//  CraftMate
//
//  Created by 최민경 on 8/23/24.
//

import UIKit



extension UIButton {
    func configureIconButton(icon: String, size: CGFloat) {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            config.imagePlacement = .all
            config.imagePadding = 0
            config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: size)
            
            self.configuration = config
            self.contentHorizontalAlignment = .fill
            self.contentVerticalAlignment = .fill
        } else {
            // iOS 15 미만 버전을 위한 대체 코드
            print("??")
            self.setImage(UIImage(named: icon)?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
        }
    }
}

