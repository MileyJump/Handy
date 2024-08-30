//
//  OrderView.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit
import SnapKit

final class CommunityView: BaseView {
    
    let tableView = UITableView()
    let floatingButton = FloatingButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
        addSubview(floatingButton)
    }
    
    override func configureView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = CraftMate.color.whiteColor
    }
    
    override func configureLayout() {

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.size.equalTo(60)
        }
    }

}
