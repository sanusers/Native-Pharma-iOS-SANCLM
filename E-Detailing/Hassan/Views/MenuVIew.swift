//
//  MenuVIew.swift
//  E-Detailing
//
//  Created by San eforce on 10/11/23.
//



import Foundation
import UIKit
import CoreData

extension MenuView : UITextViewDelegate {
    
}

extension MenuView {
    func toGetTourPlanResponse() {

        let appdefaultSetup = AppDefaults.shared.getAppSetUp()
        
      
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        self.sessionDetailsArr.date = dateFormatter.string(from: self.menuVC.selectedDate ?? Date())
        
        dateFormatter.dateFormat = "EEEE"
        self.sessionDetailsArr.day = dateFormatter.string(from: self.menuVC.selectedDate ?? Date())
        
        self.sessionDetailsArr.dayNo = "1"
        self.sessionDetailsArr.entryMode = ""
        self.sessionDetailsArr.rejectionReason = ""
        

        let aDaySessions = self.sessionDetailsArr
        aDaySessions.sessionDetails.forEach { session in
            session.workType = nil
            session.headQuates = nil
            session.cluster = nil
            session.jointWork = nil
            session.listedDoctors = nil
            session.chemist = nil
            
        }
        let tourPlanArr =  AppDefaults.shared.tpArry
        tourPlanArr.Div = appdefaultSetup.divisionCode
        tourPlanArr.SFCode = appdefaultSetup.sfCode
        tourPlanArr.SFName = appdefaultSetup.sfName
        if tourPlanArr.arrOfPlan.isEmpty {
            tourPlanArr.arrOfPlan.append(aDaySessions)
            _ =   self.toSetParams(tourPlanArr)
        } else {
//            tourPlanArr.arrOfPlan.enumerated().forEach { index, dayPlan  in
//                dayPlan.sessionDetails.enumerated().forEach { sessionIndex, session in
//                    if session.sessionName  == aDaySessions.sessionDetails[index].sessionName  {
//                        tourPlanArr.arrOfPlan.remove(at: index)
//                        tourPlanArr.arrOfPlan.append(aDaySessions)
//                        _ =   self.toSetParams(tourPlanArr)
//                    } else {
//                        tourPlanArr.arrOfPlan.append(aDaySessions)
//                        _ = self.toSetParams(tourPlanArr)
//                    }
//                }
//
//
//            }
            
            tourPlanArr.arrOfPlan.enumerated().forEach { tourPlanArrindex, sessionDetailsArr in
                sessionDetailsArr.sessionDetails.enumerated().forEach { sessionDetailsArrindex, sessionDetails in
                    aDaySessions.sessionDetails.enumerated().forEach { paramindex, paramSessionDetail in
                        if sessionDetails.sessionName == paramSessionDetail.sessionName {
                            tourPlanArr.arrOfPlan.remove(at: tourPlanArrindex)
                            tourPlanArr.arrOfPlan.append(aDaySessions)
                            _ =   self.toSetParams(tourPlanArr)
                        } else {
                            tourPlanArr.arrOfPlan.append(aDaySessions)
                            _ = self.toSetParams(tourPlanArr)
                        }
                    }
                    
                }
            }
            
        }
        AppDefaults.shared.tpArry = tourPlanArr
        if  AppDefaults.shared.eachDatePlan.tourPlanArr.isEmpty {
            AppDefaults.shared.eachDatePlan.tourPlanArr.append(AppDefaults.shared.tpArry)
        } else {
            AppDefaults.shared.eachDatePlan.tourPlanArr.enumerated().forEach { eachDayindex,eachDaySessions in
                eachDaySessions.arrOfPlan.enumerated().forEach { eachSessionindex, eachSession in
                    AppDefaults.shared.tpArry.arrOfPlan.enumerated().forEach({ addedeachSessionindex, addedeachSession in
                        if addedeachSession.date == eachSession.date && eachSession.changeStatus == "true" {
                          //  AppDefaults.shared.eachDatePlan.tourPlanArr.append(AppDefaults.shared.tpArry)
                            eachDaySessions.arrOfPlan.remove(at: eachSessionindex)
                            AppDefaults.shared.eachDatePlan.tourPlanArr.append(AppDefaults.shared.tpArry)
                        } else {
                         
                            AppDefaults.shared.eachDatePlan.tourPlanArr.append(AppDefaults.shared.tpArry)
                          
                        }
                    })
                }
            }
        }
        self.toCreateToast("Session added successfully")
            self.menuVC.menuDelegate?.callPlanAPI()
        self.hideMenuAndDismiss()
//        sessionResponseVM!.getTourPlanData(params: param, api: .none) { result in
//                    switch result {
//                    case .success(let response):
//                        print(response)
//
//                        do {
//                            try AppDefaults.shared.toSaveEncodedData(object: response, key: .tourPlan) {_ in
//
//                            }
//                        } catch {
//                            print("Unable to save")
//                        }
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
            
    }
    
    func toSetParams(_ tourPlanArr: TourPlanArr) -> [String: Any] {
        var param = [String: Any]()
        param["Div"] = tourPlanArr.Div
        param["SFCode"] = tourPlanArr.SFCode
        param["SFName"] = tourPlanArr.SFName
        param["tpData"] = [Any]()
        var tpparam = [String: Any]()
        var sessionArr = [Any]()
        tourPlanArr.arrOfPlan.enumerated().forEach { index, allDayPlans in
            tpparam["changeStatus"] = allDayPlans.changeStatus
            tpparam["date"] = allDayPlans.date
            tpparam["day"] = allDayPlans.day
            tpparam["dayNo"] = allDayPlans.dayNo
            tpparam["entryMode"] = allDayPlans.entryMode
            tpparam["rejectionReason"] = allDayPlans.rejectionReason
            tpparam["sessions"] = [Any]()
    
            allDayPlans.sessionDetails.forEach { session in
                var sessionParam = [String: Any]()
                sessionParam["FWFlg"] = session.FWFlg
                sessionParam["HQCodes"] = session.HQCodes
                sessionParam["HQNames"] = session.HQNames
                sessionParam["WTCode"] = session.WTCode
                sessionParam["WTName"] = session.WTName
                sessionParam["chemCode"] = session.chemCode
                sessionParam["chemName"] = session.chemName
                sessionParam["clusterCode"] = session.clusterCode
                sessionParam["clusterName"] = session.clusterName
                sessionParam["drCode"] = session.drCode
                sessionParam["drName"] = session.drName
                sessionParam["jwCode"] = session.jwCode
                sessionParam["jwName"] = session.jwName
                sessionParam["remarks"] = session.remarks
    
                sessionArr.append(sessionParam)
            }
            tpparam["sessions"] = sessionArr
            var info = [String: Any]()
            info["date"] = "\(Date())"
            info["timezone"] = "3"
            info["timezone_type"] = "\(TimeZone.current.identifier)"
            tpparam["submittedTime"] = info
        }
        param["tpData"] = tpparam
    
        let stringJSON = param.toString()
        print(stringJSON)
    
        return param
    }

}

class MenuView : BaseView{
    
    
    
    enum CellType {
        case edit
        case session
        case workType
        case cluster
        case headQuater
        case jointCall
        case listedDoctor
        case chemist
      //  case FieldWork
       // case others
    }
    
    var menuVC :  MenuVC!
    //MARK: Outlets
    
    @IBOutlet var lblAddPlan: UILabel!
    @IBOutlet weak var sideMenuHolderView : UIView!
 
    @IBOutlet weak var countLbl: UILabel!
    
    @IBOutlet weak var menuTable : UITableView!

    @IBOutlet weak var contentBgView: UIView!
  
    @IBOutlet weak var closeTapView: UIView!
    
    @IBOutlet weak var selectView: UIView!
    
    @IBOutlet weak var countView: UIView!
    
    @IBOutlet weak var selectionChevlon: UIImageView!
    
    @IBOutlet weak var selectTitleLbl: UILabel!
    
