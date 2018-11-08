//
//  CustomTabBarController.swift
//  CustomTabBarController
//
//  Created by Caio Ortu on 08/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    let customTabBar = CustomTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.isHidden = true
        setupCutomBar()
        didSetViewControllers()
    }
    
    private func setupCutomBar() {
        view.addSubview(customTabBar)
        NSLayoutConstraint.view(customTabBar, edgesTo: tabBar, insets: UIEdgeInsets(top: -9, left: 0, bottom: 0, right: 0))
    }
    
    override var viewControllers: [UIViewController]? { didSet { didSetViewControllers() } }
    
    fileprivate func didSetViewControllers() {
        var items = [CustomTabBarItem]()
        viewControllers?.forEach {
            let tabBarItem = CustomTabBarItem(title: $0.title, image: #imageLiteral(resourceName: "first"))
            items.append(tabBarItem)
        }
        customTabBar.items = items
    }
}
