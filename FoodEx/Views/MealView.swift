//
//  DishCard.swift
//  FoodEx
//
//  Created by korsour on 4/20/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

class MealView : UIView {
    
    enum State {
        case Expanded
        case Collapsed
    }
    
    let kCONTENT_XIB_NAME = "MealView"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var card: Card!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var rowsParent: UIStackView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var detailsParent: UIStackView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinsLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var carboLabel: UILabel!
    
    var onHeightChanged = Event<Any>()
    
    var dishCardRows: [DishView] = []
    var meal: Meal = Meal()
    var currentState = State.Expanded
    var currentDishesState = DishView.State.Collapsed
    
    var height: CGFloat {
        get {
            var dishViewsHeight: CGFloat = 0
            
            for dishView in dishCardRows {
                dishViewsHeight += dishView.height
            }
            
//            return heightConstraint.constant + dishViewsHeight
            return defaultHeight + dishViewsHeight
        }
    }
    
    var defaultHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(meal: Meal, state: State = State.Expanded, dishesState: DishView.State = .Collapsed) {
        super.init(frame: CGRect())
        commonInit()
        
        showSkeleton()
        
        
        Technical.callInSeconds(delay: 2.0, action: {() in
            self.setMeal(meal: meal)
            self.stopSkeleton()
            
            
            self.onHeightChanged.raise(data: self.height)
        })

        
        currentDishesState = dishesState
        setNewState(state: state)
    }
    
    func setMeal(meal: Meal) {
        self.meal = meal
        
        for dish in meal.dishes {
            addDishCardRow(dish: dish)
        }
        
        title.text = meal.title
        time.text = meal.time
        icon.image = meal.icon
        
        carboLabel.text = String(meal.carbo)
        caloriesLabel.text = String(meal.calories)
        fatsLabel.text = String(meal.fats)
        proteinsLabel.text = String(meal.proteins)
        weightLabel.text = String(meal.weight)
        
        self.card.stripe.backgroundColor = meal.color
    }
    
    func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
//        defaultHeight = self.frame.height
        defaultHeight = heightConstraint.constant
        
        
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.4
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.onClick (_:)))
        self.addGestureRecognizer(gesture)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//        }
    }
    
    @objc func onClick(_ sender:UITapGestureRecognizer){
        //switchCollapseState()
    }
    
    func addDishCardRow(dish: Dish) {
        let dishCardRow = DishView(dish: dish, state: currentDishesState)
        //imageView.caption = "CodePath starts new class for designers"
        rowsParent.addArrangedSubview(dishCardRow)
        dishCardRows.append(dishCardRow)
        
        heightConstraint.constant = height
        //self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height + dishCardRow.frame.height)
    }
    
    func showSkeleton() {
        title.text = ""
        time.text = ""
        
        card.showAnimatedGradientSkeleton()
    }
    
    func stopSkeleton() {
        
        card.hideSkeleton()
    }
    
    func switchCollapseState() {
        if currentState == .Collapsed {
            currentState = .Expanded
        } else {
            currentState = .Collapsed
        }
        
        setNewState(state: currentState)
    }
        
        
    func setNewState(state: State) {
        if state == .Collapsed {
            UIView.animate(withDuration: 1,
                           delay: 0.0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1,
                           options: [UIView.AnimationOptions.allowAnimatedContent], animations: {
                            self.heightConstraint.constant = self.height - 15
                            
                            //                self.rowsParent.isHidden = true
                            self.detailsParent.isHidden = true
                            self.setNeedsLayout()
                            self.layoutIfNeeded()
                            
                            DashboardVC.shared!.mealsParent.setNeedsLayout()
                            DashboardVC.shared!.mealsParent.layoutIfNeeded()
            })
        } else if state == .Expanded {
            UIView.animate(withDuration: 1,
                           delay: 0.0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1,
                           options: [], animations: {
                            self.heightConstraint.constant = self.height
                            //                self.rowsParent.isHidden = false
                            self.detailsParent.isHidden = false
                            
                            self.setNeedsLayout()
                            self.layoutIfNeeded()
                            DashboardVC.shared!.mealsParent.setNeedsLayout()
                            DashboardVC.shared!.mealsParent.layoutIfNeeded()
            })
        }
    }
}
