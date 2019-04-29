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
    enum State {
        case Expanded
        case Collapsed
    }
    
    let kCONTENT_XIB_NAME = "DishView"
    @IBOutlet weak var dishTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var contentView: UIView!
    private var currentState: State = State.Collapsed
    @IBOutlet weak var detailsParent: UIStackView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    let defaultHeight: CGFloat = 54
    let collapsedHeight: CGFloat = 22
    
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
    
    init(dish: Dish, state: State = State.Collapsed) {
        super.init(frame: CGRect())
        commonInit()
        
        self.dish = dish
        
        setCollapsedState(newState: state)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func switchCollapsedState() {
        if currentState == .Collapsed {
            setCollapsedState(newState: .Expanded)
        } else if currentState == .Expanded {
            setCollapsedState(newState: .Collapsed)
        }
    }
    
    func setCollapsedState(newState: State) {
        if newState == .Collapsed {
            detailsParent.isHidden = true
            heightConstraint.constant = collapsedHeight
            
        } else if newState == .Expanded {
            detailsParent.isHidden = false
            heightConstraint.constant = defaultHeight
        }
        
        currentState = newState
    }
}
