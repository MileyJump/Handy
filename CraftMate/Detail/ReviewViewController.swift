//
//  ReviewViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit

final class ReviewViewController: BaseViewController<ReviewView> {
    
    var post: Post?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
