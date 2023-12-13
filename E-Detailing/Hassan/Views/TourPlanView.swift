//
//  TourPlanView.swift
//  E-Detailing
//
//  Created by San eforce on 09/11/23.
//

import Foundation
import UIKit
import FSCalendar

extension TourPlanView: PopOverVCDelegate {
    func didTapRow(_ index: Int, _ SelectedArrIndex: Int) {
        if index == 0 {
            let modal = self.tempArrofPlan?[SelectedArrIndex]
            self.moveToMenuVC(modal?.rawDate ?? Date(), isForWeekOff: modal?.isForWeekoff, isforHoliday: false)
        }
        
        else if index == 1 {
            let modal = self.tempArrofPlan?[SelectedArrIndex]
            self.toRemoveSession(modal ?? SessionDetailsArr())
            LocalStorage.shared.setBool(LocalStorage.LocalValue.istoEnableApproveBtn, value: false)
            self.toToggleApprovalState(false)
        }
    }
    

    
    
}

extension TourPlanView {

    func toGetAllmonthData() {
        
    }
    
    
    func getDatesForDayIndex(_ dayIndex: Int) -> [Date] {
        let calendar = Calendar.current
        let currentDate = Date()

        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)),
              let firstDayOfMonth = calendar.nextDate(after: startOfMonth, matching: DateComponents(weekday: dayIndex), matchingPolicy: .nextTime) else {
            print("Error calculating start of the month or finding the first occurrence of the day.")
            return []
        }

        var dates: [Date] = []

        for monthOffset in [-1, 0, 1] {
            guard let startOfDesiredMonth = calendar.date(byAdding: .month, value: monthOffset, to: firstDayOfMonth),
                  let range = calendar.range(of: .day, in: .month, for: startOfDesiredMonth) else {
                print("Error calculating start of the desired month or getting the range of days.")
                return []
            }

            let datesForMonth: [Date] = (range.lowerBound..<range.upperBound)
                .compactMap { calendar.date(bySetting: .day, value: $0, of: startOfDesiredMonth) }
                .filter { calendar.component(.weekday, from: $0) == dayIndex }

            dates.append(contentsOf: datesForMonth)
        }

        return dates
    }
}

extension TourPlanView {
   

    
    func toSetParams(_ arrOfPlan: [SessionDetailsArr], completion: @escaping (Result<SaveTPresponseModel, Error>) -> ())  {
        let appdefaultSetup = AppDefaults.shared.getAppSetUp()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let date =  dateFormatter.string(from:  Date())
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let dayNo = dateFormatter.string(from: Date())
        
        
        let dateArr = date.components(separatedBy: " ") //"1 Nov 2023"
        let anotherDateArr = dayNo.components(separatedBy: "/") // MM/dd/yyyy - 09/12/2018
        var param = [String: Any]()
        param["SFCode"] = appdefaultSetup.sfCode
        param["SFName"] = appdefaultSetup.sfName
        param["Div"] = appdefaultSetup.divisionCode
        param["Mnth"] = anotherDateArr[0]
        param["Yr"] = dateArr[2]//2023
        param["Day"] =  dateArr[0]//1
        param["Tour_Month"] = anotherDateArr[0]// 11
        param["Tour_Year"] = dateArr[2] // 2023
        param["tpmonth"] = dateArr[1]// Nov
        param["tpday"] = day// Wednesday
        param["dayno"] = anotherDateArr[0] // 11
        let tpDtDate = dayNo.replacingOccurrences(of: "/", with: "-")
        param["TPDt"] =  tpDtDate//2023-11-01 00:00:00
        // tourPlanArr.arrOfPlan?.enumerated().forEach { index, allDayPlans in
        
        var sessions = [JSON]()
        
        arrOfPlan.enumerated().forEach { index, allDayPlans in
            allDayPlans.sessionDetails?.enumerated().forEach { sessionIndex, session in
                var sessionParam = [String: Any]()
                var index = String()
                if sessionIndex == 0 {
                    index = ""
                } else {
                    index = "\(sessionIndex + 1)"
                }
                
                var drIndex = String()
                if sessionIndex == 0 {
                    drIndex = "_"
                } else if sessionIndex == 1{
                    drIndex = "_two_"
                } else if sessionIndex == 2 {
                    drIndex = "_three_"
                }
                param["FWFlg\(index)"] = session.FWFlg
                param["HQCodes\(index)"] = session.HQCodes
                param["HQNames\(index)"] = session.HQNames
                param["WTCode\(index)"] = session.WTCode
                param["WTName\(index)"] = session.WTName
                param["chem\(drIndex)Code"] = session.chemCode
                param["chem\(drIndex)Name"] = session.chemName
                param["clusterCode\(index)"] = session.clusterCode
                param["clusterName\(index)"] = session.clusterName
                param["Dr\(drIndex)Code"] = session.drCode
                param["Dr\(drIndex)Name"] = session.drName
                param["jwCodes\(index)"] = session.jwCode
                param["jwNames\(index)"] = session.jwName
                param["DayRemarks\(index)"] = session.remarks
            }
            param["submittedTime"] = "\(Date())"
            param["Mode"] = "Android-App"
            param["Entry_mode"] = "Apps"
            param["Approve_mode"] = ""
            param["Approved_time"] = ""
            param["app_version"] = "N 1.6.9"
            sessions.append(param)
        }
        dump(sessions)
        
        
        
        
        var jsonDatum = Data()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: sessions, options: [])
            jsonDatum = jsonData
            // Convert JSON data to a string
            if let tempjsonString = String(data: jsonData, encoding: .utf8) {
                print(tempjsonString)
                
            }
            
            
        } catch {
            print("Error converting parameter to JSON: \(error)")
        }
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        self.sessionResponseVM = SessionResponseVM()
        sessionResponseVM!.uploadTPmultipartFormData(params: toSendData, api: .saveTP, paramData: jsonDatum) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
                dump(response)
                
            case .failure(let error):
                print(error.localizedDescription)
                
                completion(.failure(error))
            }
        }
    }
    
}

