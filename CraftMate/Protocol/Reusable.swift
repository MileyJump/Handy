//
//  Reusable.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIView: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

