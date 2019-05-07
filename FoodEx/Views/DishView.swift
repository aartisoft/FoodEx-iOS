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
    private var currentState: State = State.Collapsed
    @IBOutlet weak var dishTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var detailsParent: UIStackView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinsLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var carboLabel: UILabel!
    
    let defaultHeight: CGFloat = 60
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
            carboLabel.text = String(newValue.carbo)
            caloriesLabel.text = String(newValue.calories)
            fatsLabel.text = String(newValue.fats)
            proteinsLabel.text = String(newValue.proteins)
            weightLabel.text = String(newValue.weight)
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
        contentView.fixInView(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        contentView.fixInView(self)
    }
    
    init(dish: Dish, state: State = State.Collapsed) {
        super.init(frame: CGRect())
        commonInit()
        
        self.dish = dish
        
        setCollapsedState(newState: state)
        contentView.fixInView(self)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
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
