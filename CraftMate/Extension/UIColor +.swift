//
//  UIColor +.swift
//  CraftMate
//
//  Created by 최민경 on 8/15/24.
//

import UIKit

enum CraftMate { }

extension CraftMate {
    enum color {
//        static let mainColor = UIColor(hexCode: "BCE365") // 초록
        static let mainColor = UIColor(hexCode: "3FA2F6") // 하늘
        static let darkGrayColor = UIColor(hexCode: "4D5652")
        static let MediumGrayColor = UIColor(hexCode: "8C8C8C")
        static let LightGrayColor = UIColor(hexCode: "F2F2F2")
        static let blackColor = UIColor(hexCode: "000000")
        static let whiteColor = UIColor(hexCode: "FFFFFF")
        
        
    }
}

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
