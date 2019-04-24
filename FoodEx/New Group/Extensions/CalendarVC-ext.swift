//
//  WeightVC.swift
//  FoodEx
//
//  Created by korsour on 4/22/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar
import XLPagerTabStrip

extension CalendarVC: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2019 01 01")!
        let endDate = formatter.date(from: "2019 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, firstDayOfWeek: .monday)
        
        return parameters
    }
}

extension CalendarVC: JTAppleCalendarViewDelegate {
    // Display the cell
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {        // This function should have the same code as the cellForItemAt function
        let cell = cell as! CalendarDietCell
        //        cell.dateLabel.textColor = UIColor.red
        //        cell.selectedCircle.isHidden = true
        
        //
        //        cell.dateLabel.text = cellState.text
        //
        //        handleCellSelected(cellView: cell, cellState: cellState)
        //        handleCellTextColor(cellView: cell, cellState: cellState)
        //
        sharedFunctionToConfigureCell(validCell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarDietCell", for: indexPath) as! CalendarDietCell
        
        
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        cell.dateLabel.text = cellState.text
        
        sharedFunctionToConfigureCell(validCell: cell, cellState: cellState)
        
        sharedFunctionToConfigureCell(validCell: cell, cellState: cellState)
        
        return cell
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard (cell as? CalendarDietCell) != nil else { return }
        
        sharedFunctionToConfigureCell(validCell: cell as! CalendarDietCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard (cell as? CalendarDietCell) != nil else { return }
        
        sharedFunctionToConfigureCell(validCell: cell as! CalendarDietCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        yearLabel.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        monthLabel.text = formatter.string(from: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "header", for: indexPath) as! CalendarDayHeader
        
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 27)
    }
}
