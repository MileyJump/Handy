//
//  UINavigationBar +.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

extension UINavigationBar {
    func configureNavigationBarTitle(font: UIFont, textColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        
        // 타이틀 폰트와 색상 설정
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        // 네비게이션 바의 배경색, tint 색상 등 설정 (필요한 경우 추가)
        appearance.backgroundColor = .white  // 네비게이션 바 배경색 설정
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.font: font,  // 대형 타이틀의 폰트 설정 (선택 사항)
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        // 네비게이션 바에 appearance 적용
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
}
