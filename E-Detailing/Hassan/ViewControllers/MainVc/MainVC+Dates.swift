//
//  MainVC+Dates.swift
//  SAN ZEN
//
//  Created by San eforce on 29/06/24.
//

import Foundation
import CoreData
import UIKit
extension MainVC {
    
    func toLoadCalenderData() {

        self.tourPlanCalander.register(MyDayPlanCalenderCell.self, forCellReuseIdentifier: "MyDayPlanCalenderCell")
        
        tourPlanCalander.scrollEnabled = false
        tourPlanCalander.calendarHeaderView.isHidden = true
        tourPlanCalander.headerHeight = 0 // this makes some extra spacing, but you can try 0 or 1
        tourPlanCalander.rowHeight =  tourPlanCalander.height / 5
        tourPlanCalander.layer.borderColor = UIColor.appSelectionColor.cgColor
        tourPlanCalander.calendarWeekdayView.weekdayLabels.forEach { label in
            label.setFont(font: .medium(size: .BODY))
            label.textColor = .appLightTextColor
        }
        tourPlanCalander.placeholderType = .none
        tourPlanCalander.calendarWeekdayView.backgroundColor = .clear
        self.tourPlanCalander.scrollDirection = .horizontal
        self.tourPlanCalander.register(CustomCalendarCell.self, forCellReuseIdentifier: "CustomCalendarCell")
        tourPlanCalander.adjustsBoundingRectWhenChangingMonths = true
        
        self.returnWeeklyoffDates()
        
         self.tourPlanCalander.delegate = self
         self.tourPlanCalander.dataSource = self
         self.tourPlanCalander.reloadData()
        
        if let currentPage = self.currentPage {
            self.tourPlanCalander.setCurrentPage(currentPage, animated: true)
        }

    }
    
