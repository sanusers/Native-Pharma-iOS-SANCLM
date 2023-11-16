//
//  MenuVIew.swift
//  E-Detailing
//
//  Created by San eforce on 10/11/23.
//



import Foundation
import UIKit
import CoreData


class MenuView : BaseView{
    
    
    
    enum CellType {
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
    
    ///properties to hold session contents
    var sessionDetailsArr = SessionDetailsArr()
    var sessionDetail = SessionDetail()
    
    ///properties to handle selection:
    var selectedSession: Int = 0
    var clusterIDArr : [String]?
    
    
    ///constraint Constants
    let selectViewHeight: CGFloat = 50
    let searchVIewHeight: CGFloat = 50
    let typesTitleHeight: CGFloat = 35
    let cellStackHeightforFW : CGFloat = 450
    let cellStackHeightfOthers : CGFloat = 80
    let cellHeightForFW :  CGFloat = 520
    let cellHeightForOthers : CGFloat = 140
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
        searchTF.delegate = self
        cellRegistration()
        loadrequiredDataFromDB()

        
        self.selectTitleLbl.text = "Select"
        self.countView.isHidden = true
        self.menuTable.delegate = self
        self.menuTable.dataSource = self
        if self.cellType == .session {
           
        }
        setPageType(.session)
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
        
        toGenerateNewSession()

    }
    
    func toGenerateNewSession() {
        
        sessionDetail = SessionDetail()
        sessionDetail.workType = workTypeArr?.uniqued()
        sessionDetail.headQuates =  headQuatersArr?.uniqued()
        sessionDetail.cluster = clusterArr?.uniqued()
        sessionDetail.jointWork = jointWorkArr?.uniqued()
        sessionDetail.listedDoctors = listedDocArr?.uniqued()
        sessionDetail.chemist = chemistArr?.uniqued()
        self.sessionDetailsArr.sessionDetails.append(sessionDetail)
        
    }
    
    
    func toRemoveSession(at index: Int) {
        self.sessionDetailsArr.sessionDetails.remove(at: index)
    }
    
    @IBAction func userBegintoSearch(_ sender: UITextField) {
        
        
        
        switch self.cellType {
            
        case .workType:
            // Filter the array to get people with the name "Bob"
            let filteredtype = workTypeArr?.filter { $0.name?.localizedLowercase == sender.text?.localizedLowercase }

            if let types = filteredtype {
                // Access the person with the name "Bob"
                print("Found : \(types.count) elements")
            } else {
                print("No person named Bob found.")
            }
        case .cluster:
            break
        case .headQuater:
            break
        case .jointCall:
            break
        case .listedDoctor:
            break
        case .chemist:
            break

        default:
            break
        }
    }
    
    
    @objc func hideMenu() {
        self.hideMenuAndDismiss()
    }
    
    func ThemeUpdate() {

    }
    
    
    func cellRegistration() {
        
        menuTable.register(UINib(nibName: "SessionInfoTVC", bundle: nil), forCellReuseIdentifier: "SessionInfoTVC")
        
        menuTable.register(UINib(nibName: "SelectAllTypesTVC", bundle: nil), forCellReuseIdentifier: "SelectAllTypesTVC")
        
        
        
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
        case .session:
            self.cellType = .session
            addSessionView.isHidden = false
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
         //   self.menuTable.reloadData()
            
        case .workType:
            self.cellType = .workType
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
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
         //   self.menuTable.reloadData()
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
            selectAllView.isHidden = false
            selectAllHeightConst.constant = selectAllHeight
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].cluster = self.clusterArr
         //   self.menuTable.reloadData()
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
            selectAllView.isHidden = false
            selectAllHeightConst.constant = selectAllHeight
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].headQuates = self.headQuatersArr
         //   self.menuTable.reloadData()
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
            selectAllView.isHidden = false
            selectAllHeightConst.constant = selectAllHeight
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].jointWork = self.jointWorkArr
         //   self.menuTable.reloadData()
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
            selectAllView.isHidden = false
            selectAllHeightConst.constant = selectAllHeight
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].listedDoctors = self.listedDocArr
          //  self.menuTable.reloadData()
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
            selectAllView.isHidden = false
            typesTitleview.isHidden = false
            selectAllHeightConst.constant = selectAllHeight
            self.menuTable.separatorStyle = .singleLine
            self.sessionDetailsArr.sessionDetails[self.selectedSession].chemist = self.chemistArr
          //  self.menuTable.reloadData()
