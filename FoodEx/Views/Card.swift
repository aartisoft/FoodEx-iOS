//
//  Card.swift
//  FoodEx
//
//  Created by korsour on 4/21/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class Card : UIView {
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 10.0
    private var shadowRadius: CGFloat = 5
    private var shadowOpacity: Float = 0.3
    private var fillColor: UIColor = .white
    var stripe: UIView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            layer.cornerRadius = cornerRadius
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
        
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        stripe.backgroundColor = UIColor.primary
        self.addSubview(stripe)
        
        stripe.translatesAutoresizingMaskIntoConstraints = false
        
        let leftConstraint = NSLayoutConstraint(item: stripe, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: stripe, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: stripe, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: stripe, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: cornerRadius)
        self.addConstraints([leftConstraint, topConstraint, bottomConstraint, widthConstraint])
        
        clipsToBounds = true
    }
}
