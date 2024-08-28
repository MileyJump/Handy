//
//  ReviewView.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit
import Then
import SnapKit

final class ReviewView: BaseView {
    
    let tableView = UITableView()
    
    let textField = UITextField().then {
        $0.placeholder = "남겨보세요!"
        $0.font = CraftMate.CustomFont.regular14
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
        addSubview(textField)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(100)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
