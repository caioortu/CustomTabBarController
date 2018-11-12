//
//  MiddleButtonTabBarController.swift
//  CustomTabBarController
//
//  Created by Caio Ortu on 12/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class MiddleButtonTabBarController: UITabBarController {
    
    fileprivate var itemFont: UIFont = .systemFont(ofSize: 10)
    fileprivate var selectedItemFont: UIFont = .systemFont(ofSize: 10, weight: .bold)
    
    override var viewControllers: [UIViewController]? { didSet { didSetViewControllers() } }
    override var selectedViewController: UIViewController? { willSet { willSetSelectedViewController() }
        didSet { didSetSelectedViewController() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didSetSelectedViewController()
    }
    
    func setItemFont(_ font: UIFont) {
        itemFont = font
        for viewController in (viewControllers ?? []) {
            if viewController == selectedViewController { continue }
            viewController.tabBarItem.setTitleTextAttributes([.font: font], for: .normal)
        }
    }
    
    func setSelectedItemFont(_ font: UIFont) {
        selectedItemFont = font
        selectedViewController?.tabBarItem.setTitleTextAttributes([.font: font], for: .normal)
    }
    
    fileprivate func didSetViewControllers() {
        for viewController in (viewControllers ?? []) {
            let tabBarItem = UITabBarItem(title: viewController.tabBarItem.title,
                                          image: viewController.tabBarItem.image?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: viewController.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal))
            viewController.tabBarItem = tabBarItem
        }
    }
    
    fileprivate func willSetSelectedViewController() {
        selectedViewController?.tabBarItem.setTitleTextAttributes([.font: itemFont], for: .normal)
    }
    
    fileprivate func didSetSelectedViewController() {
        selectedViewController?.tabBarItem.setTitleTextAttributes([.font: selectedItemFont], for: .normal)
    }
}