    func getCurrentFormattedDateString(selecdate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        return dateFormatter.string(from: selecdate)
    }
    func getCurrentMonth(from selectedDate: Date) -> Int {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: selectedDate)
        return month
    }
    
    
    func getAllDatesInCurrentMonth(date: Date) -> [String] {
        let calendar = Calendar.current
        
        // Get the current date
        let currentDate = date
        
        // Get the date components for the current month
        let currentMonthComponents = calendar.dateComponents([.year, .month], from: currentDate)
        
        // Create the start date of the current month
        guard let startOfMonth = calendar.date(from: currentMonthComponents) else {
            return []
        }
        
        // Get the range of dates for the current month
        guard let rangeOfDates = calendar.range(of: .day, in: .month, for: startOfMonth) else {
            return []
        }
        
        // Generate all the dates in the current month
        var allDatesInCurrentMonth: [String] = []
        
        for day in rangeOfDates {
            if let date = calendar.date(bySetting: .day, value: day, of: startOfMonth) {
                allDatesInCurrentMonth.append(date.toString(format: "yyyy-MM-dd"))
            }
        }
        
        return allDatesInCurrentMonth
    }
    
    
    func getNonExistingDatesInCurrentMonth(selectedDate: Date, completion: @escaping(String?) -> ())  {
        
        let calendar = Calendar.current

        _ = calendar.component(.month, from: selectedDate)
        _ = getCurrentMonth(from: selectedDate)
        // Get all dates in the current month
        let allDatesInCurrentMonth = getAllDatesInCurrentMonth(date: self.currentPage ?? Date())
        
        // Filter dates that are not present in homeDataArr
        let nonExistingDates = allDatesInCurrentMonth.filter { date in
            let isDateInHomeDataArr = homeDataArr.contains { dateObject in
                guard let dateObjectDate = dateObject.dcr_dt?.toDate(format: "yyyy-MM-dd") else { return false }
                return calendar.isDate(date.toDate(format: "yyyy-MM-dd"), inSameDayAs: dateObjectDate)
            }
            return !isDateInHomeDataArr
        }

        if selectedDate == nonExistingDates.first?.toDate(format: "yyyy-MM-dd") {
            completion(nil)
        } else {
            completion(nonExistingDates.first)
        }
        
      
        
        
    }
    func toMergeDate(selectedDate: Date) -> Date? {
        var yetToReturnDate : Date?
        // Assume selectedDate is a Date object without time component
        let selectedDate = selectedDate
        let systemDate = Date()

        let calendar = Calendar.current

        // Extract the date components from selectedDate
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)

        // Extract the time components from systemDate
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: systemDate)

        // Combine the date and time components
        var mergedComponents = DateComponents()
        mergedComponents.year = dateComponents.year
        mergedComponents.month = dateComponents.month
        mergedComponents.day = dateComponents.day
        mergedComponents.hour = timeComponents.hour
        mergedComponents.minute = timeComponents.minute
        mergedComponents.second = timeComponents.second

        // Create the new merged date object
        if let mergedDate = calendar.date(from: mergedComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            print("Merged DateTime: \(dateFormatter.string(from: mergedDate))")
            yetToReturnDate = mergedDate
        } else {
            print("Failed to create merged date")
        }
        return yetToReturnDate
    }
    
    func toTrimDate(date : Date, isForMainLabel: Bool = false) -> String {
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = isForMainLabel == true ? "MMMM yyyy" : "d"
        return dateFormatter.string(from: date)
    }
    
    func toSetDataSource() {
        var dates = [Date]()
        homeDataArr.forEach { aHomeData in
            dates.append(aHomeData.dcr_dt?.toConVertStringToDate() ?? Date())
        }
    }
    
    func separateDatesByMonth(_ dates: [Date]) -> [Int: [Date]] {
        var result: [Int: [Date]] = [:]
        
        let calendar = Calendar.current
        
        for date in dates {
            let month = calendar.component(.month, from: date)
            
            if result[month] == nil {
                result[month] = [date]
            } else {
                result[month]?.append(date)
            }
        }
        
        return result
    }
    
    func toExtractWorkDetails(date: Date) -> HomeData? {

        let dateString = date.toString(format: "yyyy-MM-dd")
        
        print(dateString)
        
        let filteredDetails =   homeDataArr.filter { $0.dcr_dt ?? "" == dateString}
        
        if !filteredDetails.isEmpty {
            return filteredDetails.first
        } else {
            return nil
        }
        
    }
    
    func togetDCRdates(isToUpdateDate: Bool, completion: @escaping () -> ()) {
        CoreDataManager.shared.fetchDcrDates { savedDcrDates in
            for dcrDate in savedDcrDates {
                CoreDataManager.shared.context.refresh(dcrDate, mergeChanges: true)
                // Now, the data is loaded for all properties
                self.responseDcrDates.append(dcrDate)
                self.toAppendDCRtoHomeData(date: dcrDate.date ?? "", flag: dcrDate.flag ?? "", tbName: dcrDate.tbname ?? "", editFlag: dcrDate.editFlag ?? "")
                print("Sf_Code: \(dcrDate.sfcode ?? ""), Date: \(dcrDate.date ?? ""), Flag: \(dcrDate.flag ?? ""), Tbname: \(dcrDate.tbname ?? "")")
            }
            
         
            if isToUpdateDate {
                let planDates = savedDcrDates.filter { $0.flag == "0" && $0.tbname == "dcr" }
                 
                 guard !planDates.isEmpty, let currentDate = planDates.first  else {
                   completion()
                     return
                 }
                 //"2024-06-06 00:00:00"
                 guard let toDayDate = currentDate.date?.toDate(format: "yyyy-MM-dd") else {
                     completion()
                     return
                 }
                
                let mergedDate = self.toMergeDate(selectedDate: toDayDate) ?? Date()
                Shared.instance.selectedDate = mergedDate
                self.currentPage = mergedDate
                self.selectedToday = mergedDate
                self.setDateLbl(date: mergedDate)
                self.toCreateNewDayStatus()
                self.callDayPLanAPI(date: mergedDate, isFromDCRDates: true)
                self.toLoadCalenderData()
                 completion()
            } else {
                self.toLoadCalenderData()
                completion()
            }

        }
        
    }
    
    func toAppendDCRtoHomeData(date: String, flag: String, tbName:String, editFlag: String) {
        
        var isDayExists: Bool = false
        // = self.homeDataArr.map { $0.dcr_dt  }.contains(date)
        var existingEntity: HomeData?
        if let sampleElement = self.homeDataArr.first(where: { $0.dcr_dt == date }) {
            // Do something with sampleElement
            existingEntity = sampleElement
            isDayExists = true
        } else {
            // Handle the case where no matching element is found
            print("No element found for the given date")
        }
        
   
        if isDayExists {
            print("<------Day exists----->")
           self.homeDataArr.removeAll { $0.dcr_dt == date }
        
        }
            if let entityDescription = NSEntityDescription.entity(forEntityName: "HomeData", in: context) {
                let entityHomedata = HomeData(entity: entityDescription, insertInto: context)
                
                
                entityHomedata.anslNo = isDayExists ? existingEntity?.anslNo : ""
                entityHomedata.custCode =  isDayExists ? existingEntity?.custCode : ""
                entityHomedata.custName = isDayExists ? existingEntity?.custName : ""
                entityHomedata.custType = isDayExists ? existingEntity?.custType : ""
                entityHomedata.dcr_dt = date
                entityHomedata.dcr_flag = isDayExists ? existingEntity?.dcr_flag : ""
                entityHomedata.editflag = isDayExists ? existingEntity?.editflag : ""
                entityHomedata.fw_Indicator = isDayExists ? existingEntity?.fw_Indicator :  (flag == "1"  &&  tbName == "missed") ?  "M" : (flag == "2"  &&  tbName == "leave") ? "LAP" : ""

                entityHomedata.isDataSentToAPI = isDayExists ? existingEntity?.isDataSentToAPI : ""
                entityHomedata.mnth = isDayExists ? existingEntity?.mnth : ""
                entityHomedata.month_name = isDayExists ? existingEntity?.month_name : ""
                entityHomedata.rejectionReason = isDayExists ? existingEntity?.rejectionReason : ""
                entityHomedata.sf_Code = isDayExists ? existingEntity?.sf_Code : ""
                entityHomedata.town_code = isDayExists ? existingEntity?.town_code : ""
                entityHomedata.town_name = isDayExists ? existingEntity?.town_name : ""
                entityHomedata.trans_SlNo = isDayExists ? existingEntity?.trans_SlNo : ""
                entityHomedata.yr = isDayExists ? existingEntity?.yr : ""
                
                self.homeDataArr.append(entityHomedata)
            }
     

  
    
    }
    
    func returnWeeklyoffDates() {
        
        
        let weeklyoffSetupArr : [Weeklyoff]? = DBManager.shared.getWeeklyOff()

        guard let  weeklyoffSetupArr = weeklyoffSetupArr, !weeklyoffSetupArr.isEmpty else {return}
        var weekoffIndex : [Int] = []
        //(weeklyOff?.holiday_Mode ?? "0") ?? 0
        weeklyoffSetupArr.forEach({ aWeeklyoff in
            weekoffIndex.append(Int(aWeeklyoff.holiday_Mode ?? "0") ?? 0)
        })
        var weekoffDates : [Date] = []
        let monthIndex : [Int] = [-1, 0]
        weekoffIndex.forEach { weeklyoffIndex in
            weekoffDates.append(contentsOf: getWeekoffDates(forMonths: monthIndex, weekoffday: weeklyoffIndex))
        }
        

        let dcrWeeklyoffDateStrArr: [String] = {
            var dateStrings = [String]()
            
            weekoffDates.forEach { date in
                let modifiedDateStr = toModifyDate(date: date, isForHoliday: true)
                dateStrings.append(modifiedDateStr)
            }
            
            return dateStrings
        }()
        
        var  homeDataWeekoffEntities = [HomeData]()
        
        for aWeeklyoffDate in dcrWeeklyoffDateStrArr {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "HomeData", in: context) {
                let entityHomedata = HomeData(entity: entityDescription, insertInto: context)
                
                
                entityHomedata.anslNo = ""
                entityHomedata.custCode =  String()
                entityHomedata.custName = String()
                entityHomedata.custType = String()
                entityHomedata.dcr_dt = aWeeklyoffDate
                entityHomedata.dcr_flag = String()
                entityHomedata.fw_Indicator = "W"
                entityHomedata.index = Int16()
                entityHomedata.isDataSentToAPI = String()
                entityHomedata.mnth = String()
                entityHomedata.month_name = String()
                entityHomedata.rejectionReason = String()
                entityHomedata.sf_Code = String()
                entityHomedata.town_code = String()
                entityHomedata.town_name = String()
                entityHomedata.trans_SlNo = String()
                entityHomedata.yr = String()
                
                homeDataWeekoffEntities.append(entityHomedata)
            }
            
            
        }
        self.homeDataArr.append(contentsOf: homeDataWeekoffEntities)
        
        
        
        
    }
    
    func getWeekoffDates(forMonths months: [Int], weekoffday: Int) -> [Date] {
        let currentDate = getFirstDayOfCurrentMonth() ?? Date()
        let calendar = Calendar.current
        
        var saturdays: [Date] = []
        
        for monthOffset in months {
            guard let targetDate = calendar.date(byAdding: .month, value: monthOffset, to: currentDate) else {
                continue
            }
            
            let monthRange = calendar.range(of: .day, in: .month, for: targetDate)!
            
            for day in monthRange.lowerBound..<monthRange.upperBound {
                guard let date = calendar.date(bySetting: .day, value: day, of: targetDate) else {
                    continue
                }
                
                if calendar.component(.weekday, from: date) == weekoffday { // Sunday is represented as 1, so Saturday is 7
                    saturdays.append(date)
                }
            }
        }
        
        return saturdays
    }
    
    func getFirstDayOfCurrentMonth() -> Date? {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Get the components (year, month, day) of the current date
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        
        // Create a new date using the components for the first day of the current month
        if let firstDayOfMonth = calendar.date(from: components) {
            return firstDayOfMonth
        } else {
            return nil
        }
    }
    
    func toModifyDate(date: Date, isForHoliday: Bool? = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = (isForHoliday ?? false) ? "yyyy-MM-dd" : "d MMMM yyyy"
        return dateFormatter.string(from: date )
    }
    
    func isFurureDate(date : Date) -> Bool {
        let currentDate = Date() // current date

        // Create another date to compare (for example, one day ahead)
        let futureDate = date

      
            if futureDate.compare(currentDate) == .orderedDescending {
                // futureDate is greater than currentDate
                print("futureDate is greater than currentDate")
            return true
            } else {
                // futureDate is not greater than currentDate
                print("futureDate is not greater than currentDate")
                return false
            }
      
    }
}
