//
//  DishCardRow.swift
//  FoodEx
//
//  Created by korsour on 4/21/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class DishView : UIView {
    let kCONTENT_XIB_NAME = "DishView"
    @IBOutlet weak var dishTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    var _dish: Dish = Dish()
    var dish : Dish {
        get {
            return _dish
        }
        set {
            _dish = newValue
            
            dishTypeLabel.text = newValue.dishType.str + ":"
            nameLabel.text = newValue.name
        }
    }
    
    var height: CGFloat {
        get {
            return nameLabel.frame.height
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
    
    init(dish: Dish) {
        super.init(frame: CGRect())
        commonInit()
        
        self.dish = dish
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
}