//        case .FieldWork:
//            self.cellType = .FieldWork
//            addSessionView.isHidden = false
//            saveView.isHidden = false
//            clearview.isHidden = true
//            self.selectViewHeightCons.constant = 0
//            self.searchHolderHeight.constant = 0
//            searchHolderView.isHidden = true
//            self.selectView.isHidden = true
//
//          //  self.menuTable.reloadData()
//        case .others:
//            self.cellType = .others
//            addSessionView.isHidden = false
//            saveView.isHidden = false
//            clearview.isHidden = true
//            self.selectViewHeightCons.constant = 0
//            self.searchHolderHeight.constant = 0
//            searchHolderView.isHidden = true
//            self.selectView.isHidden = true
          //  self.menuTable.reloadData()
        }
        //self.isSearched = false
        self.searchTF.text = ""
        self.searchTF.placeholder = "Search"
        self.menuTable.reloadData()
        var targetRowIndexPath = IndexPath()
        if session == nil {
            targetRowIndexPath =   IndexPath(row: 0, section: 0)
        } else {
            targetRowIndexPath =  IndexPath(row: session ?? 0, section: 0)
        }
        if menuTable.indexPathExists(indexPath: targetRowIndexPath)
        {
            menuTable.scrollToRow(at: targetRowIndexPath, at: .top, animated: true)
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
            switch self.cellType {
                
            case .session:
                break
            case .workType:
//                if sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork {
//                    setPageType(.FieldWork, for: self.selectedSession)
//                } else {
//                    setPageType(.others, for: self.selectedSession)
//                }
                
                if sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork {
                    setPageType(.session, for: self.selectedSession)
                } else {
                    setPageType(.session, for: self.selectedSession)
                }
            case .cluster:
                setPageType(.session, for: self.selectedSession)
                //setPageType(.FieldWork, for: self.selectedSession)
            case .headQuater:
                setPageType(.session, for: self.selectedSession)
               // setPageType(.FieldWork, for: self.selectedSession)
            case .jointCall:
                setPageType(.session, for: self.selectedSession)
                //setPageType(.FieldWork, for: self.selectedSession)
            case .listedDoctor:
               // setPageType(.FieldWork, for: self.selectedSession)
                setPageType(.session, for: self.selectedSession)
            case .chemist:
                setPageType(.session, for: self.selectedSession)
               // setPageType(.FieldWork, for: self.selectedSession)
//            case .FieldWork:
//                setPageType(.session, for: self.selectedSession)
//               // setPageType(.FieldWork, for: self.selectedSession)
//            case .others:
//                setPageType(.session, for: self.selectedSession)
//              //  setPageType(.others, for: self.selectedSession)
            }
        }
        
        selectView.addTap { [self] in
            
            switch self.cellType {
                
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
//            case .FieldWork:
//                setPageType(.FieldWork, for: self.selectedSession)
//            case .others:
//                setPageType(.others, for: self.selectedSession)
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
                self.toGenerateNewSession()
                
                self.setPageType(.session, for: count)
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
                sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices.removeAll()
            case .headQuater:
                sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.removeAll()
                sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices.removeAll()
            case .jointCall:
                sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.removeAll()
                sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices.removeAll()
            case .listedDoctor:
                sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.removeAll()
                sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.removeAll()
            case .chemist:
                sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.removeAll()
                sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.removeAll()
            }
            self.menuTable.reloadData()
        }
        
        
        selectAllView.addTap { [self] in
             
            self.selectAllIV.image =  self.selectAllIV.image ==  UIImage(named: "checkBoxEmpty") ? UIImage(named: "checkBoxSelected") : UIImage(named: "checkBoxEmpty")
            switch self.cellType {
              
            case .session:
                break
            case .workType:
                break
            case .cluster:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                    sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices.removeAll()
                    self.sessionDetailsArr.sessionDetails[selectedSession].cluster?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] = true
                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices.append(index)
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].cluster?.enumerated().forEach({ (index, cluster) in
                       // sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] = false
                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.removeValue(forKey: cluster.code ?? "")
                    })
                    sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices.removeAll()
                }
      
                
            case .headQuater:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                    
                } else {
                    
                }
