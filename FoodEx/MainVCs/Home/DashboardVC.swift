//
//  DashboardVC
//  FoodEx
//
//  Created by Ivan Taranov on 3/27/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import UPCarouselFlowLayout
import CountdownLabel
import NVActivityIndicatorView

class DashboardVC: UIViewController, IndicatorInfoProvider {
    
    static var shared : DashboardVC? = nil
    
    @IBOutlet weak var nextMealTimer: CountdownLabel!
    @IBOutlet weak var nextDeliveringTimer: CountdownLabel!
    @IBOutlet weak var mealsParent: UIStackView!
    @IBOutlet weak var mealsParentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loader: NVActivityIndicatorView!
    var todayMeals: [Meal] = []
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Dashboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DashboardVC.shared = self
        
        nextMealTimer.setCountDownTime(minutes: 47 * 60)
        nextMealTimer.animationType = .Sparkle
        nextMealTimer.start()
//        nextMealTimer.timeFormat = "hh:mm"
        
        nextDeliveringTimer.setCountDownTime(minutes: 647 * 60)
        nextDeliveringTimer.animationType = .Sparkle
        nextDeliveringTimer.start()
        
        loader.startAnimating()
        
        Technical.callInSeconds(delay: 2.0, action: { () in
            self.loader.stopAnimating()
            
            self.getTodayMeals()
        })
//        nextDeliveringTimer.timeFormat = "hh:mm"
    }
    
    func getTodayMeals() {
        FireFunctions.callFunction(.getDayMeal, "", callback: { (dictResponse) in
            
            let dietDay = DietDay(dict: dictResponse)
            
            for meal in dietDay.meals {
                let mealView = MealView(meal: meal, state: .Default, dishesState: .Expanded)
                self.mealsParent.addArrangedSubview(mealView)
                //mealView.switchCollapseState()
                
                
                mealView.onHeightChanged.addHandler(uniqueName: "resizeMealParent", handler: {(newSize) in
                    self.mealsParentHeightConstraint.constant = newSize as! CGFloat
                })

                return
//                mealsCards.append(mealView)
            }
        })
    }
}
