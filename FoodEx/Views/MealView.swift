//
//  DishCard.swift
//  FoodEx
//
//  Created by korsour on 4/20/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class MealView : UIView {
    let kCONTENT_XIB_NAME = "MealView"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var card: Card!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var rowsParent: UIStackView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var icon: UIImageView!
    
    var dishCardRows: [DishView] = []
    var meal: Meal = Meal()
    
    var height: CGFloat {
        get {
            var dishViewsHeight: CGFloat = 0
            
            for dishView in dishCardRows {
                dishViewsHeight += dishView.height
            }
            
            return heightConstraint.constant + dishViewsHeight
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
    
    init(meal: Meal) {
        super.init(frame: CGRect())
        commonInit()
        
        self.meal = meal
        
        for var dish in meal.dishes {
            addDishCardRow(dish: dish)
        }
        
        title.text = meal.title
        time.text = meal.time
        icon.image = meal.icon
        
        self.card.stripe.backgroundColor = meal.color
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func addDishCardRow(dish: Dish) {
        let dishCardRow = DishView(dish: dish)
        //imageView.caption = "CodePath starts new class for designers"
        rowsParent.addArrangedSubview(dishCardRow)
        dishCardRows.append(dishCardRow)
        
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height + dishCardRow.frame.height)
    }
}