class TourPlanView: BaseView {
    
    struct MonthlyOffs {
        var id : String
        var month : String
        var weekoffsDateArr : [Date]
        var weekoffStrArr : [String]
    }
    
    var monthlyOffs = [MonthlyOffs]()
    
    //MARK: - Outlets
    ///  common
    @IBOutlet var overAllContentsHolder: UIView!
    
    @IBOutlet var calenderHolderView: UIView!
    
    @IBOutlet var tourPlanCalander: FSCalendar!
    
    @IBOutlet var tableElementsHolderView: UIView!
    
    @IBOutlet var bottomButtonsHolderView: UIView!
    
    @IBOutlet var worksPlanTable: UITableView!
    
    @IBOutlet var backHolder: UIView!
    
    @IBOutlet var planningLbl: UILabel!
    /// General page type outlets
    @IBOutlet var lblSendToApproval: UILabel!
    @IBOutlet var generalButtonsHolder: UIView!
    
    @IBOutlet var btnSendFOrApproval: UIButton!
    
    //MARK: if inactive: #282A3C (alpha 0.1)
    
    @IBOutlet var titleHolder: UIView!
    
    /// SessionType outlets
    @IBOutlet var sessionTypeButtonsHolderView: UIView!
    @IBOutlet var addSessionTapView: UIView!
    @IBOutlet var sessionTypeSaveTapView: UIView!
    
    
    /// ClusterType outlets
    @IBOutlet var clusterTypeButtonsHolder: UIView!
    
    @IBOutlet var clusterTypeSaveTapView: UIView!
    @IBOutlet var clusterTypeClearTapView: UIView!
    
    @IBOutlet var calenderPrevIV: UIImageView!
    
    @IBOutlet var calenderNextIV: UIImageView!
    
    @IBOutlet var mainDateLbl: UILabel!
    
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var tableTitle: UILabel!
    
    @IBOutlet var sessionTableHolderView: UIView!
    
