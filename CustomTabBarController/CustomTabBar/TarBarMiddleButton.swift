//
//  TarBarMiddleButton.swift
//  CustomTabBarController
//
//  Created by Caio Ortu on 12/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class TarBarMiddleButton: UIControl {
    
    // MARK: - Properties
    var title: String? { didSet { titleLabel?.text = title } }
    var image: UIImage? { didSet { didSetImage() } }
    var selectedImage: UIImage? { didSet { didSetSelectedImage() } }
    var buttonFont: UIFont = .systemFont(ofSize: 10) { didSet { didSetButtonFont() } }
    var selectedButtonFont: UIFont = .systemFont(ofSize: 10, weight: .bold) { didSet { didSetSelectedButtonFont() } }
    var buttonFontColor: UIColor? { didSet { didSetButtonFontColor() } }
    var selectedButtonFontColor: UIColor? { didSet { didSetSelectedButtonFontColor() } }
    
    // MARK: - Private properties
    fileprivate weak var stackView: UIStackView?
    fileprivate weak var titleLabel: UILabel?
    fileprivate weak var imageView: UIImageView?
    
    // MARK: - Init
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
    
    // MARK: - Methods
    func setSelected(_ flag: Bool) {
        isSelected = flag
        imageView?.image = isSelected ? selectedImage: image
        titleLabel?.textColor = isSelected ? selectedButtonFontColor: buttonFontColor
        titleLabel?.font = isSelected ? selectedButtonFont: buttonFont
    }
    
    // MARK: - Private Methods
    fileprivate func setup() {
        setupStackView()
        backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    fileprivate func setupStackView() {
        guard self.stackView == nil else { return }
        let stackView = UIStackView()
        addSubview(stackView)
        NSLayoutConstraint.centerToSuperview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.isUserInteractionEnabled = false
        stackView.addArrangedSubview(setupImageView())
        stackView.addArrangedSubview(setupTitleLabel())
        self.stackView = stackView
    }
    
    fileprivate func setupImageView() -> UIImageView {
        guard self.imageView == nil else { return self.imageView! }
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.imageView = imageView
        return imageView
    }
    
    fileprivate func setupTitleLabel() -> UILabel {
        guard titleLabel == nil else { return self.titleLabel! }
        let label = UILabel()
        label.text = title
        label.font = buttonFont
        titleLabel = label
        return label
    }
    
    fileprivate func didSetImage() {
        if !isSelected {
            imageView?.image = image
        }
    }
    
    fileprivate func didSetSelectedImage() {
        if isSelected {
            imageView?.image = selectedImage
        }
    }
    
    fileprivate func didSetButtonFont() {
        if !isSelected {
            titleLabel?.font = buttonFont
        }
    }
    
    fileprivate func didSetSelectedButtonFont() {
        if isSelected {
            titleLabel?.font = selectedButtonFont
        }
    }
    
    fileprivate func didSetButtonFontColor() {
        if !isSelected {
            titleLabel?.textColor = buttonFontColor
        }
    }
    
    fileprivate func didSetSelectedButtonFontColor() {
        if isSelected {
            titleLabel?.textColor = selectedButtonFontColor
        }
    }
}
