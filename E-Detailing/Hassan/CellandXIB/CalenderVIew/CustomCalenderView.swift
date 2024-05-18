//
//  CustomCalenderView.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 18/07/23.
//

import Foundation
import UIKit
import FSCalendar

protocol CustomCalenderViewDelegate: AnyObject {
    func didSelectDate(selectedDate : Date)
}
//typealias SelectedDateCallBack = (_ selectedDat : Date) -> Void

class CustomCalenderView : UIView {
    
    @IBOutlet var viewCalendar: FSCalendar!
    
    
    
    var completion : CustomCalenderViewDelegate?
    
    var minDate : Date?
    
    func setupUI() {
        
        self.layer.cornerRadius = 5
    
        self.viewCalendar.register(MyDayPlanCalenderCell.self, forCellReuseIdentifier: "MyDayPlanCalenderCell")
            
        viewCalendar.scrollEnabled = false
        viewCalendar.calendarHeaderView.isHidden = true
        viewCalendar.headerHeight = 0 // this makes some extra spacing, but you can try 0 or 1
            //tourPlanCalander.daysContainer.backgroundColor = UIColor.gray
        viewCalendar.rowHeight =  viewCalendar.height / 5
        viewCalendar.layer.borderColor = UIColor.appSelectionColor.cgColor
            //  tourPlanCalander.calendarWeekdayView.weekdayLabels = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
        viewCalendar.calendarWeekdayView.weekdayLabels.forEach { label in
                label.setFont(font: .medium(size: .BODY))
                label.textColor = .appLightTextColor
            }

        viewCalendar.placeholderType = .none
        viewCalendar.calendarWeekdayView.backgroundColor = .clear
            self.viewCalendar.scrollDirection = .horizontal
            self.viewCalendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "CustomCalendarCell")
        viewCalendar.adjustsBoundingRectWhenChangingMonths = true
        
        viewCalendar.delegate = self
        viewCalendar.dataSource = self
        viewCalendar.reloadData()
    }
    
//     func setupUI() {
//         self.layer.cornerRadius = 5
//        
//        let color = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.4))
//        
//        let headerColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(1.0))
//        
//        let borderColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.25))
//        
//        self.viewCalendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
//        self.viewCalendar.appearance.todayColor = UIColor.clear
//        self.viewCalendar.appearance.weekdayTextColor = headerColor
//        self.viewCalendar.appearance.headerTitleColor = headerColor
//        
//        self.viewCalendar.appearance.headerTitleFont = UIFont(name: "Satoshi-Medium", size: 20)
//        self.viewCalendar.appearance.weekdayFont = UIFont(name: "Satoshi-Medium", size: 18)
//        self.viewCalendar.appearance.subtitleFont = UIFont(name: "Satoshi-Medium", size: 18)
//        
//        self.viewCalendar.appearance.borderDefaultColor = borderColor
//        self.viewCalendar.appearance.borderRadius = 0
//        
//    //    self.viewCalendar.register(fsCalendarCell.self, forCellReuseIdentifier: "fsCell")
//        
//    //    self.viewCalendar.appearance.accessibilityFrame.size = CGSize(width: 100, height: 100)
//        
//        self.viewCalendar.appearance.calendar.visibleCells()
//       
//    }

}


extension CustomCalenderView : FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {

    func toTrimDate(date : Date, isForMainLabel: Bool = false) -> String {
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = isForMainLabel == true ? "MMMM yyyy" : "d"
        return dateFormatter.string(from: date)
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        // let borderColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.25))
        let cell = calendar.dequeueReusableCell(withIdentifier: "MyDayPlanCalenderCell", for: date, at: position) as! MyDayPlanCalenderCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        cell.addedIV.backgroundColor = .clear
        //  let toCompareDate = dateFormatter.string(from: date)
        cell.addedIV.isHidden = false
        cell.customLabel.text = toTrimDate(date: date)
        cell.customLabel.textColor = .appTextColor
        cell.customLabel.setFont(font: .medium(size: .BODY))
        cell.customLabel.textColor = .appTextColor
        // cell.customLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        cell.titleLabel.isHidden = true
        cell.shapeLayer.isHidden = true
        
        cell.layer.borderColor = UIColor.appSelectionColor.cgColor
        cell.layer.borderWidth = 0.5

        
        cell.addTap {
            let dateString = date.toString(format: "yyyy-MM-dd")
            print(dateString)
            self.completion?.didSelectDate(selectedDate: date)
        }
        
        return cell
    }

    
//    func minimumDate(for calendar: FSCalendar) -> Date {
//        return self.minDate ?? Date()
//    }
    

//    
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//        
//        self.viewCalendar.frame.size.height = bounds.height
//        self.viewCalendar.frame.size.width = bounds.width
//    }
    
    
}

