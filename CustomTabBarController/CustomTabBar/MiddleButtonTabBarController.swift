//
//  MiddleButtonTabBarController.swift
//  CustomTabBarController
//
//  Created by Caio Ortu on 12/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class MiddleButtonTabBarController: UITabBarController {
    
    // MARK: - Properties
    @IBInspectable var itemFontColor: UIColor? { didSet { didSetItemFontColor() } }
    @IBInspectable var selectedItemFontColor: UIColor? { didSet { didSetSelectedItemFontColor() } }
    
    // MARK: - Private properties
    fileprivate var itemFont: UIFont = .systemFont(ofSize: 10)
    fileprivate var selectedItemFont: UIFont = .systemFont(ofSize: 10, weight: .bold)
    
    // MARK: - Override properties
    override var viewControllers: [UIViewController]? { didSet { didSetViewControllers() } }
    override var selectedViewController: UIViewController? { willSet { willSetSelectedViewController() }
                                                             didSet { didSetSelectedViewController() } }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Methods
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
    
    
    // MARK: - Private Methods
    fileprivate func setup() {
        didSetViewControllers()
        didSetSelectedViewController()
    }
    
    fileprivate func didSetViewControllers() {
        for viewController in (viewControllers ?? []) {
            let tabBarItem = UITabBarItem(title: viewController.tabBarItem.title,
                                          image: viewController.tabBarItem.image?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: viewController.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal))
            viewController.tabBarItem = tabBarItem
        }
    }
    
    fileprivate func didSetItemFontColor() {
        tabBar.unselectedItemTintColor = itemFontColor
    }
    
    fileprivate func didSetSelectedItemFontColor() {
        tabBar.tintColor = selectedItemFontColor
    }
    
    fileprivate func willSetSelectedViewController() {
        selectedViewController?.tabBarItem.setTitleTextAttributes([.font: itemFont], for: .normal)
    }
    
    fileprivate func didSetSelectedViewController() {
        selectedViewController?.tabBarItem.setTitleTextAttributes([.font: selectedItemFont], for: .normal)
    }
}
