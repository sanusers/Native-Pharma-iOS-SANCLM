//
//  MainVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 21/07/23.
//

import UIKit
import Foundation
import FSCalendar
import UICircularProgressRing
import Alamofire


typealias collectionViewProtocols = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
typealias tableViewProtocols = UITableViewDelegate & UITableViewDataSource

class MainVC : UIViewController {
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    @IBOutlet weak var lblAnalysisName: UILabel!
    @IBOutlet weak var lblWorkType: UILabel!
    @IBOutlet weak var lblHeadquarter: UILabel!
    @IBOutlet weak var lblCluster: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var txtViewRemarks: UITextView!
    
    
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnSync: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnActivity: UIButton!
    
    
    @IBOutlet weak var segmentControlForDcr: UISegmentedControl!
    @IBOutlet weak var segmentControlForAnalysis: UISegmentedControl!
    
    @IBOutlet weak var salesStackView: UIStackView!
    @IBOutlet weak var callStackView: UIStackView!
    @IBOutlet weak var slideStackView: UIStackView!
    
    // views
    
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewAnalysis: UIView!
    @IBOutlet weak var viewQuickLinks: UIView!
    
    @IBOutlet weak var viewWorkPlan: UIView!
    @IBOutlet weak var viewCalls: UIView!
    @IBOutlet weak var viewOutBox: UIView!
    
    
    @IBOutlet weak var viewDayPlanStatus: UIView!
    
    @IBOutlet weak var viewSideMenu: UIView!
    @IBOutlet weak var viewProfile: UIView!
    
    @IBOutlet weak var viewWorkType: UIView!
    @IBOutlet weak var viewHeadquarter: UIView!
    @IBOutlet weak var viewCluster: UIView!
    
    
    @IBOutlet weak var viewRemarks: UIView!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var viewPcpmChart: UICircularProgressRing!
    
    
    @IBOutlet weak var viewSalesAnalysisStackView: UIStackView!
    
    
    @IBOutlet weak var quickLinkCollectionView: UICollectionView!
    @IBOutlet weak var dcrCallsCollectionView: UICollectionView!
    @IBOutlet weak var analysisCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var callTableView: UITableView!
    @IBOutlet weak var outboxTableView: UITableView!
    
    
    var selectedWorktype : WorkType? {
        didSet {
            guard let selectedWorktype = self.selectedWorktype else{
                return
            }
            self.lblWorkType.text = selectedWorktype.name
        }
    }
    
    var selectedHeadquarter : Subordinate? {
        didSet {
            guard let selectedHeadquarter = self.selectedHeadquarter else{
                return
            }
            self.lblHeadquarter.text = selectedHeadquarter.name
        }
    }
    
    var selectedCluster : Territory? {
        didSet {
            guard let selectedCluster = self.selectedCluster else{
                return
            }
            self.lblCluster.text = selectedCluster.name
        }
    }
    
    
    var links = [QuicKLink]()
    
    var dcrCount = [DcrCount]()
    