    @IBOutlet weak var saveView: UIView!
    
    
    @IBOutlet var lblSave: UILabel!
    
    @IBOutlet weak var clearview: UIView!
    @IBOutlet weak var addSessionView: UIView!
    
    @IBOutlet var tableHolderView: UIView!
    
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var selectViewHeightCons: NSLayoutConstraint!
    
    @IBOutlet var searchHolderView: UIView!
    
    @IBOutlet var searchTF: UITextField!
    
    @IBOutlet var searchHolderHeight: NSLayoutConstraint!
    
    @IBOutlet var typesTitleview: UIView!
    
    @IBOutlet var typesTitle: UILabel!
    
    @IBOutlet var typesTitleHeightConst: NSLayoutConstraint!
    
    @IBOutlet var selectAllView: UIView!
    
    @IBOutlet var selectAllIV: UIImageView!
    
    @IBOutlet var selectAllHeightConst: NSLayoutConstraint!
    
    @IBOutlet var noresultsView: UIView!
    
    var isSearched: Bool = false
    var isSearchedWorkTypeSelected: Bool = false
    ///properties to hold array elements
    var selectedClusterIndices : [Int] = []
    var selectedHeadQuatersIndices : [Int] = []
    var selectedJointWorkIndices : [Int] = []
    var selectedDoctorsIndices : [Int] = []
    var selectedChemistIndices : [Int] = []
    var selectedWorkTypeName : String = ""
    var cellType : CellType = .session
    var workTypeArr : [WorkType]?
    var headQuatersArr : [Subordinate]?
    var clusterArr : [Territory]?
    var jointWorkArr : [JointWork]?
    var listedDocArr : [DoctorFencing]?
    var chemistArr : [Chemist]?
    var sessionResponseVM: SessionResponseVM?
    ///properties to hold session contents
    var sessionDetailsArr = SessionDetailsArr()
    var sessionDetail = SessionDetail()
    
    ///properties to handle selection:
    var selectedSession: Int = 0
    var clusterIDArr : [String]?
    
    
    ///Height constraint constants
    let selectViewHeight: CGFloat = 50
    let searchVIewHeight: CGFloat = 50
    let typesTitleHeight: CGFloat = 35
    let cellStackHeightforFW : CGFloat = 450
    let cellStackHeightfOthers : CGFloat = 80
    let cellHeightForFW :  CGFloat = 520 + 100
    let cellHeightForOthers : CGFloat = 140 + 100
    var selectAllHeight : CGFloat = 50
    
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.showMenu()
    }
    
    
    //MARK: - life cycle
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.menuVC = baseVC as? MenuVC
        self.initView()
        self.initGestures()
        self.ThemeUpdate()
    }
    
    
    //MARK: - function to initialize view
    func initView(){
        self.sessionResponseVM = SessionResponseVM()
        searchTF.delegate = self
        cellRegistration()
        loadrequiredDataFromDB()

        
        self.selectTitleLbl.text = "Select"
        self.countView.isHidden = true
        self.menuTable.delegate = self
        self.menuTable.dataSource = self
  
       
        self.selectView.layer.borderWidth = 1
        self.selectView.layer.borderColor = UIColor.gray.cgColor
        self.selectView.layer.cornerRadius = 5
        
        addSessionView.layer.cornerRadius = 5
        addSessionView.layer.borderWidth = 1
        addSessionView.layer.borderColor = UIColor.systemGreen.cgColor
        addSessionView.elevate(2)
        
        saveView.elevate(2)
        saveView.layer.cornerRadius = 5
        
        clearview.elevate(2)
        clearview.layer.borderColor = UIColor.gray.cgColor
        clearview.layer.borderWidth = 1
        clearview.layer.cornerRadius = 5
        countView.elevate(2)
        countView.layer.borderColor = UIColor.systemGreen.cgColor
        countView.layer.borderWidth = 1
        countView.layer.cornerRadius = 5
        
        
        
        searchHolderView.elevate(2)
        searchHolderView.layer.borderColor = UIColor.lightGray.cgColor
        searchHolderView.layer.borderWidth = 0.5
        searchHolderView.layer.cornerRadius = 5
        
      //  self.menuTable.layoutIfNeeded()
      //  NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: Notification.Name("hideMenu"), object: nil)
    }

    func loadrequiredDataFromDB() {
        
        self.workTypeArr = DBManager.shared.getWorkType()
      
        self.headQuatersArr =  DBManager.shared.getSubordinate()
     
        self.clusterArr = DBManager.shared.getTerritory()
     
        self.jointWorkArr = DBManager.shared.getJointWork()
      
        self.listedDocArr = DBManager.shared.getDoctor()
       
        self.chemistArr = DBManager.shared.getChemist()
        
        toGenerateNewSession(self.menuVC.sessionDetailsArr != nil ? false : true)
//isToAddSession: self.menuVC.sessionDetailsArr != nil ? false : true
    }
    
    func toGenerateNewSession(_ istoAddSession: Bool) {
        
//        sessionDetail = SessionDetail()
//        sessionDetail.workType = workTypeArr?.uniqued()
//        sessionDetail.headQuates =  headQuatersArr?.uniqued()
//        sessionDetail.cluster = clusterArr?.uniqued()
//        sessionDetail.jointWork = jointWorkArr?.uniqued()
//        sessionDetail.listedDoctors = listedDocArr?.uniqued()
//        sessionDetail.chemist = chemistArr?.uniqued()
//        self.sessionDetailsArr.sessionDetails.append(sessionDetail)
//        setPageType(.session)
        

        sessionDetail.workType = workTypeArr?.uniqued()
        sessionDetail.headQuates =  headQuatersArr?.uniqued()
        sessionDetail.cluster = clusterArr?.uniqued()
        sessionDetail.jointWork = jointWorkArr?.uniqued()
        sessionDetail.listedDoctors = listedDocArr?.uniqued()
        sessionDetail.chemist = chemistArr?.uniqued()

        if self.menuVC.sessionDetailsArr != nil  {
            self.sessionDetailsArr = self.menuVC.sessionDetailsArr ?? SessionDetailsArr()
            lblAddPlan.text = self.menuVC.sessionDetailsArr?.date ?? ""
            if  istoAddSession {
                self.sessionDetailsArr.sessionDetails.append(sessionDetail)
                setPageType(.session)
            } else {
                setPageType(.edit)
            }
          
        } else {
            sessionDetail = SessionDetail()
            self.sessionDetailsArr.sessionDetails.append(sessionDetail)
            setPageType(.session)
        }
    }
    
    
    func toRemoveSession(at index: Int) {
        self.sessionDetailsArr.sessionDetails.remove(at: index)
    }
    

    @objc func hideMenu() {
        self.hideMenuAndDismiss()
    }
    
    func ThemeUpdate() {

    }
    
    
    func cellRegistration() {
        
        menuTable.register(UINib(nibName: "SessionInfoTVC", bundle: nil), forCellReuseIdentifier: "SessionInfoTVC")
        
        menuTable.register(UINib(nibName: "SelectAllTypesTVC", bundle: nil), forCellReuseIdentifier: "SelectAllTypesTVC")
        
        menuTable.register(UINib(nibName: "EditSessionTVC", bundle: nil), forCellReuseIdentifier: "EditSessionTVC")
        
    }
    
