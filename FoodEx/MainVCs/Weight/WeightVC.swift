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
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.selectDates([ Date() ])
        
        setupCalendarView()
    }
    
    func setupCalendarView() {
        // setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //Setup labels
        calendarView.visibleDates { (visibleDate) in
            self.setuoViewsOfCalendar(from: visibleDate)
        }
    }
    
    func handleCellTextColor(cellView: JTAppleCell?, cellState: CellState) {
        guard let validCell = cellView as? CalendarDietCell else {return}
        
        let todaysDate = Date()
        formatter.dateFormat = "yyyy MM dd"
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                if todaysDateString == monthDateString {
                    validCell.dateLabel.textColor = UIColor.primaryDark
                } else {
                    validCell.dateLabel.textColor = UIColor.darkGrayKor
                }
            } else {
                validCell.dateLabel.textColor = UIColor.lightGrayKor
            }
        }
        
        
    }
    
    func handleCellSelected(cellView: JTAppleCell?, cellState: CellState) {
        guard let validCell = cellView as? CalendarDietCell else { return }
        
        if cellState.isSelected {
            validCell.selectedCircle.isHidden = false
        } else {
            validCell.selectedCircle.isHidden = true
        }
    }
    
    func setuoViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
}

extension WeightVC: JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let a = 3
    }
    
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

extension WeightVC: JTAppleCalendarViewDelegate {
    // Display the cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarDietCell", for: indexPath) as! CalendarDietCell
        
        cell.dateLabel.text = cellState.text
        
        handleCellSelected(cellView: cell, cellState: cellState)
        handleCellTextColor(cellView: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarDietCell else { return }
        
        handleCellSelected(cellView: cell, cellState: cellState)
        handleCellTextColor(cellView: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarDietCell else { return }
        
        handleCellSelected(cellView: cell, cellState: cellState)
        handleCellTextColor(cellView: cell, cellState: cellState)
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
