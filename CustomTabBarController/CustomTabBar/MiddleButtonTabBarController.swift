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
    @IBInspectable var itemFontColor: UIColor? { didSet { tabBar.unselectedItemTintColor = itemFontColor } }
    @IBInspectable var selectedItemFontColor: UIColor? { didSet { tabBar.tintColor = selectedItemFontColor } }
    @IBInspectable var middleButtonFontColor: UIColor? { didSet { middleButton?.buttonFontColor = middleButtonFontColor } }
    @IBInspectable var selectedMiddleButtonFontColor: UIColor? { didSet { middleButton?.selectedButtonFontColor = selectedMiddleButtonFontColor } }
    @IBInspectable var middleButtonColor: UIColor? { didSet { middleButton?.backgroundColor = middleButtonColor } }
    
    // MARK: - Private properties
    fileprivate var itemFont: UIFont = .systemFont(ofSize: 10)
    fileprivate var selectedItemFont: UIFont = .systemFont(ofSize: 10, weight: .bold)
    fileprivate var middleButtonFont: UIFont = .systemFont(ofSize: 10)
    fileprivate var selectedMiddleButtonFont: UIFont = .systemFont(ofSize: 10, weight: .bold)
    fileprivate weak var middleButton: TarBarMiddleButton?
    fileprivate var middleIndex: Int?
    
    // MARK: - Override properties
    override var viewControllers: [UIViewController]? { didSet { didSetViewControllers() } }
    override var selectedViewController: UIViewController? { willSet { willSetSelectedViewController() }
        didSet { didSetSelectedViewController() } }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didSetSelectedViewController()
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
    
    func setMiddleButtonFont(_ font: UIFont) {
        middleButtonFont = font
        middleButton?.buttonFont = font
    }
    
    func setSelectedMiddleButtonFont(_ font: UIFont) {
        selectedMiddleButtonFont = font
        middleButton?.selectedButtonFont = font
    }
    
    // MARK: - Private Methods
    fileprivate func setup() {
        didSetViewControllers()
    }
    
    fileprivate func didSetViewControllers() {
        guard let viewControllers = viewControllers else { return }
        for viewController in viewControllers {
            let tabBarItem = UITabBarItem(title: viewController.tabBarItem.title,
                                          image: viewController.tabBarItem.image?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: viewController.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal))
            viewController.tabBarItem = tabBarItem
        }
        if viewControllers.count % 2 != 0 {
            let middleIndex = viewControllers.count / 2
            let tabBarItem = viewControllers[middleIndex].tabBarItem
            setupMiddleButton(title: tabBarItem?.title, image: tabBarItem?.image, selectedImage: tabBarItem?.selectedImage)
            self.middleIndex = middleIndex
        }
    }
    
    fileprivate func willSetSelectedViewController() {
        selectedViewController?.tabBarItem.setTitleTextAttributes([.font: itemFont], for: .normal)
    }
    
    fileprivate func didSetSelectedViewController() {
        guard let middleIndex = middleIndex, selectedViewController == viewControllers?[middleIndex] else {
            middleButton?.setSelected(false)
            selectedViewController?.tabBarItem.setTitleTextAttributes([.font: selectedItemFont], for: .normal)
            guard let middleButton = middleButton else { return }
            tabBar.bringSubviewToFront(middleButton)
            return
        }
        middleButton?.setSelected(true)
    }
    
    fileprivate func setupMiddleButton(title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil) {
        let height: CGFloat = 78
        let middleButton = TarBarMiddleButton(title: title, image: image, selectedImage: selectedImage)
        tabBar.addSubview(middleButton)
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.centerYAnchor.constraint(equalTo: tabBar.layoutMarginsGuide.centerYAnchor).isActive = true
        middleButton.centerXAnchor.constraint(equalTo: tabBar.layoutMarginsGuide.centerXAnchor).isActive = true
        middleButton.widthAnchor.constraint(equalToConstant: height).isActive = true
        middleButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        middleButton.backgroundColor = middleButtonColor
        middleButton.buttonFont = middleButtonFont
        middleButton.selectedButtonFont = selectedMiddleButtonFont
        middleButton.buttonFontColor = middleButtonFontColor
        middleButton.selectedButtonFontColor = selectedMiddleButtonFontColor
        middleButton.layer.cornerRadius = height / 2.0
        middleButton.layer.masksToBounds = true
        middleButton.addTarget(self, action: #selector(middleButtonTouchUpInside), for: .touchUpInside)
        self.middleButton = middleButton
    }
    
    @objc fileprivate func middleButtonTouchUpInside(_ sender: Any) {
        guard let middleIndex = middleIndex else { return }
        guard let viewControllers = viewControllers else { return }
        selectedViewController = viewControllers[middleIndex]
    }
}
