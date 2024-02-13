//
//  SpecifiedMenuView.swift
//  E-Detailing
//
//  Created by San eforce on 08/02/24.
//

import Foundation
import UIKit
import CoreData

extension SpecifiedMenuView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Handle the text change
        if let text = textField.text as NSString? {
            let newText = text.replacingCharacters(in: range, with: string).lowercased()
            print("New text: \(newText)")

            switch self.cellType {
        
            case .workType:
                if newText.isEmpty {
                    self.toLoadRequiredData()
                    toLOadData()
                }
                var filteredWorkType = [WorkType]()
                filteredWorkType.removeAll()
                var isMatched = false
              workTypeArr?.forEach({ workType in
                    if workType.name!.lowercased().contains(newText) {
                        filteredWorkType.append(workType)
                        isMatched = true
                        
                    }
                })
                
                if newText.isEmpty {
                  //  self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = self.workTypeArr
                    self.noresultsView.isHidden = true
                    //self.selectAllView.isHidden = true
                   // self.selectAllHeightConst.constant = 0
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    self.workTypeArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.menuTable.isHidden = true
                }
                
                
            case .cluster:
                if newText.isEmpty {
                    self.toLoadRequiredData()
                    toLOadData()
                }
                var filteredWorkType = [Territory]()
                filteredWorkType.removeAll()
                var isMatched = false
               clusterArr?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        
                        isMatched = true
                    }
                })
                if newText.isEmpty {

                    self.noresultsView.isHidden = true

                    isSearched = true
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    if isMatched {
                        self.clusterArr = filteredWorkType
                        isSearched = true
                        self.noresultsView.isHidden = true
                        self.menuTable.isHidden = false
                        self.menuTable.reloadData()
                    } else {
                        print("Not matched")
                        self.noresultsView.isHidden = false
                        isSearched = true
                        self.menuTable.isHidden = true
                    }
                }
  
            case .headQuater:
                if newText.isEmpty {
                    self.toLoadRequiredData()
                    toLOadData()
                }
                var filteredWorkType = [Subordinate]()
                filteredWorkType.removeAll()
                var isMatched = false
                self.headQuatersArr?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        
                        isMatched = true
                    }
                })
                
                
                if newText.isEmpty {

                    self.noresultsView.isHidden = true

                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    self.headQuatersArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.menuTable.isHidden = true
                }
            case .jointCall:
                if newText.isEmpty {
                    self.toLoadRequiredData()
                    toLOadData()
                }
                var filteredWorkType = [JointWork]()
                filteredWorkType.removeAll()
                var isMatched = false
              jointWorkArr?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        
                        isMatched = true
                    }
                })
                
                if newText.isEmpty {
             
                    self.noresultsView.isHidden = true

                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    jointWorkArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true

                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false

                    self.menuTable.isHidden = true
                }

            case .listedDoctor:
                if newText.isEmpty {
                    self.toLoadRequiredData(isfromTF: true)
                    toLOadData()
                }
                var filteredWorkType = [DoctorFencing]()
                filteredWorkType.removeAll()
                var isMatched = false
            listedDocArr?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        
                        isMatched = true
                    }
                })
                
                if newText.isEmpty {
        
                    self.noresultsView.isHidden = true
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    listedDocArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.menuTable.isHidden = true
                }
                

            case .chemist:
                if newText.isEmpty {
                    self.toLoadRequiredData()
                    toLOadData()
                }
                var filteredWorkType = [Chemist]()
                filteredWorkType.removeAll()
                var isMatched = false
              chemistArr?.forEach({ cluster in
                    if cluster.name!.lowercased().contains(newText) {
                        filteredWorkType.append(cluster)
                        isMatched = true
                    }
                })

                
                if newText.isEmpty {
                
                    self.noresultsView.isHidden = true

                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    chemistArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.menuTable.isHidden = true
                }
                
            case .stockist:
                if newText.isEmpty {
                    self.toLoadRequiredData()
                }
                var filteredWorkType = [Stockist]()
                filteredWorkType.removeAll()
                var isMatched = false
  stockistArr?.forEach({ stockist in
                    if stockist.name!.lowercased().contains(newText) {
                        filteredWorkType.append(stockist)
                        isMatched = true
                    }
                })

                
                if newText.isEmpty {

                    self.noresultsView.isHidden = true
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                   stockistArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.menuTable.isHidden = true
                }
                
                
            case .unlistedDoctor:
                if newText.isEmpty {
                    self.toLoadRequiredData()
                    toLOadData()
                }
                var filteredWorkType = [UnListedDoctor]()
                filteredWorkType.removeAll()
                var isMatched = false
 unlisteedDocArr?.forEach({ newDocs in
                    if newDocs.name!.lowercased().contains(newText) {
                        filteredWorkType.append(newDocs)
                        isMatched = true
                    }
                })

                
                if newText.isEmpty {

                    self.noresultsView.isHidden = true

                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                 unlisteedDocArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    isSearched = false
                    self.menuTable.isHidden = true
                }
            default:
                print("Yet to implement")
            }
            // You can update your UI or perform other actions based on the filteredArray
        }

        return true
    }
}
 
