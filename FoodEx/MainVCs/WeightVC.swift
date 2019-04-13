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

class WeightVC : UIViewController {
    let formatter = DateFormatter()
}

extension WeightVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let a = 3
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarDietCell", for: indexPath) as! CalendarDietCell
        
        myCustomCell.dateLabel.text = cellState.text
        

        
        return myCustomCell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2019 01 01")!
        let endDate = formatter.date(from: "2019 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        
        return parameters
    }
}
