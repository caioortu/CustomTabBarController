//
//  CustomTabBarItem.swift
//  CustomTabBarController
//
//  Created by Caio Ortu on 08/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class CustomTabBarItem: UIView {
    var isEnabled: Bool = true
    var title: String? { didSet { titleLabel?.text = title?.uppercased() } }
    var image: UIImage? { didSet { imageView?.image = image } }
    var selectedImage: UIImage?
    
    fileprivate weak var titleLabel: UILabel?
    fileprivate weak var imageView: UIImageView?
    
    convenience init(title: String?, image: UIImage? = nil, selectedImage: UIImage? = nil) {
        self.init()
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        setupImageView()
        setupTitleLabel()
    }
    
    fileprivate func setupImageView() {
        guard self.imageView == nil else { return }
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.imageView = imageView
    }
    
    fileprivate func setupTitleLabel() {
        guard titleLabel == nil else { return }
        guard let imageView = imageView else { return }
        let label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7).isActive = true
        label.text = title?.uppercased()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        titleLabel = label
    }
}