extension SpecifiedMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellType {
    
        case .workType:
            print("Yet to omplement")
        case .cluster:
            print("Yet to omplement")
        case .headQuater:
            print("Yet to omplement")
        case .jointCall:
            print("Yet to omplement")
        case .listedDoctor:
           return self.listedDocArr?.count ?? 0
        case .chemist:
            print("Yet to omplement")
        case .stockist:
            print("Yet to omplement")
        case .unlistedDoctor:
            print("Yet to omplement")
      
        default:
            print("Yet to implement")
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTCell = tableView.dequeueReusableCell(withIdentifier: "MenuTCell", for: indexPath) as!  MenuTCell
        cell.selectionStyle = .none
        switch cellType {
    
        case .workType:
            titleLbl.text = "Select Worktype"
            print("Yet to omplement")
        case .cluster:
            print("Yet to omplement")
        case .headQuater:
            print("Yet to omplement")
        case .jointCall:
            print("Yet to omplement")
        case .listedDoctor:
            titleLbl.text = "Select Doctor"
            let model =  self.listedDocArr?[indexPath.row]
            cell.lblName.text = model?.name
            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
            
            if self.selectedObject != nil {
               let doctorObj = self.selectedObject as! DoctorFencing
                if doctorObj.code == model?.code {
                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                }
            } else {
                if self.isSearched {
                    if self.selectedSpecifiedTypeID ==  model?.code {
                        cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                    } else {
                        cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                    }
                } else {
                    if indexPath.row == self.selectecIndex {
                        cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                    } else {
                        cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                    }
                }
            }
            

            
   
            
            cell.addTap { [weak self] in
                guard let welf = self else {return}
                welf.selectedObject = nil
                welf.specifiedMenuVC.selectedObject = nil
                if welf.isSearched {
                    welf.selectedSpecifiedTypeID = model?.code ?? ""
               
                } else {
                    welf.selectecIndex = indexPath.row
                  
                }
               
              
                welf.specifiedMenuVC.menuDelegate?.selectedType(welf.cellType, selectedObject: model ?? DoctorFencing())
                welf.endEditing(true)
                welf.hideMenuAndDismiss()
            }
        case .chemist:
            print("Yet to omplement")
        case .stockist:
            print("Yet to omplement")
        case .unlistedDoctor:
            print("Yet to omplement")
      
        default:
            print("Yet to implement")
        }
        return cell
    }
    
    
}

class SpecifiedMenuView: BaseView {
    
    
    @IBOutlet weak var sideMenuHolderView : UIView!
    @IBOutlet weak var menuTable : UITableView!
    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var closeTapView: UIView!
    @IBOutlet weak var saveView: UIView!
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var searchHolderVIew: UIView!
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var noresultsView: UIView!
    var selectedSpecifiedTypeID : String = ""
    var cellType : MenuView.CellType = .listedDoctor
    var specifiedMenuVC :  SpecifiedMenuVC!
    var workTypeArr : [WorkType]?
    var headQuatersArr : [Subordinate]?
    var clusterArr : [Territory]?
    var jointWorkArr : [JointWork]?
    var listedDocArr : [DoctorFencing]?
    var chemistArr : [Chemist]?
    var stockistArr : [Stockist]?
    var unlisteedDocArr : [UnListedDoctor]?
    var selectecIndex: Int? = nil
    var isSearched: Bool = false
    var selectedObject: NSManagedObject?
    var selectedCode: Int?
    //MARK: UDF, gestures  and animations
    
