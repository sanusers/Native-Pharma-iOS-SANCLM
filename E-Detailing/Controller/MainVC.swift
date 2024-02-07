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
import CoreData

extension MainVC : HomeLineChartViewDelegate
{

    
    func didSetValues(values: [String], valueStr: String) {
        
     
        self.monthRangeLbl.text = valueStr
        switch values.count {

        case 0:
            toHodeMonthStact(count: 0)
        
            
        case 1:

            toHodeMonthStact(count: 1)

        case 2:
            toHodeMonthStact(count: 2)

            
        case 3:
     
            toHodeMonthStact(count: 3)

            
        default:
            print("Above / Below")
        }
        

        
        
        func toHodeMonthStact(count: Int) {
            
            let views: [UIView] = [month1View, month2View, month3View]
            let labels : [UILabel] = [month1Lbl, month2Lbl, month3Lbl]
            switch count {
            case 0:
                views.enumerated().forEach { aViewIndex, aView in
                    aView.isHidden = true
                }
                labels.forEach { aLabel in
                    aLabel.isHidden = true
                }
            case 1:
                
                views.forEach { aView in
                    switch aView {
                    case month1View:
                        aView.isHidden = false
                    default:
                        aView.isHidden = true
                        
                    }
                }
                labels.enumerated().forEach {aLabelIndex, aLabel in
                    switch aLabel {
                    case month1Lbl:
                        aLabel.isHidden = false
                        aLabel.text = values[0]
                    default:
                        aLabel.isHidden = true
                        
                    }
                }
                
            case 2:
                views.forEach { aView in
                    switch aView {
                    case month1View, month2View:
                        aView.isHidden = false
                    default:
                        aView.isHidden = true
                        
                    }
                }
                labels.enumerated().forEach {aLabelIndex,  aLabel in
                    switch aLabel {
                    case month1Lbl:
                        aLabel.isHidden = false
                        aLabel.text = values[0]
                        
                    case month2Lbl:
                        aLabel.isHidden = false
                        aLabel.text = values[1]
                    default:
                        aLabel.isHidden = true
                        
                    }
                }
                
                
            case 3:
                views.forEach { aView in
                    switch aView {
                    case month1View, month2View, month3View:
                        aView.isHidden = false
                    default:
                        aView.isHidden = true
                        
                    }
                }
                labels.enumerated().forEach {aLabelIndex,  aLabel in
                    switch aLabel {
                    case month1Lbl:
                        aLabel.isHidden = false
                        aLabel.text = values[0]
                        
                    case month2Lbl:
                        aLabel.isHidden = false
                        aLabel.text = values[1]
                        
                    case month1Lbl:
                        aLabel.isHidden = false
                        aLabel.text = values[0]
                        
                    case month3Lbl:
                        aLabel.isHidden = false
                        aLabel.text = values[2]
                    default:
                        aLabel.isHidden = true
                        
                    }
                }
            default:
                print("Out of range")
            }
        }
        
    }
    

}

extension MainVC: MenuResponseProtocol {
    func callPlanAPI() {
        print("")
    }
    func routeToView(_ view : UIViewController) {
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}

typealias collectionViewProtocols = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
typealias tableViewProtocols = UITableViewDelegate & UITableViewDataSource

class MainVC : UIViewController {
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    @IBOutlet var monthRangeLbl: UILabel!
    @IBOutlet var lblAverageDocCalls: UILabel!
    @IBOutlet weak var lblAnalysisName: UILabel!
    @IBOutlet weak var lblWorkType: UILabel!
    @IBOutlet weak var lblHeadquarter: UILabel!
    @IBOutlet weak var lblCluster: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var txtViewRemarks: UITextView!
    
    @IBOutlet var worktypeTable: UITableView!
    
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
    
    ///Mark: - charts
    
    @IBOutlet var chartHolderView: UIView!
    @IBOutlet var lineChatrtView: UIView!
    
    @IBOutlet var monthHolderView: UIView!
    
    @IBOutlet var month2View: UIView!
    
    @IBOutlet var month1View: UIView!
    
    @IBOutlet var month1VXview: UIVisualEffectView!
    
    @IBOutlet var month2VXview: UIVisualEffectView!
    
    @IBOutlet var month3VXview: UIVisualEffectView!
    
    @IBOutlet var month3View: UIView!
    
    @IBOutlet var month1Lbl: UILabel!
    
    @IBOutlet var month2Lbl: UILabel!
    
    @IBOutlet var quickLinkTitle: UILabel!
    @IBOutlet var month3Lbl: UILabel!
    
    ///Mark: - Calls
    
    @IBOutlet var outboxCountVIew: UIView!
    @IBOutlet var callsCountLbl: UILabel!
    
    @IBOutlet var outboxCallsCountLabel: UILabel!
    
    @IBOutlet var clearCallsBtn: UIButton!
    
    @IBOutlet var outboxCallsCountLbl: UILabel!
    
    
    @IBOutlet weak var quickLinkCollectionView: UICollectionView!
    @IBOutlet weak var dcrCallsCollectionView: UICollectionView!
    @IBOutlet weak var analysisCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    @IBOutlet var showMenuView: UIView!
    
    @IBOutlet var homeTitleLbl: UILabel!
    
    
    @IBOutlet var segmentBorderLbl: UILabel!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var callTableView: UITableView!
    @IBOutlet weak var outboxTableView: UITableView!
    let network: ReachabilityManager = ReachabilityManager.sharedInstance
    var callsCellHeight = 400 + 10 // + 10 padding
    var homeLineChartView : HomeLineChartView?
    var chartType: ChartType = .doctor
    var cacheDCRindex: Int = 0
    var doctorArr = [HomeData]()
    var chemistArr = [HomeData]()
    var stockistArr = [HomeData]()
    var unlistedDocArr = [HomeData]()
    var cipArr = [HomeData]()
    var hospitalArr = [HomeData]()
    var  homeDataArr = [HomeData]()
    var outBoxDataArr : [TodayCallsModel]?
    var totalFWCount: Int = 0
    var cacheINdex: Int = 0
    var selectedCallIndex: Int = 0
    var sessionResponseVM : SessionResponseVM?
    let dispatchGroup = DispatchGroup()
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
    
