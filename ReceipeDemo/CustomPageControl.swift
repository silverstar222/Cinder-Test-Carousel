//
//  CustomPageControl.swift
//  ReceipeDemo
//
//  Created by Andy Castro on 26/07/19.
//  Copyright © 2019 Acquaint. All rights reserved.
//

import UIKit

import UIKit

class CustomPageControl: UIPageControl {
    
    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        super.sendAction(action, to: target, for: event)
        updateDots()
    }
    
    private func updateDots() {
        let currentDot = subviews[currentPage]
        let largeScaling = CGAffineTransform(scaleX: 1.5, y: 1)
        let smallScaling = CGAffineTransform(scaleX: 1.0, y: 1.0)
        currentDot.layer.cornerRadius = currentDot.bounds.height / 4
        subviews.forEach {
            $0.transform = $0 == currentDot ? largeScaling : smallScaling
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        rewriteConstraints()
    }
    
    private func rewriteConstraints() {
        let systemDotSize: CGFloat = 10.0
        let systemDotDistance: CGFloat = 20.0
        
        let halfCount = CGFloat(subviews.count) / 2
        subviews.enumerated().forEach {
            let dot = $0.element
            dot.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.deactivate(dot.constraints)
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: systemDotSize),
                dot.heightAnchor.constraint(equalToConstant: systemDotSize),
                dot.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
                dot.centerXAnchor.constraint(equalTo: centerXAnchor, constant: systemDotDistance * (CGFloat($0.offset) - halfCount))
                ])
        }
    }
}