    let eventArr = ["Weekly off","Field Work","Non-Field Work","Holiday","Missed Released","Missed","Re Entry","Leave","TP Devition Released","TP Devition"]//,"Leave Aprroval Pending","Approval Pending"]
    
    
    let menuList = ["Refresh","Tour Plan","Create Presentation","Leave Application","Reports","Activiy","Near Me","Quiz","Survey","Forms","Profiling"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.locationUpdate()
        
        outboxTableView.estimatedRowHeight = 80
        outboxTableView.rowHeight = UITableView.automaticDimension
        
        if #available(iOS 15.0, *) {
            outboxTableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        
        self.viewDate.Border_Radius(border_height: 0, isborder: true, radius: 10)
        
        [btnNotification,btnSync,btnProfile].forEach({$0?.Border_Radius(border_height: 0, isborder: true, radius: 25)})
        
        self.quickLinkCollectionView.register(UINib(nibName: "QuickLinkCell", bundle: nil), forCellWithReuseIdentifier: "QuickLinkCell")
        
        self.dcrCallsCollectionView.register(UINib(nibName: "DCRCallAnalysisCell", bundle: nil), forCellWithReuseIdentifier: "DCRCallAnalysisCell")
        
        self.analysisCollectionView.register(UINib(nibName: "AnalysisCell", bundle: nil), forCellWithReuseIdentifier: "AnalysisCell")
   
        
        self.sideMenuTableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        self.callTableView.register(UINib(nibName: "DCRCallCell", bundle: nil), forCellReuseIdentifier: "DCRCallCell")
        
        self.outboxTableView.register(UINib(nibName: "DCRCallCell", bundle: nil), forCellReuseIdentifier: "DCRCallCell")
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.quickLinkCollectionView.collectionViewLayout = layout
        
        let layout1 = UICollectionViewFlowLayout()
        
        layout1.scrollDirection = .horizontal
        
        self.dcrCallsCollectionView.collectionViewLayout = layout1
        self.analysisCollectionView.collectionViewLayout = layout1
        
        self.viewAnalysis.addGestureRecognizer(createSwipeGesture(direction: .left))
        self.viewAnalysis.addGestureRecognizer(createSwipeGesture(direction: .right))
        
        self.updateLinks()
        self.updateDcr()
        self.updateSegmentForDcr()
        
       // self.segmentControlForAnalysis.removeBorder()
        
        self.segmentControlForAnalysis.fillSelectedSegment()
        
        [viewWorkType,viewHeadquarter,viewCluster,viewRemarks].forEach { view in
            view.layer.borderColor = AppColors.primaryColorWith_40per_alpha.cgColor
            view.layer.borderWidth = 1.5
            view.layer.cornerRadius = 10
        }
        
        [btnCall,btnActivity].forEach { button in
            button.layer.borderColor = AppColors.primaryColorWith_40per_alpha.cgColor
            button.layer.borderWidth = 1
        }
        
        
        self.imgProfile.Border_Radius(border_height: 0.0, isborder: false, radius: 50)
        
        self.updateCalender()
        
        self.updatePCPMChart()
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        self.fetchHome()
        
//        self.fetch()
//        self.fetch1()
        
    }
    
    deinit {
        print("ok bye")
    }
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        
        if btnHome.isSelected == true {
            self.btnHome.isSelected = false
            UIView.animate(withDuration: 0.5) { [self] in
                self.viewSideMenu.alpha = 0
                self.viewSideMenu.isHidden = true
            }
            return
        }
        
