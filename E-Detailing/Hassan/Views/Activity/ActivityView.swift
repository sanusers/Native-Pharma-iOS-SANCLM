//
//  ActivityView.swift
//  SAN ZEN
//
//  Created by San eforce on 05/08/24.
//

import Foundation
import UIKit
class ActivityView: BaseView {
//    func containsOnlyApprovedCharacters(in userText: String, toCheckString: String) -> Bool {
//        let approvedCharacters = Set(toCheckString)
//        
//        for char in userText {
//            if !approvedCharacters.contains(char) {
//                return false
//            }
//        }
//        
//        return true
//    }
  //  var dayReportsSortView: DayReportsSortView?
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var titleLBL: UILabel!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var sortCalenderView: UIView!
    
    @IBOutlet var sortSearchView: UIView!
    
    @IBOutlet var sortFiltersView: UIView!
    
    @IBOutlet var filterDateTF: UITextField!
    
    @IBOutlet var activitiesTable: UITableView!
    
    @IBOutlet var noreportsView: UIView!
    
    @IBOutlet var noreportsLbl: UILabel!
    
    @IBOutlet var searchTF: UITextField!
    
    @IBOutlet var clearView: UIView!
    
    @IBOutlet var resourceHQlbl: UITextField!
    
    @IBOutlet var resouceHQholderVIew: UIView!
    
    @IBOutlet var viewActivity: UIView!
    @IBOutlet var calendarView: UIView!
    var selectedSortIndex: Int? = nil
    
    var isSortPresented = false

    var isMatched : Bool = false

    var fromDate: Date?
    var customCalenderView: CustomCalenderView?
    
    var activityVC : ActivityVC!
    
    override func didLoad(baseVC: BaseViewController) {
        
        self.activityVC = baseVC as? ActivityVC
      //  self.setupUI()

        
    }
    
    override func didLayoutSubviews(baseVC: BaseViewController) {
        super.didLayoutSubviews(baseVC: baseVC)

        let checkinVIewwidth = self.bounds.width / 3
        let checkinVIewheight = self.bounds.height / 2
        
        let checkinVIewcenterX = self.bounds.midX - (checkinVIewwidth / 2)
        let checkinVIewcenterY = self.bounds.midY - (checkinVIewheight / 2)

        customCalenderView?.frame = CGRect(x: checkinVIewcenterX, y: checkinVIewcenterY, width: checkinVIewwidth, height: checkinVIewheight)
        
        
    }
    
    func setupUI() {
        self.noreportsView.isHidden = true
        backgroundView.isHidden = true
        self.noreportsLbl.setFont(font: .bold(size: .BODY))
        //searchTF.delegate = self
        initTaps()
       //searchTF.placeholder = UIFont(name: "Satoshi-Bold", size: 14)
        searchTF.font = UIFont(name: "Satoshi-Bold", size: 14)
        titleLBL.setFont(font: .bold(size: .BODY))

        filterDateTF.font = UIFont(name: "Satoshi-Bold", size: 14)
     
        filterDateTF.text = toConvertDate(date: Date())
        self.fromDate = Date()
        filterDateTF.isUserInteractionEnabled = false
        resourceHQlbl.isUserInteractionEnabled = false
        cellRegistration()
        activitiesTable.separatorStyle = .none
        self.backgroundColor = .appGreyColor
        sortCalenderView.layer.borderColor = UIColor.appTextColor.cgColor
        sortCalenderView.layer.borderWidth = 0.5
        sortCalenderView.backgroundColor = .appWhiteColor
       // sortCalenderView.elevate(2)
        sortCalenderView.layer.cornerRadius = 5
        resouceHQholderVIew.layer.cornerRadius = 5
        sortSearchView.backgroundColor = .appWhiteColor
       // sortSearchView.elevate(2)
        sortSearchView.layer.cornerRadius = 5
        
       // sortFiltersView.elevate(2)
        sortFiltersView.layer.cornerRadius = 5
        
        
        initTaps()
    }
    
    
    func setHQlbl() {
        // let appsetup = AppDefaults.shared.getAppSetUp()
            CoreDataManager.shared.toRetriveSavedDayPlanHQ { hqModelArr in
                let savedEntity = hqModelArr.first
                guard let savedEntity = savedEntity else{
                    
                    self.resourceHQlbl.text = "Select HQ"
                    
                    return
                    
                }
                
                self.resourceHQlbl.text = savedEntity.name == "" ? "Select HQ" : savedEntity.name
                
                let subordinates = DBManager.shared.getSubordinate()
                
                let asubordinate = subordinates.filter{$0.id == savedEntity.code}
                
                if !asubordinate.isEmpty {
                 //  self.fetchedHQObject = asubordinate.first
                 //   LocalStorage.shared.setSting(LocalStorage.LocalValue.selectedRSFID, text:  asubordinate.first?.id ?? "")
                }
            
              
  
 
                
            }
            // Retrieve Data from local storage
               return
        

       
    }
    
