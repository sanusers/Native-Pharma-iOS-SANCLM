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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : worksPlanTVC = tableView.dequeueReusableCell(withIdentifier: "worksPlanTVC", for: indexPath) as! worksPlanTVC
        
        cell.toLOadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            ///  cgfloat value 100 mentioned here belongs to a content view in cell which holds date, options image and other label
         
            /// cgfloat value 100  mentioned here belongs to a collection view cell (if needed give10 points of paddin value)
        case 0:
   
            return (2 * 75) + 80
        case 1:
            return 75 + 80
        default:
           return 0
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
    
    
    //MARK: - Properties
    var selectedDate: String = ""
    var tourplanVC : TourPlanVC!
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
        toSetPagetype(ofType: .general)
        setupUI()
        initViews()
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

    private func moveCurrentPage(moveUp: Bool) {
            
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
      //  let date = Calendar.current.date(from: dateComponents)
      
     
        
     
        
        self.tourPlanCalander.setCurrentPage(self.currentPage!, animated: true)
        
//        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.tourPlanCalander.currentPage)
//       let year = values.year
//        let month = values.month?.description
     
      //  mainDateLbl.text = "\(values.month!) \(values.year!)"
        //toTrimDate(date: date ?? Date(), isForMainLabel: true)
    }
    
    func cellRegistration() {
        worksPlanTable.register(UINib(nibName: "worksPlanTVC", bundle: nil), forCellReuseIdentifier: "worksPlanTVC")
        //tourPlanCalander.collectionView.register(UINib(nibName: "FSCalendarCVC", bundle: nil), forCellWithReuseIdentifier: "FSCalendarCVC")
    }
    
    func toLoadData() {
        worksPlanTable.delegate = self
        worksPlanTable.dataSource = self
        worksPlanTable.reloadData()
    }
    
    func toLoadCalenderData() {
        tourPlanCalander.delegate = self
        tourPlanCalander.dataSource = self
        tourPlanCalander.reloadData()
    }
    
    private func updateCalender () {
        

       
        
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
        
        worksPlanTable.elevate(2)
        worksPlanTable.layer.cornerRadius = 10
    }
    
    
    func toTrimDate(date : Date, isForMainLabel: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = isForMainLabel == true ? "MMMM yyyy" : "dd"
        return dateFormatter.string(from: date)
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let toCompareDate = dateFormatter.string(from: date )
        cell.addTap {
       
          
            
            self.selectedDate =  self.toTrimDate(date: date)
            
            self.tourPlanCalander.reloadData()
            
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
        
        return cell
    }
}

extension TourPlanView: MenuResponseProtocol {
    func sessionRemoved() {
        print("Yet to delete")
    }
    
    func callPlanAPI() {
        self.worksPlanTable.reloadData()
        print("Called")
    }
    

}

