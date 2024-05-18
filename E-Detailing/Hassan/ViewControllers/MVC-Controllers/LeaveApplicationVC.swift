//
//  LeaveApplicationVC.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 12/07/23.
//

import Foundation
import UIKit
import Charts
import UICircularProgressRing
import Alamofire

extension LeaveApplicationVC: CustomCalenderViewDelegate {
    
    
    func didClose() {
        backgroundView.isHidden = true
         backgroundView.alpha = 0.3
         self.view.subviews.forEach { aAddedView in
             
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
    
    func didSelectDate(selectedDate: Date) {
        backgroundView.isHidden = true
         backgroundView.alpha = 0.3
         self.view.subviews.forEach { aAddedView in
             
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

class LeaveApplicationVC: UIViewController {
    
    
    
    class func initWithStory() -> LeaveApplicationVC {
        let tourPlanVC : LeaveApplicationVC = UIStoryboard.Hassan.instantiateViewController()
        //tourPlanVC.tourplanVM = TourPlanVM()
        return tourPlanVC
    }
    
    func setupUI() {
        backgroundView.isHidden = true
     //   self.view.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        //contentsHolder.backgroundColor = .appLightGrey
        let holerCurvedViews: [UIView] = [viewLeaveAvailablity, ViewLeaveinfo]
        holerCurvedViews.forEach { aView in
            aView.layer.cornerRadius = 5
        }
        
        leaveEntryHolderVIew.layer.borderWidth = 1
        leaveEntryHolderVIew.layer.borderColor = UIColor.appBlue.cgColor
        leaveEntryHolderVIew.layer.cornerRadius = 5
        tableHolderVXview.backgroundColor = .appBlue.withAlphaComponent(0.1)
        let selectionViews: [UIView] = [leaveTypeCurveView, addressEnterCurveView, reasonEnterCurveView,  attachmentCurveView, toDateCurveVIew, fromDateCurveView]
        selectionViews.forEach { aView in
            aView.layer.borderWidth = 1
            aView.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.2).cgColor
            aView.layer.cornerRadius = 5
        }
        
        backHolderView.addTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        fromDateCurveView.addTap {
            self.calenderAction()
        }
        
        backgroundView.addTap {
            self.didClose()
        }
    }
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var tableHolderVXview: UIVisualEffectView!
    
    @IBOutlet var contentsHolder: UIView!
    @IBOutlet var leaveTypeCurveView: UIView!
    
    @IBOutlet var leaveEntryHolderVIew: UIView!
    @IBOutlet var addressEnterCurveView: UIView!
    @IBOutlet var reasonEnterCurveView: UIView!
    @IBOutlet var attachmentCurveView: UIView!
    @IBOutlet var toDateCurveVIew: UIView!
    @IBOutlet var fromDateCurveView: UIView!
    
    @IBOutlet weak var lblLeaveDateFrom: UILabel!
    @IBOutlet weak var lblLeaveToDate: UILabel!
    @IBOutlet weak var lblLeaveType : UILabel!
    @IBOutlet weak var lblChooseFile: UILabel!
    
    @IBOutlet weak var lblLeaveTotalDaysWithType: UILabel!
    
    @IBOutlet weak var lblRemaining: UILabel!
    
    @IBOutlet weak var lblLeaveTypeValue: UILabel!
    
    
    @IBOutlet weak var lblAttachment: UILabel!
    
    @IBOutlet weak var lblSize: UILabel!
    
    @IBOutlet weak var txtFromDate: UILabel!
    
    @IBOutlet weak var txtToDate: UILabel!
    
    
    @IBOutlet weak var txtViewLeaveReason: UITextView!
    @IBOutlet weak var txtViewLeaveAddress: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    
    @IBOutlet weak var viewLeaveAvailablity: UIStackView!
    
    @IBOutlet var ViewLeaveinfo: UIView!
    
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet weak var viewAttachment: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var lblLeaveHide: UILabel!
    
    var customCalenderView: CustomCalenderView?
    
    var isFromToDate : Bool = false
    var fromDate : Date?
    var toDate : Date?
    
    var totalDays = [Date]()
    
//    var selectedLeaveType : LeaveType?
    
    var leaveStatus = [LeaveStatus]()
    
    var selectedLeaveType : LeaveType! {
        didSet {
            guard let selectedLeaveType = self.selectedLeaveType else{
                return
            }
            
            self.lblLeaveTypeValue.text = selectedLeaveType.leaveName
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let checkinVIewwidth = view.bounds.width / 3.5
        let checkinVIewheight = view.bounds.height / 2
        
        let checkinVIewcenterX = view.bounds.midX - (checkinVIewwidth / 2)
        let checkinVIewcenterY = view.bounds.midY - (checkinVIewheight / 2)

        customCalenderView?.frame = CGRect(x: checkinVIewcenterX, y: checkinVIewcenterY, width: checkinVIewwidth, height: checkinVIewheight)
        
    }
    
    func calenderAction() {
        
    
        backgroundView.isHidden = false
        backgroundView.alpha = 0.3
        //  backgroundView.toAddBlurtoVIew()
        self.view.subviews.forEach { aAddedView in
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
        
        customCalenderView = self.loadCustomView(nibname: XIBs.customCalenderView) as? CustomCalenderView
        customCalenderView?.setupUI()
        customCalenderView?.completion = self
        //customCalenderView?.delegate = self
        //customCalenderView?.setupTaggeImage(fetchedImageData: imageData)
        self.view.addSubview(customCalenderView ?? CustomCalenderView())
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.tableView.register(UINib(nibName: "LeaveStatusCell", bundle: nil), forCellReuseIdentifier: "LeaveStatusCell")
        self.collectionView.register(UINib(nibName: "LeaveAvailablityCell", bundle: nil), forCellWithReuseIdentifier: "LeaveAvailablityCell")
        
        self.btnSubmit.layer.cornerRadius = 5

        
        self.fetchLeave()
        
        self.updateLabel()

    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
//    @IBAction func fromDateAction(_ sender: UIButton) {
//        let appsetup = AppDefaults.shared.getAppSetUp()
//        
//        let calenterVC = UIStoryboard.calenderVC
//        if appsetup.pastLeavePost == 1 {
//            calenterVC.minDate = Date()
//        }
//        calenterVC.didSelectCompletion { selectedDat in
//            let dateString = selectedDat.toString(format: "MMM dd, yyyy")
//            self.fromDate = selectedDat
//            self.txtFromDate.text = dateString
//            
//            self.txtToDate.text = ""
//            self.toDate = nil
//            self.selectedLeaveType = nil
//            self.lblLeaveTypeValue.text = "Select Leave Type"
//        }
//        self.present(calenterVC, animated: true)
//        
//    }
    
//    @IBAction func toDateAction(_ sender: UIButton) {
//        if self.fromDate == nil {
//            return
//        }
//        let calenterVC = UIStoryboard.calenderVC
//        calenterVC.minDate = self.fromDate
//        calenterVC.didSelectCompletion { selectedDat in
//            let dateString = selectedDat.toString(format: "MMM dd, yyyy")
//            self.toDate = selectedDat
//            self.txtToDate.text = dateString
//            
//            self.selectedLeaveType = nil
//            self.lblLeaveTypeValue.text = "Select Leave Type"
//        }
//        self.present(calenterVC, animated: true)
//        
//    }
    
    @IBAction func leaveTypeAction(_ sender: UIButton) {
 
        
     //   let leaveType = DBManager.shared.getLeaveType()
        

    }
    
    
    @IBAction func uploadDocAction(_ sender: UIButton) {
        
        // crm.saneforce.in/iOSServer/db_module.php?axn=save/leavemodule
        
       // {"tableName":"saveleave","sfcode":"MR0026","FDate":"2023-7-6","TDate":"2023-7-6","LeaveType":"CL","NOD":"1","LvOnAdd":"","LvRem":"test","division_code":"8,","Rsf":"MR0026","sf_type":"1","Designation":"TBM","state_code":"28","subdivision_code":"62,","sf_emp_id":"give emp id here","leave_typ_code":"give leavetype code here"}
        
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        if self.fromDate == nil || self.toDate == nil {
            return
        }else if self.selectedLeaveType == nil{
            return
        }
        
        let appsetup = AppDefaults.shared.getAppSetUp()
    
        let fromDate = self.fromDate!.toString(format: "yyyy-MM-dd")
        let toDate = self.toDate!.toString(format: "yyyy-MM-dd")
        
        let leaveRemarks = self.txtViewLeaveReason.text!
        let leaveAddress = self.txtViewLeaveAddress.text!
        
        let selectedLeaveType = self.selectedLeaveType
        
        let url = APIUrl + "save/leavemodule"
        
        let paramString = "{\"tableName\":\"saveleave\",\"sfcode\":\"\(appsetup.sfCode!)\",\"FDate\":\"\(fromDate)\",\"TDate\":\"\(toDate)\",\"LeaveType\":\"\(selectedLeaveType?.leaveSName ?? "")\",\"NOD\":\"2\",\"LvOnAdd\":\"\(leaveAddress)\",\"LvRem\":\"\(leaveRemarks)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\",\"sf_emp_id\":\"\(appsetup.sfEmpId!)\",\"leave_typ_code\":\"\(selectedLeaveType?.leaveCode ?? "")\"}"

        let data = ["data" : paramString]
        
        print(url)
        print(data)
        
        AF.request(url,method: .post,parameters: data).responseData { (response) in

            switch response.result {
            case .success(_):
                do{
                    let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                    print(apiResponse)
                }catch{
                    print(response.error as Any)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    
    private func updateLabel() {
        

        let color = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.65))
        
        let fromDate = NSMutableAttributedString(string: "Leave Date From*",attributes: [NSAttributedString.Key.foregroundColor : color])
        fromDate.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: NSMakeRange(15, 1))
        self.lblLeaveDateFrom.attributedText = fromDate
        
        let toDate = NSMutableAttributedString(string: "Leave Date To*",attributes: [NSAttributedString.Key.foregroundColor : color])
        toDate.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: NSMakeRange(13, 1))
        self.lblLeaveToDate.attributedText = toDate
        
        let leaveType = NSMutableAttributedString(string: "Leave Type*",attributes: [NSAttributedString.Key.foregroundColor : color])
        leaveType.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: NSMakeRange(10, 1))
        self.lblLeaveType.attributedText = leaveType
        
//        let text = NSMutableAttributedString(
//          string: "Choose file to upload",
//          attributes: [.font: UIFont(name: "Satoshi-Bold", size: 14) as Any])
//        text.addAttributes([.font: UIFont(name: "Satoshi-Regular", size: 14) as Any], range: NSMakeRange(12,9))
//        self.lblChooseFile.attributedText = text
    }
    
    
    private func leaveValidationApi() {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let fromDate = self.fromDate!.toString(format: "yyyy-MM-dd")
        let toDate = self.toDate!.toString(format: "yyyy-MM-dd")
        
        let url = APIUrl + "table/leave"
        
        let paramString = "{\"tableName\":\"getlvlvalid\",\"sfcode\":\"\(appsetup.sfCode!)\",\"Fdt\":\"\(fromDate)\",\"Tdt\":\"\(toDate)\",\"LTy\":\"\(self.selectedLeaveType?.leaveSName ?? "")\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        let data = ["data" : paramString]
        
        print(url)
        print(paramString)
        
        AF.request(url,method: .post,parameters: data).responseData{ (response) in
            
            switch response.result {
                
            case .success(_):
                do{
                    let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                    print(apiResponse)
                    self.updateLeaveRequest()
                }catch{
                    print(response.error as Any)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchLeave() {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        let url = APIUrl + "table/leave"
        
        let paramString = "{\"tableName\":\"getleavestatus\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        let data = ["data" : paramString]
        Shared.instance.showLoaderInWindow()
        AF.request(url,method: .post,parameters: data).responseData{ (response) in
            Shared.instance.removeLoaderInWindow()
            switch response.result {
                
            case .success(_):
                do{
                    let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                    print(apiResponse)
                    
                    guard let responseArray = apiResponse as? [[String : Any]] else{
                        return
                    }
                    
                    self.leaveStatus  = responseArray.map{LeaveStatus(fromDictionary: $0)}
                    self.collectionView.reloadData()
                    
                }catch{
                    print(response.error as Any)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    private func updateLeaveRequest() {
        
        guard let fromDate = self.fromDate, let toDate = self.toDate else{
            return
        }
        
        print(fromDate)
        print(toDate)
        
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: fromDate)
        let date2 = calendar.startOfDay(for: toDate)
        
        let datesBetweenArray = Date.dates(from: date1, to: date2)
        
        self.totalDays = datesBetweenArray
        self.tableView.reloadData()
    }
    
}


extension LeaveApplicationVC : tableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.totalDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaveStatusCell", for: indexPath) as! LeaveStatusCell
        cell.lblDate.text = self.totalDays[indexPath.row].toString(format: "MMM dd, yyyy")
        return cell
    }
}


extension LeaveApplicationVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.leaveStatus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaveAvailablityCell", for: indexPath) as! LeaveAvailablityCell
        cell.leaveStatus = self.leaveStatus[indexPath.row]
        cell.viewLop.isHidden = self.leaveStatus[indexPath.row].leaveTypeCode == "LOP" ? false : true
        return cell
    }
}



extension LeaveApplicationVC: UITextViewDelegate {
    
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        if self.selectedLeaveType != nil{
//            return true
//        }else{
//
//            return false
//        }
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case txtViewLeaveReason:
            if textView.text.isEmpty {
                textView.text = "Enter leave Reason"
                textView.textColor = UIColor.lightGray
            }
            break
        default:
            if textView.text.isEmpty {
                textView.text = "Enter the remarks"
                textView.textColor = UIColor.lightGray
            }
            break
        }
    }
}


extension Date{
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}



struct LeaveStatus{
    
    var available : String!
    var eligibility : String!
    var leaveTypeCode : String!
    var leaveCode : String!
    var taken : String!
    
    
    init(fromDictionary dictionary: [String:Any]){

        available = dictionary["Avail"] as? String ?? ""
        eligibility = dictionary["Elig"] as? String ?? ""
        leaveTypeCode = dictionary["Leave_Type_Code"] as? String ?? ""
        leaveCode = dictionary["Leave_code"] as? String ?? ""
        taken = dictionary["Taken"] as? String ?? ""
        
    }
}