//    override func didLayoutSubviews(baseVC: BaseViewController) {
//        super.didLayoutSubviews(baseVC: baseVC)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            if self.menuTable.contentSize.height + 10 >=  self.height - self.height * 0.07 * 0.1  + 35 - 10 {
//                self.tableHeight.constant = self.height - self.height * 0.07 + 35 * 0.1
//            } else {
//                self.tableHeight.constant = self.menuTable.contentSize.height + 10
//            }
//        }
//    }
    
    func setPageType(_ pagetype: CellType, for session: Int? = nil) {
        switch pagetype {
            
        case .edit:
            self.cellType = .edit
            addSessionView.isHidden = true
            self.lblSave.text = "Edit"
            saveView.isHidden = false
            clearview.isHidden = true
            self.selectViewHeightCons.constant = 0
            self.searchHolderHeight.constant = 0
            typesTitleHeightConst.constant = 0
            self.selectView.isHidden = true
            searchHolderView.isHidden = true
            typesTitleview.isHidden = true
            selectAllView.isHidden = true
            selectAllHeightConst.constant = 0
            typesTitle.text = ""
            self.menuTable.separatorStyle = .none
            self.sessionDetailsArr.sessionDetails[self.selectedSession].workType = self.workTypeArr
            
        case .session:
            self.cellType = .session
            addSessionView.isHidden = false
            saveView.isHidden = false
            self.lblSave.text = "Save"
            clearview.isHidden = true
            self.selectViewHeightCons.constant = 0
            self.searchHolderHeight.constant = 0
            typesTitleHeightConst.constant = 0
            self.selectView.isHidden = true
            searchHolderView.isHidden = true
            typesTitleview.isHidden = true
            selectAllView.isHidden = true
            selectAllHeightConst.constant = 0
            typesTitle.text = ""
            self.menuTable.separatorStyle = .none
            self.sessionDetailsArr.sessionDetails[self.selectedSession].workType = self.workTypeArr
      
            
        case .workType:
            self.cellType = .workType
            addSessionView.isHidden = true
            saveView.isHidden = true
            clearview.isHidden = true
            self.selectViewHeightCons.constant = selectViewHeight
            self.searchHolderHeight.constant =   searchVIewHeight
            typesTitleHeightConst.constant = typesTitleHeight
            typesTitleview.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
            self.selectView.isHidden = false
            searchHolderView.isHidden = false
            selectAllView.isHidden = true
            selectAllHeightConst.constant = 0
            typesTitle.text = "Work Type"
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].workType = self.workTypeArr
        
        case .cluster:
            self.cellType = .cluster
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant =   selectViewHeight
            self.searchHolderHeight.constant = searchVIewHeight
            typesTitleHeightConst.constant = typesTitleHeight
            typesTitle.text = "Cluster"
            typesTitleview.isHidden = false
            self.selectView.isHidden = false
            searchHolderView.isHidden = false
            self.countView.isHidden = true
//            selectAllView.isHidden = false
//            selectAllHeightConst.constant = selectAllHeight
            selectAllView.isHidden = true
            selectAllHeightConst.constant = 0
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].cluster = self.clusterArr
        
        case .headQuater:
            self.cellType = .headQuater
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant =   selectViewHeight
            self.searchHolderHeight.constant =  searchVIewHeight
            typesTitleHeightConst.constant = typesTitleHeight
            typesTitle.text = "Head Quarters"
            typesTitleview.isHidden = false
            searchHolderView.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
//            selectAllView.isHidden = false
//            selectAllHeightConst.constant = selectAllHeight
            selectAllView.isHidden = true
            selectAllHeightConst.constant = 0
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].headQuates = self.headQuatersArr
       
        case .jointCall:
            self.cellType = .jointCall
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant =  selectViewHeight
            self.searchHolderHeight.constant = searchVIewHeight
            typesTitleHeightConst.constant = typesTitleHeight
            typesTitle.text = "Joint Call"
            typesTitleview.isHidden = false
            searchHolderView.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
//            selectAllView.isHidden = false
//            selectAllHeightConst.constant = selectAllHeight
            selectAllView.isHidden = true
            selectAllHeightConst.constant = 0
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].jointWork = self.jointWorkArr
     
        case .listedDoctor:
            self.cellType = .listedDoctor
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant =  selectViewHeight
            self.searchHolderHeight.constant = searchVIewHeight
            typesTitleHeightConst.constant = typesTitleHeight
            typesTitle.text = "Listed doctor"
            typesTitleview.isHidden = false
            searchHolderView.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
