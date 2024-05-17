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


typealias SelectedDateCallBack = (_ selectedDat : Date) -> Void

class CustomCalenderView : UIView {
    
    @IBOutlet var viewCalendar: FSCalendar!
    
    
    
    var completion : SelectedDateCallBack?
    
    var minDate : Date?
    
     func setupUI() {
       
        
        let color = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.4))
        
        let headerColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(1.0))
        
        let borderColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.25))
        
        self.viewCalendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        self.viewCalendar.appearance.todayColor = UIColor.clear
        self.viewCalendar.appearance.weekdayTextColor = headerColor
        self.viewCalendar.appearance.headerTitleColor = headerColor
        
        self.viewCalendar.appearance.headerTitleFont = UIFont(name: "Satoshi-Medium", size: 20)
        self.viewCalendar.appearance.weekdayFont = UIFont(name: "Satoshi-Medium", size: 18)
        self.viewCalendar.appearance.subtitleFont = UIFont(name: "Satoshi-Medium", size: 18)
        
        self.viewCalendar.appearance.borderDefaultColor = borderColor
        self.viewCalendar.appearance.borderRadius = 0
        
    //    self.viewCalendar.register(fsCalendarCell.self, forCellReuseIdentifier: "fsCell")
        
    //    self.viewCalendar.appearance.accessibilityFrame.size = CGSize(width: 100, height: 100)
        
        self.viewCalendar.appearance.calendar.visibleCells()
       
    }
    
    func didSelectCompletion (callback : @escaping SelectedDateCallBack) {
        self.completion = callback
    }
}


extension CustomCalenderView : FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        let cell = calendar.dequeueReusableCell(withIdentifier: "fsCell", for: date, at: position)
//
//        return cell
//    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateString = date.toString(format: "yyyy-MM-dd")
        print(dateString)
        
        if let completion = self.completion {
            completion(date)
        }
        print("Yet to")
       // self.dismiss(animated: true)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.minDate ?? Date()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let color = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.65))
        
        return color
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        self.viewCalendar.frame.size.height = bounds.height
        self.viewCalendar.frame.size.width = bounds.width
    }
    
    
}