//                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
//                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices.removeAll()
//                    self.sessionDetailsArr.sessionDetails[selectedSession].headQuates?.enumerated().forEach({ index, cluster in
//                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[cluster.code ?? ""] = true
//                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices.append(index)
//                    })
//                } else {
//                    self.sessionDetailsArr.sessionDetails[selectedSession].headQuates?.enumerated().forEach({ (index, cluster) in
//                       // sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[cluster.code ?? ""] = false
//                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.removeValue(forKey: cluster.code ?? "")
//                    })
//                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices.removeAll()
//                }
                break
            case .jointCall:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                    sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices.removeAll()
                    self.sessionDetailsArr.sessionDetails[selectedSession].jointWork?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[cluster.code ?? ""] = true
                        sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices.append(index)
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].jointWork?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.removeValue(forKey: cluster.code ?? "")
                    })
                    sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices.removeAll()
                }
            case .listedDoctor:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                    sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.removeAll()
                    self.sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[cluster.code ?? ""] = true
                        sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.append(index)
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.removeValue(forKey: cluster.code ?? "")
                    })
                    sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.removeAll()
                }
            case .chemist:
                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
                    sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.removeAll()
                    self.sessionDetailsArr.sessionDetails[selectedSession].chemist?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[cluster.code ?? ""] = true
                        sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.append(index)
                    })
                } else {
                    self.sessionDetailsArr.sessionDetails[selectedSession].chemist?.enumerated().forEach({ (index, cluster) in
                        sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.removeValue(forKey: cluster.code ?? "")
                    })
                    sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.removeAll()
                }
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
            if selectedIndexCount == sessionDetailsArr.sessionDetails[selectedSession].cluster?.count ?? 0 {
                isToSelectAll = true
            } else {
                isToSelectAll = false
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
            
            self.menuVC.dismiss(animated: false, completion: nil)
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
        case .session:
            return sessionDetailsArr.sessionDetails.count
           // return sessionCount
        case .workType:
            return sessionDetailsArr.sessionDetails[selectedSession].workType?.count ?? 0
           // return workTypeArr?.count ?? 0
        case .cluster:
            return sessionDetailsArr.sessionDetails[selectedSession].cluster?.count ?? 0
          //  return self.clusterArr?.count ?? 0
        case .headQuater:
            return sessionDetailsArr.sessionDetails[selectedSession].headQuates?.count ?? 0
           // return self.headQuatersArr?.count ?? 0
        case .jointCall:
            return sessionDetailsArr.sessionDetails[selectedSession].jointWork?.count ?? 0
           // return self.jointWorkArr?.count ?? 0
        case .listedDoctor:
            return sessionDetailsArr.sessionDetails[selectedSession].listedDoctors?.count ?? 0
          //  return self.listedDocArr?.count ?? 0
        case .chemist:
            return sessionDetailsArr.sessionDetails[selectedSession].chemist?.count ?? 0
           // return self.chemistArr?.count ?? 0
//        case .FieldWork:
//            return sessionDetailsArr.sessionDetails.count
//          //  return sessionCount
//        case .others:
//            return sessionDetailsArr.sessionDetails.count
//         //   return  sessionCount
        }
       
        //self.menuVC.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType {
            
        case .session:
            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
            cell.selectionStyle = .none
            
        
            
            cell.lblName.text = "Session \(indexPath.row + 1)"
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
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedClusterID.isEmpty {
                sessionDetailsArr.sessionDetails[indexPath.row].cluster?.forEach({ cluster in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedClusterID.forEach { key, value in
                        if key == cluster.code {
                            clusterNameArr.append(cluster.name ?? "")
                        }
                    }
                })
                cell.lblCluster.text = clusterNameArr.joined(separator:",")
            } else {
                
                cell.lblCluster.text = "Select"
            }
            var headQuatersNameArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedHeadQuaterID.isEmpty {
                sessionDetailsArr.sessionDetails[indexPath.row].headQuates?.forEach({ headQuaters in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedHeadQuaterID.forEach { key, value in
                        if key == headQuaters.id {
                            headQuatersNameArr.append(headQuaters.name ?? "")
                        }
                    }
                })
                cell.lblHeadquaters.text = headQuatersNameArr.joined(separator:",")
            } else {
                
                cell.lblHeadquaters.text = "Select"
            }
            
            
            
            var jointWorkNameArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedjointWorkID.isEmpty {
                sessionDetailsArr.sessionDetails[indexPath.row].jointWork?.forEach({ work in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedjointWorkID.forEach { key, value in
                        if key == work.code {
                            jointWorkNameArr.append(work.name ?? "")
                        }
                    }
                })
                cell.lblJointCall.text = jointWorkNameArr.joined(separator:",")
            } else {
                
                cell.lblJointCall.text = "Select"
            }
            
            
            var listedDoctorsNameArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedlistedDoctorsID.isEmpty {
                sessionDetailsArr.sessionDetails[indexPath.row].listedDoctors?.forEach({ doctors in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedlistedDoctorsID.forEach { key, value in
                        if key == doctors.code {
                            listedDoctorsNameArr.append(doctors.name ?? "")
                        }
                    }
                })
                cell.lblListedDoctor.text = listedDoctorsNameArr.joined(separator:",")
            } else {
                
                cell.lblListedDoctor.text = "Select"
            }
            var chemistNameArr = [String]()
            if !sessionDetailsArr.sessionDetails[indexPath.row].selectedchemistID.isEmpty {
                sessionDetailsArr.sessionDetails[indexPath.row].chemist?.forEach({ chemist in
                    sessionDetailsArr.sessionDetails[indexPath.row].selectedchemistID.forEach { key, value in
                        if key == chemist.code {
                            chemistNameArr.append(chemist.name ?? "")
                        }
                    }
                })
                cell.lblChemist.text = chemistNameArr.joined(separator:",")
            } else {
                
                cell.lblChemist.text = "Select"
            }
            
            
            cell.clusterView.addTap {
                self.cellType = .cluster
                self.selectedSession = indexPath.row
       
                self.setPageType(.cluster)
            }
            cell.workTypeView.addTap {
                self.cellType = .workType
                
                 self.selectedSession = indexPath.row

                self.setPageType(.workType)
            }
            
            cell.headQuatersView.addTap {
                self.cellType = .headQuater
                 self.selectedSession = indexPath.row
    
                self.setPageType(.headQuater)
            }
            cell.jointCallView.addTap {
                self.cellType = .jointCall
                 self.selectedSession = indexPath.row

                self.setPageType(.jointCall)
            }
            cell.listedDoctorView.addTap {
                self.cellType = .listedDoctor
                  self.selectedSession = indexPath.row

                self.setPageType(.listedDoctor)

            }
            cell.chemistView.addTap {
                self.cellType = .chemist
                 self.selectedSession = indexPath.row

                self.setPageType(.chemist)
            }
            
            cell.deleteIcon.isHidden = false
            
            
            cell.deleteIcon.addTap {
                self.toRemoveSession(at: indexPath.row)
                tableView.reloadData()
            }
          
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
                            
                                sessionDetailsArr.sessionDetails[selectedSession].cluster?.forEach({ cluster in
                                    //  dump(cluster.code)
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.forEach { id, isSelected in
                                        if id == cluster.code {
                                            
                                            if isSelected  {
                                                
                                                sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices.forEach({ index in
                                                    if index == indexPath.row {
                                                        dump("cluster name --> \(cluster.name!)")
                                                        dump("cluster code --> \(cluster.code!)")
                                                        dump("dictionary code --> \(id)")
                                                        dump("isSelected --> \(isSelected)")
                                                        print("Selected index --> \(indexPath.row)")
                                                        cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                    }
                                                })
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
                                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID
                                    
                                    // MARK: - Append contents to selectedClusterID Dictionary
                                    /**
                                     selectedClusterID dictionary holds code key and Boolean value
                                     - note : on tap action on cell if key code doent exists we are making value to true else value for key is removed
                                     - note : if value is false selectAllIV is set to checkBoxEmpty image since key does not holds all code values as true.
                                     */
                                    if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] {
                                        
                                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] == true ? false : true
                                        
                                        if sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] == false {
                                            sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.removeValue(forKey: item?.code ?? "")
                                            self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                        }
                                        
                                    } else {
                                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] = true
                                    }
                                    
                                    // MARK: - Append contents to selectedClusterID Dictionary ends
                                    
                                    
                                    // MARK: - Append contents to selectedClusterIndices Array
                                    /**
                                     selectedClusterIndices is a variable which holds all the selected cluster type indices
                                     - note : selectedClusterID dictionary holds code key and Boolean value if key has true value we are appending elements to selectedClusterIndices array
                                     - note : toSetSelectAllImage function is called here, to set select all
                                     */
                                    
                                    if  sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] == true {
                                        _ = item?.code ?? ""
                                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices.append(indexPath.row)
                                        
                                        
                                        toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices.count)
                                    } else {
                                        let newArr =  sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices.filter { $0 != indexPath.row }
                                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterIndices = newArr
                                        toSetSelectAllImage(selectedIndexCount: newArr.count)
                                    }
                                    
                                    //MARK: - Append contents to selectedClusterIndices Array ends
                                    
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
                                            
                                            sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices.forEach({ index in
                                                if index == indexPath.row {
                                                    dump("cluster name --> \(quaters.name!)")
                                                    dump("cluster code --> \(quaters.id!)")
                                                    dump("dictionary code --> \(id)")
                                                    dump("isSelected --> \(isSelected)")
                                                    print("Selected index --> \(indexPath.row)")
                                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                } else {
                                                    //  cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                }
                                            })
                                            
                                            
                                        } else {
                                            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                                        }
                                    } else {
                                        // cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
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
                                
                                
                                if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] {
                                    
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] == true ? false : true
                                    
                                    if sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] == false {
                                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.removeValue(forKey: item?.id ?? "")
                                        self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                    }
                                    
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] = true
                                }
                                
                                
                                
                                if  sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] == true {
                                    _ = item?.id ?? ""
                                    //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                                    //  self.selectedIndices.append(index ?? 0)
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices.append(indexPath.row)
                                    toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices.count)
                                } else {
                                    let newArr =  sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices.filter { $0 != indexPath.row }
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuatersIndices = newArr
                                    toSetSelectAllImage(selectedIndexCount: newArr.count)
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
                                            
                                            sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices.forEach({ index in
                                                if index == indexPath.row {
                                                    dump("cluster name --> \(work.name!)")
                                                    dump("cluster code --> \(work.code!)")
                                                    dump("dictionary code --> \(id)")
                                                    dump("isSelected --> \(isSelected)")
                                                    print("Selected index --> \(indexPath.row)")
                                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                } else {
                                                    //  cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                }
                                            })
                                            
                                            
                                        } else {
                                            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                                        }
                                    } else {
                                        // cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
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
                                
                                
                                if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] {
                                    
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] == true ? false : true
                                    
                                    if sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] == false {
                                        sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.removeValue(forKey: item?.code ?? "")
                                        self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                    }
                                    
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] = true
                                }
                                
                                
                                
                                if  sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] == true {
                                    _ = item?.code ?? ""
                                    //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                                    //  self.selectedIndices.append(index ?? 0)
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices.append(indexPath.row)
                                    toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices.count)
                                } else {
                                    let newArr = sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices.filter { $0 != indexPath.row }
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedJointWorkIndices = newArr
                                    toSetSelectAllImage(selectedIndexCount: newArr.count)
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
                                            
                                            sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.forEach({ index in
                                                if index == indexPath.row {
                                                    dump("cluster name --> \(doctors.name!)")
                                                    dump("cluster code --> \(doctors.code!)")
                                                    dump("dictionary code --> \(id)")
                                                    dump("isSelected --> \(isSelected)")
                                                    print("Selected index --> \(indexPath.row)")
                                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                } else {
                                                    //  cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                }
                                            })
                                            
                                            
                                        } else {
                                            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                                        }
                                    } else {
                                        // cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
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
                                
                                
                                if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] {
                                    
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] == true ? false : true
                                    
                                    if sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] == false {
                                        sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.removeValue(forKey: item?.code ?? "")
                                        self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                    }
                                    
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] = true
                                }
                                
                                
                                
                                if  sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] == true {
                                    _ = item?.code ?? ""
                                    //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                                    //  self.selectedIndices.append(index ?? 0)
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.append(indexPath.row)
                                    toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.count)
                                } else {
                                    let newArr =  sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices.filter { $0 != indexPath.row }
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedDoctorsIndices = newArr
                                    toSetSelectAllImage(selectedIndexCount: newArr.count)
                                }
                                
                                
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
                                tableView.reloadData()
                            }
                        case .chemist:
                            item = sessionDetailsArr.sessionDetails[selectedSession].chemist?[indexPath.row]
                            cell.lblName?.text = item?.name ?? ""
                            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                            sessionDetailsArr.sessionDetails[selectedSession].chemist?.forEach({ chemist in
                                //  dump(cluster.code)
                                sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.forEach { id, isSelected in
                                    if id == chemist.code {
                                        
                                        if isSelected  {
                                            
                                            sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.forEach({ index in
                                                if index == indexPath.row {
                                                    dump("cluster name --> \(chemist.name!)")
                                                    dump("cluster code --> \(chemist.code!)")
                                                    dump("dictionary code --> \(id)")
                                                    dump("isSelected --> \(isSelected)")
                                                    print("Selected index --> \(indexPath.row)")
                                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                } else {
                                                    //  cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                                                }
                                            })
                                            
                                            
                                        } else {
                                            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                                        }
                                    } else {
                                        // cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
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
                                
                                
                                if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] {
                                    
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] == true ? false : true
                                    
                                    if sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] == false {
                                        sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.removeValue(forKey: item?.code ?? "")
                                        self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
                                    }
                                    
                                } else {
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] = true
                                }
                                
                                
                                
                                if  sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] == true {
                                    _ = item?.code ?? ""
                                    //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                                    //  self.selectedIndices.append(index ?? 0)
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.append(indexPath.row)
                                    toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.count)
                                } else {
                                    let newArr = sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices.filter { $0 != indexPath.row }
                                    sessionDetailsArr.sessionDetails[selectedSession].selectedChemistIndices = newArr
                                    toSetSelectAllImage(selectedIndexCount: newArr.count)
                                }
                                
                                
                                
                                tableView.reloadData()
                            }
                        default:  return UITableViewCell()
                        }
                        cell.selectionStyle = .none
                        return cell
        
                

                
                
                
      
                
                
                //        case .FieldWork:
                //            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
                //            cell.selectionStyle = .none
                //            [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.workTypeView].forEach { view in
                //                view?.isHidden = false
                //                // cell.workselectionHolder,
                //            }
                //
                //            cell.lblName.text = "Session \(indexPath.row + 1)"
                //            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex
                //            let isForFieldWork = sessionDetailsArr.sessionDetails[indexPath.row].isForFieldWork
                //
                //            if  isForFieldWork  {
                //                cell.stackHeight.constant = cellStackHeightforFW
                //                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
                //            }  else {
                //                cell.stackHeight.constant = cellStackHeightfOthers
                //                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
                //            }
                //
                //
                //            return cell
                //        case .others:
                //            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
                //            cell.selectionStyle = .none
                //            [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView].forEach { view in
                //                view?.isHidden = true
                //                // cell.workselectionHolder,
                //            }
                //            cell.lblName.text = "Session \(indexPath.row + 1)"
                //            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex
                //            let isForFieldWork = sessionDetailsArr.sessionDetails[indexPath.row].isForFieldWork
                //
                //            if  isForFieldWork  {
                //                cell.stackHeight.constant = cellStackHeightforFW
                //                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
                //            }  else {
                //                cell.stackHeight.constant = cellStackHeightfOthers
                //                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
                //            }
                //            return cell
                
                
                
                
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
            //tableView.height / 1.1
        case .workType:
            return 50
        case .cluster, .headQuater, .jointCall, .listedDoctor, .chemist:
            if indexPath.section == 0 {
                return 50
            } else {
                return 50
            }
           