//            selectAllView.isHidden = false
//            selectAllHeightConst.constant = selectAllHeight
            selectAllView.isHidden = true
            selectAllHeightConst.constant = 0
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].listedDoctors = self.listedDocArr
        
        case .chemist:
            self.cellType = .chemist
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant = selectViewHeight
            self.searchHolderHeight.constant = searchVIewHeight
            typesTitleHeightConst.constant = typesTitleHeight
            typesTitle.text = "Chemist"
            searchHolderView.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
           // selectAllView.isHidden = false
            //selectAllHeightConst.constant = selectAllHeight
            selectAllView.isHidden = true
            selectAllHeightConst.constant = 0
            typesTitleview.isHidden = false
            
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].chemist = self.chemistArr
       
        }
   
        self.menuTable.isHidden = false
        self.searchTF.text = ""
        self.searchTF.placeholder = "Search"
        self.noresultsView.isHidden = true
        self.menuTable.reloadData()
        var targetRowIndexPath = IndexPath()
        if session == nil {
            targetRowIndexPath =   IndexPath(row: 0, section: 0)
        } else {
            targetRowIndexPath =  IndexPath(row: session ?? 0, section: 0)
        }
        if menuTable.indexPathExists(indexPath: targetRowIndexPath)
        {
            menuTable.scrollToRow(at: targetRowIndexPath, at: .top, animated: false)
        }
       
    }
    
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        
        hideMenuAndDismiss()
    }
    

    
    func initGestures(){
        closeTapView.addTap {
            self.hideMenuAndDismiss()
        }
        
        saveView.addTap { [self] in
            self.endEditing(true)
            self.isSearched = false
            switch self.cellType {
            case .edit:
              //  self.menuTable.reloadData()
              //  self.toGetTourPlanResponse()
                self.sessionDetailsArr.changeStatus = "True"
                self.setPageType(.session)
            case .session:
                self.menuTable.reloadData()
                self.toGetTourPlanResponse()
            case .workType:

                if sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork {
                    setPageType(.session, for: self.selectedSession)
                } else {
                    setPageType(.session, for: self.selectedSession)
                }
            case .cluster:
                setPageType(.session, for: self.selectedSession)
              
            case .headQuater:
                setPageType(.session, for: self.selectedSession)
               
            case .jointCall:
                setPageType(.session, for: self.selectedSession)
               
            case .listedDoctor:
               
                setPageType(.session, for: self.selectedSession)
                
            case .chemist:
                setPageType(.session, for: self.selectedSession)

          
            }
        }
        
        selectView.addTap { [self] in
            self.endEditing(true)
            self.isSearched = false
            switch self.cellType {
            case .edit:
                break
            case .session:
                break
            case .workType:
                if sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork {
                    setPageType(.session, for: self.selectedSession)
                } else {
                    setPageType(.session, for: self.selectedSession)
                }
            case .cluster:
                setPageType(.session, for: self.selectedSession)
            case .headQuater:
                setPageType(.session, for: self.selectedSession)
            case .jointCall:
                setPageType(.session, for: self.selectedSession)
            case .listedDoctor:
                setPageType(.session, for: self.selectedSession)
            case .chemist:
                setPageType(.session, for: self.selectedSession)

          
            }
           
        }
        
        addSessionView.addTap {
            let count = self.sessionDetailsArr.sessionDetails.count
            if  count > 2 {
                if #available(iOS 13.0, *) {
                    (UIApplication.shared.delegate as! AppDelegate).createToastMessage("Maximum plans added", isFromWishList: true)
                } else {
                  print("Maximum plan added")
                }
            } else {
             
                self.toGenerateNewSession(true)
                //isToAddSession: true
                
            }
        }
        
        clearview.addTap { [self] in
            switch self.cellType {
                
            case .session:
                break
            case .workType:
                break
            case .cluster:
                sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.removeAll()
              
            case .headQuater:
                sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.removeAll()
               
            case .jointCall:
                sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.removeAll()
             
            case .listedDoctor:
                sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.removeAll()
               
            case .chemist:
                sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.removeAll()
             
            case .edit:
                break
            }
            self.menuTable.reloadData()
        }
        
        
        selectAllView.addTap { [self] in
            self.endEditing(true)
            
            self.selectAllIV.image =  self.selectAllIV.image ==  UIImage(named: "checkBoxEmpty") ? UIImage(named: "checkBoxSelected") : UIImage(named: "checkBoxEmpty")
            switch self.cellType {
              
            case .session:
                break
            case .workType:
                break
            case .cluster:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                 
                    self.sessionDetailsArr.sessionDetails[selectedSession].cluster?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] = true
                     
                        
              
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].cluster?.enumerated().forEach({ (index, cluster) in
                   
                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.removeValue(forKey: cluster.code ?? "")
                    })
                  
                    
          
                }
      
                
            case .headQuater:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                    
                } else {
                    
                }
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                 
                    self.sessionDetailsArr.sessionDetails[selectedSession].headQuates?.enumerated().forEach({ index, cluster in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[cluster.id ?? ""] = true
               
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].headQuates?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.removeValue(forKey: cluster.id ?? "")
                    })
                
                }
                break
            case .jointCall:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                  
                    self.sessionDetailsArr.sessionDetails[selectedSession].jointWork?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[cluster.code ?? ""] = true
                    
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].jointWork?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.removeValue(forKey: cluster.code ?? "")
                    })
                   
                }
            case .listedDoctor:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                   // sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.removeAll()
                    self.sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[cluster.code ?? ""] = true
                      //  sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.append(index)
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.removeValue(forKey: cluster.code ?? "")
                    })
                
                }
            case .chemist:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                   // sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.removeAll()
                    self.sessionDetailsArr.sessionDetails[selectedSession].chemist?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[cluster.code ?? ""] = true
                      //  sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.append(index)
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].chemist?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.removeValue(forKey: cluster.code ?? "")
                    })
                  //  sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.removeAll()
                }
            case .edit:
                break
            }
            self.menuTable.reloadData()
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleMenuPan(_:)))
        self.sideMenuHolderView.addGestureRecognizer(panGesture)
        self.sideMenuHolderView.isUserInteractionEnabled = true
    }
    
    func toSetSelectAllImage(selectedIndexCount : Int) {
        var isToSelectAll: Bool = false
        switch self.cellType {
        case .session:
            break
        case .workType:
            break
        case .cluster:
            
            if isSearched {
                if selectedIndexCount == sessionDetailsArr.sessionDetails[selectedSession].cluster?.count ?? 0 {
                    isToSelectAll = true
                } else {
                    isToSelectAll = false
                }
            } else {
                if selectedIndexCount == self.clusterArr?.count ?? 0 {
                    isToSelectAll = true
                } else {
                    isToSelectAll = false
                }
            }
            
 
        case .headQuater:
            if selectedIndexCount == sessionDetailsArr.sessionDetails[selectedSession].headQuates?.count ?? 0 {
                isToSelectAll = true
            } else {
                isToSelectAll = false
            }
        case .jointCall:
            if selectedIndexCount == sessionDetailsArr.sessionDetails[selectedSession].jointWork?.count ?? 0 {
                isToSelectAll = true
            } else {
                isToSelectAll = false
            }
        case .listedDoctor:
            if selectedIndexCount == sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?.count ?? 0 {
                isToSelectAll = true
            } else {
                isToSelectAll = false
            }
        case .chemist:
            if selectedIndexCount == sessionDetailsArr.sessionDetails[selectedSession].chemist?.count ?? 0 {
                isToSelectAll = true
            } else {
                isToSelectAll = false
            }
        case .edit:
            break
        }
        if isToSelectAll {
            self.selectAllIV.image =  UIImage(named: "checkBoxSelected")
        } else {
            self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
        }
    }

    //MARK: UDF, gestures  and animations
    
    private var animationDuration : Double = 1.0
    private let aniamteionWaitTime : TimeInterval = 0.15
    private let animationVelocity : CGFloat = 5.0
    private let animationDampning : CGFloat = 2.0
    private let viewOpacity : CGFloat = 0.3
    
    func showMenu(){
       // let isRTL = isRTLLanguage
        let _ : CGFloat =  -1
        //isRTL ? 1 :
        let width = self.frame.width
        self.sideMenuHolderView.transform =  CGAffineTransform(translationX: width,y: 1)
        //isRTL ? CGAffineTransform(translationX: 1 * width,y: 0)  :
        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        while animationDuration > 1.6{
            animationDuration = animationDuration * 0.1
        }
        UIView.animate(withDuration: animationDuration,
                       delay: aniamteionWaitTime,
                       usingSpringWithDamping: animationDampning,
                       initialSpringVelocity: animationVelocity,
                       options: [.curveEaseOut,.allowUserInteraction],
                       animations: {
                        self.sideMenuHolderView.transform = .identity
                        self.backgroundColor = UIColor.black.withAlphaComponent(self.viewOpacity)
                       }, completion: nil)
    }

    func hideMenuAndDismiss(){
       
        let rtlValue : CGFloat = 1
      //  isRTL ? 1 :
        let width = self.frame.width
        while animationDuration > 1.6{
            animationDuration = animationDuration * 0.1
        }
        UIView.animate(withDuration: animationDuration,
                       delay: aniamteionWaitTime,
                       usingSpringWithDamping: animationDampning,
                       initialSpringVelocity: animationVelocity,
                       options: [.curveEaseOut,.allowUserInteraction],
                       animations: {
                        self.sideMenuHolderView.transform = CGAffineTransform(translationX: width * rtlValue,
                                                                              y: 0)
                        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                       }) { (val) in
            
                           self.menuVC.dismiss(animated: true, completion: nil)
        }
        
        
    }
    @objc func handleMenuPan(_ gesture : UIPanGestureRecognizer){
      
        let _ : CGFloat =   -1
        //isRTL ? 1 :
        let translation = gesture.translation(in: self.sideMenuHolderView)
        let xMovement = translation.x
        //        guard abs(xMovement) < self.view.frame.width/2 else{return}
        var opacity = viewOpacity * (abs(xMovement * 2)/(self.frame.width))
        opacity = (1 - opacity) - (self.viewOpacity * 2)
        print("~opcaity : ",opacity)
        switch gesture.state {
        case .began,.changed:
            guard  ( xMovement > 0)  else {return}
          //  ||  (xMovement < 0)
           // isRTL && || !isRTL &&
            
            self.sideMenuHolderView.transform = CGAffineTransform(translationX: xMovement, y: 0)
            self.backgroundColor = UIColor.black.withAlphaComponent(opacity)
        default:
            let velocity = gesture.velocity(in: self.sideMenuHolderView).x
            self.animationDuration = Double(velocity)
            if abs(xMovement) <= self.frame.width * 0.25{//show
                self.sideMenuHolderView.transform = .identity
                self.backgroundColor = UIColor.black.withAlphaComponent(self.viewOpacity)
            }else{//hide
                self.hideMenuAndDismiss()
            }
            
        }
    }
    
    

}
extension MenuView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.cellType {
        case .edit:
            return sessionDetailsArr.sessionDetails.count
            
        case .session:
            return sessionDetailsArr.sessionDetails.count
        
        case .workType:
            return sessionDetailsArr.sessionDetails[selectedSession].workType?.count ?? 0
           
        case .cluster:
            return sessionDetailsArr.sessionDetails[selectedSession].cluster?.count ?? 0
         
        case .headQuater:
            return sessionDetailsArr.sessionDetails[selectedSession].headQuates?.count ?? 0
          
        case .jointCall:
            return sessionDetailsArr.sessionDetails[selectedSession].jointWork?.count ?? 0
           
        case .listedDoctor:
            return sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?.count ?? 0
          
