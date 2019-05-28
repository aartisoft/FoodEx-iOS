//
//  EmptyMealView.swift
//  FoodEx
//
//  Created by korsour on 5/20/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class EmptyMealView : UIView {
    
    let kCONTENT_XIB_NAME = "EmptyMealView"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var height: CGFloat {
        get {
            return heightConstraint.constant
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.4
    }
}