    var todayCallsModel: [TodayCallsModel]?
    enum ChartType {
        case doctor
        case chemist
        case stockist
        case unlistedDoctor
    }
    
    
    func toSetChartType(chartType: ChartType) {
        switch chartType {
            
        default:
            self.toIntegrateChartView(.doctor, 0)
        }
    }
    
    
    func toSeperateDCR() {
        homeDataArr = DBManager.shared.getHomeData()
        dump(homeDataArr)
        
        let totalFWs =  homeDataArr.filter { aHomeData in
            aHomeData.fw_Indicator == "F"  &&   aHomeData.custType == "0"
        }
        self.totalFWCount = totalFWs.count
        
        doctorArr =  homeDataArr.filter { aHomeData in
            aHomeData.custType == "1"
        }
        
        chemistArr =  homeDataArr.filter { aHomeData in
            aHomeData.custType == "2"
        }
        
        stockistArr =  homeDataArr.filter { aHomeData in
            aHomeData.custType == "3"
        }
        
        
        unlistedDocArr =  homeDataArr.filter { aHomeData in
            aHomeData.custType == "4"
        }
        
        cipArr =  homeDataArr.filter { aHomeData in
            aHomeData.custType == "5"
        }
        
        hospitalArr =  homeDataArr.filter { aHomeData in
            aHomeData.custType == "6"
        }
        
    }
    
    @objc func networkModified(_ notification: NSNotification) {
        
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let status = dict["Type"] as? String{
                DispatchQueue.main.async {
                    if status == "No Connection" {
                        //   self.toSetPageType(.notconnected)
                        self.toCreateToast("Please check your internet connection.")
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                        self.segmentControlForDcr.selectedSegmentIndex = 2
                        self.segmentControlForDcr.sendActions(for: .valueChanged)
                    } else if  status == "WiFi" || status ==  "Cellular"   {
                        
                        self.toCreateToast("You are now connected.")
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
                        self.toretryDCRupload( date: "") {isCompleted in
                            if isCompleted {
                               // self.toSetParams()
                            }
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    
    
    func setupUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkModified(_:)) , name: NSNotification.Name("connectionChanged"), object: nil)
        outboxCountVIew.isHidden = true
        outboxCallsCountLabel.setFont(font: .medium(size: .BODY))
        outboxCallsCountLabel.textColor = .appWhiteColor
        outboxCountVIew.layer.cornerRadius = outboxCountVIew.height / 2
        outboxCountVIew.backgroundColor = .appTextColor
        clearCallsBtn.layer.cornerRadius = 5
        clearCallsBtn.backgroundColor = .appTextColor
        clearCallsBtn.titleLabel?.textColor = .appWhiteColor
        
        
        outboxCallsCountLbl.setFont(font: .medium(size: .BODY))
        outboxCallsCountLbl.textColor = .appTextColor
        
        viewCalls.layer.cornerRadius = 5
        viewCalls.backgroundColor = .appWhiteColor
        lblDate.setFont(font: .bold(size: .SUBHEADER))
        btnCall.layer.borderColor = UIColor.appSelectionColor.cgColor
        btnCall.layer.borderWidth = 0.5
        btnCall.tintColor = .appTextColor
        btnCall?.layer.cornerRadius = 5
        btnCall.backgroundColor = .appGreyColor
        btnActivity.layer.borderColor = UIColor.appSelectionColor.cgColor
        btnActivity.layer.borderWidth = 0.5
        btnActivity.tintColor = .appTextColor
        btnActivity?.layer.cornerRadius = 5
        btnActivity.backgroundColor = .appGreyColor
        
        self.worktypeTable.contentInsetAdjustmentBehavior = .never
        self.callTableView.contentInsetAdjustmentBehavior = .never
        self.worktypeTable.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0);
        self.callTableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0);
        callsCountLbl.setFont(font: .medium(size: .BODY))
        callsCountLbl.textColor = .appTextColor
        homeTitleLbl.setFont(font: .bold(size: .SUBHEADER))
        homeTitleLbl.text = "SAN Media Pvt Ltd.,"
        homeTitleLbl.textColor = .appWhiteColor
        //        showMenuView.addTap {
        //            print("Tapped")
        //            let menuvc =   HomeSideMenuVC.initWithStory(self)
        //            self.modalPresentationStyle = .custom
        //            self.navigationController?.present(menuvc, animated: false)
        //        }
        quickLinkTitle.setFont(font: .bold(size: .SUBHEADER))
        monthRangeLbl.setFont(font: .medium(size: .BODY))
        lblAverageDocCalls.setFont(font: .bold(size: .SUBHEADER))
        lblAnalysisName.setFont(font: .bold(size: .SUBHEADER))
        //toSeperateDCR()
        chartHolderView.layer.cornerRadius = 5
        chartHolderView.backgroundColor = .appWhiteColor
        // self.toIntegrateChartView(.doctor, 0)
        month1View.layer.cornerRadius = 5
        month2View.layer.cornerRadius = 5
        month3View.layer.cornerRadius = 5
        
        //  month3View.isHidden = true
        // month2View.isHidden = true
        month1VXview.backgroundColor = .appSelectionColor
        month2VXview.backgroundColor = .appSelectionColor
        month3VXview.backgroundColor = .appSelectionColor
        
        month1Lbl.setFont(font: .bold(size: .BODY))
        month2Lbl.setFont(font: .bold(size: .BODY))
        month3Lbl.setFont(font: .bold(size: .BODY))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.toSeperateDCR()
        self.updateDcr()
        self.toIntegrateChartView(self.chartType, self.cacheDCRindex)
        
        if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
           // toSetParams()
            // self.segmentControlForDcr.selectedSegmentIndex = 1
        } else {
            //  self.segmentControlForDcr.selectedSegmentIndex = 2
            
        }
        // self.segmentControlForDcr.underlinePosition()
        // self.segmentControlForDcr.sendActions(for: .valueChanged)
        