        case .chemist:
            return sessionDetailsArr.sessionDetails[selectedSession].chemist?.count ?? 0

        }
       
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType {
            
        case .edit:
            let cell : EditSessionTVC = tableView.dequeueReusableCell(withIdentifier:"EditSessionTVC" ) as! EditSessionTVC
            cell.selectionStyle = .none

            cell.lblName.text = "Plan \(indexPath.row + 1)"
           
            sessionDetailsArr.sessionDetails[indexPath.row].sessionName = cell.lblName.text ?? ""
            
            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex
            let searchedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].searchedWorkTypeIndex
            let isForFieldWork = sessionDetailsArr.sessionDetails[indexPath.row].isForFieldWork
            
            if  isForFieldWork  {
                cell.stackHeight.constant = cellStackHeightforFW
                [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.workTypeView].forEach { view in
                    view?.isHidden = false
                    // cell.workselectionHolder,
                }
            }  else {
                cell.stackHeight.constant = cellStackHeightfOthers
                [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView].forEach { view in
                    view?.isHidden = true
                    // cell.workselectionHolder,
                }
                
            }
            if isSearched {
                if sessionDetailsArr.sessionDetails[indexPath.row].searchedWorkTypeIndex != nil {
                    cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[searchedWorkTypeIndex ?? 0].name
                } else {
                    cell.lblWorkType.text = "No info available"
                }
            } else {
                if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil {
                    cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
                } else {
                    cell.lblWorkType.text = "No info available"
                }
                
            }
            
            var clusterNameArr = [String]()
            var clusterCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedClusterID.isEmpty {
                self.clusterArr?.forEach({ cluster in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedClusterID.forEach { key, value in
                        if key == cluster.code {
                            clusterNameArr.append(cluster.name ?? "")
                            clusterCodeArr.append(key)
                        }
                    }
                })
                cell.lblCluster.text = clusterNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].clusterName =  cell.lblCluster.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].clusterCode = clusterCodeArr.joined(separator:", ")
            } else {
                
                cell.lblCluster.text = "No info available"
            }
            var headQuatersNameArr = [String]()
            var headQuartersCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedHeadQuaterID.isEmpty {
                self.headQuatersArr?.forEach({ headQuaters in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedHeadQuaterID.forEach { key, value in
                        if key == headQuaters.id {
                            headQuatersNameArr.append(headQuaters.name ?? "")
                            headQuartersCodeArr.append(key)
                        }
                    }
                })
                
                cell.lblHeadquaters.text = headQuatersNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].HQNames =  cell.lblHeadquaters.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].HQCodes = headQuartersCodeArr.joined(separator:", ")
            } else {
                
                cell.lblHeadquaters.text = "No info available"
            }
            
            
            
            var jointWorkNameArr = [String]()
            var jointWorkCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedjointWorkID.isEmpty {
                self.jointWorkArr?.forEach({ work in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedjointWorkID.forEach { key, value in
                        if key == work.code {
                            jointWorkNameArr.append(work.name ?? "")
                            jointWorkCodeArr.append(key)
                        }
                    }
                })
                cell.lblJointCall.text = jointWorkNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].jwName =  cell.lblJointCall.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].jwCode = jointWorkCodeArr.joined(separator:", ")
            } else {
                
                cell.lblJointCall.text = "No info available"
            }
            
            
            var listedDoctorsNameArr = [String]()
            var listedDoctorsCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedlistedDoctorsID.isEmpty {
                self.listedDocArr?.forEach({ doctors in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedlistedDoctorsID.forEach { key, value in
                        if key == doctors.code {
                            listedDoctorsNameArr.append(doctors.name ?? "")
                            listedDoctorsCodeArr.append(key)
                        }
                    }
                })
                cell.lblListedDoctor.text = listedDoctorsNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].drName =  cell.lblListedDoctor.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].drCode = listedDoctorsCodeArr.joined(separator:", ")
            } else {
                
                cell.lblListedDoctor.text = "No info available"
            }
            var chemistNameArr = [String]()
            var chemistCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedchemistID.isEmpty {
                self.chemistArr?.forEach({ chemist in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedchemistID.forEach { key, value in
                        if key == chemist.code {
                            chemistNameArr.append(chemist.name ?? "")
                            chemistCodeArr.append(key)
                        }
                    }
                })
                cell.lblChemist.text = chemistNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].chemName =  cell.lblChemist.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].chemCode = chemistCodeArr.joined(separator:", ")
            } else {
                
                cell.lblChemist.text = "No info available"
            }
            
           return cell
            

        case .session:
            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
            cell.selectionStyle = .none
        
          //  cell.remarksTV.delegate = self
          //  cell.remarks =  sessionDetailsArr.sessionDetails[indexPath.row].remarks.isEmpty ? nil : sessionDetailsArr.sessionDetails[indexPath.row].remarks
            cell.keybordenabled = false
            cell.lblName.text = "Session \(indexPath.row + 1)"
            cell.selectedIndex = indexPath.row + 1
            sessionDetailsArr.sessionDetails[indexPath.row].sessionName = cell.lblName.text ?? ""
            
            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex
            let searchedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].searchedWorkTypeIndex
            let isForFieldWork = sessionDetailsArr.sessionDetails[indexPath.row].isForFieldWork
            
            if  isForFieldWork  {
                cell.stackHeight.constant = cellStackHeightforFW
                [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.workTypeView].forEach { view in
                    view?.isHidden = false
                    // cell.workselectionHolder,
                }
            }  else {
                cell.stackHeight.constant = cellStackHeightfOthers
                [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView].forEach { view in
                    view?.isHidden = true
                    // cell.workselectionHolder,
                }
                
            }
            if isSearched {
                if sessionDetailsArr.sessionDetails[indexPath.row].searchedWorkTypeIndex != nil {
                    cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[searchedWorkTypeIndex ?? 0].name
                } else {
                    cell.lblWorkType.text = "Select"
                }
            } else {
                if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil {
                    cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
                } else {
                    cell.lblWorkType.text = "Select"
                }
                
            }
            
            var clusterNameArr = [String]()
            var clusterCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedClusterID.isEmpty {
                self.clusterArr?.forEach({ cluster in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedClusterID.forEach { key, value in
                        if key == cluster.code {
                            clusterNameArr.append(cluster.name ?? "")
                            clusterCodeArr.append(key)
                        }
                    }
                })
                cell.lblCluster.text = clusterNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].clusterName =  cell.lblCluster.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].clusterCode = clusterCodeArr.joined(separator:", ")
            } else {
                
                cell.lblCluster.text = "Select"
            }
            var headQuatersNameArr = [String]()
            var headQuartersCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedHeadQuaterID.isEmpty {
                self.headQuatersArr?.forEach({ headQuaters in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedHeadQuaterID.forEach { key, value in
                        if key == headQuaters.id {
                            headQuatersNameArr.append(headQuaters.name ?? "")
                            headQuartersCodeArr.append(key)
                        }
                    }
                })
                
                cell.lblHeadquaters.text = headQuatersNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].HQNames =  cell.lblHeadquaters.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].HQCodes = headQuartersCodeArr.joined(separator:", ")
            } else {
                
                cell.lblHeadquaters.text = "Select"
            }
            
            
            
            var jointWorkNameArr = [String]()
            var jointWorkCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedjointWorkID.isEmpty {
                self.jointWorkArr?.forEach({ work in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedjointWorkID.forEach { key, value in
                        if key == work.code {
                            jointWorkNameArr.append(work.name ?? "")
                            jointWorkCodeArr.append(key)
                        }
                    }
                })
                cell.lblJointCall.text = jointWorkNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].jwName =  cell.lblJointCall.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].jwCode = jointWorkCodeArr.joined(separator:", ")
            } else {
                
                cell.lblJointCall.text = "Select"
            }
            
            
            var listedDoctorsNameArr = [String]()
            var listedDoctorsCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedlistedDoctorsID.isEmpty {
                self.listedDocArr?.forEach({ doctors in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedlistedDoctorsID.forEach { key, value in
                        if key == doctors.code {
                            listedDoctorsNameArr.append(doctors.name ?? "")
                            listedDoctorsCodeArr.append(key)
                        }
                    }
                })
                cell.lblListedDoctor.text = listedDoctorsNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].drName =  cell.lblListedDoctor.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].drCode = listedDoctorsCodeArr.joined(separator:", ")
            } else {
                
                cell.lblListedDoctor.text = "Select"
            }
            var chemistNameArr = [String]()
            var chemistCodeArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedchemistID.isEmpty {
                self.chemistArr?.forEach({ chemist in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedchemistID.forEach { key, value in
                        if key == chemist.code {
                            chemistNameArr.append(chemist.name ?? "")
                            chemistCodeArr.append(key)
                        }
                    }
                })
                cell.lblChemist.text = chemistNameArr.joined(separator:", ")
                sessionDetailsArr.sessionDetails[indexPath.row].chemName =  cell.lblChemist.text ?? ""
                sessionDetailsArr.sessionDetails[indexPath.row].chemCode = chemistCodeArr.joined(separator:", ")
            } else {
                
                cell.lblChemist.text = "Select"
            }
            
            var isToproceed = false
            

            
            cell.clusterView.addTap { [self] in
               
                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[indexPath.row].selectedClusterID.count)
                if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  {
                    isToproceed = true
                }
                if isToproceed {
                    self.cellType = .cluster
                    self.selectedSession = indexPath.row
                    self.setPageType(.cluster)
                } else {
                    self.toCreateToast("Please select work type")
                }
                
                
            }
            cell.workTypeView.addTap {
                
               
                    self.cellType = .workType
                    self.selectedSession = indexPath.row
                    
                    self.setPageType(.workType)
           
                
                
            }
            
            cell.headQuatersView.addTap { [self] in
                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[indexPath.row].selectedHeadQuaterID.count)
                if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  {
                    isToproceed = true
                }
                if isToproceed {
                    self.cellType = .headQuater
                    self.selectedSession = indexPath.row
                    
                    self.setPageType(.headQuater)
                } else {
                    self.toCreateToast("Please select work type")
                }
                
                
            }
            cell.jointCallView.addTap { [self] in
                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[indexPath.row].selectedjointWorkID.count)
                if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  {
                    isToproceed = true
                }
                if isToproceed {
                    self.cellType = .jointCall
                    self.selectedSession = indexPath.row
                    
                    self.setPageType(.jointCall)
                } else {
                    self.toCreateToast("Please select work type")
                }
                
                
            }
            cell.listedDoctorView.addTap { [self] in
                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[indexPath.row].selectedlistedDoctorsID.count)
                if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  {
                    isToproceed = true
                }
                if isToproceed {
                    self.cellType = .listedDoctor
                    self.selectedSession = indexPath.row
                    
                    self.setPageType(.listedDoctor)
                } else {
                    self.toCreateToast("Please select work type")
                }
                
                
                
            }
            cell.chemistView.addTap { [self] in
                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[indexPath.row].selectedchemistID.count)
                if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil  {
                    isToproceed = true
                }
                if isToproceed {
                    self.cellType = .chemist
                    self.selectedSession = indexPath.row
                    self.setPageType(.chemist)
                } else {
                    self.toCreateToast("Please select work type")
                }
                
                
                
            }
            
            cell.deleteIcon.isHidden = false
            
            
            cell.deleteIcon.addTap {
                self.selectedSession = indexPath.row
                self.toRemoveSession(at: indexPath.row)
                tableView.reloadData()
            }
         
           
