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
        searchHolderView.layer.borderColor = UIColor.gray.cgColor
        searchHolderView.layer.borderWidth = 1
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
        sessionDetail.workType = workTypeArr
        sessionDetail.headQuates =  headQuatersArr
        sessionDetail.cluster = clusterArr
        sessionDetail.jointWork = jointWorkArr
        sessionDetail.listedDoctors = listedDocArr
        sessionDetail.chemist = chemistArr
        
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
    
    func setPageType(_ pagetype: CellType, for index: Int? = nil) {
        switch pagetype {
        case .session:
            self.cellType = .session
            addSessionView.isHidden = false
            saveView.isHidden = false
            clearview.isHidden = true
            self.selectViewHeightCons.constant = 0
            self.searchHolderHeight.constant = 0
            self.selectView.isHidden = true
            searchHolderView.isHidden = true
         //   self.menuTable.reloadData()
            
        case .workType:
            self.cellType = .workType
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.selectViewHeightCons.constant = 40
            self.searchHolderHeight.constant = 40
            self.selectView.isHidden = false
            self.countView.isHidden = true
            self.selectView.isHidden = false
            searchHolderView.isHidden = false
         //   self.menuTable.reloadData()
        case .cluster:
            self.cellType = .cluster
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant = 40
            self.searchHolderHeight.constant = 40
            self.selectView.isHidden = false
            searchHolderView.isHidden = false
            self.countView.isHidden = true
         //   self.menuTable.reloadData()
        case .headQuater:
            self.cellType = .headQuater
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant = 40
            self.searchHolderHeight.constant = 40
            searchHolderView.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
         //   self.menuTable.reloadData()
        case .jointCall:
            self.cellType = .jointCall
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant = 40
            self.searchHolderHeight.constant = 40
            searchHolderView.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
         //   self.menuTable.reloadData()
        case .listedDoctor:
            self.cellType = .listedDoctor
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant = 40
            self.searchHolderHeight.constant = 40
            searchHolderView.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
          //  self.menuTable.reloadData()
        case .chemist:
            self.cellType = .chemist
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant = 40
            self.searchHolderHeight.constant = 40
            searchHolderView.isHidden = false
            self.selectView.isHidden = false
            self.countView.isHidden = true
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
        if index != nil {
//            let indexPath = IndexPath(row: index ?? 0, section: 0)
//            DispatchQueue.main.async {
//                self.menuTable.reloadRows(at: [indexPath], with: .fade)
//            }
            self.menuTable.reloadData()
            //self.menuTable.reloadData()
//            Dispatch.background {
//                // do stuff
//
//
//
//                Dispatch.main {
//                    // update UI
//                    self.menuTable.beginUpdates()
//
//                    self.menuTable.endUpdates()
//                }
//
//
//            }
        }else {
            self.menuTable.reloadData()
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
                setPageType(.cluster, for: self.selectedSession)
            case .headQuater:
                setPageType(.headQuater, for: self.selectedSession)
            case .jointCall:
                setPageType(.jointCall, for: self.selectedSession)
            case .listedDoctor:
                setPageType(.listedDoctor, for: self.selectedSession)
            case .chemist:
                setPageType(.chemist, for: self.selectedSession)
//            case .FieldWork:
//                setPageType(.FieldWork, for: self.selectedSession)
//            case .others:
//                setPageType(.others, for: self.selectedSession)
            }
           
        }
        
        addSessionView.addTap {
            self.toGenerateNewSession()
           // self.cellType = .session
            self.setPageType(.session)
          //  self.menuTable.reloadData()
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleMenuPan(_:)))
        self.sideMenuHolderView.addGestureRecognizer(panGesture)
        self.sideMenuHolderView.isUserInteractionEnabled = true
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
            let isForFieldWork = sessionDetailsArr.sessionDetails[indexPath.row].isForFieldWork
            
            if  isForFieldWork  {
                cell.stackHeight.constant = 450
                [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.workTypeView].forEach { view in
                    view?.isHidden = false
                    // cell.workselectionHolder,
                }
            }  else {
                cell.stackHeight.constant = 80
                [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView].forEach { view in
                    view?.isHidden = true
                    // cell.workselectionHolder,
                }
             
            }
            
            if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex != nil {
                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
            } else {
                cell.lblWorkType.text = "Select"
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
                            jointWorkNameArr.append(doctors.name ?? "")
                        }
                    }
                })
                cell.lblListedDoctor.text = jointWorkNameArr.joined(separator:",")
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
              //  self.selectedSession = indexPath.row
                self.setPageType(.cluster)
             
              //  tableView.reloadData()
            }
            cell.workTypeView.addTap {
                self.cellType = .workType
               // self.selectedSession = indexPath.row
                self.setPageType(.workType)
             
               // tableView.reloadData()
            }
            
            cell.headQuatersView.addTap {
                self.cellType = .headQuater
               // self.selectedSession = indexPath.row
                self.setPageType(.headQuater)
             
               // tableView.reloadData()
            }
            cell.jointCallView.addTap {
                self.cellType = .jointCall
               // self.selectedSession = indexPath.row
                self.setPageType(.jointCall)
             
               // tableView.reloadData()
            }
            cell.listedDoctorView.addTap {
                self.cellType = .listedDoctor
              //  self.selectedSession = indexPath.row
                self.setPageType(.listedDoctor)
             
               // tableView.reloadData()
            }
            cell.chemistView.addTap {
                self.cellType = .chemist
              //  self.selectedSession = indexPath.row
                self.setPageType(.chemist)
             
               // tableView.reloadData()
            }
            
                cell.deleteIcon.isHidden = false
            
            
            cell.deleteIcon.addTap {
               // self.sessionCount -= 1
                self.toRemoveSession(at: indexPath.row)
                tableView.reloadData()
               // self.didLayoutSubviews(baseVC: self.menuVC)
            }
            self.selectedSession = indexPath.row
            return cell
            
        case .workType:
            let cell = tableView.dequeueReusableCell(withIdentifier:"WorkTypeCell" ) as! WorkTypeCell
            let item = sessionDetailsArr.sessionDetails[selectedSession].workType?[indexPath.row]
           // let item = self.workTypeArr?[indexPath.row]
            cell.workTypeLbl.text = item?.name ?? ""
            if sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex == indexPath.row {
                cell.workTypeLbl.textColor = .green
            }
            else {
                cell.workTypeLbl.textColor = .black
               
                //cell.didSelected = cell.didSelected == true ? false : true
            }
            cell.addTap { [self] in
                if sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex == indexPath.row {
                    sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex  = nil
                    self.selectTitleLbl.text = "Select"
                   // item.isSelected = false
                } else {
                    sessionDetailsArr.sessionDetails[selectedSession].selectedWorkTypeIndex = indexPath.row
                    if item?.terrslFlg == "Y" {
                        sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork = true
                    } else {
                        sessionDetailsArr.sessionDetails[selectedSession].isForFieldWork = false
                    }
                    self.selectedWorkTypeName = item?.name ?? ""
                    self.selectTitleLbl.text = item?.name ?? ""
                 //   item.isSelected = true
                }
                
                tableView.reloadData()
            }
            
          
            cell.selectionStyle = .none
            return cell


        case .cluster, .headQuater, .jointCall, .listedDoctor, .chemist:
            let cell = tableView.dequeueReusableCell(withIdentifier:MenuTCell.identifier ) as! MenuTCell
            
            var item : AnyObject?
            switch self.cellType {
            
            case .cluster:
               let item = sessionDetailsArr.sessionDetails[selectedSession].cluster?[indexPath.row]
                let _ = sessionDetailsArr.sessionDetails[selectedSession].cluster
                cell.lblName?.text = item?.name ?? ""
                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                sessionDetailsArr.sessionDetails[selectedSession].cluster?.forEach({ cluster in
                  //  dump(cluster.code)
                    sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.forEach { id, isSelected in
                        if id == cluster.code {

                            if isSelected  {

                               self.selectedClusterIndices.forEach({ index in
                                    if index == indexPath.row {
                                        dump("cluster name --> \(cluster.name!)")
                                        dump("cluster code --> \(cluster.code!)")
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
                

                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID
                   
                    
                    if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] {

                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] == true ? false : true
                        
                        if sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] == false {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID.removeValue(forKey: item?.code ?? "")
                        }
                        
                    } else {
                        sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] = true
                    }
                    
                    
                   
                      if  sessionDetailsArr.sessionDetails[selectedSession].selectedClusterID[item?.code ?? ""] == true {
                          _ = item?.code ?? ""
                        //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                        //  self.selectedIndices.append(index ?? 0)
                          self.selectedClusterIndices.append(indexPath.row)
                      } else {
                          let newArr = selectedClusterIndices.filter { $0 != indexPath.row }
                          self.selectedClusterIndices = newArr
                      }
                  
                    
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

                                self.selectedHeadQuatersIndices.forEach({ index in
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
                

                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID
                   
                    
                    if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] {

                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] == true ? false : true
                        
                        if sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] == false {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID.removeValue(forKey: item?.id ?? "")
                        }
                        
                    } else {
                        sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] = true
                    }
                    
                    
                   
                      if  sessionDetailsArr.sessionDetails[selectedSession].selectedHeadQuaterID[item?.id ?? ""] == true {
                          _ = item?.id ?? ""
                        //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                        //  self.selectedIndices.append(index ?? 0)
                          self.selectedHeadQuatersIndices.append(indexPath.row)
                      } else {
                          let newArr = selectedHeadQuatersIndices.filter { $0 != indexPath.row }
                          self.selectedHeadQuatersIndices = newArr
                      }
                  
                    
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

                               self.selectedJointWorkIndices.forEach({ index in
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
                

                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID
                   
                    
                    if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] {

                        sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] == true ? false : true
                        
                        if sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] == false {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID.removeValue(forKey: item?.code ?? "")
                        }
                        
                    } else {
                        sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] = true
                    }
                    
                    
                   
                      if  sessionDetailsArr.sessionDetails[selectedSession].selectedjointWorkID[item?.code ?? ""] == true {
                          _ = item?.code ?? ""
                        //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                        //  self.selectedIndices.append(index ?? 0)
                          self.selectedJointWorkIndices.append(indexPath.row)
                      } else {
                          let newArr = selectedJointWorkIndices.filter { $0 != indexPath.row }
                          self.selectedJointWorkIndices = newArr
                      }
                  
                    
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

                               self.selectedDoctorsIndices.forEach({ index in
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
                

                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID
                   
                    
                    if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] {

                        sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] == true ? false : true
                        
                        if sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] == false {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID.removeValue(forKey: item?.code ?? "")
                        }
                        
                    } else {
                        sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] = true
                    }
                    
                    
                   
                      if  sessionDetailsArr.sessionDetails[selectedSession].selectedlistedDoctorsID[item?.code ?? ""] == true {
                          _ = item?.code ?? ""
                        //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                        //  self.selectedIndices.append(index ?? 0)
                          self.selectedDoctorsIndices.append(indexPath.row)
                      } else {
                          let newArr = selectedDoctorsIndices.filter { $0 != indexPath.row }
                          self.selectedDoctorsIndices = newArr
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

                               self.selectedChemistIndices.forEach({ index in
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
                

                cell.addTap { [self] in
                    _ = sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID
                   
                    
                    if let _ = sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] {

                        sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] =  sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] == true ? false : true
                        
                        if sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] == false {
                            sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID.removeValue(forKey: item?.code ?? "")
                        }
                        
                    } else {
                        sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] = true
                    }
                    
                    
                   
                      if  sessionDetailsArr.sessionDetails[selectedSession].selectedchemistID[item?.code ?? ""] == true {
                          _ = item?.code ?? ""
                        //  let index = clusterItem?.firstIndex(where: {$0.code == code})
                        //  self.selectedIndices.append(index ?? 0)
                          self.selectedChemistIndices.append(indexPath.row)
                      } else {
                          let newArr = selectedChemistIndices.filter { $0 != indexPath.row }
                          self.selectedChemistIndices = newArr
                      }
                  
                    
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
//                cell.stackHeight.constant = 450
//                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
//            }  else {
//                cell.stackHeight.constant = 80
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
//                cell.stackHeight.constant = 450
//                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
//            }  else {
//                cell.stackHeight.constant = 80
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
                return 520
            }  else {
                return 140
            }
            //tableView.height / 1.1
        case .workType:
            return tableView.height / 10
        case .cluster, .headQuater, .jointCall, .listedDoctor, .chemist:
            return tableView.height / 10
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
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.sessionDetailsArr.sessionDetails[self.selectedSession].workType = self.workTypeArr
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
            // You can update your UI or perform other actions based on the filteredArray
        }

        return true
    }
}