        toLoadDcrCollection()
        toLoadOutboxTable()
    }
    
    func toLoadDcrCollection() {
        dcrCallsCollectionView.delegate = self
        dcrCallsCollectionView.dataSource = self
        dcrCallsCollectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sessionResponseVM = SessionResponseVM()
        //self.toSeperateDCR()
        self.updateLinks()
        
        self.updateSegmentForDcr()
        setupUI()
        LocationManager.shared.locationUpdate()
        
//        outboxTableView.estimatedRowHeight = 80
//        outboxTableView.rowHeight = UITableView.automaticDimension
        
//        if #available(iOS 15.0, *) {
//            outboxTableView.sectionHeaderTopPadding = 0
//        } else {
//            // Fallback on earlier versions
//        }
        
        self.viewDate.Border_Radius(border_height: 0, isborder: true, radius: 10)
        
        [btnNotification,btnSync,btnProfile].forEach({$0?.Border_Radius(border_height: 0, isborder: true, radius: 25)})
        
        self.quickLinkCollectionView.register(UINib(nibName: "QuickLinkCell", bundle: nil), forCellWithReuseIdentifier: "QuickLinkCell")
        
        self.dcrCallsCollectionView.register(UINib(nibName: "DCRCallAnalysisCell", bundle: nil), forCellWithReuseIdentifier: "DCRCallAnalysisCell")
        
        self.analysisCollectionView.register(UINib(nibName: "AnalysisCell", bundle: nil), forCellWithReuseIdentifier: "AnalysisCell")
        
        
        self.sideMenuTableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        self.callTableView.register(UINib(nibName: "DCRCallCell", bundle: nil), forCellReuseIdentifier: "DCRCallCell")
        
        self.outboxTableView.register(UINib(nibName: "DCRCallCell", bundle: nil), forCellReuseIdentifier: "DCRCallCell")
        
        self.outboxTableView.register(UINib(nibName: "outboxCollapseTVC", bundle: nil), forCellReuseIdentifier: "outboxCollapseTVC")
        
        
        self.outboxTableView.register(UINib(nibName: "outboxCollapseTVC", bundle: nil), forHeaderFooterViewReuseIdentifier: "outboxCollapseTVC")
        
        self.outboxTableView.register(UINib(nibName: "OutboxDetailsTVC", bundle: nil), forCellReuseIdentifier: "OutboxDetailsTVC")
        
        
        self.worktypeTable.register(UINib(nibName: "HomeWorktypeTVC", bundle: nil), forCellReuseIdentifier: "HomeWorktypeTVC")
        
        
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.quickLinkCollectionView.collectionViewLayout = layout
        
        let layout1 = UICollectionViewFlowLayout()
        
        layout1.scrollDirection = .horizontal
        
        self.dcrCallsCollectionView.collectionViewLayout = layout1
        self.analysisCollectionView.collectionViewLayout = layout1
        
        self.viewAnalysis.addGestureRecognizer(createSwipeGesture(direction: .left))
        self.viewAnalysis.addGestureRecognizer(createSwipeGesture(direction: .right))
        
        
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
        
    }
    
    
    
    
    
    func toIntegrateChartView(_ type: ChartType, _ index: Int) {
        
        self.lineChatrtView.subviews.forEach { aAddedView in
            aAddedView.removeFromSuperview()
        }
        
        let ahomeLineChartView = HomeLineChartView()
        ahomeLineChartView.delegate = self
        ahomeLineChartView.allListArr = homeDataArr
        ahomeLineChartView.dcrCount = self.dcrCount[index]
        switch type {
            
        case .doctor:
            ahomeLineChartView.setupUI(self.doctorArr, avgCalls: self.totalFWCount)
            
        case .chemist:
            ahomeLineChartView.setupUI(self.chemistArr, avgCalls: self.totalFWCount)
            
        case .stockist:
            ahomeLineChartView.setupUI(self.stockistArr, avgCalls: self.totalFWCount)
            
        case .unlistedDoctor:
            ahomeLineChartView.setupUI(self.unlistedDocArr, avgCalls: self.totalFWCount)
            
        }
        
        
        ahomeLineChartView.viewController = self
        
        self.homeLineChartView = ahomeLineChartView
        
        
        lineChatrtView?.addSubview(homeLineChartView ?? HomeLineChartView())
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.homeLineChartView?.frame = lineChatrtView.bounds
        let attr = NSDictionary(object: UIFont(name: "Satoshi-Bold", size: 16)!, forKey: NSAttributedString.Key.font as NSCopying)
        segmentControlForDcr.setTitleTextAttributes(attr as? [NSAttributedString.Key : Any] , for: .normal)
    }
    
    deinit {
        print("ok bye")
    }
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        
        //        if btnHome.isSelected == true {
        //            self.btnHome.isSelected = false
        //            UIView.animate(withDuration: 0.5) { [self] in
        //                self.viewSideMenu.alpha = 0
        //                self.viewSideMenu.isHidden = true
        //            }
        //            return
        //        }
        //
        //        self.viewSideMenu.isHidden = false
        //        self.viewSideMenu.alpha = 0
        //        UIView.animate(withDuration: 0.5) {
        //            self.viewSideMenu.alpha = 1
        //        }
        //        self.btnHome.isSelected = true
        
