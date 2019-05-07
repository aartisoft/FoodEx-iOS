//
//  ProgramView.swift
//  FoodEx
//
//  Created by korsour on 4/28/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class ProgramView: UIView {
    let kCONTENT_XIB_NAME = "ProgramView"
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var shortDescription: UILabel!
    @IBOutlet var cost: UILabel!
    @IBOutlet var actionButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet var contentView : UIView!
    var _program: Program? = nil
    var program: Program? {
        get {
            return _program
        }
        set {
            _program = newValue
            title.text = newValue?.name
            shortDescription.text = newValue?.shortDescription
            //cost.text = newValue.price
            image.image = newValue?.image
        }
    }
    
    var height: CGFloat {
        get {
            return heightConstraint.constant
        }
    }
    
    @IBAction func openLink(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: _program!.link)! as URL)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(program: Program) {
        super.init(frame: CGRect())
        commonInit()
        
        self.program = program
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 0.4
        
        actionButton.layer.borderColor = UIColor(hex: 0xE1101B).cgColor

        //contentView.fixInView(self)
    }
}