        self.viewSideMenu.isHidden = false
        self.viewSideMenu.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.viewSideMenu.alpha = 1
        }
        self.btnHome.isSelected = true
    }
    
    
    @IBAction func dateAction(_ sender: UIButton) {
       
//        if btnDate.isSelected == true {
//            UIView.animate(withDuration: 0.5) { [self] in
//                self.viewDayPlanStatus.alpha = 0
//                self.viewDayPlanStatus.isHidden = true
//            }
//            self.btnDate.isSelected = false
//            return
//        }
        
        self.viewDayPlanStatus.isHidden = false
        self.viewDayPlanStatus.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.viewDayPlanStatus.alpha = 1
        }
        self.btnDate.isSelected = true
    }
    
    
    @IBAction func dcrSegmentControlAction(_ sender: UISegmentedControl) {
        
        self.segmentControlForDcr.underlinePosition()
        
        switch self.segmentControlForDcr.selectedSegmentIndex {
            case 0:
                self.viewWorkPlan.isHidden = false
                self.viewCalls.isHidden = true
                self.viewOutBox.isHidden = true
            case 1:
                self.viewWorkPlan.isHidden = true
                self.viewCalls.isHidden = false
                self.viewOutBox.isHidden = true
                self.callTableView.reloadData()
            case 2:
                self.viewWorkPlan.isHidden = true
                self.viewCalls.isHidden = true
                self.viewOutBox.isHidden = false
                self.outboxTableView.reloadData()
            default:
                break
        }
    }
    
    
    @IBAction func segmentSwipeAction(_ sender: UISegmentedControl) {
        
        
        switch self.segmentControlForAnalysis.selectedSegmentIndex{
            case 0:
                self.lblAnalysisName.text = "Call Analysis"
                self.salesStackView.isHidden = true
                self.slideStackView.isHidden = true
            
                
                self.callStackView.isHidden = false
            case 1:
                self.lblAnalysisName.text = "E-Detailing Analysis"
                self.salesStackView.isHidden = true
                self.slideStackView.isHidden = false
                self.callStackView.isHidden = true
            case 2:
                self.lblAnalysisName.text = "Sales Analysis"
                self.salesStackView.isHidden = false
                self.slideStackView.isHidden = true
                self.callStackView.isHidden = true
            default:
                break
        }
    }
    
    
    
    @IBAction func notificationAction(_ sender: UIButton) {
        
//        let vc = UIStoryboard.singleSelectionRightVC
//        vc.transitioningDelegate = self
//        vc.modalPresentationStyle = .custom
////        vc.modalTransitionStyle = .crossDissolve
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//     //   self.present(vc, animated: true)
        
        
        let v = UIStoryboard.slideDownloadVC
        self.present(v, animated: true)
        
    }
    
    
    @IBAction func masterSyncAction(_ sender: UIButton) {
        
        let masterSync = UIStoryboard.masterSyncVC
        self.navigationController?.pushViewController(masterSync, animated: true)
        
    }
    
    
    @IBAction func profileAction(_ sender: UIButton) {
        
//        if btnProfile.isSelected == true {
//            self.viewProfile.isHidden = true
//            self.btnProfile.isSelected = false
//            return
//        }
        
        self.viewProfile.isHidden = false
//        self.btnProfile.isSelected = true
        
    }
    
    
    @IBAction func profileCloseAction(_ sender: UIButton) {
        
        self.viewProfile.isHidden = true
    }
    
    
    @IBAction func workTypeAction(_ sender: UIButton) {
        
        let workType = DBManager.shared.getWorkType()
        
        
        let selectionVC = UIStoryboard.singleSelectionVC
        selectionVC.selectionData = workType
        selectionVC.didSelectCompletion { selectedIndex in
            self.selectedWorktype = workType[selectedIndex]
        }
        self.present(selectionVC, animated: true)
        
    }
    
    
    
    @IBAction func headquarterAction(_ sender: UIButton) {
        let hq = DBManager.shared.getSubordinate()
        
        
        let selectionVC = UIStoryboard.singleSelectionVC
        selectionVC.selectionData = hq
        selectionVC.didSelectCompletion { selectedIndex in
            self.selectedHeadquarter = hq[selectedIndex]
        }
        self.present(selectionVC, animated: true)
    }
    
    
    @IBAction func clusterAction(_ sender: UIButton) {
        
        let territory = DBManager.shared.getTerritory()
        
        
        let selectionVC = UIStoryboard.singleSelectionVC
        selectionVC.selectionData = territory
        selectionVC.didSelectCompletion { selectedIndex in
            self.selectedCluster = territory[selectedIndex]
        }
        self.present(selectionVC, animated: true)
        
    }
    
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        
        
        // http://crm.saneforce.in/iOSServer/db_ios.php?axn=save/dayplan
        
        
        
        /* "{""tableName"":""dayplan"",""sfcode"":""MGR0571"",""division_code"":""8,"",""Rsf"":""MR0026"",""sf_type"":""1"",""Designation"":""TBM"",""state_code"":""28"",""subdivision_code"":""62,"",""town_code"":""142494"",""Town_name"":""BANGALORE"",""WT_code"":""6"",""WTName"":""Field Work"",""FwFlg"":""F"",""Remarks"":"""",""location"":"""",""InsMode"":""0"",
        ""Appver"":""V2.0.7"",""Mod"":""Android-Edet"",""TPDt"":""2023-06-24 12:52:16"",""TpVwFlg"":""0"",""TP_cluster"":"""",""TP_worktype"":""""}" */
        
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let Date = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
        
        let url = appMainURL + "save/dayplan"
        

        let paramString = "{\"tableName\":\"dayplan\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\",\"town_code\":\"\(self.selectedCluster?.code ?? "")\",\"Town_name\":\"\(self.selectedCluster?.name ?? "")\",\"WT_code\":\"\(self.selectedWorktype!.code ?? "")\",\"WTName\":\"\(self.selectedWorktype!.name ?? "")\",\"FwFlg\":\"\(self.selectedWorktype!.fwFlg ?? "")\",\"Remarks\":\"\(self.txtViewRemarks.text!)\",\"location\":\"\",\"InsMode\":\"0\",\"Appver\":\"V2.0.7\",\"Mod\":\"iOS-Edet-New\",\"TPDt\":\"\(Date)\",\"TpVwFlg\":\"0\",\"TP_cluster\":\"\",\"TP_worktype\":\"\"}"
        
        
        print(paramString)
        
        let params = ["data" : paramString]
        
        AF.request(url,method: .post,parameters: params).responseData(){ (response) in
            
            
            switch response.result {
                
                case .success(_):
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        
                        print("ssususnbjbo")
                        print(apiResponse)
                        print("ssusus")
                        
                        
                        if let response = apiResponse as? [[String : Any]] {
                            
                        }
                    }catch {
                        print(error)
                    }
                case .failure(let error):
                    ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                    print(error)
                    return
            }
        }
    }
    
    
    
    @IBAction func todayCallSyncAction(_ sender: UIButton) {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
        
        let url =  appMainURL + "table/additionaldcrmasterdata"
        
        
        // "crm.saneforce.in/iOSServer/db_module.php?axn=table/additionaldcrmasterdata"
        
        let params : [String : Any] = ["tableName" : "gettodycalls",
                                          "sfcode" : appsetup.sfCode ?? "",
                                          "ReqDt" : date,
                                          "division_code" : appsetup.divisionCode ?? "",
                                          "Rsf" : appsetup.sfCode ?? "",
                                          "sf_type" : appsetup.sfType ?? "",
                                       "Designation" : appsetup.dsName ?? "",
                                       "state_code" : appsetup.stateCode ?? "",
                                       "subdivision_code" : appsetup.subDivisionCode ?? ""
        ]
        
        let param = ["data" : params.toString()]
        
        print(param)
        print(url)
        
        AF.request(url,method: .post,parameters: param).responseData { responseFeed in
            
            switch responseFeed.result {
                
            case .success(_):
                do {
                    
                    let apiResponse = try JSONSerialization.jsonObject(with: responseFeed.data!,options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    print(apiResponse as Any)
                }catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
                return
            }
        }
        
        
    }
    
    
    @IBAction func callAction(_ sender: UIButton) {
        
        let callVC = UIStoryboard.callVC
        
        self.navigationController?.pushViewController(callVC, animated: true)
        
        
    }
    
    
    
    @IBAction func outboxCallSyncAction(_ sender: UIButton) {
        
    }
    
    
    private func fetchHome () {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let url = appMainURL + "home"
        
        let paramString = "{\"tableName\":\"gethome\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!.replacingOccurrences(of: ",", with: ""))\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        
        let params = ["data" : paramString]
        
        print(url)
        print(paramString)
        
        AF.request(url,method: .post,parameters: params).responseData(){ (response) in
            
            switch response.result {
                
                case .success(_):
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        print("ssususnbjbo")
                        print(apiResponse)
                        print("ssusus")
                        
                        if let response = apiResponse as? [[String : Any]]{
                            
                        }
                    }catch {
                        print(error)
                    }
                case .failure(let error):
                    ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                    print(error)
                    return
            }
        }
    }
    
    private func fetch() {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let url = appMainURL + "homedashboard"
        
        let paramString = "{\"tableName\":\"getcallvst\",\"sfcode\":\"MR0026\",\"division_code\":\"8,\",\"Rsf\":\"MR0026\",\"sf_type\":\"1\",\"Designation\":\"TBM\",\"state_code\":\"28\",\"subdivision_code\":\"62,\"}"
        
        let params = ["data" : paramString]
        
        
        AF.request(url,method: .post,parameters: params).responseData(){ (response) in
            
            
            switch response.result {
                
                case .success(_):
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        
                        print("ssususnbjbo")
                        print(apiResponse)
                        print("ssusus")
                        
                        
                        if let response = apiResponse as? [[String : Any]] {
                            
                        }
                    }catch {
                        print(error)
                    }
                case .failure(let error):
                    ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                    print(error)
                    return
            }
        }
    }
    
    private func fetch1() {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let url = appMainURL + "homedashboard"
        
        
        let paramString = "{\"tableName\":\"getcallavgyrcht\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        
        let params = ["data" : paramString]
        
        AF.request(url,method: .post,parameters: params).responseData(){ (response) in
            
            switch response.result {
                
                case .success(_):
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        print("ssususnbjbo")
                        print(apiResponse)
                        print("ssusus")
                        
                        if let response = apiResponse as? [[String : Any]] {
                            
                        }
                    }catch {
                        print(error)
                    }
                case .failure(let error):
                    ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                    print(error)
                    return
            }
        }
    }
    
    private func updatePCPMChart() {
        
        self.viewPcpmChart.startAngle = -90.0
        self.viewPcpmChart.isClockwise = true
        self.viewPcpmChart.font = UIFont(name: "Satoshi-Bold", size: 18)!
        self.viewPcpmChart.fontColor = .darkGray
        if #available(iOS 13.0, *) {
            self.viewPcpmChart.outerRingColor = UIColor.systemGray4
        } else {
            self.viewPcpmChart.outerRingColor = UIColor.lightGray
            // Fallback on earlier versions
        }
        
        self.viewPcpmChart.innerRingColor = UIColor(red: CGFloat(254.0/255.0), green: CGFloat(185.0/255.0), blue: CGFloat(26.0/255.0), alpha: CGFloat(1.0))
        self.viewPcpmChart.innerRingWidth = 25.0
        self.viewPcpmChart.style = .bordered(width: 0.0, color: .black)
        self.viewPcpmChart.outerRingWidth = 25.0
        
        self.viewPcpmChart.maxValue = CGFloat(truncating: 10.0)
        self.viewPcpmChart.startProgress(to: CGFloat(truncating: 4.0), duration: 2)
    }
    
    
    private func updateSegmentForDcr() {
        
        let font = UIFont(name: "Satoshi-Bold", size: 14)!
        self.segmentControlForDcr.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
        self.segmentControlForDcr.highlightSelectedSegment()
        
    }
    
    private func updateCalender () {
        
        let color = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.4))
        
        let headerColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(1.0))
        
        self.calendar.appearance.todayColor = UIColor.clear
        self.calendar.appearance.weekdayTextColor = color
        self.calendar.appearance.headerTitleColor = headerColor
        self.calendar.appearance.headerTitleFont = UIFont(name: "Satoshi-Medium", size: 18)
        self.calendar.appearance.weekdayFont = UIFont(name: "Satoshi-Medium", size: 16)
        self.calendar.appearance.subtitleFont = UIFont(name: "Satoshi-Medium", size: 16)
        self.calendar.appearance.borderRadius = 0
        self.calendar.scrollDirection = .vertical
        self.calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "DateCell")
        self.calendar.reloadData()
    }
    
    private func updateLinks () {
        
        let presentationColor = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(0.15))
        let activityColor = UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(0.15))
        let reportsColor = UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(0.15))
        
        
        let presentation = QuicKLink(color: presentationColor, name: "Presentaion", image: UIImage(imageLiteralResourceName: "presentationIcon"))
        let activity = QuicKLink(color: activityColor, name: "Activity", image: UIImage(imageLiteralResourceName: "activity"))
        let reports = QuicKLink(color: reportsColor, name: "Reports", image: UIImage(imageLiteralResourceName: "reportIcon"))
        
        let slidePreview = QuicKLink(color: UIColor.white, name: "Slide Preview", image: UIImage(imageLiteralResourceName: "slidePreviewIcon"))
        
        self.links.append(presentation)
        self.links.append(activity)
        self.links.append(reports)
        self.links.append(slidePreview)
        
    }
    
    private func updateDcr () {
        
        let doctorColor = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(1.0))
        
        let chemistColor = UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(1.0))
        
        let stockistColor = UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(1.0))
        
        let unlistdColor = UIColor(red: CGFloat(128.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(128.0/255.0), alpha: CGFloat(0.8))
        
        let cipColor = UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(0.8))
        
        let hospitalColor = UIColor(red: CGFloat(128.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(128.0/255.0), alpha: CGFloat(0.8))
        
        self.dcrCount.append(DcrCount(name: "Doctor",color: doctorColor,count: DBManager.shared.getDoctor().count.description))
        
        self.dcrCount.append(DcrCount(name: "Chemist",color: chemistColor,count: DBManager.shared.getChemist().count.description))
        
        self.dcrCount.append(DcrCount(name: "Stockist",color: stockistColor,count: DBManager.shared.getStockist().count.description))
        
        self.dcrCount.append(DcrCount(name: "UnListed Doctor",color: unlistdColor,count: DBManager.shared.getUnListedDoctor().count.description))
        
        self.dcrCount.append(DcrCount(name: "Cip",color: cipColor,count: DBManager.shared.getUnListedDoctor().count.description))
        
        self.dcrCount.append(DcrCount(name: "Hospital",color: hospitalColor,count: DBManager.shared.getUnListedDoctor().count.description))
        
    }
    
    private func createSwipeGesture(direction : UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipe.direction = direction
        return swipe
    }
    
    @objc private func swipeAction(_ sender : UISwipeGestureRecognizer) {
        self.viewProfile.isHidden = true
        self.viewDayPlanStatus.isHidden = true
        
        switch sender.direction {
            
            case .left :
                    
                var value =  self.segmentControlForAnalysis.selectedSegmentIndex
                value += 1
            
                self.segmentControlForAnalysis.selectedSegmentIndex = value > 2 ? 2 : value
                switch value{
                    case 0:
                        self.lblAnalysisName.text = "Call Analysis"
                        self.salesStackView.isHidden = true
                        self.slideStackView.isHidden = true
                        self.callStackView.isHidden = false
                    case 1:
                        self.lblAnalysisName.text = "E-Detailing Analysis"
                        self.salesStackView.isHidden = true
                        self.slideStackView.isHidden = false
                        self.callStackView.isHidden = true
                    case 2:
                        self.lblAnalysisName.text = "Sales Analysis"
                        self.salesStackView.isHidden = false
                        self.slideStackView.isHidden = true
                        self.callStackView.isHidden = true
                    default:
                        break
                }
            case .right :
                var value =  self.segmentControlForAnalysis.selectedSegmentIndex
                value -= 1
            
                self.segmentControlForAnalysis.selectedSegmentIndex = value < 0 ? 0 : value
            
                switch value {
                    case 0:
                        self.lblAnalysisName.text = "Call Analysis"
                        self.salesStackView.isHidden = true
                        self.slideStackView.isHidden = true
                        self.callStackView.isHidden = false
                    case 1:
                        self.lblAnalysisName.text = "E-Detailing Analysis"
                        self.salesStackView.isHidden = true
                        self.slideStackView.isHidden = false
                        self.callStackView.isHidden = true
                    case 2:
                        self.lblAnalysisName.text = "Sales Analysis"
                        self.salesStackView.isHidden = false
                        self.slideStackView.isHidden = true
                        self.callStackView.isHidden = true
                    default:
                        break
                }
            default:
                break
        }
    }
}


