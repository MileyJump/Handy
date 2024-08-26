//
//  SearchPageView.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import SnapKit

final class SearchPageView: BaseView {
    
     let searchBar = UISearchBar()
     let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    override func configureView() {
        backgroundColor = .white
        tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        tableView.rowHeight = 400
    }
}