    func toConvertDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return  formatter.string(from: date)
       
        
    }
    
    func cellRegistration() {
        
    }
    
    func initTaps() {
        
    }
    
    func calenderAction(isForFrom: Bool) {
        
    
        backgroundView.isHidden = false
        backgroundView.alpha = 0.3
        //  backgroundView.toAddBlurtoVIew()
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case customCalenderView:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1

            case backgroundView:
                aAddedView.isUserInteractionEnabled = true
              
            default:
                print("Yet to implement")
          
                
                aAddedView.isUserInteractionEnabled = false
              
                
            }
            
        }
        
        customCalenderView = self.activityVC.loadCustomView(nibname: XIBs.customCalenderView) as? CustomCalenderView
        customCalenderView?.setupUI(isPastDaysAllowed: true)
        customCalenderView?.today = self.fromDate ?? Date()
       // customCalenderView?.currentPage = self.fromDate ?? Date()
        customCalenderView?.isFromReports = true
        customCalenderView?.completion = self
        customCalenderView?.selectedFromDate = fromDate
        customCalenderView?.isForFrom = isForFrom

        self.addSubview(customCalenderView ?? CustomCalenderView())
        
    }

}

extension ActivityView: CustomCalenderViewDelegate {
    
    @objc func donedatePicker(){

    guard let fromDate = self.fromDate else {return}
    filterDateTF.text = toConvertDate(date: fromDate)
  //   self.detailedreporsVC.toSetParamsAndGetResponse(fromDate)
     self.endEditing(true)
   }
    
    func didClose() {
        backgroundView.isHidden = true
       // stopBackgroundColorAnimation(view: toDateCurveVIew)
       // stopBackgroundColorAnimation(view: fromDateCurveView)
    
         backgroundView.alpha = 0.3
         self.subviews.forEach { aAddedView in
             
             switch aAddedView {

             case customCalenderView:
                 aAddedView.removeFromSuperview()
                 aAddedView.alpha = 0
                 
             default:
                 aAddedView.isUserInteractionEnabled = true
                 aAddedView.alpha = 1
                 print("Yet to implement")
                 
                 // aAddedView.alpha = 1
                 
             }
             
         }
    }
    
    func didSelectDate(selectedDate: Date, isforFrom: Bool) {

        self.fromDate = selectedDate
        donedatePicker()

        backgroundView.isHidden = true
         backgroundView.alpha = 0.3
         self.subviews.forEach { aAddedView in
             
             switch aAddedView {

             case customCalenderView:
                 aAddedView.removeFromSuperview()
                 aAddedView.alpha = 0
                 
             default:
                 aAddedView.isUserInteractionEnabled = true
                 aAddedView.alpha = 1
                 print("Yet to implement")
                 
                 // aAddedView.alpha = 1
                 
             }
             
         }
    }
    
    
}