extension MainVC : collectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            case self.quickLinkCollectionView :
                return self.links.count
            case self.dcrCallsCollectionView:
            return self.dcrCount.count
            case self.analysisCollectionView:
                return 4
            case self.eventCollectionView:
                return eventArr.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let color = [UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(0.8)),UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(0.8)),UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(0.8)),UIColor(red: CGFloat(128.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(128.0/255.0), alpha: CGFloat(0.7))].randomElement()
        
        switch collectionView {
            case self.quickLinkCollectionView :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickLinkCell", for: indexPath) as! QuickLinkCell
                cell.link = self.links[indexPath.row]
                return cell
            case self.dcrCallsCollectionView:
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DCRCallAnalysisCell", for: indexPath) as! DCRCallAnalysisCell
                cell.viewDoctor.backgroundColor = self.dcrCount[indexPath.row].color
                cell.lblName.text = self.dcrCount[indexPath.row].name
                cell.lblCount.text = "0/"+"\(self.dcrCount[indexPath.row].count!)"
                cell.imgArrow.tintColor = self.dcrCount[indexPath.row].color
                if indexPath.row != 0 {
                   cell.imgArrow.isHidden = true
                }
                return cell
            case self.analysisCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalysisCell", for: indexPath) as! AnalysisCell
                if indexPath.row != 0 {
                    cell.viewAnalysis.backgroundColor = color
                    cell.imgArrow.isHidden = true
                }
//                if indexPath.row == 1{
//                    cell.lblName.text = "Brand Analysis"
//                    cell.lblDetail.text = "Brand wise detailed to doctors & Chemists with duration"
//                }
//                if indexPath.row == 2{
//                    cell.lblName.text = "Specialty Analysis"
//                    cell.lblDetail.text = "Specialty wise detailed to doctors by brand & product"
//                }
            
                return cell
            case self.eventCollectionView :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayPlanEventCell", for: indexPath) as! DayPlanEventCell
                cell.lblEvent.text = eventArr[indexPath.row]
                cell.lblEvent.textColor = ColorArray[indexPath.row]
                cell.viewEvent.backgroundColor = ColorArrayForBackground[indexPath.row]
            
           //     cell.width1 = collectionView.bounds.width - Constants.spacing
                cell.Border_Radius(border_height: 0.0, isborder: false, radius: 5)
                return cell
            default :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickLinkCell", for: indexPath) as! QuickLinkCell
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch collectionView {
            case self.quickLinkCollectionView :
                let width = self.quickLinkCollectionView.frame.width / 3
                let size = CGSize(width: width - 10, height: 60)
                return size
            case self.dcrCallsCollectionView :
                let width = self.dcrCallsCollectionView.frame.width / 3
                let size = CGSize(width: width - 10, height: self.dcrCallsCollectionView.frame.height)
                return size
            case self.analysisCollectionView :
                let width = self.analysisCollectionView.frame.width / 3
                let size = CGSize(width: width - 10, height: self.analysisCollectionView.frame.height)
                return size
            case self.eventCollectionView:
                let width = self.eventCollectionView.bounds.width - Constants.spacing
                let size = CGSize(width: width, height: 60)
                return size
            default :
                let width = self.analysisCollectionView.frame.width / 3
                let size = CGSize(width: width - 10, height: self.analysisCollectionView.frame.height)
                return size

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}


extension MainVC : tableViewProtocols , CollapsibleTableViewHeaderDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.outboxTableView {
            
            print("riigjroo  \(obj_sections.count)")
            return obj_sections.count
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.outboxTableView {
            return obj_sections[section].collapsed ? 0 : obj_sections[section].items.count
        }
        switch tableView {
            case self.sideMenuTableView :
                return menuList.count
            case self.callTableView:
                return 10
            case self.outboxTableView:
                return 5
            default :
                return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
            case self.sideMenuTableView :
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
                cell.lblName.text = menuList[indexPath.row]
                return cell
            case self.callTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DCRCallCell", for: indexPath) as! DCRCallCell
                cell.imgProfile.backgroundColor = UIColor.random()
                return cell
            case self.outboxTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DCRCallCell", for: indexPath) as! DCRCallCell
                cell.imgProfile.backgroundColor = UIColor.random()
                return cell
            default :
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
        if tableView == self.outboxTableView {
            return UITableView.automaticDimension
        } else {
            return 95
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == outboxTableView {
            return 50
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        
        if tableView == outboxTableView {
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
            header.titleLabel.text = obj_sections[section].name
            header.section = section
            header.delegate = self
            
            if obj_sections[section].collapsed {
                
                header.arrowLabel.text = "Expand"
            } else {
                header.arrowLabel.text = "Collapse"
            }
            return header
            
        } else {
            
            return view
        }
    }
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        
        let collapsed = !obj_sections[section].collapsed
        obj_sections[section].collapsed = collapsed
        
        // Reload the whole section
        self.outboxTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
            case sideMenuTableView:
            if menuList[indexPath.row] == "Near Me" {
                
                let nearMe = UIStoryboard.nearMeVC
                self.navigationController?.pushViewController(nearMe, animated: true)
                
            }else if menuList[indexPath.row] == "Leave Application" {
                let leaveVC = UIStoryboard.leaveVC
                self.navigationController?.pushViewController(leaveVC, animated: true)
            } else if menuList[indexPath.row] == "Tour Plan" {
                  let tourplanVC = TourPlanVC.initWithStory()
                self.navigationController?.pushViewController(tourplanVC, animated: true)
            } else if menuList[indexPath.row] == "Reports" {
                let tourplanVC = ReportsVC.initWithStory()
              self.navigationController?.pushViewController(tourplanVC, animated: true)
          }
            
            default :
                break
        }
        
    }
}

extension MainVC : FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        
        self.lblDate.text = date.toString(format: "yyyy-MM-dd HH:mm:")
        
        
        
        let dateformatter = DateFormatter()
        let month = DateFormatter()
        dateformatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM dd, yyyy", options: 0, locale: calendar.locale)
        month.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM yyyy", options: 0, locale: calendar.locale)
        
        
        self.lblDate.text = dateformatter.string(from: date)
        
        
        UIView.animate(withDuration: 0.5) { [self] in
            self.viewDayPlanStatus.alpha = 0
            self.viewDayPlanStatus.isHidden = true
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let color = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.65))
        return color
    }
    
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let borderColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.25))
        
        let cell = calendar.dequeueReusableCell(withIdentifier: "DateCell", for: date, at: position)
        cell.layer.borderColor = borderColor.cgColor
        cell.layer.borderWidth = 1
        cell.layer.masksToBounds = true
        return cell
    }
    
}

