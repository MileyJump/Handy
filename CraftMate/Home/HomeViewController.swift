//
//  HomeController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "CraftMate"
        if let font = CraftMate.CustomFont.SemiBold20 {
            navigationController?.navigationBar.configureNavigationBarTitle(font: font, textColor: CraftMate.color.mainColor)
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationItem.title = "CraftMate"
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rootView.tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        return cell
    }
    
    
}
