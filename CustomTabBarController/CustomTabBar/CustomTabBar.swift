//
//  CustomTabBar.swift
//  CustomTabBarController
//
//  Created by Caio Ortu on 08/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class CustomTabBar: UIView {
    
    fileprivate weak var stackView: UIStackView?
    
    var items: [CustomTabBarItem]? { didSet { didSetItems() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setupStackView() {
        guard self.stackView == nil else { return }
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        self.stackView = stackView
    }
    
    fileprivate func setup() {
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        setupStackView()
    }
    
    fileprivate func didSetItems() {
        items?.forEach { [weak self] in
            self?.stackView?.addArrangedSubview($0)
        }
    }

}
