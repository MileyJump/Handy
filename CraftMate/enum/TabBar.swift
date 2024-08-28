//
//  TabBar.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//
import UIKit

enum MainTabBar {
    
    case mainHome
    case community
    case savePage
    case setting
    
    var viewController: UIViewController {
        switch self {
        case .mainHome:
            return HomeContentViewController()
        case .community:
            return CommunityViewController()
        case .savePage:
            return SaveViewController()
        case .setting:
            return SettingViewController()
        }
    }
    
    var title: String {
        switch self {
        case .mainHome:
            return CraftMate.Phrase.homeTabBar
        case .savePage:
            return CraftMate.Phrase.saveTabBar
        case .setting:
            return CraftMate.Phrase.myPageTabBar
        case .community:
            return CraftMate.Phrase.communityTabBar
        }
    }
    
    var image: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(systemName: CraftMate.Phrase.homeImage)
        case .savePage:
            return UIImage(systemName: CraftMate.Phrase.saveImage)
        case .setting:
            return UIImage(systemName: CraftMate.Phrase.myPageImage)
        case .community:
            return UIImage(systemName: CraftMate.Phrase.communityImage)
        }
    }
    
    var selectImage: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(systemName: CraftMate.Phrase.homeSelectImage)
        case .savePage:
            return UIImage(systemName: CraftMate.Phrase.saveSelectImage)
        case .setting:
            return UIImage(systemName: CraftMate.Phrase.myPageSelectImage)
        case .community:
            return UIImage(systemName: CraftMate.Phrase.communitySelectImage)
        }
    }
}
