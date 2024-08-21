//
//  BaseViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView = RootView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        setupAddTarget()
        setupNavigationBar()
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func setupAddTarget() { }
    
    func setupNavigationBar() {
        
        
        navigationItem.backBarButtonItem?.tintColor = CraftMate.color.blackColor
        
        navigationItem.backButtonTitle = ""
    }
}