    //MARK: - Properties
    var selectedDate: String = ""
    var tourplanVC : TourPlanVC!
    var isNextMonth = false
    var isPrevMonth = false
    var isCurrentMonth = false
    var arrOfPlan : [SessionDetailsArr]?
    var tempArrofPlan: [SessionDetailsArr]?
    var sessionResponseVM: SessionResponseVM?
    var  weeklyOff : Weeklyoff?
    var  holidays : Holidays?
   // var tableSetupmodel: TableSetupModel?
    var totalDays = Int()
    var filledDates = [Date]()
    var months = [String]()
    var weeklyOffDates = [String]()
    var weeklyOffRawDates = [Date]()
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    //MARK: - View Lifecyle
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.tourplanVC = baseVC as? TourPlanVC
       // toSetPagetype(ofType: .general)
       // setupUI()
    }
    
    
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.tourplanVC = baseVC as? TourPlanVC
       // tourplanVC.togetTableSetup()
        toSetPagetype(ofType: .general)
        setupUI()
        initViews()
    }
    
    
    
    
    func monthWiseSeperationofSessions(_ date: Date) {
        

        let tocomparemonth = toGetMonth(date)
        var thisMonthPaln = [SessionDetailsArr]()

        arrOfPlan?.forEach({ plan in
            let month = toGetMonth(plan.rawDate ?? Date())
            if month == tocomparemonth {
                thisMonthPaln.append(plan)
            }
        })
      
        thisMonthPaln = thisMonthPaln.sorted(by: { $0.rawDate.compare($1.rawDate) == .orderedAscending })
        
        self.tempArrofPlan = thisMonthPaln
        
      
        worksPlanTable.delegate = self
        worksPlanTable.dataSource = self
        worksPlanTable.reloadData()
        self.tourPlanCalander.collectionView.reloadData()
      //  let indexpath = IndexPath(row: 0, section: 0)
      //  worksPlanTable.scrollToRow(at: indexpath, at: .top, animated: false)
        
        if filledDates.count == 3 {
            toEnableApprovalBtn(totaldate: filledDates, filleddate: arrOfPlan?.count ?? 0)
        } else {
           
                if months.isEmpty {
                    months.append(toGetMonth(date))
                    filledDates.append(date)
                } else {
                    if months.contains(toGetMonth(date)) {
                    } else {
                        months.append(toGetMonth(date))
                        filledDates.append(date)
                    }
                }
        }

    }
    
    
    func toEnableApprovalBtn(totaldate: [Date], filleddate: Int) {
        totalDays = 0
        filledDates.forEach { date in
            let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date)
                totalDays = totalDays + (range?.count ?? 30)
        }
        print("Total days--->\(totalDays)----||")
        
        
        if filleddate >= totalDays {
            LocalStorage.shared.setBool(LocalStorage.LocalValue.istoEnableApproveBtn, value: true)
            self.planningLbl.text = "Planned"
            toToggleApprovalState(true)
        } else {
            LocalStorage.shared.setBool(LocalStorage.LocalValue.istoEnableApproveBtn, value: false)
            self.planningLbl.text = "Planning..."
            toToggleApprovalState(false)
        }
        
    }
    
    func toToggleApprovalState(_ isActive: Bool) {
        if isActive {
            generalButtonsHolder.backgroundColor = .green
            btnSendFOrApproval.isUserInteractionEnabled = true
        } else {
            generalButtonsHolder.backgroundColor = .appSelectionColor
            btnSendFOrApproval.isUserInteractionEnabled = false
        }
    }
    
    
    func toRemoveSession(_ sessionDetArr:  SessionDetailsArr) {

        
        toRemoveElement(isToremove: true, toRemoveSessionDetArr: sessionDetArr)
    }
    
    
    
    func toAppendWeeklyoffs(date: [String], rawDate: [Date]) {
        
        AppDefaults.shared.eachDatePlan.weekoffsDates = rawDate
        
            let initialsavefinish = NSKeyedArchiver.archiveRootObject(AppDefaults.shared.eachDatePlan, toFile: EachDatePlan.ArchiveURL.path)
            if !initialsavefinish {
                print("Error")
            }
        AppDefaults.shared.eachDatePlan = NSKeyedUnarchiver.unarchiveObject(withFile: EachDatePlan.ArchiveURL.path) as? EachDatePlan ?? EachDatePlan()
    
            var includedSessionArr = [SessionDetailsArr]()
            var sessionDetail = SessionDetail()


            if includedSessionArr.count == 0 {
                AppDefaults.shared.eachDatePlan.weekoffsDates.enumerated().forEach { adateIndex, adate in
                    let aSession = SessionDetail()
                    let aSessionDetArr = SessionDetailsArr()
                    aSession.isForFieldWork = false
                    aSession.WTCode = self.weeklyOff?.wtcode ?? ""
                    aSession.WTName = self.weeklyOff?.wtname ?? "Weekly off"
                    aSessionDetArr.date = toModifyDate(date: adate)
                    aSessionDetArr.rawDate = adate
                    aSessionDetArr.isForWeekoff = true
                    aSessionDetArr.isDataSentToApi = false
                    aSessionDetArr.sessionDetails.append(aSession)
                    includedSessionArr.append(aSessionDetArr)
                }
            }

            dump(includedSessionArr)
            var  temptpArray =  TourPlanArr()
            temptpArray.arrOfPlan = includedSessionArr
            AppDefaults.shared.tpArry.arrOfPlan.append(contentsOf: includedSessionArr)
     
            AppDefaults.shared.eachDatePlan.tourPlanArr.append(AppDefaults.shared.tpArry)
        
        let savefinish = NSKeyedArchiver.archiveRootObject(AppDefaults.shared.eachDatePlan, toFile: EachDatePlan.ArchiveURL.path)
        if !savefinish {
            print("Error")
        } else {
            LocalStorage.shared.setBool(LocalStorage.LocalValue.TPalldatesAppended, value: true)
            toLoadData()
        }
    }
    
    
  

    func toGetMonth(_ date: Date)  -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    func toRemoveElement(isToremove: Bool?, toRemoveSessionDetArr:  SessionDetailsArr?) {

            var  temptpArray =  [TourPlanArr]()
            self.arrOfPlan?.enumerated().forEach({ sessionDetArrIndex ,sessionDetArr in
                if sessionDetArr.date == toRemoveSessionDetArr?.date {
                    self.arrOfPlan?.remove(at: sessionDetArrIndex)
                }
            })
            AppDefaults.shared.eachDatePlan.tourPlanArr?.forEach {  eachDayPlan in
                temptpArray.append(eachDayPlan)
            }
            
            temptpArray.forEach({ tpArr in
                tpArr.arrOfPlan =  self.arrOfPlan
            })
        
            AppDefaults.shared.eachDatePlan.tourPlanArr = temptpArray
        
                        let savefinish = NSKeyedArchiver.archiveRootObject(AppDefaults.shared.eachDatePlan, toFile: EachDatePlan.ArchiveURL.path)
                             if !savefinish {
                                 print("Error")
                             }
        toLoadData()
        
    }
    

    
    func toLoadData()  {
        AppDefaults.shared.eachDatePlan = NSKeyedUnarchiver.unarchiveObject(withFile: EachDatePlan.ArchiveURL.path) as? EachDatePlan ?? EachDatePlan()

        self.arrOfPlan = [SessionDetailsArr]()
        var tpArray =  [TourPlanArr]()

        AppDefaults.shared.eachDatePlan.tourPlanArr?.enumerated().forEach { index, eachDayPlan in
            tpArray.append(eachDayPlan)
        }
        tpArray.forEach({ tpArr in
            self.arrOfPlan = tpArr.arrOfPlan
        })

        monthWiseSeperationofSessions(tourPlanCalander.currentPage)
    }
    
    func initViews() {

        backHolder.addTap {
            self.tourplanVC.navigationController?.popViewController(animated: true)
        }
        
        calenderPrevIV.addTap {
            self.moveCurrentPage(moveUp: false)
        }
        
        calenderNextIV.addTap {
            self.moveCurrentPage(moveUp: true)
            }
        
      

        
    }
    
    @IBAction func didTApSendToApproval(_ sender: UIButton) {
        
        let unSavedPlans = self.arrOfPlan?.filter({ toFilterSessionsArr in
            toFilterSessionsArr.isDataSentToApi == false
        })
        
        
       let unsentIndices = self.arrOfPlan?.indices.filter { self.arrOfPlan?[$0].isDataSentToApi == false } ?? [Int]()
        
        dump(unSavedPlans)
        
        if unSavedPlans?.count ?? 0 > 0 {
            self.toSetParams(unSavedPlans ?? [SessionDetailsArr]()) {
                responseResult in
                switch responseResult {
                case .success(let responseJSON):
                    dump(responseJSON)
                    
                    unsentIndices.forEach { index in
                        self.arrOfPlan?[index].isDataSentToApi = true
                    }
                    
                    var temptpArray = [TourPlanArr]()
                    
                    AppDefaults.shared.eachDatePlan.tourPlanArr?.forEach {  eachDayPlan in
                        temptpArray.append(eachDayPlan)
                    }
                    
                    temptpArray.forEach({ tpArr in
                        tpArr.arrOfPlan =  self.arrOfPlan
                    })
                
                    AppDefaults.shared.eachDatePlan.tourPlanArr = temptpArray
                                let savefinish = NSKeyedArchiver.archiveRootObject(AppDefaults.shared.eachDatePlan, toFile: EachDatePlan.ArchiveURL.path)
                                     if !savefinish {
                                         print("Error")
                                     }
                    self.toLoadData()
                case .failure(let error):
                    self.toCreateToast("The operation couldn’t be completed. Try again later")
                }
            }
        }
        
    }
    
    
    func toDisableNextPrevBtn(enableprevBtn: Bool, enablenextBtn: Bool) {
        
        if enableprevBtn && enablenextBtn {
            calenderPrevIV.alpha = 1
            calenderPrevIV.isUserInteractionEnabled = true
            
            calenderNextIV.alpha = 1
            calenderNextIV.isUserInteractionEnabled = true
        } else  if enableprevBtn {
            calenderPrevIV.alpha = 1
            calenderPrevIV.isUserInteractionEnabled = true
            
            calenderNextIV.alpha = 0.3
            calenderNextIV.isUserInteractionEnabled = false
            
        } else if enablenextBtn {
            calenderPrevIV.alpha = 0.3
            calenderPrevIV.isUserInteractionEnabled = false
            
            calenderNextIV.alpha = 1
            calenderNextIV.isUserInteractionEnabled = true
        }
        
     
    }
    

    private func moveCurrentPage(moveUp: Bool) {
     
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1

      //  self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)

      
        if moveUp {
            var isToMoveindex: Int? = nil
            self.isNextMonth = true
            if isPrevMonth {
                self.isCurrentMonth = true
            }
            
            if isNextMonth && isCurrentMonth {
                isToMoveindex = 0
                toDisableNextPrevBtn(enableprevBtn: true, enablenextBtn: true)
                isCurrentMonth = false
            } else {
                isToMoveindex = 1
                toDisableNextPrevBtn(enableprevBtn: true, enablenextBtn: false)
            }
            
            if let nextMonth = calendar.date(byAdding: .month, value: isToMoveindex ?? 0, to: self.today) {
                  print("Next Month:", nextMonth)
                self.currentPage = nextMonth
                self.isPrevMonth = false
              }
        } else if !moveUp{
            // Calculate the previous month
            var isToMoveindex: Int? = nil
            self.isPrevMonth = true
            if isNextMonth {
                self.isCurrentMonth = true
            }
            
            if isPrevMonth && isCurrentMonth {
                isToMoveindex = 0
                isCurrentMonth = false
                toDisableNextPrevBtn(enableprevBtn: true, enablenextBtn: true)
            } else {
                isToMoveindex = -1
                toDisableNextPrevBtn(enableprevBtn: false, enablenextBtn: true)
            }
            if let previousMonth = calendar.date(byAdding: .month, value: isToMoveindex ?? 0, to: self.today) {
                print("Previous Month:", previousMonth)
                self.currentPage = previousMonth
                self.isNextMonth = false
               
            }
        } else {
            if let currentMonth = calendar.date(byAdding: .month, value: 0, to: self.today) {
                print("Previous Month:", currentMonth)
                self.currentPage = currentMonth
               
            }
        }

        self.tourPlanCalander.setCurrentPage(self.currentPage!, animated: true)
        monthWiseSeperationofSessions(self.currentPage ?? Date())
    }
    
    /// Returns the amount of months from another date
    func months(fromdate: Date, todate: Date) -> Int {
         return Calendar.current.dateComponents([.month], from: fromdate, to: todate).month ?? 0
     }
    
    func cellRegistration() {
        worksPlanTable.register(UINib(nibName: "worksPlanTVC", bundle: nil), forCellReuseIdentifier: "worksPlanTVC")
        //tourPlanCalander.collectionView.register(UINib(nibName: "FSCalendarCVC", bundle: nil), forCellWithReuseIdentifier: "FSCalendarCVC")
    }
    
    
    func toLoadCalenderData() {
        tourPlanCalander.delegate = self
        tourPlanCalander.dataSource = self
        tourPlanCalander.reloadData()
    }
    
    func toCheckMonthVariations() -> Bool {
        
        AppDefaults.shared.eachDatePlan = NSKeyedUnarchiver.unarchiveObject(withFile: EachDatePlan.ArchiveURL.path) as? EachDatePlan ?? EachDatePlan()
        
        //MARK: - Added months
        
        var addedMonths = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        AppDefaults.shared.eachDatePlan.weekoffsDates.forEach { weeklyoffDates in
            addedMonths.append(dateFormatter.string(from: weeklyoffDates))
        }
        let uniqueSet = Set(addedMonths)
        addedMonths = Array(uniqueSet)
        
        //MARK: - Current months
        
        let currentMonths = getCurrentPreviousNextMonthStrings()
        
        
        let containsAllElements = currentMonths.allSatisfy { addedMonths.contains($0) }

        if containsAllElements {
            return true
        } else {
            return false
        }
    }
    
    private func updateCalender () {
        
        let weeklyoffSetupArr = DBManager.shared.getWeeklyOff()
        self.weeklyOff = weeklyoffSetupArr[0]
//        let weekoffIndex = Int(self.weeklyOff?.holiday_Mode ?? "0")
//        let weekoffDates = getDatesForDayIndex(weekoffIndex ?? 0, numberOfMonths: 3)
        
        LocalStorage.shared.setBool(LocalStorage.LocalValue.TPalldatesAppended, value: toCheckMonthVariations())

        let isAlldatesAppended  = LocalStorage.shared.getBool(key: LocalStorage.LocalValue.TPalldatesAppended)
        if !isAlldatesAppended {
            let weekoffIndex = Int(self.weeklyOff?.holiday_Mode ?? "0") ?? 0
            let weekoffDates = getDatesForDayIndex(weekoffIndex + 1)
            self.weeklyOffRawDates.append(contentsOf: weekoffDates)
            weeklyOffDates.removeAll()
            self.weeklyOffRawDates.forEach { rawDate in
                weeklyOffDates.append(toModifyDate(date: rawDate))
            }
            toAppendWeeklyoffs(date: self.weeklyOffDates, rawDate:   self.weeklyOffRawDates)
        } else {
            toLoadData()
        }
        let holidaysSetupArr = DBManager.shared.getHolidays()
        self.holidays = holidaysSetupArr[0]
        
        
        self.selectedDate = ""
        tourPlanCalander.scrollEnabled = false
        tourPlanCalander.calendarHeaderView.isHidden = true
        tourPlanCalander.headerHeight = 0 // this makes some extra spacing, but you can try 0 or 1
        //tourPlanCalander.daysContainer.backgroundColor = UIColor.gray
        tourPlanCalander.rowHeight =  tourPlanCalander.height / 5
        tourPlanCalander.layer.borderColor = UIColor.appSelectionColor.cgColor
        tourPlanCalander.calendarWeekdayView.weekdayLabels.forEach { label in
            label.setFont(font: .bold(size: .BODY))
        }
        tourPlanCalander.layer.borderWidth = 1
        tourPlanCalander.layer.cornerRadius = 5
        tourPlanCalander.clipsToBounds = true
        tourPlanCalander.placeholderType = .none
        tourPlanCalander.calendarWeekdayView.backgroundColor = .appSelectionColor
        self.tourPlanCalander.scrollDirection = .horizontal
        self.tourPlanCalander.register(CustomCalendarCell.self, forCellReuseIdentifier: "CustomCalendarCell")
        tourPlanCalander.adjustsBoundingRectWhenChangingMonths = true
        tourPlanCalander.delegate = self
        tourPlanCalander.dataSource = self
        tourPlanCalander.reloadData()
        mainDateLbl.text = toTrimDate(date: tourPlanCalander.currentPage , isForMainLabel: true)
    }
    
    
    

    func getCurrentPreviousNextMonthStrings() -> [String] {
        
        var months = [String]()
        
        let calendar = Calendar.current
        let currentDate = Date()

        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"

        // Current month
        let currentMonthString = monthFormatter.string(from: currentDate)
        print("Current Month: \(currentMonthString)")
        months.append(currentMonthString)
        // Previous month
        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            let previousMonthString = monthFormatter.string(from: previousMonth)
            print("Previous Month: \(previousMonthString)")
            months.append(previousMonthString)
            
        }

        // Next month
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentDate) {
            let nextMonthString = monthFormatter.string(from: nextMonth)
            print("Next Month: \(nextMonthString)")
            months.append(nextMonthString)
        }
        return months
    }
    
    //MARK: - Enum Page types
    /**
     Page types use enum to switch page types
     - note : set the page type by use of toSetPagetype function
     */
       
    enum pageTypes {
        case general
        case session
        case workType
        case cluster
        case edit
    }
    

    ///  Pagetypes use enum  to switch page types
    /// - Parameter pageType: use appropriate pageTypes enums
    func toSetPagetype(ofType pageType : pageTypes) {
        switch pageType {
            
        case .general:
            generalButtonsHolder.isHidden = false
            sessionTypeButtonsHolderView.isHidden = true
            clusterTypeButtonsHolder.isHidden = true
            
            
        case .session:
            generalButtonsHolder.isHidden = true
            sessionTypeButtonsHolderView.isHidden = false
            clusterTypeButtonsHolder.isHidden = true
            
            
        case .workType:
            generalButtonsHolder.isHidden = true
            sessionTypeButtonsHolderView.isHidden = true
            clusterTypeButtonsHolder.isHidden = true
            
            
        case .cluster:
            generalButtonsHolder.isHidden = true
            sessionTypeButtonsHolderView.isHidden = true
            clusterTypeButtonsHolder.isHidden = false
            
            
        case .edit:
            generalButtonsHolder.isHidden = true
            sessionTypeButtonsHolderView.isHidden = true
            clusterTypeButtonsHolder.isHidden = true
        }
    }
    
    func setupUI() {
  
        titleLbl.setFont(font: .bold(size: .BODY))
        mainDateLbl.setFont(font: .medium(size: .BODY))
        tableTitle.setFont(font: .medium(size: .BODY))
        planningLbl.setFont(font: .bold(size: .BODY))
        btnSendFOrApproval.setTitle("Send to Approval", for: .normal)
        btnSendFOrApproval.titleLabel?.font = UIFont(name: "Satoshi-Bold", size: 16)
        btnSendFOrApproval.backgroundColor = .clear
        btnSendFOrApproval.tintColor = .appWhiteColor
        titleHolder.elevate(2)
        titleHolder.backgroundColor = .appSelectionColor
        titleHolder.layer.cornerRadius = 5
        worksPlanTable.separatorStyle = .none
       
        cellRegistration()
        updateCalender()
      
      
        if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.istoEnableApproveBtn) {
            planningLbl.isHidden = true
            toToggleApprovalState(true)
        } else {
            toToggleApprovalState(false)
            planningLbl.isHidden = false
        }
        calenderHolderView.elevate(2)
        calenderHolderView.layer.cornerRadius = 5

        bottomButtonsHolderView.layer.cornerRadius = 5
        generalButtonsHolder.layer.cornerRadius = 5
        
        sessionTableHolderView.elevate(2)
        sessionTableHolderView.layer.cornerRadius = 5
    }
    
    
    func toTrimDate(date : Date, isForMainLabel: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = isForMainLabel == true ? "MMMM yyyy" : "dd"
        return dateFormatter.string(from: date)
    }
    
    
    func moveToMenuVC(_ date: Date, isForWeekOff: Bool?, isforHoliday: Bool?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let toCompareDate = dateFormatter.string(from: date )
          self.selectedDate =  self.toTrimDate(date: date)
       //   self.tourPlanCalander.reloadData()
          
        let menuvc = MenuVC.initWithStory(self, date, isForWeekOff: isForWeekOff, isForHoliday: isforHoliday)
                  self.tourplanVC.modalPresentationStyle = .custom
                  menuvc.menuDelegate = self
//        if isForWeekOff ?? false {
//            let aSession = SessionDetail()
//            aSession.isForFieldWork = false
//            aSession.WTCode = self.weeklyOff?.wtcode ?? ""
//            aSession.WTName = self.weeklyOff?.wtname ?? "Weekly off"
//
//            let aSessionDetArr = SessionDetailsArr()
//            aSessionDetArr.sessionDetails.append(aSession)
//            aSessionDetArr.date = toCompareDate
//            aSessionDetArr.rawDate = date
//            menuvc.sessionDetailsArr = aSessionDetArr
//            //menuvc.selectedDate = date
//           // menuvc.isWeekoffEditable =
//        } else {
            AppDefaults.shared.eachDatePlan = NSKeyedUnarchiver.unarchiveObject(withFile: EachDatePlan.ArchiveURL.path) as? EachDatePlan ?? EachDatePlan()
              AppDefaults.shared.eachDatePlan.tourPlanArr?.enumerated().forEach { index, eachDayPlan in
                  eachDayPlan.arrOfPlan?.enumerated().forEach { index, sessions in
                      if sessions.date == toCompareDate {
                          menuvc.sessionDetailsArr = sessions
                      }
                  }
              }
       // }
        

    self.tourplanVC.navigationController?.present(menuvc, animated: true)
    }
}

