//
//  TourPlanView.swift
//  E-Detailing
//
//  Created by San eforce on 09/11/23.
//

import Foundation
import UIKit
import FSCalendar





extension TourPlanView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArrofPlan?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : worksPlanTVC = tableView.dequeueReusableCell(withIdentifier: "worksPlanTVC", for: indexPath) as! worksPlanTVC
        let modal =  self.tempArrofPlan?[indexPath.row]
        cell.toPopulateCell(modal ?? SessionDetailsArr())
        
        cell.addTap {
            self.moveToMenuVC(modal?.rawDate ?? Date())
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
        modal?.sessionDetails.forEach({ session in
            if session.isForFieldWork{
                isFieldWorkExist.append(true)
                if  session.jwName != "" {
                    jointCallstr.append(session.jwName)
                  }
                if  session.HQCodes != "" {
                    headQuartersstr.append(session.HQCodes)
                  }
                if  session.clusterCode != "" {
                    clusterstr.append(session.clusterCode)
                  }
                if  session.jwCode != "" {
                    jointcallstr.append(session.jwCode)
                  }
                if  session.drCode != "" {
                    doctorsstr.append(session.drCode)
                  }
                if  session.chemCode != "" {
                    chemiststr.append(session.chemCode)
                  }
              if session.stockistCode != "" {
                  stockiststr.append(session.stockistCode)
              }
              if session.unListedDrCode != "" {
                  unlistedDocstr.append(session.unListedDrCode)
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

class TourPlanView: BaseView {
    

    
    //MARK: - Outlets
    ///  common
    @IBOutlet var overAllContentsHolder: UIView!
    
    @IBOutlet var calenderHolderView: UIView!
    
    @IBOutlet var tourPlanCalander: FSCalendar!
    
    @IBOutlet var tableElementsHolderView: UIView!
    
    @IBOutlet var bottomButtonsHolderView: UIView!
    
    @IBOutlet var worksPlanTable: UITableView!
    
    @IBOutlet var backHolder: UIView!
    /// General page type outlets
    @IBOutlet var lblSendToApproval: UILabel!
    @IBOutlet var generalButtonsHolder: UIView!
    
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
    var tableSetupmodel: TableSetupModel?
   // let appGraycolor = UIColor(hex: "#EEEEEE")
   // let cellSelectionColor = UIColor(hex: "#F2F2F7")
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
           let month = toGetMonth(plan.rawDate)
            if month == tocomparemonth {
                thisMonthPaln.append(plan)
            }
        })
      
            self.tempArrofPlan = thisMonthPaln
        
      
        worksPlanTable.delegate = self
        worksPlanTable.dataSource = self
        worksPlanTable.reloadData()
        self.tourPlanCalander.collectionView.reloadData()
        
    }
    
    func toGetMonth(_ date: Date)  -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date )
    }
    
    func toLoadData() {
        self.arrOfPlan = [SessionDetailsArr]()
        var tpArray =  [TourPlanArr]()

        AppDefaults.shared.eachDatePlan.tourPlanArr.enumerated().forEach { index, eachDayPlan in
            tpArray.append(eachDayPlan)
        }
        AppDefaults.shared.eachDatePlan.tourPlanArr.forEach({ tpArr in
            self.arrOfPlan = tpArr.arrOfPlan
        })
        self.tableSetupmodel = TableSetupModel()
        
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
    
    private func updateCalender () {
        

       
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
        titleHolder.elevate(2)
        titleHolder.backgroundColor = .appSelectionColor
        titleHolder.layer.cornerRadius = 5
        worksPlanTable.separatorStyle = .none
        cellRegistration()
        updateCalender()
        toLoadData()
      
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
    
    
    func moveToMenuVC(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let toCompareDate = dateFormatter.string(from: date )
          self.selectedDate =  self.toTrimDate(date: date)
       //   self.tourPlanCalander.reloadData()
          
                  let menuvc = MenuVC.initWithStory(self, date)
                  self.tourplanVC.modalPresentationStyle = .custom
                  menuvc.menuDelegate = self
          
         // var isExist = Bool()
          AppDefaults.shared.eachDatePlan.tourPlanArr.enumerated().forEach { index, eachDayPlan in
              eachDayPlan.arrOfPlan.enumerated().forEach { index, sessions in
                  if sessions.date == toCompareDate {
                      menuvc.sessionDetailsArr = sessions
                  }
              }
          }
    self.tourplanVC.navigationController?.present(menuvc, animated: true)
    }
}

extension TourPlanView : FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance, UICollectionViewDelegateFlowLayout {
    
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
        cell.addedIV.isHidden = isExist ? false : true
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
            self.moveToMenuVC(date)

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == tourPlanCalander.collectionView {
            return 0
        }
    return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == tourPlanCalander.collectionView {
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tourPlanCalander.collectionView {
            return CGSize(width: collectionView.width / 7, height: collectionView.height / 5)
        }
      return CGSize()
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

