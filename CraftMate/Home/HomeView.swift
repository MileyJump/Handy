//
//  HomeView.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
        tableView.backgroundColor = .blue
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
            
        }
    }
    
    override func configureView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
        tableView.rowHeight = 400
    }
    
    
    
}

