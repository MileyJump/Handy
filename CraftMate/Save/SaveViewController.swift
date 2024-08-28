//
//  SaveViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import Tabman
import Pageboy

final class SaveViewController: TabmanViewController {
    
    //   let disposeBag = DisposeBag()
    
    var items = ["구매", "커뮤니티"]
    
    // 탭을 통해 보여줄 뷰 컨트롤러들
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 각 탭에 연결될 ViewController들을 초기화
        setupViewControllers()
        
        // PageboyViewController의 데이터 소스를 self로 설정
        self.dataSource = self
        
        // Tabman의 탭 바 설정
        setupTabBar()
        setupNavigationBar()
    }
    

    func setupNavigationBar() {
        
        navigationItem.title = "좋아요"
        if let font = CraftMate.CustomFont.SemiBold16 {
            navigationController?.navigationBar.configureNavigationBarTitle(font: font, textColor: CraftMate.color.blackColor)
        }
    }
    
   
    
    private func setupViewControllers() {
     
        let orderSaveVC = OrderSaveViewController()
        let communitySaveVC = CommunitySaveViewController()
        
        viewControllers = [orderSaveVC, communitySaveVC] // 각 탭에 연결될 뷰 컨트롤러 추가
    }
    
    private func setupTabBar() {
        let bar = TMBar.ButtonBar()
        
        let systemBar = bar.systemBar()
        
        bar.layout.contentMode = .fit
        
        bar.backgroundColor = .white
        
        bar.layout.transitionStyle = .snap
        
        bar.buttons.customize { button in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.font = CraftMate.CustomFont.regular13 ?? UIFont.systemFont(ofSize: 13)
            button.backgroundColor = .white
        }
        
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        bar.indicator.tintColor = .black
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    
}

extension SaveViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: items[index])  // 탭의 제목 설정
    }
}

    