        print("Tapped")
        let menuvc =   HomeSideMenuVC.initWithStory(self)
        self.modalPresentationStyle = .custom
        self.navigationController?.present(menuvc, animated: false)
        
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
            toLoadWorktypeTable()
        case 1:
            self.viewWorkPlan.isHidden = true
            self.viewCalls.isHidden = false
            self.viewOutBox.isHidden = true
            //   self.callTableView.reloadData()
        case 2:
            self.viewWorkPlan.isHidden = true
            self.viewCalls.isHidden = true
            self.viewOutBox.isHidden = false
            //toLoadOutboxTable()
        default:
            break
        }
    }
    
    func toLoadOutboxTable() {
        toSetupOutBoxDataSource()
        outboxTableView.delegate = self
        outboxTableView.dataSource = self
        outboxTableView.reloadData()
    }
    
    
    func toLoadWorktypeTable() {
        worktypeTable.delegate = self
        worktypeTable.dataSource = self
        worktypeTable.reloadData()
    }
    
    func toConfigureClearCalls(istoEnable: Bool) {
        if istoEnable {
            clearCallsBtn.alpha = 1
            clearCallsBtn.isUserInteractionEnabled = true
        } else {
            clearCallsBtn.alpha = 0.5
            clearCallsBtn.isUserInteractionEnabled = false
        }
        
    }
    
    func toSetupOutBoxDataSource() {
        
        self.outBoxDataArr?.removeAll()
        
        let outBoxDataArr =  self.homeDataArr.filter { aHomeData in
            aHomeData.isDataSentToAPI == "0"
        }
        
        if !outBoxDataArr.isEmpty {
            outboxCountVIew.isHidden = false
            
            outboxCallsCountLabel.text = "\(outBoxDataArr.count)"
        } else {
            outboxCountVIew.isHidden = true
        }
        
        
        self.outBoxDataArr = [TodayCallsModel]()
        
        outBoxDataArr.forEach { aHomeData in
            
            let toDdayCall =  TodayCallsModel()
            toDdayCall.aDetSLNo = aHomeData.anslNo ?? ""
            toDdayCall.custCode = aHomeData.custCode ?? ""
            toDdayCall.custName = aHomeData.custName ?? ""
            let type =  Int(aHomeData.custType ?? "0")
            toDdayCall.custType = type ?? 0
            toDdayCall.transSlNo = aHomeData.trans_SlNo ?? ""
            toDdayCall.name = aHomeData.custName ?? ""
            toDdayCall.vstTime = aHomeData.dcr_dt ?? ""
            toDdayCall.submissionDate = aHomeData.dcr_dt ?? ""
            toDdayCall.designation = type == 1 ? "Doctor" : type == 2 ? "Chemist" : type == 3 ? "Stockist" : type == 4 ? "hospital" : type == 5 ? "cip" : type == 6 ? "UnlistedDr." : ""
            self.outBoxDataArr?.append(toDdayCall)
        }
        toSeperateOutboxSections(outboxArr: self.outBoxDataArr ?? [TodayCallsModel]())
        if self.outBoxDataArr?.count ?? 0 == 0 {
            toConfigureClearCalls(istoEnable: false)
        } else {
            toConfigureClearCalls(istoEnable: true)
        }
    }
    
    
    func toSeperateOutboxSections(outboxArr : [TodayCallsModel]) {
        // Dictionary to store arrays of TodayCallsModel for each day
        var callsByDay: [String: [TodayCallsModel]] = [:]
        
        // Create a DateFormatter to parse the vstTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Iterate through the array and organize elements by day
        for call in outboxArr {
            if let date = dateFormatter.date(from: call.vstTime) {
                let dayString = dateFormatter.string(from: date)
                
                // Check if the day key exists in the dictionary
                if callsByDay[dayString] == nil {
                    callsByDay[dayString] = [call]
                } else {
                    callsByDay[dayString]?.append(call)
                }
            }
        }
        obj_sections.removeAll()
        // Iterate through callsByDay and create Section objects
        for (day, calls) in callsByDay {
            let section = Section(items: calls, date: day)
            obj_sections.append(section)
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
             //   ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                self.toCreateToast(error.localizedDescription)
                print(error)
                return
            }
        }
    }
    
    
    
    @IBAction func todayCallSyncAction(_ sender: UIButton) {
        let isConnected = LocalStorage.shared.getBool(key: .isConnectedToNetwork)
        //  obj_sections[section].isLoading = true
        if isConnected {
            toSetParams()
            //self.toretryDCRupload( date: obj_sections[section].date)
        } else {
            self.toCreateToast("Please connect to internet and try again later.")
        }
        
        //        let appsetup = AppDefaults.shared.getAppSetUp()
        //
        //        let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
        
        //   let url =  appMainURL + "table/additionaldcrmasterdata"
        
        
        // "crm.saneforce.in/iOSServer/db_module.php?axn=table/additionaldcrmasterdata"
        
        //        let params : [String : Any] = ["tableName" : "gettodycalls",
        //                                          "sfcode" : appsetup.sfCode ?? "",
        //                                          "ReqDt" : date,
        //                                          "division_code" : appsetup.divisionCode ?? "",
        //                                          "Rsf" : appsetup.sfCode ?? "",
        //                                          "sf_type" : appsetup.sfType ?? "",
        //                                       "Designation" : appsetup.dsName ?? "",
        //                                       "state_code" : appsetup.stateCode ?? "",
        //                                       "subdivision_code" : appsetup.subDivisionCode ?? ""
        //        ]
        //
        //        let param = ["data" : params.toString()]
        //
        //        print(param)
        //        print(url)
        
        // {"tableName":"gettodycalls","sfcode":"MR6028","ReqDt":"2024-01-17 12:54:25""sf_type":"1","divisionCode":"44,","Rsf":"MR6028","Designation":"MR","state_code":"41","subdivision_code":"170,"}
        
        
        
        
        //        AF.request(url,method: .post,parameters: param).responseData { responseFeed in
        //
        //            switch responseFeed.result {
        //
        //            case .success(_):
        //                do {
        //
        //                    let apiResponse = try JSONSerialization.jsonObject(with: responseFeed.data!,options: JSONSerialization.ReadingOptions.allowFragments)
        //
        //                    print(apiResponse as Any)
        //                }catch {
        //                    print(error)
        //                }
        //
        //            case .failure(let error):
        //                print(error)
        //                return
        //            }
        //        }
        
    }
    
    func toSetParams() {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
        var params = [String : Any]()
        params["tableName"] = "gettodycalls"
        params["sfcode"] =  appsetup.sfCode ?? ""
        params["ReqDt"] = date
        params["division_code"] = appsetup.divisionCode ?? ""
        params["Rsf"] = appsetup.sfCode ?? ""
        params["sf_type"] = appsetup.sfType ?? ""
        params["Designation"] = appsetup.dsName ?? ""
        params["state_code"] = appsetup.stateCode ?? ""
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: params)
        
        //        var jsonDatum = Data()
        //
        //        do {
        //            let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
        //            jsonDatum = jsonData
        //            // Convert JSON data to a string
        //            if let tempjsonString = String(data: jsonData, encoding: .utf8) {
        //                print(tempjsonString)
        //
        //            }
        //
        //
        //        } catch {
        //            print("Error converting parameter to JSON: \(error)")
        //        }
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        print(params)
        getTodayCalls(toSendData, paramData: params)
    }
    
    
    func getTodayCalls(_ param: [String: Any], paramData: JSON) {
        Shared.instance.showLoaderInWindow()
        sessionResponseVM?.getTodayCallsData(params: param, api: .getTodayCalls, paramData: paramData) { result in
            switch result {
            case .success(let response):
                print(response)
                self.todayCallsModel = response
                // Shared.instance.removeLoader(in: self.view)
                self.setupCalls(response: response)
                dump(response)
                Shared.instance.removeLoaderInWindow()
            case .failure(let error):
                //  Shared.instance.removeLoader(in: self.view)
                
                print(error.localizedDescription)
                self.view.toCreateToast("Error while fetching response from server.")
                Shared.instance.removeLoaderInWindow()
                
            }
        }
    }
    
    
    func setupCalls(response: [TodayCallsModel]) {
        callsCountLbl.text = "Call Count: 0\(response.count)"
        toloadCallsTable()
    }
    
    
    func setupDataFromDB() {
        
    }
    
    func toloadCallsTable() {
        callTableView.delegate = self
        callTableView.dataSource = self
        callTableView.reloadData()
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
              //  ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                print(error)
                self.toCreateToast(error.localizedDescription)
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
              //  ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                self.toCreateToast(error.localizedDescription)
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
          //      ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                self.toCreateToast(error.localizedDescription)
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
        
        //  let font = UIFont(name: "Satoshi-Bold", size: 14)!
        //  self.segmentControlForDcr.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
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
        
        let presentationColor = UIColor.appGreen
        let activityColor = UIColor.appBrown
        let reportsColor = UIColor.appLightPink
        let previewColor = UIColor.appBlue
        
        
        let presentation = QuicKLink(color: presentationColor, name: "Presentaion", image: UIImage(imageLiteralResourceName: "presentationIcon"))
        let activity = QuicKLink(color: activityColor, name: "Activity", image: UIImage(imageLiteralResourceName: "activity"))
        let reports = QuicKLink(color: reportsColor, name: "Reports", image: UIImage(imageLiteralResourceName: "reportIcon"))
        
        let slidePreview = QuicKLink(color: previewColor, name: "Slide Preview", image: UIImage(imageLiteralResourceName: "slidePreviewIcon"))
        
        self.links.append(presentation)
        self.links.append(slidePreview)
        self.links.append(reports)
        self.links.append(activity)
        
        
        
    }
    
    private func updateDcr () {
        
        let doctorColor = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(1.0))
        
        let chemistColor = UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(1.0))
        
        let stockistColor = UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(1.0))
        
        let unlistdColor = UIColor(red: CGFloat(128.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(128.0/255.0), alpha: CGFloat(0.8))
        
        let cipColor = UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(0.8))
        
        let hospitalColor = UIColor(red: CGFloat(128.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(128.0/255.0), alpha: CGFloat(0.8))
        
        
        
        self.dcrCount.append(DcrCount(name: "Doctor Calls",color: doctorColor,count: DBManager.shared.getDoctor().count.description, image: UIImage(named: "ListedDoctor") ?? UIImage(), callsCount:   self.doctorArr.count))
        
        self.dcrCount.append(DcrCount(name: "Chemist Calls",color: .appBlue,count: DBManager.shared.getChemist().count.description, image: UIImage(named: "Chemist") ?? UIImage(), callsCount: self.chemistArr.count))
        
        self.dcrCount.append(DcrCount(name: "Stockist Calls",color: .appLightPink,count: DBManager.shared.getStockist().count.description, image: UIImage(named: "Stockist") ?? UIImage(), callsCount: self.stockistArr.count))
        
        self.dcrCount.append(DcrCount(name: "UnListed Doctor Calls",color: .darkGray,count: DBManager.shared.getUnListedDoctor().count.description, image: UIImage(named: "Doctor") ?? UIImage(), callsCount: self.unlistedDocArr.count))
        
        self.dcrCount.append(DcrCount(name: "Cip Calls",color: cipColor,count: DBManager.shared.getUnListedDoctor().count.description, image: UIImage(named: "cip") ?? UIImage(), callsCount: cipArr.count))
        
        self.dcrCount.append(DcrCount(name: "Hospital Calls",color: hospitalColor,count: DBManager.shared.getUnListedDoctor().count.description, image: UIImage(named: "hospital") ?? UIImage(), callsCount: hospitalArr.count))
        
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
    
    func toSetupAlert() {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "E - Detailing", alertDescription: "Please do try syncing All slides!.", okAction: "Ok")
        commonAlert.addAdditionalOkAction(isForSingleOption: true) {
            print("no action")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let color = [UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(0.8)),UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(0.8)),UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(0.8)),UIColor(red: CGFloat(128.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(128.0/255.0), alpha: CGFloat(0.7))].randomElement()
        
        switch collectionView {
        case self.quickLinkCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickLinkCell", for: indexPath) as! QuickLinkCell
            cell.link = self.links[indexPath.row]
            
            cell.addTap {
                switch cell.link.name {
                case "Presentaion":
                    
                    if  LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isSlidesLoaded) {
                        let vc =  PresentationHomeVC.initWithStory()
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        self.toSetupAlert()
                    }
                    
                case "Slide Preview":
                    let vc = PreviewHomeVC.initWithStory()
                    self.navigationController?.pushViewController(vc, animated: true)
                case .none:
                    print("none")
                case .some(_):
                    print("some")
                }
            }
            
            return cell
        case self.dcrCallsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DCRCallAnalysisCell", for: indexPath) as! DCRCallAnalysisCell
            cell.imgArrow.isHidden = true
            let model =  self.dcrCount[indexPath.row]
            cell.dcrCount = model
            // cell.imgArrow.image = UIImage(named: "arrowtriangle.down.fill")?.withRenderingMode(.alwaysTemplate)
            if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isMR) {
                cell.setCellType(cellType: .MR)
                // lblName.text = self.dcrCount.name
                if self.selectedCallIndex == indexPath.row {
                    cell.imgArrow.isHidden = false
                }
            } else {
                cell.setCellType(cellType: .Manager)
                if self.selectedCallIndex == indexPath.row {
                    cell.imgArrow.isHidden = false
                }
            }
            
            
            
            
            cell.addTap {
                let model = self.dcrCount[indexPath.row]
                self.cacheDCRindex = indexPath.row
                self.selectedCallIndex = indexPath.row
                if model.name == "Doctor Calls" {
                    self.chartType = .doctor
                    self.toIntegrateChartView(.doctor, indexPath.row)
                    self.lblAverageDocCalls.text = "Average Doctor Calls"
                } else if model.name == "Chemist Calls" {
                    self.chartType = .doctor
                    self.toIntegrateChartView(.chemist, indexPath.row)
                    self.lblAverageDocCalls.text = "Average Chemist Calls"
                } else if model.name == "Stockist Calls" {
                    self.chartType = .doctor
                    self.toIntegrateChartView(.stockist, indexPath.row)
                    self.lblAverageDocCalls.text = "Average Stockist Calls"
                } else if model.name == "UnListed Doctor Calls" {
                    self.chartType = .doctor
                    self.toIntegrateChartView(.unlistedDoctor, indexPath.row)
                    self.lblAverageDocCalls.text = "Average UnListed Doctor Calls"
                }
                self.dcrCallsCollectionView.reloadData()
                //
                // }
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
    func toggleSection(_ header: UITableViewHeaderFooterView, section: Int) {
        
        for index in obj_sections.indices {
            if index == section {
                let collapsed = !obj_sections[section].collapsed
                obj_sections[section].collapsed = collapsed
            } else {
                obj_sections[index].collapsed = true
            }
            obj_sections[index].isCallExpanded = false
        }
        
        
        
        // Reload the whole section
        self.outboxTableView.reloadData()
        //.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.outboxTableView {
            
            print("riigjroo  \(obj_sections.count)")
            return obj_sections.count
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if tableView == self.outboxTableView {
        //            return obj_sections[section].collapsed ? 0 : obj_sections[section].items.count
        //        }
        switch tableView {
        case self.sideMenuTableView :
            return menuList.count
        case self.callTableView:
            return self.todayCallsModel?.count ?? 0
        case self.outboxTableView:
            if obj_sections.isEmpty {
                return  0
            } else {
                return obj_sections[section].collapsed ? 0 : 1
            }
            
        case self.worktypeTable:
            return 3
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
            cell.selectionStyle = .none
            //  cell.imgProfile.backgroundColor = UIColor.random()
            let model: TodayCallsModel = self.todayCallsModel?[indexPath.row] ?? TodayCallsModel()
            cell.topopulateCell(model)
            cell.optionsBtn.addTap {
                print("Tapped -->")
                let vc = PopOverVC.initWithStory(preferredFrame: CGSize(width: cell.width / 3, height: 90), on: cell.optionsBtn, onframe: CGRect(), pagetype: .calls)
                // vc.delegate = self
                //  vc.selectedIndex = indexPath.row
                self.navigationController?.present(vc, animated: true)
            }
            return cell
        case self.outboxTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OutboxDetailsTVC", for: indexPath) as! OutboxDetailsTVC
            let model = obj_sections[indexPath.section].items
            cell.todayCallsModel = model
            //[indexPath.row]
            //self.outBoxDataArr
            let count = model.count
            //self.outBoxDataArr?.count ?? 0
            cell.callsCountLbl.text = "\(count)"
            cell.toLoadData()
            
            if  !obj_sections[indexPath.section].isCallExpanded {
                cell.toSetCellHeight(callsExpandState:  .callsNotExpanded)
            }
            
            
            cell.callsCollapseIV.addTap {
                cell.callsExpandState =  cell.callsExpandState == .callsNotExpanded ? .callsExpanded : .callsNotExpanded
                // cell.callsCollapseIV.image = cell.callsExpandState == .callsNotExpanded ? UIImage(named: "chevlon.expand") : UIImage(named: "chevlon.collapse")
                
                if cell.callsExpandState == .callsExpanded {
                    obj_sections[indexPath.section].isCallExpanded = true
                    
                    //                    cell.cellStackHeightConst.constant = CGFloat(290 + 90 * count)
                    //                    cell.callSubDetailVIew.isHidden = false
                    //                    cell.callSubdetailHeightConst.constant = 90 * 2
                    //                    cell.callDetailStackHeightConst.constant = CGFloat(50 + 90 * count)
                    //                    cell.callsHolderViewHeightConst.constant = CGFloat(50 + 90 * count)
                    //                    cell.callsViewSeperator.isHidden = false
                } else {
                    obj_sections[indexPath.section].isCallExpanded = false
                    
                    //                    cell.cellStackHeightConst.constant = 290
                    //                    cell.callSubDetailVIew.isHidden = true
                    //                    cell.callSubdetailHeightConst.constant = 0 //90
                    //                    cell.callsHolderViewHeightConst.constant = 50
                    //                    cell.callDetailStackHeightConst.constant = 50
                    //                    cell.callsViewSeperator.isHidden = true
                }
                cell.toSetCellHeight(callsExpandState:  cell.callsExpandState)
                self.outboxTableView.reloadData()
            }
            
            // cell.imgProfile.backgroundColor = UIColor.random()
            cell.selectionStyle = .none
            return cell
            
        case worktypeTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorktypeTVC", for: indexPath) as! HomeWorktypeTVC
            cell.selectionStyle = .none
            return cell
            
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // return UITableView.automaticDimension
        
        if tableView == self.outboxTableView {
            let count = obj_sections[indexPath.section].items.count
            //self.outBoxDataArr?.count ?? 0
            switch indexPath.section {
            default:
                if  obj_sections[indexPath.section].isCallExpanded == true {
                    return CGFloat(290 + 10 + (90 * count))
                } else {
                    return 290 + 10
                }
            }
            
            
        } else if tableView == self.callTableView {
            return 75
        } else if tableView == self.worktypeTable {
            return 60
        }
        else {
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
            
            //            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
            //            header.titleLabel.text = obj_sections[section].name
            //            header.section = section
            //            header.delegate = self
            
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "outboxCollapseTVC") as? outboxCollapseTVC
            header?.delegate = self
            header?.section = section
            if obj_sections[section].collapsed {
                header?.collapseIV.image = UIImage(named: "chevlon.expand")
            } else {
                header?.collapseIV.image = UIImage(named: "chevlon.collapse")
            }
            header?.refreshdelegate = self
            

            
            let dateString = obj_sections[section].date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = dateFormatter.date(from: dateString) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "MMMM dd, yyyy"
                
                let formattedDate = outputFormatter.string(from: date)
                print(formattedDate)  // Output: January 19, 2024
                header?.dateLbl.text = formattedDate
            } else {
                print("Error parsing date")
            }
            
            
            
            return header
            
        } else {
            
            return view
        }
    }
    
    func toretryDCRupload( date: String, completion: @escaping (Bool) -> Void) {
    
        let paramData = LocalStorage.shared.getData(key: .outboxParams)
        var localParamArr = [String: [[String: Any]]]()
        do {
            localParamArr  = try JSONSerialization.jsonObject(with: paramData, options: []) as? [String: [[String: Any]]] ?? [String: [[String: Any]]]()
            dump(localParamArr)
        } catch {
            self.toCreateToast("unable to retrive")
        }
        
        var specificDateParams : [[String: Any]] = [[:]]
        
        
        if date.isEmpty {
            localParamArr.forEach { key, value in
                
                specificDateParams = value
                
            }
        } else {
            localParamArr.forEach { key, value in
                if key == date {
                    dump(value)
                    specificDateParams = value
                }
            }
        }
        
        print("specificDateParams has \(specificDateParams.count) values")
        if !localParamArr.isEmpty {
            toSendParamsToAPISerially(index: 0, items: specificDateParams) { isCompleted in
                if isCompleted {
                    Shared.instance.removeLoaderInWindow()
                    self.toSetParams()
                    completion(true)
                }
            }
        } else {
            Shared.instance.removeLoaderInWindow()
            completion(true)
        }
        
    }
    
    
    
    func toSendParamsToAPISerially(index: Int, items: [JSON], completion: @escaping (Bool) -> Void) {
        
        guard index < items.count else {
            // All items processed, exit the recursion
            DispatchQueue.main.async {
                self.toLoadOutboxTable()
            }
            
            return
        }
        
        let params = items[index]
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: params)
        
        // Perform your asynchronous task or function
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        if params.isEmpty {
            completion(true)
            return
        }
        self.sendAPIrequest(toSendData, paramData: params) { iscompleted in
            completion(iscompleted)
            let nextIndex = index + 1
            self.toSendParamsToAPISerially(index: nextIndex, items: items) {_ in}
            
        }
        // Handle the result if needed
        
        // Move to the next item
        
    }
    
    
    
    
    //    func toSendParamsToAPISerially(paramsArr : [JSON], completion: @escaping (Bool) -> Void) {
    //         // Iterate through the array of parameters
    //
    //
    //
    //        for (_, params) in paramsArr.enumerated() {
    //
    //            let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: params)
    //
    ////            var jsonDatum = Data()
    ////
    ////            do {
    ////                let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
    ////                jsonDatum = jsonData
    ////                // Convert JSON data to a string
    ////                if let tempjsonString = String(data: jsonData, encoding: .utf8) {
    ////                    print(tempjsonString)
    ////
    ////                }
    ////
    ////
    ////            } catch {
    ////                print("Error converting parameter to JSON: \(error)")
    ////            }
    //
    //
    //
    //
    //            var toSendData = [String: Any]()
    //            toSendData["data"] = jsonDatum
    //
    //            if params.isEmpty {
    //               completion(true)
    //               return
    //            }
    //            self.sendAPIrequest(toSendData, paramData: params) { iscompleted in
    //                completion(iscompleted)
    //
    //            }
    //
    //        }
    //    }
    
    
    func sendAPIrequest(_ param: [String: Any], paramData: JSON, completion: @escaping (Bool) -> Void) {
        Shared.instance.showLoaderInWindow()
        sessionResponseVM?.saveDCRdata(params: param, api: .saveDCR, paramData: paramData) { result in
            switch result {
            case .success(let response):
                print(response)
                
                dump(response)
                if response.msg == "Call Already Exists" {
                    // self.saveCallsToDB(issussess: false, appsetup: appsetup, cusType: cusType, param: jsonDatum)
                    self.toCreateToast(response.msg!)
                    self.toRemoveOutboxandDefaultParams(param: paramData)
                } else {
                    self.toRemoveOutboxandDefaultParams(param: paramData)
                    
                    //   self.saveCallsToDB(issussess: true, appsetup: appsetup, cusType: cusType, param: jsonDatum)
                }
                
                completion(true)
                //  Shared.instance.removeLoaderInWindow()
            case .failure(let error):
                //   self.saveCallsToDB(issussess: false, appsetup: appsetup, cusType: cusType, param: jsonDatum)
                
                print(error.localizedDescription)
                self.view.toCreateToast("Error uploading data try again later.")
                
                completion(true)
                //   Shared.instance.removeLoaderInWindow()
                
                return
            }
            
        }
    }
    
    
    @IBAction func didTapClearCalls() {
        
        self.outBoxDataArr?.removeAll()
        
        
        LocalStorage.shared.setData(LocalStorage.LocalValue.outboxParams, data: Data())
        
        let context = DBManager.shared.managedContext()
        let fetchRequest: NSFetchRequest<HomeData> = HomeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isDataSentToAPI == %@", "0")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for object in results {
                context.delete(object)
            }
            
            // Save the context to persist changes
            DBManager.shared.saveContext()
        } catch {
            // Handle fetch error
        }
        
        DispatchQueue.main.async {
            self.toLoadOutboxTable()
        }
    }
    
    func toRemoveOutboxandDefaultParams(param: JSON) {
        
        
        //to remove object from Local array and core data
        
        let filteredValues =  self.outBoxDataArr?.filter({ outBoxCallModel in
            outBoxCallModel.custCode != param["CustCode"] as! String
        })
        
        self.outBoxDataArr = filteredValues
        
        
        self.homeDataArr.forEach { aHomeData in
            if aHomeData.custCode == param["CustCode"] as? String {
                aHomeData.isDataSentToAPI = "1"
            }
        }
        let identifier = param["CustCode"] as? String // Assuming "identifier" is a unique identifier in HomeData
        // let existingHomeData = masterData.homeData?.first { ($0 as! HomeData).custCode == identifier }
        
        
        let context = DBManager.shared.managedContext()
        
        let fetchRequest: NSFetchRequest<HomeData> = HomeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "custCode == %@", identifier ?? "")
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingObject = results.first {
                // Object found, update isDataSentToAPI
                existingObject.isDataSentToAPI = "1"
                
                // Save the context to persist changes
                DBManager.shared.saveContext()
            } else {
                // Object not found, handle accordingly
            }
        } catch {
            // Handle fetch error
        }
        
        
        //to remove values from User defaults values
        
        let paramData = LocalStorage.shared.getData(key: LocalStorage.LocalValue.outboxParams)
        
        
        var localParamArr = [String: [[String: Any]]]()
        do {
            localParamArr  = try JSONSerialization.jsonObject(with: paramData, options: []) as? [String: [[String: Any]]] ?? [String: [[String: Any]]]()
            dump(localParamArr)
        } catch {
            self.toCreateToast("unable to retrive")
        }
        
        
        let custCodeToRemove = param["CustCode"] as! String
        
        // Iterate through the dictionary and filter out elements with the specified CustCode
        localParamArr = localParamArr.mapValues { callsArray in
            return callsArray.filter { call in
                if let custCode = call["CustCode"] as? String {
                    if custCode == custCodeToRemove {
                        print("Removing element with CustCode: \(custCode)")
                        return false
                    }
                }
                return true
            }
        }
        // Remove entries where the filtered array is empty
        localParamArr = localParamArr.filter { _, callsArray in
            return !callsArray.isEmpty
        }
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: localParamArr)
        
        
        //            var jsonDatum = Data()
        //
        //            do {
        //                let jsonData = try JSONSerialization.data(withJSONObject: localParamArr, options: [])
        //                jsonDatum = jsonData
        //                // Convert JSON data to a string
        //                if let tempjsonString = String(data: jsonData, encoding: .utf8) {
        //                    print(tempjsonString)
        //
        //                }
        //            } catch {
        //                print("Error converting parameter to JSON: \(error)")
        //            }
        
        LocalStorage.shared.setData(LocalStorage.LocalValue.outboxParams, data: jsonDatum)
        
        
        
        // Create a new array with modified sections
        let updatedSections = obj_sections.map { section -> Section in
            var updatedSection = section
            
            // Filter items in the section
            updatedSection.items = section.items.filter { call in
                // Assuming custCode is not an optional type
                return call.custCode != custCodeToRemove
            }
            
            // Keep the section if it still has items after filtering
            return updatedSection
        }
        
        
        
        
        
        // Assign the updated array back to obj_sections
        obj_sections = updatedSections.filter({ section in
            !section.items.isEmpty
        })
        
        print(obj_sections)
        
        
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
                let tourplanVC = ReportsVC.initWithStory(pageType: .reports)
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


extension MainVC : outboxCollapseTVCDelegate {
    func didTapRefresh(_ refreshIndex: Int) {
        
        let isConnected = LocalStorage.shared.getBool(key: .isConnectedToNetwork)
        //  obj_sections[section].isLoading = true
        if isConnected {
            self.toretryDCRupload(date: obj_sections[refreshIndex].date) {_ in }
        } else {
            self.toCreateToast("Please connect to internet and try again later.")
        }
        
        // header?.refreshBtn.isUserInteractionEnabled = false
        // header?.refreshBtn.alpha = 0.5
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
    
    var name : String
    var color : UIColor
    var count : String
    var image: UIImage
    var callsCount : Int
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

