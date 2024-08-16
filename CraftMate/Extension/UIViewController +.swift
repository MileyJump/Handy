//
//  UIViewController +.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

extension UIViewController {
    
    func changeRootViewController(_ rootViewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let window = (windowScene.delegate as? SceneDelegate)?.window else { return }
        if let _ = rootViewController as? UITabBarController {
            window.rootViewController = rootViewController
        } else {
            let navigationController = UINavigationController(rootViewController: rootViewController)
            
            window.rootViewController = navigationController
        }
        
        window.makeKeyAndVisible()
        
    }
}
