//
//  NSLayoutConstraintExtention.swift
//  CustomTabBarController
//
//  Created by Caio Ortu on 08/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    enum LayoutEdge {
        case top
        case bottom
        case left
        case right
    }
    
    /// Anchor layout of view to anotherView edges
    ///
    /// - Parameters:
    ///   - view: the view that will be anchored to another view's edges
    ///   - anotherView: the view that will have another view anchored to its edges
    ///   - insets: the edge insets for the view to the anotherView
    ///   - excludedEdges: edges not to be layouted
    class func view(_ view: UIView, edgesTo anotherView: UIView, insets: UIEdgeInsets = .zero, excluding excludedEdges: [LayoutEdge] = []) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if !excludedEdges.contains(.left) {
            let leadingAnchor = view.leadingAnchor.constraint(equalTo: anotherView.leadingAnchor, constant: insets.left)
            leadingAnchor.isActive = true
            leadingAnchor.identifier = "LeadingAnchor"
        }
        
        if !excludedEdges.contains(.right) {
            let trailingAnchor = view.trailingAnchor.constraint(equalTo: anotherView.trailingAnchor, constant: -insets.right)
            trailingAnchor.isActive = true
            trailingAnchor.identifier = "TrailingAnchor"
        }
        
        if !excludedEdges.contains(.top) {
            let topAnchor = view.topAnchor.constraint(equalTo: anotherView.topAnchor, constant: insets.top)
            topAnchor.isActive = true
            topAnchor.identifier = "TopAnchor"
        }
        
        if !excludedEdges.contains(.bottom) {
            let bottomAnchor = view.bottomAnchor.constraint(equalTo: anotherView.bottomAnchor, constant: -insets.bottom)
            bottomAnchor.isActive = true
            bottomAnchor.identifier = "BottomAnchor"
        }
    }
    
    /// Anchor layout of view to anotherView center
    ///
    /// - Parameters:
    ///   - view: the view that will be anchored to another view's center
    ///   - anotherView: the view that will have another view anchored to its center
    ///   - offset: the x and y offset for the view to the anotherView center
    class func view(_ view: UIView, centerTo anotherView: UIView, offset: UIOffset = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXAnchor = view.centerXAnchor.constraint(equalTo: anotherView.centerXAnchor, constant: offset.horizontal)
        centerXAnchor.isActive = true
        centerXAnchor.identifier = "CenterXAnchor"
        
        let centerYAnchor = view.centerYAnchor.constraint(equalTo: anotherView.centerYAnchor, constant: offset.vertical)
        centerYAnchor.isActive = true
        centerYAnchor.identifier = "CenterYAnchor"
    }
    
    /// Anchor layout to superview edges
    ///
    /// - Parameters:
    ///   - view: the view that will be anchored to its superview's edges
    ///   - insets: the edge insets for the view to its superview
    ///   - excludedEdges: edges not to be layouted
    class func edgesToSuperview(_ aView: UIView, insets: UIEdgeInsets = .zero, excluding excludedEdges: [LayoutEdge] = []) {
        guard let viewSuperview = aView.superview else { return }
        view(aView, edgesTo: viewSuperview, insets: insets, excluding: excludedEdges)
    }
    
    /// Anchor layout to superview center
    ///
    /// - Parameters:
    ///   - view: the view that will be centered to its superview's center
    ///   - offset: the x and y offset for the view to its superview center
    class func centerToSuperview(_ aView: UIView, offset: UIOffset = .zero) {
        guard let viewSuperview = aView.superview else { return }
        view(aView, centerTo: viewSuperview, offset: offset)
    }
}
