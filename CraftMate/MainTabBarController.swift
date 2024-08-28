//
//  MainTabBarController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabs: [MainTabBar] = [.mainHome, .community, .savePage, .setting]
        
//        var viewControllers: [UINavigationController] = []
//        var viewControllers = tabs.map { $0.viewController }
        var viewControllers: [UIViewController] = []
        
        for (index, tabBar) in tabs.enumerated() {
            let vc = tabBar.viewController
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: tabBar.title, image: tabBar.image, tag: index)
            nav.tabBarItem.selectedImage = tabBar.selectImage
            viewControllers.append(nav)
        }
        
        setViewControllers(viewControllers, animated: true)
        tabBar.tintColor = CraftMate.color.blackColor
    }
}
