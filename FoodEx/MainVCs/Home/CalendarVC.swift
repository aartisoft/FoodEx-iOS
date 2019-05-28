//
//  Weight.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/26/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar
import XLPagerTabStrip

class CalendarVC : UIViewController, IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Calendar")
    }
    
    static var shared : CalendarVC? = nil
    
    var calendarDataSource: [String:String] = [:]
    let formatter = DateFormatter()
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var parentStack: UIStackView!
    @IBOutlet weak var mealsCardsParent: UIStackView!
    @IBOutlet weak var stackHeightConstraint: NSLayoutConstraint!
    
    var mealsCards: [MealView] = []
    var stackHeightDefault: CGFloat = 0
    var emptyMealView: EmptyMealView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CalendarVC.shared = self
        
        stackHeightDefault = self.stackHeightConstraint.constant
        
        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.selectDates([ Date() ])
        
        setupCalendarView()
        
        getDietDays()
    }
    
    func setupCalendarView() {
        // setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //Setup labels
        calendarView.visibleDates { (visibleDate) in
            self.setupViewsOfCalendar(from: visibleDate)
        }
    }

    
    func sharedFunctionToConfigureCell(validCell: CalendarDietCell, cellState: CellState, date: Date) {
        let todaysDate = Date()
        formatter.dateFormat = "yyyy MM dd"
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        validCell.selectedCircle.isHidden = !cellState.isSelected
        
        if cellState.isSelected {
            let dateString = formatter.string(from: cellState.date)
            if calendarDataSource[dateString] != nil {
                showDayMeals(date: date)
            } else {
                showNoDataCard()
            }
            validCell.dateLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                if todaysDateString == monthDateString {
                    validCell.dateLabel.textColor = UIColor.primaryDark
                } else {
                    validCell.dateLabel.textColor = UIColor.darkGrayKor
                }
                
                handleCellEvents(validCell: validCell, cellState: cellState)
            } else {
                validCell.dateLabel.textColor = UIColor.lightGrayKor
            }
        }
    }
    
    
    func handleCellEvents(validCell: CalendarDietCell, cellState: CellState) {
        let dateString = formatter.string(from: cellState.date)
        if calendarDataSource[dateString] != nil {
            validCell.dateLabel.textColor = UIColor.primary
        }
    }
    
    
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
    
    
    func addMealCard(mealCard: Meal) {
        let mealView = MealView(meal: mealCard, state: .Expanded, dishesState: .Collapsed)
        mealsCardsParent.addArrangedSubview(mealView)
        mealsCards.append(mealView)
        
        stackHeightConstraint.constant += mealView.height + mealsCardsParent.spacing
        mealView.onHeightChanged.addHandler(uniqueName: "recalculateMealsHeight", handler:
            {(newHeight) in
                self.recalculateMealsHeight()
        })
    }
    
    func recalculateMealsHeight() {
        stackHeightConstraint.constant = stackHeightDefault
        let a = Float(stackHeightDefault)
        for meal in mealsCards {
            stackHeightConstraint.constant += meal.height + mealsCardsParent.spacing
        }
    }
    
    
    func showMonthCalendar(dietDays: [Int]) {
        self.formatter.dateFormat = "yyyy MM dd"
        for day in dietDays {
            let day = Date(timeIntervalSince1970: Double(day / 1000))
            calendarDataSource[formatter.string(from: day)] = "lalala"
        }
        
        calendarView.reloadData()
        calendarView.scrollToDate(Date(), animateScroll: false)
        setupCalendarView()
    }
}

extension CalendarVC {
    func getDietDays() {
        
//        var dishes: [Dish] = []
//        let dish0 = Dish(dishType: Dish.DishType.Hotter, name: "Some Hotter")
//        let dish1 = Dish(dishType: Dish.DishType.Salad, name: "Some Salad")
//        let dish2 = Dish(dishType: Dish.DishType.Drink, name: "Some Drink")
//
//        dishes.append(dish0)
//        dishes.append(dish1)
//        dishes.append(dish2)
//
//        let meal0 = Meal(dayTime: Meal.DayTime.Breakfast, dishes: dishes)
//        let meal1 = Meal(dayTime: Meal.DayTime.Brunch, dishes: dishes)
//        let meal2 = Meal(dayTime: Meal.DayTime.Lunch, dishes: dishes)
//        let meal3 = Meal(dayTime: Meal.DayTime.AfternoonMeals, dishes: dishes)
//        let meal4 = Meal(dayTime: Meal.DayTime.SecondAfternoonMeals, dishes: dishes)
//        let meal5 = Meal(dayTime: Meal.DayTime.Dinner, dishes: dishes)
//
//        addMealCard(mealCard: meal0)
//        addMealCard(mealCard: meal1)
//        addMealCard(mealCard: meal2)
//        addMealCard(mealCard: meal3)
//        addMealCard(mealCard: meal4)
//        addMealCard(mealCard: meal5)
        
        // TODO: change month on needed (0 - January)
        FireFunctions.callFunction(.getMonthDays, ["month" : 0], callback: { (dictResponse) in
            
            self.showMonthCalendar(dietDays: dictResponse["dietDays"] as! [Int])
        })
    }
    
    func showDayMeals(date: Date) {
        cleanMeals() 
        FireFunctions.callFunction(.getDayMeal, ["timestamp" : date.timeIntervalSince1970], callback: { (dictResponse) in
            
            self.cleanMeals() 
            let dietDay = DietDay(dict: dictResponse)
            
            for meal in dietDay.meals {
                self.addMealCard(mealCard: meal)
            }
        })
    }
    
    func cleanMeals() {
        if (emptyMealView != nil) {
            emptyMealView?.removeFromSuperview()
            emptyMealView = nil
        }
        
        for mealCard in mealsCards {
            mealCard.removeFromSuperview()
            mealsCards.removeFirst()
        }
        
        stackHeightConstraint.constant = stackHeightDefault
    }
    
    func showNoDataCard() {
        if (emptyMealView != nil) {
            return
        }
        cleanMeals()
        emptyMealView = EmptyMealView(frame: CGRect())
        mealsCardsParent.addArrangedSubview(emptyMealView!)
   
        stackHeightConstraint.constant += emptyMealView!.height
    }
}

