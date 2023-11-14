//
//  MenuVIew.swift
//  E-Detailing
//
//  Created by San eforce on 10/11/23.
//



import Foundation
import UIKit


class MenuView : BaseView{
    
    
    
    enum CellType {
        case session
        case workType
        case cluster
        case headQuater
        case jointCall
        case listedDoctor
        case chemist
        case FieldWork
        case others
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
    
    //MARK:- life cycle
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.menuVC = baseVC as? MenuVC
        self.initView()
        self.initGestures()
        self.ThemeUpdate()
    }
    var selectedIndices : [Int] = []
    var selectedClusterIndex: Int? = nil
    var selectedWorkTyprIndex : Int? = nil
    var selectedWorkTypeName : String = ""
    var cellType : CellType = .session
    var workType = [WorkTypeModal]()
    var cluster = [ClusterModal]()
    var sessionCount = 1
    var workTypeArr : [WorkType]?
    var headQuatersArr : [Territory]?
    var clusterArr : [Subordinate]?
    var jointWorkArr : [JointWork]?
    var listedDocArr : [DoctorFencing]?
    var chemistArr : [Chemist]?
    
    var sessionDetailsArr = SessionDetailsArr()
    var sessionDetail = SessionDetail()
    
    ///Variables to handle selection:
    var selectedSession: Int? = nil
    
