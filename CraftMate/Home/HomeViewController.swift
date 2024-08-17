//
//  HomeController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController<HomeView> {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        NetworkManager.shared.postRetrieval()
        bind()
    }
    
    func bind() {
        rootView.floatingButton.floatingButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(WritePostViewController(), animated: true)
            }
            .disposed(by: disposeBag)
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