extension MainVC : UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presenter = CustomPresentationController(presentedViewController: presented, presenting: presenting)
        presenter.presentedViewFrame = presented.view.frame
        return presenter
    }
}


private enum Constants {
    static let spacing: CGFloat = 1
}


struct QuicKLink {
    
    var color : UIColor!
    var name : String!
    var image : UIImage!
}


struct DcrCount {
    
    var name : String!
    var color : UIColor!
    var count : String!
}

enum AppColorForBackground {
    
}


let ColorArray = [UIColor(red: CGFloat(254.0/255.0), green: CGFloat(185.0/255.0), blue: CGFloat(26.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(128.0/255.0), green: CGFloat(90.0/255.0), blue: CGFloat(175.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(181.0/255.0), green: CGFloat(139.0/255.0), blue: CGFloat(160.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(199.0/255.0), green: CGFloat(55.0/255.0), blue: CGFloat(150.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(7.0/255.0), green: CGFloat(97.0/255.0), blue: CGFloat(69.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(1.0)),
                  UIColor(red: CGFloat(20.0/255.0), green: CGFloat(89.0/255.0), blue: CGFloat(119.0/255.0), alpha: CGFloat(1.0))]


let ColorArrayForBackground = [UIColor(red: CGFloat(254.0/255.0), green: CGFloat(185.0/255.0), blue: CGFloat(26.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(128.0/255.0), green: CGFloat(90.0/255.0), blue: CGFloat(175.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(181.0/255.0), green: CGFloat(139.0/255.0), blue: CGFloat(160.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(199.0/255.0), green: CGFloat(55.0/255.0), blue: CGFloat(150.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(7.0/255.0), green: CGFloat(97.0/255.0), blue: CGFloat(69.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.15)),
                  UIColor(red: CGFloat(20.0/255.0), green: CGFloat(89.0/255.0), blue: CGFloat(119.0/255.0), alpha: CGFloat(0.15))]