//            sessionDetailsArr.sessionDetails[indexPath.row].remarks = cell.remarks ?? ""
//            dump(sessionDetailsArr.sessionDetails[indexPath.row].remarks)
//            cell.remarksTV.text = sessionDetailsArr.sessionDetails[indexPath.row].remarks == "" ? "Remarks" : sessionDetailsArr.sessionDetails[indexPath.row].remarks
            sessionDetailsArr.sessionDetails[indexPath.row].remarks =  cell.remarks ?? ""
            dump(sessionDetailsArr.sessionDetails[indexPath.row].remarks)
            return cell
            
        case .workType:
            let cell = tableView.dequeueReusableCell(withIdentifier:"WorkTypeCell" ) as! WorkTypeCell
            let item = sessionDetailsArr.sessionDetails[selectedSession].workType?[indexPath.row]
            cell.workTypeLbl.text = item?.name ?? ""
            let cacheIndex =  sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex
            let searchedCacheIndex = sessionDetailsArr.sessionDetails[selectedSession].searchedWorkTypeIndex
            
            
            if isSearched {
                if searchedCacheIndex == nil {
                    self.selectedWorkTypeName = "Select"
                    self.selectTitleLbl.text = selectedWorkTypeName
                } else {
                    
                    self.selectedWorkTypeName = sessionDetailsArr.sessionDetails[selectedSession].workType?[searchedCacheIndex ?? 0].name ?? ""
                    self.selectTitleLbl.text = selectedWorkTypeName
                }
            } else {
                if cacheIndex == nil {
                    self.selectedWorkTypeName = "Select"
                    self.selectTitleLbl.text = selectedWorkTypeName
                } else {
                    self.selectedWorkTypeName = sessionDetailsArr.sessionDetails[selectedSession].workType?[cacheIndex ?? 0].name ?? ""
                    sessionDetailsArr.sessionDetails[selectedSession].WTCode = sessionDetailsArr.sessionDetails[selectedSession].workType?[cacheIndex ?? 0].code ?? ""
                    
                    sessionDetailsArr.sessionDetails[selectedSession].WTName = sessionDetailsArr.sessionDetails[selectedSession].workType?[cacheIndex ?? 0].name ?? ""
                    
                    self.selectTitleLbl.text = selectedWorkTypeName
                }
            }
            
            
            
            if isSearched {
                if sessionDetailsArr.sessionDetails[selectedSession].searchedWorkTypeIndex == indexPath.row {
                    cell.workTypeLbl.textColor = .green
                }
                else {
                    cell.workTypeLbl.textColor = .black
                }
            } else {
                if sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex == indexPath.row {
                    cell.workTypeLbl.textColor = .green
                }
                else {
                    cell.workTypeLbl.textColor = .black
                }
            }
            
            
            
            cell.addTap { [self] in
                
                if self.isSearched {
                    self.workTypeArr?.enumerated().forEach({ index, workType in
                        if workType.code  ==  item?.code {
                            if sessionDetailsArr.sessionDetails[selectedSession].searchedWorkTypeIndex == index {
                                sessionDetailsArr.sessionDetails[selectedSession].searchedWorkTypeIndex  = nil
                                
                            } else {
                                sessionDetailsArr.sessionDetails[selectedSession].searchedWorkTypeIndex = index
                                
                                if item?.terrslFlg == "Y" {
                                    sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork = true
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork = false
                                }
                                sessionDetailsArr.sessionDetails[selectedSession].FWFlg = workType.terrslFlg ?? ""
                                sessionDetailsArr.sessionDetails[selectedSession].WTCode = workType.code ?? ""
                                
                                sessionDetailsArr.sessionDetails[selectedSession].WTName = workType.name ?? ""
                                
                            }
                        }
                    })
                    
                } else {
                    if sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex == indexPath.row {
                        sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex  = nil
                    } else {
                        sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex = indexPath.row
                        if item?.terrslFlg == "Y" {
                            sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork = true
                        } else {
                            sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork = false
                        }
                        sessionDetailsArr.sessionDetails[selectedSession].FWFlg = item?.terrslFlg ?? ""
                        sessionDetailsArr.sessionDetails[selectedSession].WTCode = item?.code ?? ""
                        
                        sessionDetailsArr.sessionDetails[selectedSession].WTName = item?.name ?? ""
                    }
                }
                // tableView.reloadData()
                setPageType(.session, for: self.selectedSession)
                self.endEditing(true)
            }
            
            
            cell.selectionStyle = .none
            return cell
            
            
        case .cluster, .headQuater, .jointCall, .listedDoctor, .chemist:
            
            // MARK: General note
            /**
             .headQuater, .jointCall, .listedDoctor, .chemist types follows same type of cell reloads and actions as .cluster
             - note : do read documentstions of .cluster tyoe below and make changes to types appropriately
             */
            // MARK: General note ends
            
            let cell = tableView.dequeueReusableCell(withIdentifier:MenuTCell.identifier ) as! MenuTCell
            var item : AnyObject?
            switch self.cellType {
            case .cluster:
                let item = sessionDetailsArr.sessionDetails[selectedSession].cluster?[indexPath.row]
                let _ = sessionDetailsArr.sessionDetails[selectedSession].cluster
                cell.lblName?.text = item?.name ?? ""
                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                
                // MARK: - cells load action
                /**
                 here  sessionDetailsArr.sessionDetails[selectedSession].cluster is an array which has cluster,
                 sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID id dictionary which has selected cluster code and appropriate boolean values captured from cell tap action.
                 
                 - note : iterating through cluster Array and selectedClusterID dictionary if code in selectedClusterID dictionary is equal to code in cluster array
                 - note : And furher if value for code in  selectedClusterID dictionary is true cell is modified accordingly
                 */

                    self.clusterArr?.forEach({ cluster in
                        //  dump(cluster.code)
                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.forEach { id, isSelected in
                            if id == cluster.code {

                                if isSelected  {
                                    if cluster.name ==  cell.lblName?.text {
                                        cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                    }
                                    
                                } else {
                                    cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                                }
                            } else {
                            }
                        }
                    })

                // MARK: - set count and selected label
                /**
                 here  sessionDetailsArr.sessionDetails[selectedSession].cluster is an array which has cluster,
                 sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID id dictionary which has selected cluster code and appropriate boolean values captured from cell tap action.
                 - note : iterating through selectedClusterID dictionary if (code) value in selectedClusterID dictionary is is true count value is increamented
                 */
                
                var count = 0
                sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.forEach({ (code, isSelected) in
                    if isSelected {
                        count += 1
                    }
                })
                
                if count > 0 {
                    self.selectTitleLbl.text = "Selected"
                    self.countView.isHidden = false
                    self.countLbl.text = "\(count)"
                } else {
                    self.selectTitleLbl.text = "Select"
                    self.countView.isHidden = true
                    
                }
                
                // MARK: - set count and selected ends
                
                
                // MARK: - cells load action ends
                
                cell.addTap { [self] in
                    self.endEditing(true)
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID
                    
                    // MARK: - Append contents to selectedClusterID Dictionary
                    /**
                     selectedClusterID dictionary holds code key and Boolean value
                     - note : on tap action on cell if key code doent exists we are making value to true else value for key is removed
                     - note : if value is false selectAllIV is set to checkBoxEmpty image since key does not holds all code values as true.
                     */
                    
                    if self.isSearched {
                        self.clusterArr?.enumerated().forEach({ index, cluster in
                            if cluster.code  ==  item?.code {
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] == nil {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] = true
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] == true ? false : true
                                }
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] == false {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.removeValue(forKey: cluster.code ?? "")
                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                }
                                
                            }
                            
                        })
                      
                    } else {
                        if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] {
                            
                            sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] == true ? false : true
                            
                            if sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] == false {
                                sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.removeValue(forKey: item?.code ?? "")
                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                            }
                            
                        } else {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] = true
                        }
                    }
                    tableView.reloadData()
                    
                }
                
            case .headQuater:
                item = sessionDetailsArr.sessionDetails[selectedSession].headQuates?[indexPath.row]
                cell.lblName?.text = item?.name ?? ""
                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")

                    sessionDetailsArr.sessionDetails[selectedSession].headQuates?.forEach({ quaters in
                        //  dump(cluster.code)
                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.forEach { id, isSelected in
                            if id == quaters.id {
                                
                                if isSelected  {
                                    
             
                                    if quaters.name ==  cell.lblName?.text {
                                        cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                    }
                                    
                                } else {
                                    cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                                }
                            } else {
                             
                            }
                        }
                    })
                
                

                
                var count = 0
                sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.forEach({ (id, isSelected) in
                    if isSelected {
                        count += 1
                    }
                })
                
                if count > 0 {
                    self.selectTitleLbl.text = "Selected"
                    self.countView.isHidden = false
                    self.countLbl.text = "\(count)"
                } else {
                    self.selectTitleLbl.text = "Select"
                    self.countView.isHidden = true
                    
                }
                
                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID
                    
                    if self.isSearched {
                        self.headQuatersArr?.enumerated().forEach({ index, quarters in
                            if quarters.id  ==  item?.code {
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[quarters.id ?? ""] == nil {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[quarters.id ?? ""] = true
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[quarters.id ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[quarters.id ?? ""] == true ? false : true
                                }
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[quarters.id ?? ""] == false {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.removeValue(forKey: quarters.id ?? "")
                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                }
                                
                            }
                            
                        })
                    } else {
                        if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] {
                            
                            sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] == true ? false : true
                            
                            if sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] == false {
                                sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.removeValue(forKey: item?.id ?? "")
                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                            }
                            
                        } else {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] = true
                        }
                    }
  
                    
                    tableView.reloadData()
                }
            case .jointCall:
                item = sessionDetailsArr.sessionDetails[selectedSession].jointWork?[indexPath.row]
                cell.lblName?.text = item?.name ?? ""
                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                sessionDetailsArr.sessionDetails[selectedSession].jointWork?.forEach({ work in
                    //  dump(cluster.code)
                    sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.forEach { id, isSelected in
                        if id == work.code {
                            
                            if isSelected  {
                                
                                if work.name ==  cell.lblName?.text {
                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                }
                                
                            } else {
                                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                            }
                        } else {

                        }
                    }
                })
                var count = 0
                sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.forEach({ (code, isSelected) in
                    if isSelected {
                        count += 1
                    }
                })
                
                if count > 0 {
                    self.selectTitleLbl.text = "Selected"
                    self.countView.isHidden = false
                    self.countLbl.text = "\(count)"
                } else {
                    self.selectTitleLbl.text = "Select"
                    self.countView.isHidden = true
                    
                }
                
                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID
                    
                    if isSearched {
                        self.jointWorkArr?.enumerated().forEach({ index, work in
                            if work.code  ==  item?.code {
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[work.code ?? ""] == nil {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[work.code ?? ""] = true
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[work.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[work.code ?? ""] == true ? false : true
                                }
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[work.code ?? ""] == false {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.removeValue(forKey: work.code ?? "")
                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                }
                                
                            }
                            
                        })
                    } else {
                        if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] {
                            
                            sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] == true ? false : true
                            
                            if sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] == false {
                                sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.removeValue(forKey: item?.code ?? "")
                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                            }
                            
                        } else {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] = true
                        }
                    }
                    tableView.reloadData()
                }
                
            case .listedDoctor:
                item = sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?[indexPath.row]
                cell.lblName?.text = item?.name ?? ""
                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?.forEach({ doctors in
                    //  dump(cluster.code)
                    sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.forEach { id, isSelected in
                        if id == doctors.code {
                            
                            if isSelected  {
                                
                                if doctors.name ==  cell.lblName?.text {
                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                }
                                
                                
                            } else {
                                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                            }
                        } else {
                        }
                    }
                })
                var count = 0
                sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.forEach({ (code, isSelected) in
                    if isSelected {
                        count += 1
                    }
                })
                
                if count > 0 {
                    self.selectTitleLbl.text = "Selected"
                    self.countView.isHidden = false
                    self.countLbl.text = "\(count)"
                } else {
                    self.selectTitleLbl.text = "Select"
                    self.countView.isHidden = true
                    
                }
                
                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID
                    
                    if self.isSearched {
                        self.listedDocArr?.enumerated().forEach({ index, doctors in
                            if doctors.code  ==  item?.code {
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[doctors.code ?? ""] == nil {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[doctors.code ?? ""] = true
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[doctors.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[doctors.code ?? ""] == true ? false : true
                                }
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[doctors.code ?? ""] == false {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.removeValue(forKey: doctors.code ?? "")
                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                }
                                
                            }
                            
                        })
                    } else {
                        if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] {
                            
                            sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] == true ? false : true
                            
                            if sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] == false {
                                sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.removeValue(forKey: item?.code ?? "")
                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                            }
                            
                        } else {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] = true
                        }
                    }

                    tableView.reloadData()
                }
            case .chemist:
                item = sessionDetailsArr.sessionDetails[selectedSession].chemist?[indexPath.row]
                cell.lblName?.text = item?.name ?? ""
                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                sessionDetailsArr.sessionDetails[selectedSession].chemist?.forEach({ chemist in
                  
                    sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.forEach { id, isSelected in
                        if id == chemist.code {
                            
                            if isSelected  {
                                
                                if chemist.name ==  cell.lblName?.text {
                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                }
                                
                                
                            } else {
                                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                            }
                        } else {
                       
                        }
                    }
                })
                
                var count = 0
                sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.forEach({ (code, isSelected) in
                    if isSelected {
                        count += 1
                    }
                })
                
                if count > 0 {
                    self.selectTitleLbl.text = "Selected"
                    self.countView.isHidden = false
                    self.countLbl.text = "\(count)"
                } else {
                    self.selectTitleLbl.text = "Select"
                    self.countView.isHidden = true
                    
                }
                
                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID
                    
                    if self.isSearched {
                        self.chemistArr?.enumerated().forEach({ index, chemist in
                            if chemist.code  ==  item?.code {
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[chemist.code ?? ""] == nil {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[chemist.code ?? ""] = true
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[chemist.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[chemist.code ?? ""] == true ? false : true
                                }
                                if sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[chemist.code ?? ""] == false {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.removeValue(forKey: chemist.code ?? "")
                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                }
                                
                            }
                            
                        })
                    } else {
                        if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] {
                            
                            sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] == true ? false : true
                            
                            if sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] == false {
                                sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.removeValue(forKey: item?.code ?? "")
                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                            }
                            
                        } else {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] = true
                        }
                    }
                    

                    
                    tableView.reloadData()
                }
            default:  return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
            
            
       
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellType {
            
        case .session:
 
            if sessionDetailsArr.sessionDetails[indexPath.row].isForFieldWork  {
                return cellHeightForFW
            }  else {
                return cellHeightForOthers
            }
        case .workType:
            return 50
        case .cluster, .headQuater, .jointCall, .listedDoctor, .chemist:
            if indexPath.section == 0 {
                return 50
            } else {
                return 50
            }
           
        case .edit:
            if sessionDetailsArr.sessionDetails[indexPath.row].isForFieldWork  {
                return cellHeightForFW - 100
            }  else {
                return cellHeightForOthers - 100
            }
        }
    }
    


}

class MenuTCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var menuIcon: UIImageView?
    @IBOutlet weak var holderView: UIView!
    static let identifier = "MenuTCell"
    var didSelected: Bool = false

}


class SessionCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var clusterView: UIView!
    
    @IBOutlet weak var workselectionHolder: UIView!
    
    @IBOutlet weak var clusterselectionHolder: UIView!
    
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var workTypeView: UIView!
}


class WorkTypeCell: UITableViewCell {
    @IBOutlet weak var workTypeLbl: UILabel!
}



// Given JSON string
let jsonString = "{\"tableName\": \"savetp\",\"TPDatas\": {\"worktype_name\": \"Field Work,\",\"worktype_code\": \"3637\",\"cluster_name\": \"CHAKKARAKKAL,KELAKAM,KUTHUPARAMBA,MATTANNUR,PANOOR,\",\"cluster_code\": \"18758,20218,20221,18759,18761,\",\"DayRmk\": \"planner Remarks\",},\"dayno\": \"9\",\"TPDt\": \"2023-11-9 00:00:00\",\"TPMonth\": \"11\",\"TPYear\": \"2023\"}"


extension MenuView : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTF {
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Handle the text change
        if let text = textField.text as NSString? {
            let newText = text.replacingCharacters(in: range, with: string).lowercased()
            print("New text: \(newText)")

            switch self.cellType {
                
            case .workType:
                var filteredWorkType = [WorkType]()
                filteredWorkType.removeAll()
                var isMatched = false
                sessionDetailsArr.sessionDetails[self.selectedSession].workType?.forEach({ workType in
                    if workType.name!.lowercased().contains(newText) {
                        filteredWorkType.append(workType)
                        isMatched = true
                        
                    }
                })
                
                if newText.isEmpty {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].workType = self.workTypeArr
                    self.noresultsView.isHidden = true
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].workType = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = false
//                    self.selectAllHeightConst.constant = selectAllHeight
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = true
                }
                
                
            case .cluster:
                var filteredWorkType = [Territory]()
                filteredWorkType.removeAll()
                var isMatched = false
                sessionDetailsArr.sessionDetails[self.selectedSession].cluster?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        
                        isMatched = true
                    }
                })
                if newText.isEmpty {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].cluster = self.clusterArr
                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = false
