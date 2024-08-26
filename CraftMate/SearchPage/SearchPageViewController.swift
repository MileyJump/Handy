//
//  SearchPageViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

final class SearchPageViewController: BaseViewController<SearchPageView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        navigationItem.titleView = rootView.searchBar
    }
    
    override func configureView() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
}

extension SearchPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rootView.tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.identifier, for: indexPath) as! CommunityTableViewCell
        return cell
    }
}