    var clusterIDArr : [String]?
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.showMenu()
    }
    //MARK:- initializers
    func initView(){
       // closeBtn.isHidden = true
      //  closeBtn.setTitle("", for: .normal)
        searchTF.delegate = self
        cellRegistration()
        loadrequiredDataFromDB()
        self.cluster = [ClusterModal(name: "cluster_1", id: 1, isSelected: false), ClusterModal(name: "cluster_2", id: 2, isSelected: false), ClusterModal(name: "cluster_3", id: 3, isSelected: false)]
        
        closeTapView.addTap {
            self.hideMenuAndDismiss()
        }
        
        var sessionCount = 1
        self.workType = [WorkTypeModal(name: "Field work", id: 1, isSelected: false), WorkTypeModal(name: "Meeting", id: 2, isSelected: false), WorkTypeModal(name: "Stock closure", id: 3, isSelected: false)]
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
        
        self.menuTable.layoutIfNeeded()
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: Notification.Name("hideMenu"), object: nil)
    }

    func loadrequiredDataFromDB() {
        
        self.workTypeArr = DBManager.shared.getWorkType()
      
      
        self.headQuatersArr = DBManager.shared.getTerritory()
     
        self.clusterArr = DBManager.shared.getSubordinate()
     
        self.jointWorkArr = DBManager.shared.getJointWork()
      
        self.listedDocArr = DBManager.shared.getDoctor()
       
        self.chemistArr = DBManager.shared.getChemist()
        
        toGenerateNewSession()

    }
    
    func toGenerateNewSession() {
        
        sessionDetail = SessionDetail()
        sessionDetail.workType = workTypeArr
        sessionDetail.headQuates = headQuatersArr
        sessionDetail.cluster = clusterArr
        sessionDetail.jointCall = jointWorkArr
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
        case .FieldWork:
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
          //  self.menuTable.reloadData()
        case .FieldWork:
            self.cellType = .FieldWork
            addSessionView.isHidden = false
            saveView.isHidden = false
            clearview.isHidden = true
            self.selectViewHeightCons.constant = 0
            self.searchHolderHeight.constant = 0
            searchHolderView.isHidden = true
            self.selectView.isHidden = true
          //  self.menuTable.reloadData()
        case .others:
            self.cellType = .others
            addSessionView.isHidden = false
            saveView.isHidden = false
            clearview.isHidden = true
            self.selectViewHeightCons.constant = 0
            self.searchHolderHeight.constant = 0
            searchHolderView.isHidden = true
            self.selectView.isHidden = true
          //  self.menuTable.reloadData()
        }
        if index != nil {
            let  index = IndexPath(row: 1, section: 1)
            var indexPaths = [IndexPath]()
            indexPaths.append(index)
           // self.menuTable.reloadRows(at: [index], with: .none)
          self.menuTable.reloadRows(at: indexPaths, with: .right)
            
            self.menuTable.reloadData()
            
        } else {
            self.menuTable.reloadData()
        }

    }
    
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        
        hideMenuAndDismiss()
    }
    

    
    func initGestures(){
//        self.sideMenuHolderView.addAction(for: .tap) {
//            self.hideMenuAndDismiss()
//        }

        saveView.addTap { [self] in
            switch self.cellType {
                
            case .session:
                break
            case .workType:
//                if self.selectedWorkTypeName == "Field Work" {
//                    self.setPageType(.FieldWork)
//                } else {
//                    self.setPageType(.others)
//                }
                if sessionDetailsArr.sessionDetails[selectedSession ?? 0].selectedWorkTypeIndex == 0 {
                    setPageType(.FieldWork, for: self.selectedSession)
                } else {
                    setPageType(.others, for: self.selectedSession)
                }
               
            case .cluster:
              //  self.multiSelectionAPI()
                break
            case .headQuater:
                break
            case .jointCall:
                break
            case .listedDoctor:
                break
            case .chemist:
                break
            case .FieldWork:
                break
            case .others:
                break
            }
            
       
            
           
        }
        
        selectView.addTap { [self] in
            
            if sessionDetailsArr.sessionDetails[selectedSession ?? 0].selectedWorkTypeIndex == 0 {
                setPageType(.FieldWork, for: self.selectedSession)
            } else {
                setPageType(.others, for: self.selectedSession)
            }
           
        }
        
        addSessionView.addTap {
//            if self.sessionCount == 3 {
//                print("Maximim count reached")
//                return
//            }
//            self.sessionCount += 1
            self.toGenerateNewSession()
            self.cellType = .session
            self.menuTable.reloadData()
           // self.didLayoutSubviews(baseVC: self.menuVC)
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
@available(iOS 13.0, *)
extension MenuView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.cellType {
        case .session:
            return sessionDetailsArr.sessionDetails.count
           // return sessionCount
        case .workType:
            return sessionDetailsArr.sessionDetails[selectedSession ?? 0].workType?.count ?? 0
           // return workTypeArr?.count ?? 0
        case .cluster:
            return sessionDetailsArr.sessionDetails[selectedSession ?? 0].cluster?.count ?? 0
          //  return self.clusterArr?.count ?? 0
        case .headQuater:
            return sessionDetailsArr.sessionDetails[selectedSession ?? 0].headQuates?.count ?? 0
           // return self.headQuatersArr?.count ?? 0
        case .jointCall:
            return sessionDetailsArr.sessionDetails[selectedSession ?? 0].jointCall?.count ?? 0
           // return self.jointWorkArr?.count ?? 0
        case .listedDoctor:
            return sessionDetailsArr.sessionDetails[selectedSession ?? 0].listedDoctors?.count ?? 0
          //  return self.listedDocArr?.count ?? 0
        case .chemist:
            return sessionDetailsArr.sessionDetails[selectedSession ?? 0].chemist?.count ?? 0
           // return self.chemistArr?.count ?? 0
        case .FieldWork:
            return sessionDetailsArr.sessionDetails.count
          //  return sessionCount
        case .others:
            return sessionDetailsArr.sessionDetails.count
         //   return  sessionCount
        }
       
        //self.menuVC.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType {
            
        case .session:
            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
            cell.selectionStyle = .none
            [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.workTypeView].forEach { view in
                view?.isHidden = false
                // cell.workselectionHolder,
            }
            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex
            
            if  selectedWorkTypeIndex == 0   {
                cell.stackHeight.constant = 450
                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
            } else if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == nil {
                cell.stackHeight.constant = 450
                cell.lblWorkType.text = "Select"
            } else {
                cell.stackHeight.constant = 80
                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
            }
            cell.clusterView.addTap {
                self.cellType = .cluster
                self.selectedSession = indexPath.row
                self.setPageType(.cluster)
             
              //  tableView.reloadData()
            }
            cell.workTypeView.addTap {
                self.cellType = .workType
                self.selectedSession = indexPath.row
                self.setPageType(.workType)
             
               // tableView.reloadData()
            }
            
            cell.headQuatersView.addTap {
                self.cellType = .headQuater
                self.selectedSession = indexPath.row
                self.setPageType(.headQuater)
             
               // tableView.reloadData()
            }
            cell.jointCallView.addTap {
                self.cellType = .jointCall
                self.selectedSession = indexPath.row
                self.setPageType(.jointCall)
             
               // tableView.reloadData()
            }
            cell.listedDoctorView.addTap {
                self.cellType = .listedDoctor
                self.selectedSession = indexPath.row
                self.setPageType(.listedDoctor)
             
               // tableView.reloadData()
            }
            cell.chemistView.addTap {
                self.cellType = .chemist
                self.selectedSession = indexPath.row
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
            
            return cell
            
        case .workType:
            let cell = tableView.dequeueReusableCell(withIdentifier:"WorkTypeCell" ) as! WorkTypeCell
            let item = sessionDetailsArr.sessionDetails[selectedSession ?? 0].workType?[indexPath.row]
           // let item = self.workTypeArr?[indexPath.row]
            cell.workTypeLbl.text = item?.name ?? ""
            if sessionDetailsArr.sessionDetails[selectedSession ?? 0].selectedWorkTypeIndex == indexPath.row {
                cell.workTypeLbl.textColor = .green
            }
            else {
                cell.workTypeLbl.textColor = .label
               
                //cell.didSelected = cell.didSelected == true ? false : true
            }
            cell.addTap { [self] in
                if sessionDetailsArr.sessionDetails[selectedSession ?? 0].selectedWorkTypeIndex == indexPath.row {
                    sessionDetailsArr.sessionDetails[selectedSession ?? 0].selectedWorkTypeIndex  = nil
                    self.selectTitleLbl.text = "Select"
                   // item.isSelected = false
                } else {
                    sessionDetailsArr.sessionDetails[selectedSession ?? 0].selectedWorkTypeIndex = indexPath.row
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
            
            let item : AnyObject?
            switch self.cellType {
            
            case .cluster:
                 item = self.clusterArr?[indexPath.row]
            case .headQuater:
                 item = self.headQuatersArr?[indexPath.row]
            case .jointCall:
                item = self.jointWorkArr?[indexPath.row]
            case .listedDoctor:
                item = self.listedDocArr?[indexPath.row]
            case .chemist:
                item = self.chemistArr?[indexPath.row]
                
            default:  return UITableViewCell()
            }
            
          
            cell.lblName?.text = item?.name ?? ""
//            if item.isSelected {
//                cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//            } else {
//                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//            }
            self.clusterArr?.forEach({ cluster in
                if item?.id == cluster.id {
                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                } else {
                    cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                }
            })
     
            cell.addTap {
                self.clusterIDArr?.append(item?.id ?? "")
               
          
               // item.isSelected = item.isSelected == true ? false : true
                var count = 0
//                self.clusterArr.forEach { cluster in
//                    if cluster.isSelected {
//                        count += 1
//
//                    } else {
//
//                    }
//                }
                count = self.clusterIDArr?.count ?? 0
                
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
            
          
            cell.selectionStyle = .none
            return cell

            
        case .FieldWork:
            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
            cell.selectionStyle = .none
            [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.workTypeView].forEach { view in
                view?.isHidden = false
                // cell.workselectionHolder,
            }
            
            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex
            
            if  selectedWorkTypeIndex == 0   {
                cell.stackHeight.constant = 450
                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
            } else if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == nil {
                cell.stackHeight.constant = 450
                cell.lblWorkType.text = "Select"
            } else {
                cell.stackHeight.constant = 80
                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
            }
            
           
            return cell
        case .others:
            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
            cell.selectionStyle = .none
            [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView].forEach { view in
                view?.isHidden = true
                // cell.workselectionHolder,
            }
            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex
            
            if  selectedWorkTypeIndex == 0   {
                cell.stackHeight.constant = 450
                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
            } else if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == nil {
                cell.stackHeight.constant = 450
                cell.lblWorkType.text = "Select"
            } else {
                cell.stackHeight.constant = 80
                cell.lblWorkType.text = sessionDetailsArr.sessionDetails[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
            }
            return cell
        }
        

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellType {
            
        case .session:
           
            if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == 0   {
                return 520
            } else if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == nil {
                return 520
            } else {
                return 120
            }
            //tableView.height / 1.1
        case .workType:
            return tableView.height / 10
        case .cluster, .headQuater, .jointCall, .listedDoctor, .chemist:
            return tableView.height / 10
        case .FieldWork:
           // return 520
            if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == 0   {
                return 520
            } else if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == nil {
                return 520
            } else {
                return 120
            }
        case .others:
           // return 150
            if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == 0   {
                return 520
            } else if sessionDetailsArr.sessionDetails[indexPath.row].selectedWorkTypeIndex == nil {
                return 520
            } else {
                return 140
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuTCell else {return}
        cell.holderView.backgroundColor = .gray
        cell.holderView.layer.cornerRadius = 15
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuTCell else {return}
        cell.holderView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        cell.holderView.layer.cornerRadius = 15
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


class ClusterModal {
    let name: String
    let id: Int
    var isSelected: Bool
    
    init(name: String, id: Int, isSelected: Bool) {
        self.name = name
        self.id = id
        self.isSelected = isSelected
        
    }
    
}

class WorkTypeModal {
    let name: String
    let id: Int
    var isSelected: Bool
    
    init(name: String, id: Int, isSelected: Bool) {
        self.name = name
        self.id = id
        self.isSelected = isSelected
        
    }
    
}



struct TPDatas: Codable {
    let worktypeName: String
    let worktypeCode: String
    let clusterName: String
    let clusterCode: String
    let dayRmk: String
}

struct SaveTP: Codable {
    let tableName: String
    let TPDatas: TPDatas
    let dayno: String
    let TPDt: String
    let TPMonth: String
    let TPYear: String
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
                sessionDetailsArr.sessionDetails[self.selectedSession ?? 0].workType?.forEach({ workType in
                    if workType.name!.lowercased().contains(newText) {
                        filteredWorkType.append(workType)
                        isMatched = true
                    }
                })
                if isMatched {
                    self.sessionDetailsArr.sessionDetails[self.selectedSession ?? 0].workType = filteredWorkType
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.sessionDetailsArr.sessionDetails[self.selectedSession ?? 0].workType = self.workTypeArr
                    self.menuTable.reloadData()
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
            case .FieldWork:
                break
            default:
                break
            }
            // You can update your UI or perform other actions based on the filteredArray
        }

        return true
    }
}