    private var animationDuration : Double = 1.0
    private let aniamteionWaitTime : TimeInterval = 0.15
    private let animationVelocity : CGFloat = 5.0
    private let animationDampning : CGFloat = 2.0
    private let viewOpacity : CGFloat = 0.3
    
//    enum CellType {
//
//        case workType
//        case cluster
//        case headQuater
//        case jointCall
//        case listedDoctor
//        case chemist
//        case stockist
//        case unlistedDoctor
//
//    }
    
    //MARK: - life cycle
    override func didLoad(baseVC: BaseViewController) {
        self.specifiedMenuVC = baseVC as? SpecifiedMenuVC
        //self.initView()
        //self.initGestures()
       // self.ThemeUpdate()
       // setTheme()
        self.cellType = specifiedMenuVC.celltype
        self.showMenu()
        initGestures()
        setupUI()
        //cellRegistration()
        toLoadRequiredData()
    }
    
    func setupUI() {
      //  searchTF.textColor = .appTextColor
     //   titleSeperator.backgroundColor = .appSelectionColor
        self.titleLbl.setFont(font: .bold(size:  .BODY))
        self.titleLbl.textColor = .appTextColor
        searchTF.delegate = self
        searchTF.font = UIFont(name: "Satoshi-Bold", size: 14)
        self.searchTF.text = ""
        self.searchTF.placeholder = "Search"
        searchHolderVIew.layer.borderWidth = 1
        searchHolderVIew.layer.borderColor = UIColor.appLightTextColor.cgColor
        searchHolderVIew.layer.cornerRadius = 5
    }
    
    func initGestures() {
        
        closeTapView.addTap {
            self.hideMenuAndDismiss()
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleMenuPan(_:)))
        self.sideMenuHolderView.addGestureRecognizer(panGesture)
        self.sideMenuHolderView.isUserInteractionEnabled = true
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
    
    func hideMenuAndDismiss(type: MenuView.CellType? = nil , index: Int? = nil){
       
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
            
                           self.specifiedMenuVC.dismiss(animated: true, completion: nil) 
        }
        
        
    }
    
    func toLOadData() {
        menuTable.delegate = self
        menuTable.dataSource = self
        menuTable.reloadData()
    }
    
    func toLoadRequiredData(isfromTF: Bool? = false) {
       switch self.cellType {
           
       case .workType:
           self.workTypeArr = DBManager.shared.getWorkType()
       case .cluster:
           self.clusterArr = DBManager.shared.getTerritory()
       case .headQuater:
           self.headQuatersArr =  DBManager.shared.getSubordinate()
       case .jointCall:
           self.jointWorkArr = DBManager.shared.getJointWork()
       case .listedDoctor:
           self.listedDocArr = DBManager.shared.getDoctor()
           if specifiedMenuVC.selectedObject != nil {
               self.selectedObject = specifiedMenuVC.selectedObject as! DoctorFencing
               let docObj =  self.selectedObject as! DoctorFencing
               if !(isfromTF ?? false) {
                   self.searchTF.text = docObj.name
               }
             
           }
       case .chemist:
           self.chemistArr = DBManager.shared.getChemist()
       case .stockist:
           self.stockistArr =  DBManager.shared.getStockist()
       case .unlistedDoctor:
           self.unlisteedDocArr = DBManager.shared.getUnListedDoctor()
       default:
           print("Yet to implement")
       }
       toLOadData()
    }
    
    func cellRegistration() {
        menuTable.register(UINib(nibName: "MenuTCell", bundle: nil), forCellReuseIdentifier: "MenuTCell")
        
    }
    
}
