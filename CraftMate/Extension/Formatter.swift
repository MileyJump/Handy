//
//  Formatter.swift
//  CraftMate
//
//  Created by 최민경 on 8/29/24.
//

import UIKit

extension Formatter {
    
    // 3자리 콤마
    static func decimalNumberFormatter(number: Int) -> String {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let result: String = numberFormatter.string(for: number) else { return "" }
        return result
    }
}