extension TourPlanView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArrofPlan?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : worksPlanTVC = tableView.dequeueReusableCell(withIdentifier: "worksPlanTVC", for: indexPath) as! worksPlanTVC
        let modal =  self.tempArrofPlan?[indexPath.row]
        cell.toPopulateCell(modal ?? SessionDetailsArr())
        
        cell.addTap {
            self.moveToMenuVC(modal?.rawDate ?? Date(), isForWeekOff: modal?.isForWeekoff, isforHoliday: false)
        }
        
        cell.optionsIV.addTap {
            
            
            print("Tapped -->")
            let vc = PopOverVC.initWithStory(preferredFrame: CGSize(width: cell.width / 2, height: 100), on: cell.optionsIV)
            vc.delegate = self
            vc.selectedIndex = indexPath.row
            self.tourplanVC.navigationController?.present(vc, animated: true)
//            self.toRemoveSession(modal ?? SessionDetailsArr())
//            LocalStorage.shared.setBool(LocalStorage.LocalValue.istoEnableApproveBtn, value: false)
//            self.toToggleApprovalState(false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var isForfieldWork = Bool()
        var isFieldWorkExist = [Bool]()
        let modal =  self.tempArrofPlan?[indexPath.row]
        var detailsArr = [[String]]()
        var jointCallstr = [String]()
        var headQuartersstr = [String]()
        var clusterstr  = [String]()
        var jointcallstr  = [String]()
        var doctorsstr  = [String]()
        var chemiststr  = [String]()
        var stockiststr = [String]()
        var unlistedDocstr = [String]()
        modal?.sessionDetails?.forEach({ session in
            if session.isForFieldWork ?? false{
                isFieldWorkExist.append(true)
                if  session.jwName != "" {
                    jointCallstr.append(session.jwName ?? "")
                  }
                if  session.HQCodes != "" {
                    headQuartersstr.append(session.HQCodes ?? "")
                  }
                if  session.clusterCode != "" {
                    clusterstr.append(session.clusterCode ?? "")
                  }
                if  session.jwCode != "" {
                    jointcallstr.append(session.jwCode ?? "")
                  }
                if  session.drCode != "" {
                    doctorsstr.append(session.drCode ?? "")
                  }
                if  session.chemCode != "" {
                    chemiststr.append(session.chemCode ?? "")
                  }
              if session.stockistCode != "" {
                  stockiststr.append(session.stockistCode ?? "")
              }
              if session.unListedDrCode != "" {
                  unlistedDocstr.append(session.unListedDrCode ?? "")
              }
            } else {
                isFieldWorkExist.append(false)
            }
   
            
        })
        
        isFieldWorkExist.forEach { workexist in
            if workexist {
                isForfieldWork = workexist
            }
        }
        
        if isForfieldWork {
            if headQuartersstr.count > 0 {
                detailsArr.append(headQuartersstr)
            }
            if clusterstr.count > 0 {
                detailsArr.append(clusterstr)
            }
            
            if jointcallstr.count > 0 {
                detailsArr.append(jointcallstr)
        
            }
            
            if doctorsstr.count > 0 {
                detailsArr.append(doctorsstr)

            }
            
            if chemiststr.count > 0 {
                detailsArr.append(chemiststr)
            }
            
            if stockiststr.count > 0 {
                detailsArr.append(stockiststr)
            }
            
            if unlistedDocstr.count > 0 {
                detailsArr.append(unlistedDocstr)
            }
        }

        
       
        switch indexPath.row {
            ///  cgfloat value 80 mentioned here belongs to a content view in cell which holds date, options image and other label
         
            /// cgfloat value 80  mentioned here belongs to a collection view cell (if needed give10 points of paddin value)
//
//        case 0:
//
//             (2 * 75) + 80
//        case 1:
//            return 75 + 80
        default:
            if isForfieldWork {
                let size =  detailsArr.count > 5 ?  (2 * 75) + 80 : 75 + 80
                 return CGFloat(size)
            } else {
                return 80
            }
          
        }
    }
    
}
extension TourPlanView : FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance {
    

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("::>--Tapped-->::")
        //  let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: monthPosition) as! CustomCalendarCell
       // self.selectedDate = date
//        let menuvc = MenuVC.initWithStory(self)
//        self.tourplanVC.modalPresentationStyle = .custom
//        menuvc.menuDelegate = self
//        self.tourplanVC.navigationController?.present(menuvc, animated: true)
        print(date)
        let dateformatter = DateFormatter()
        let month = DateFormatter()
        dateformatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM dd, yyyy", options: 0, locale: calendar.locale)
        month.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM yyyy", options: 0, locale: calendar.locale)
        
        
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        print(calendar.currentPage)
        mainDateLbl.text = toTrimDate(date: calendar.currentPage , isForMainLabel: true)
        self.selectedDate = ""
        //"\(values.month!) \(values.year!)"
        //
    }
    
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        // let borderColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.25))
        let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: position) as! CustomCalendarCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        var isExist = Bool()
        let toCompareDate = dateFormatter.string(from: date)
        cell.addedIV.isHidden = true

        self.arrOfPlan?.forEach({ arrPlan in
            if arrPlan.date ==  toCompareDate {
                isExist = true
                
            }
        })
        
        
        
        var isWeeklyoff = Bool()
        let currentDate = date  // Replace this with your desired date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: currentDate)
        if let weekday = components.weekday {
            // The `weekday` property returns the day of the week as an integer (1 to 7, where Sunday is 1).
            // To convert it to the range 0 to 6, you can use modulo arithmetic.
            let dayIndex = (weekday - calendar.firstWeekday + 6) % 7
            print("Day Index: \(dayIndex)")
            if self.weeklyOff?.holiday_Mode   == "\(dayIndex)" {
                isWeeklyoff = true

//                if weeklyOffDates.isEmpty {
//                    self.weeklyOffDates.append(toModifyDate(date: date))
//                    self.weeklyOffRawDates.append(date)
//                } else {
//                    if weeklyOffDates.contains(toModifyDate(date: date)) {
//
//                    } else {
//                        self.weeklyOffDates.append(toModifyDate(date: date))
//                        self.weeklyOffRawDates.append(date)
//                    }
//                }
            }
        } else {
            print("Failed to get the day of the week.")
        }

        //dump(self.weeklyOffRawDates)
        //dump(self.weeklyOffDates)
        var isForHoliday = Bool()
        let responsedates =  self.holidays?.holiday_Date

        if toModifyDate(date: date, isForHoliday: true) == responsedates {
            isForHoliday = true
        }

        
        cell.addedIV.isHidden = isExist  ? false : true
        //|| isWeeklyoff || isForHoliday
        cell.customLabel.text = toTrimDate(date: date)
        cell.customLabel.textColor = .appTextColor
        cell.customLabel.setFont(font: .medium(size: .BODY))
        cell.customLabel.textColor = .appTextColor
       // cell.customLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        cell.titleLabel.isHidden = true
        cell.shapeLayer.isHidden = true
       // cell.shapeLayer.frame = bounds
        cell.layer.borderColor = UIColor.appSelectionColor.cgColor
          cell.layer.borderWidth = 0.5
       // cell.layer.masksToBounds = true
      //  cell.layer.addSublayer(addExternalBorder())
        if selectedDate == cell.customLabel.text {
            cell.contentHolderView.backgroundColor = .appSelectionColor
        } else {
            cell.contentHolderView.backgroundColor = .clear
        }
        

        cell.addTap {
         
            self.selectedDate =  self.toTrimDate(date: date)
            self.tourPlanCalander.collectionView.reloadData()
            
            self.moveToMenuVC(date, isForWeekOff: isWeeklyoff, isforHoliday: isForHoliday)

        }
        
        return cell
    }
    
    func toModifyDate(date: Date, isForHoliday: Bool? = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = (isForHoliday ?? false) ? "yyyy-MM-dd" : "d MMMM yyyy"
        return dateFormatter.string(from: date )
    }

}

extension TourPlanView: MenuResponseProtocol {
    func sessionRemoved() {
        print("Yet to delete")
    }
    
    func callPlanAPI() {
        toLoadData()
        print("Called")
    }
    

}