//                    self.selectAllHeightConst.constant = selectAllHeight
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    isSearched = true
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    if isMatched {
                        self.sessionDetailsArr.sessionDetails[self.selectedSession].cluster = filteredWorkType
                        isSearched = true
                        self.noresultsView.isHidden = true
                        self.selectAllView.isHidden = true
                        self.selectAllHeightConst.constant = 0
                        self.menuTable.isHidden = false
                        self.menuTable.reloadData()
                    } else {
                        print("Not matched")
                        self.noresultsView.isHidden = false
                        isSearched = true
                        self.selectAllView.isHidden = true
                        self.selectAllHeightConst.constant = 0
                        self.menuTable.isHidden = true
                    }
                }
  
            case .headQuater:
                var filteredWorkType = [Subordinate]()
                filteredWorkType.removeAll()
                var isMatched = false
                sessionDetailsArr.sessionDetails[self.selectedSession].headQuates?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        
                        isMatched = true
                    }
                })
                
                
                if newText.isEmpty {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].headQuates = self.headQuatersArr
                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = false
//                    self.selectAllHeightConst.constant = selectAllHeight
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].headQuates = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = true
                }
            case .jointCall:
                var filteredWorkType = [JointWork]()
                filteredWorkType.removeAll()
                var isMatched = false
                sessionDetailsArr.sessionDetails[self.selectedSession].jointWork?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        
                        isMatched = true
                    }
                })
                
                if newText.isEmpty {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].jointWork = self.jointWorkArr
                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = false
//                    self.selectAllHeightConst.constant = selectAllHeight
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].jointWork = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = true
                }

            case .listedDoctor:
                var filteredWorkType = [DoctorFencing]()
                filteredWorkType.removeAll()
                var isMatched = false
                sessionDetailsArr.sessionDetails[self.selectedSession].listedDoctors?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        
                        isMatched = true
                    }
                })
                
                if newText.isEmpty {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].listedDoctors = self.listedDocArr
                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = false
//                    self.selectAllHeightConst.constant = selectAllHeight
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].listedDoctors = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = true
                }
                

            case .chemist:
                var filteredWorkType = [Chemist]()
                filteredWorkType.removeAll()
                var isMatched = false
                sessionDetailsArr.sessionDetails[self.selectedSession].chemist?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        isMatched = true
                    }
                })

                
                if newText.isEmpty {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].chemist = self.chemistArr
                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = false
//                    self.selectAllHeightConst.constant = selectAllHeight
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].chemist = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.selectAllView.isHidden = true
                    self.selectAllHeightConst.constant = 0
                    self.menuTable.isHidden = true
                }
            default:
                break
            }
            // You can update your UI or perform other actions based on the filteredArray
        }

        return true
    }
}


