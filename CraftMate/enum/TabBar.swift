//
//  TabBar.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//
import UIKit

enum MainTabBar {
    
    case mainHome
    case searchPage
    case savePage
    case setting
    
    var viewController: UIViewController {
        switch self {
        case .mainHome:
            return HomeViewController()
        case .searchPage:
            return SearchPageViewController()
        case .savePage:
            return SaveViewController()
        case .setting:
            return SettingViewController()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(named: CraftMate.Phrase.homeImage)
        case .searchPage:
            return UIImage(named:CraftMate.Phrase.searchImage)
        case .savePage:
            return UIImage(named: CraftMate.Phrase.saveImage)
        case .setting:
            return UIImage(named: CraftMate.Phrase.myPageImage)
        }
    }
    
    var selectImage: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(named: CraftMate.Phrase.homeSelectImage)
        case .searchPage:
            return UIImage(named:CraftMate.Phrase.searchImage)
        case .savePage:
            return UIImage(named: CraftMate.Phrase.saveSelectImage)
        case .setting:
            return UIImage(named: CraftMate.Phrase.myPageSelectImage)
        }
    }
}
