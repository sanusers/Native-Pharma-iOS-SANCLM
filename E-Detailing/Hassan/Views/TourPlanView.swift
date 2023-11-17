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
   
            return (2 * 100) + 100
        case 1:
            return 100 + 100
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
    
    //MARK: - Properties
    
    var tourplanVC : TourPlanVC!
    let appGraycolor = UIColor(hex: "#EEEEEE")
    
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
        tourPlanCalander.headerHeight = 6.0 // this makes some extra spacing, but you can try 0 or 1
        //tourPlanCalander.daysContainer.backgroundColor = UIColor.gray
        tourPlanCalander.appearance.borderDefaultColor = appGraycolor
        tourPlanCalander.appearance.borderRadius = 0.5
        tourPlanCalander.placeholderType = .none
        //tourPlanCalander.placeholderType = FSCalendarPlaceholderTypeNone;
        tourPlanCalander.calendarWeekdayView.backgroundColor = appGraycolor
        self.tourPlanCalander.appearance.todayColor = appGraycolor
        self.tourPlanCalander.appearance.weekdayTextColor = appGraycolor
      
        self.tourPlanCalander.appearance.headerTitleFont = UIFont(name: "Satoshi-Medium", size: 18)
        self.tourPlanCalander.appearance.weekdayFont = UIFont(name: "Satoshi-Medium", size: 16)
        self.tourPlanCalander.appearance.subtitleFont = UIFont(name: "Satoshi-Medium", size: 16)
        
        self.tourPlanCalander.appearance.borderRadius = 0
        self.tourPlanCalander.scrollDirection = .horizontal
      //  self.tourPlanCalander.register(FSCalendarCell.self, forCellReuseIdentifier: "DateCell")
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
        titleHolder.elevate(2)
        titleHolder.layer.cornerRadius = 5
        worksPlanTable.separatorStyle = .none
        cellRegistration()
        updateCalender()
       // toLoadCalenderData()
        toLoadData()
      
        calenderHolderView.elevate(2)
        calenderHolderView.layer.cornerRadius = 5

        bottomButtonsHolderView.layer.cornerRadius = 5
        generalButtonsHolder.layer.cornerRadius = 5
        
        worksPlanTable.elevate(2)
        worksPlanTable.layer.cornerRadius = 10
    }
    
    
    func toTrimDate(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
}

extension TourPlanView : FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("::>--Tapped-->::")
        let menuvc = MenuVC.initWithStory(self)
        self.tourplanVC.modalPresentationStyle = .custom
        menuvc.menuDelegate = self
        self.tourplanVC.navigationController?.present(menuvc, animated: true)
        print(date)
        let dateformatter = DateFormatter()
        let month = DateFormatter()
        dateformatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM dd, yyyy", options: 0, locale: calendar.locale)
        month.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM yyyy", options: 0, locale: calendar.locale)
        
    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        let color = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.65))
//        return color
//    }
    
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let borderColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.25))
        let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: position) as! CustomCalendarCell
        
        
        cell.customLabel.text = toTrimDate(date: date)
        cell.customLabel.textColor = UIColor.gray
        cell.customLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
       
       // cell.addSubview(dateLbl)
        
        cell.titleLabel.isHidden = true
        cell.shapeLayer.isHidden = true
       // cell.layer.borderColor = borderColor.cgColor
      //  cell.layer.borderWidth = 0.5
        cell.layer.masksToBounds = true
        cell.layer.masksToBounds = true
        return cell
    }
    
    

    

    
}


extension TourPlanView: MenuResponseProtocol {
    func callPlanAPI() {
        print("Called")
    }
    

}
class CustomCalendarCell: FSCalendarCell {

    // Your custom label
    var customLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        // Initialize and configure your custom label
        customLabel = UILabel()
        customLabel.textAlignment = .right
        addSubview(customLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Adjust the position of the custom label
        customLabel.frame = CGRect(x: self.width - self.height / 3 - 10, y: 10, width: self.height / 3, height: self.height / 3)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // Reset the state of the custom cell
        customLabel.text = nil
    }
}