//        case .FieldWork:
//           // return 520
//            if sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork  {
//                return 520
//            }  else {
//                return 140
//            }
//        case .others:
//           // return 150
//            if sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork  {
//                return 520
//            }  else {
//                return 140
//            }
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
    func ThemeUpdate() {

    }
    
    func modifyContents() {
        
    }
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
                if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].workType = filteredWorkType
                    self.isSearched = true
                    sessionDetailsArr.sessionDetails[selectedSession].searchedWorkTypeIndex = nil
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].workType = self.workTypeArr
                  //  self.isSearched = false
                    self.menuTable.reloadData()
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
                if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].cluster = filteredWorkType
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].cluster = self.clusterArr
                    self.menuTable.reloadData()
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
                if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].headQuates = filteredWorkType
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].headQuates = self.headQuatersArr
                    self.menuTable.reloadData()
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
                if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].jointWork = filteredWorkType
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].jointWork = self.jointWorkArr
                    self.menuTable.reloadData()
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
                if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].listedDoctors = filteredWorkType
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].listedDoctors = self.listedDocArr
                    self.menuTable.reloadData()
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
                if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].chemist = filteredWorkType
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].chemist = self.chemistArr
                    self.menuTable.reloadData()
                }
            default:
                break
            }
            // You can update your UI or perform other actions based on the filteredArray
        }

        return true
    }
}


