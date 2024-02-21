//
//  SpecifiedMenuView.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 08/02/24.
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
                    noresultsLbl.text = ""
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                    listedDocArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    noresultsLbl.text = ""
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    noresultsLbl.text = "No results found"
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
                    noresultsLbl.text = "No results found"
                    isSearched = false
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else if isMatched {
                 unlisteedDocArr = filteredWorkType
                    isSearched = true
                    self.noresultsView.isHidden = true
                    noresultsLbl.text = ""
                    self.menuTable.isHidden = false
                    self.menuTable.reloadData()
                } else {
                    print("Not matched")
                    self.noresultsView.isHidden = false
                    noresultsLbl.text = "No results found"
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
            return self.workTypeArr?.count ?? 0
        case .cluster:
            return self.clusterArr?.count ?? 0
        case .headQuater:
            return self.headQuatersArr?.count ?? 0
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
        let cell: SpecifiedMenuTCell = tableView.dequeueReusableCell(withIdentifier: "SpecifiedMenuTCell", for: indexPath) as!  SpecifiedMenuTCell
        cell.selectionStyle = .none
        switch cellType {
    
        case .workType:
            titleLbl.text = "Select Worktype"
            let model =  self.workTypeArr?[indexPath.row]
            cell.lblName.text = model?.name
            cell.lblName.textColor = .appTextColor
            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
            
         //   cell.setupUI(model: model ?? DoctorFencing(), isForspecialty: self.previewType != nil)
            
            if self.selectedObject != nil {
               let doctorObj = self.selectedObject as! WorkType
                if doctorObj.id == model?.id {
                   // cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                    cell.lblName.textColor = .appGreen
                }
            } else {
                if self.isSearched {
                    if self.selectedSpecifiedTypeID ==  model?.code {
                      //  cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                        cell.lblName.textColor = .appGreen
                    } else {
                      //  cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                        cell.lblName.textColor = .appTextColor
                    }
                } else {
                    if indexPath.row == self.selectecIndex {
                       // cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                        cell.lblName.textColor = .appGreen
                    } else {
                       // cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                        cell.lblName.textColor = .appTextColor
                    }
                }
            }
            

            
   
            
            cell.addTap { [weak self] in
                guard let welf = self else {return}
                welf.selectedObject = model
                welf.specifiedMenuVC.selectedObject = model
                if welf.isSearched {
                    welf.selectedSpecifiedTypeID = model?.code ?? ""
               
                } else {
                    welf.selectecIndex = indexPath.row
                  
                }
               
              
              //  welf.specifiedMenuVC.menuDelegate?.selectedType(welf.cellType, selectedObject: model ?? Territory(), selectedObjects: [NSManagedObject]())
                welf.endEditing(true)
                welf.hideMenuAndDismiss()
            }
        case .cluster:
       
            cell.setCheckBox(isToset: true)
            titleLbl.text = "Select Cluster"
            let model =  self.clusterArr?[indexPath.row]
            cell.lblName.text = model?.name
            cell.lblName.textColor = .appTextColor
            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
            
         //   cell.setupUI(model: model ?? DoctorFencing(), isForspecialty: self.previewType != nil)
            
            
            self.clusterArr?.forEach({ cluster in
                //  dump(cluster.code)
                selectedClusterID.forEach { id, isSelected in
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

            cell.addTap { [weak self] in
                guard let welf = self else {return}
                 var selectedClusterID = welf.selectedClusterID
                
                if let _ = selectedClusterID[model?.code ?? ""] {

                    selectedClusterID[model?.code ?? ""] =
                        !(selectedClusterID[model?.code ?? ""] ?? false)

                    if selectedClusterID[model?.code ?? ""] == false {
                        selectedClusterID.removeValue(forKey: model?.code ?? "")
                    }

                } else {
                    selectedClusterID[model?.code ?? ""] = true
                }
                
                welf.selectedClusterID = selectedClusterID
                tableView.reloadData()
            }
            
            
        case .headQuater:
            print("Yet to omplement")
            
            titleLbl.text = "Select HQ"
            let model =  self.headQuatersArr?[indexPath.row]
            cell.lblName.text = model?.name
            cell.lblName.textColor = .appTextColor
            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
            
         //   cell.setupUI(model: model ?? DoctorFencing(), isForspecialty: self.previewType != nil)
            
            if self.selectedObject != nil {
               let doctorObj = self.selectedObject as! Subordinate
                if doctorObj.id == model?.id {
                   // cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                    cell.lblName.textColor = .appGreen
                }
            } else {
                if self.isSearched {
                    if self.selectedSpecifiedTypeID ==  model?.id {
                      //  cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                        cell.lblName.textColor = .appGreen
                    } else {
                      //  cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                        cell.lblName.textColor = .appTextColor
                    }
                } else {
                    if indexPath.row == self.selectecIndex {
                       // cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                        cell.lblName.textColor = .appGreen
                    } else {
                       // cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                        cell.lblName.textColor = .appTextColor
                    }
                }
            }
            

            
   
            
            cell.addTap { [weak self] in
                guard let welf = self else {return}
                welf.selectedObject = model
                welf.specifiedMenuVC.selectedObject = model
                if welf.isSearched {
                    welf.selectedSpecifiedTypeID = model?.id ?? ""
               
                } else {
                    welf.selectecIndex = indexPath.row
                  
                }

                welf.endEditing(true)
                welf.hideMenuAndDismiss()
            }
            
            
        case .jointCall:
            print("Yet to omplement")
        case .listedDoctor:
            titleLbl.text = "Select Doctor"
            let model =  self.listedDocArr?[indexPath.row]
            cell.lblName.text = model?.name
            cell.lblName.textColor = .appTextColor
            cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
            
            cell.setupUI(model: model ?? DoctorFencing(), isForspecialty: self.previewType != nil)
            
            if self.selectedObject != nil {
               let doctorObj = self.selectedObject as! DoctorFencing
                if doctorObj.code == model?.code {
                   // cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                    cell.lblName.textColor = .appGreen
                }
            } else {
                if self.isSearched {
                    if self.selectedSpecifiedTypeID ==  model?.code {
                      //  cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                        cell.lblName.textColor = .appGreen
                    } else {
                      //  cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                        cell.lblName.textColor = .appTextColor
                    }
                } else {
                    if indexPath.row == self.selectecIndex {
                       // cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
                        cell.lblName.textColor = .appGreen
                    } else {
                       // cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
                        cell.lblName.textColor = .appTextColor
                    }
                }
            }
            

            
   
            
            cell.addTap { [weak self] in
                guard let welf = self else {return}
                welf.selectedObject = model
                welf.specifiedMenuVC.selectedObject = model
                if welf.isSearched {
                    welf.selectedSpecifiedTypeID = model?.code ?? ""
               
                } else {
                    welf.selectecIndex = indexPath.row
                  
                }

              
                welf.specifiedMenuVC.menuDelegate?.selectedType(welf.cellType, selectedObject: model ?? DoctorFencing(), selectedObjects: [NSManagedObject]())
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
    
    @IBOutlet var saveLbl: UILabel!
    
    @IBOutlet var clearLbl: UILabel!
    
    @IBOutlet var clearView: UIView!
    
    @IBOutlet var bottomHolderHeight: NSLayoutConstraint!
    @IBOutlet var bottomContentsView: UIView!
    @IBOutlet weak var sideMenuHolderView : UIView!
    @IBOutlet weak var menuTable : UITableView!
    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var closeTapView: UIView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet var clearTFView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var searchHolderVIew: UIView!
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var noresultsView: UIView!
    
    @IBOutlet var noresultsLbl: UILabel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
    var filteredTerritories: [Territory]?
    var selectecIndex: Int? = nil
    var isSearched: Bool = false
    var selectedObject: NSManagedObject?
    var selectedCode: Int?
    var previewType: String?
    var selectedClusterID = [String: Bool]()
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
        saveLbl.setFont(font: .bold(size: .BODY))
        clearLbl.setFont(font: .bold(size: .BODY))
        saveView.layer.cornerRadius = 5
        saveView.backgroundColor = .appTextColor
        
        
        clearView.layer.cornerRadius = 5
        clearView.layer.borderColor = UIColor.gray.cgColor
        clearView.layer.borderWidth = 1
       
        
        
        menuTable.separatorStyle = .singleLine
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
        clearView.addTap {
            self.specifiedMenuVC.selectedClusterID = nil
            self.selectedClusterID = [String: Bool]()
            self.menuTable.reloadData()
        }
        
        saveView.addTap { [weak self] in
            guard let welf = self else {return}
            welf.filteredTerritories = welf.clusterArr?.filter { territory in
                guard let code = territory.code else {
                    return false
                }
                return welf.selectedClusterID[code] == true
            }
            

            
    
            
            welf.hideMenuAndDismiss()
        }
        
        clearTFView.addTap { [weak self] in
            guard let welf = self else {return}
            welf.selectedObject = nil
            welf.selectecIndex = nil
            welf.searchTF.text = ""
            welf.isSearched = false
            welf.endEditing(true)
            welf.toLOadData()
        }
        
        closeTapView.addTap { [weak self] in
            guard let welf = self else {return}
            welf.filteredTerritories = welf.clusterArr?.filter { territory in
                guard let code = territory.code else {
                    return false
                }
                return welf.selectedClusterID[code] == true
            }
            welf.hideMenuAndDismiss()
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
                
             
                filteredTerritories = clusterArr?.filter { territory in
                    guard let code = territory.code else {
                        return false
                    }
                    return selectedClusterID[code] == true
                }
                

                
                
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
            
                           self.specifiedMenuVC.dismiss(animated: true) { [weak self] in

                               guard let welf = self  else {return}
                               
                               
                               guard let selectedHqentity = NSEntityDescription.entity(forEntityName: "Subordinate", in: welf.context),
                                     let selectedWTentity = NSEntityDescription.entity(forEntityName: "WorkType", in: welf.context),
                                     let selectedClusterentity = NSEntityDescription.entity(forEntityName: "Territory", in: welf.context)
                               else {
                                   fatalError("Entity not found")
                               }
                               
                               
                               let temporaryselectedSubordinateobj = NSManagedObject(entity: selectedHqentity, insertInto: nil)  as! Subordinate
                               let temporaryselectedWTobj = NSManagedObject(entity: selectedWTentity, insertInto: nil)  as! WorkType
                               let temporaryselectedClusterobj = NSManagedObject(entity: selectedClusterentity, insertInto: nil)  as! Territory
                               
                               switch welf.cellType {
                               case .headQuater:
                                   welf.specifiedMenuVC.menuDelegate?.selectedType(welf.cellType, selectedObject: welf.specifiedMenuVC.selectedObject ?? temporaryselectedSubordinateobj, selectedObjects: [temporaryselectedClusterobj])
                               case .cluster:
                                   welf.specifiedMenuVC.menuDelegate?.selectedType(welf.cellType, selectedObject: welf.specifiedMenuVC.selectedObject ?? temporaryselectedSubordinateobj, selectedObjects: welf.filteredTerritories ?? [temporaryselectedClusterobj])
                                   
                               case .workType:
                                   welf.specifiedMenuVC.menuDelegate?.selectedType(welf.cellType, selectedObject: welf.specifiedMenuVC.selectedObject ?? temporaryselectedWTobj, selectedObjects: [temporaryselectedClusterobj])
                               default:
                                   print("Yet to implement")
                               }
                           
                           }
        }
        
        
    }
    
    func toLOadData() {
        menuTable.delegate = self
        menuTable.dataSource = self
        menuTable.reloadData()
    }
    
    func toLoadRequiredData(isfromTF: Bool? = false) {
        var selectedIndex : Int?
        self.selectedClusterID = specifiedMenuVC.selectedClusterID ?? [String: Bool]()
       switch self.cellType {
           
       case .workType:
           bottomHolderHeight.constant = 0
           self.workTypeArr = DBManager.shared.getWorkType()
           if specifiedMenuVC.selectedObject != nil {
               self.selectedObject = specifiedMenuVC.selectedObject as! WorkType
               let docObj =  self.selectedObject as! WorkType
               if !(isfromTF ?? false) {
                   self.searchTF.text = docObj.name
               }
              
               self.listedDocArr?.enumerated().forEach({ index, doctor in
                   if doctor.id  == docObj.id {
                       selectedIndex = index
                   }
               })
              
      
           }
       case .cluster:
           bottomHolderHeight.constant = 60
           self.clusterArr = DBManager.shared.getTerritory()
           if specifiedMenuVC.selectedObject != nil {
               self.selectedObject = specifiedMenuVC.selectedObject as! Territory
               let docObj =  self.selectedObject as! Territory
               if !(isfromTF ?? false) {
                   self.searchTF.text = docObj.name
               }
              
               self.listedDocArr?.enumerated().forEach({ index, doctor in
                   if doctor.id  == docObj.id {
                       selectedIndex = index
                   }
               })
              
      
           }
       case .headQuater:
           bottomHolderHeight.constant = 0
           self.headQuatersArr =  DBManager.shared.getSubordinate()
           if specifiedMenuVC.selectedObject != nil {
               self.selectedObject = specifiedMenuVC.selectedObject as! Subordinate
               let docObj =  self.selectedObject as! Subordinate
               if !(isfromTF ?? false) {
                   self.searchTF.text = docObj.name
               }
              
               self.listedDocArr?.enumerated().forEach({ index, doctor in
                   if doctor.id  == docObj.id {
                       selectedIndex = index
                   }
               })
              
      
           }
        
       case .jointCall:
           bottomHolderHeight.constant = 0
           self.jointWorkArr = DBManager.shared.getJointWork()
       case .listedDoctor:
           if specifiedMenuVC.previewType != nil {
               switch specifiedMenuVC.previewType {
               case .speciality  :
                   print("Yet to implement")
                   self.previewType = specifiedMenuVC.previewType?.rawValue
               
               default:
                   print("Yet to implement")
               }
           }
           self.listedDocArr = DBManager.shared.getDoctor()
           if specifiedMenuVC.selectedObject != nil {
               self.selectedObject = specifiedMenuVC.selectedObject as! DoctorFencing
               let docObj =  self.selectedObject as! DoctorFencing
               if !(isfromTF ?? false) {
                   self.searchTF.text = docObj.name
               }
              
               self.listedDocArr?.enumerated().forEach({ index, doctor in
                   if doctor.code  == docObj.code {
                       selectedIndex = index
                   }
               })
              
      
           }
       case .chemist:
           bottomHolderHeight.constant = 0
           self.chemistArr = DBManager.shared.getChemist()
           
       case .stockist:
           self.stockistArr =  DBManager.shared.getStockist()
       case .unlistedDoctor:
           self.unlisteedDocArr = DBManager.shared.getUnListedDoctor()
       default:
           print("Yet to implement")
       }
        toLOadData()
        guard let selectedIndex = selectedIndex else {
            return
        }
        let toScrollIndex: IndexPath = IndexPath(row: selectedIndex, section: 0)
        self.menuTable.scrollToRow(at: toScrollIndex, at: .middle, animated: true)
    }
    
    func cellRegistration() {
        menuTable.register(UINib(nibName: "SpecifiedMenuTCell", bundle: nil), forCellReuseIdentifier: "SpecifiedMenuTCell")
        
    }
    
}


class SpecifiedMenuTCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var holderView: UIView!
    static let identifier = "SpecifiedMenuTCell"
  
    @IBOutlet var lblNameLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var brandMatrisIndicator: UIView!
    
    @IBOutlet var specialityLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblNameLeadingConstraint.constant = 15
        menuIcon.isHidden = true
        menuIcon.isHidden = true
        lblName.textColor = .appTextColor
        lblName.setFont(font: .medium(size: .SMALL))
        brandMatrisIndicator.layer.cornerRadius = brandMatrisIndicator.height / 2
        brandMatrisIndicator.backgroundColor = .appGreen
        brandMatrisIndicator.isHidden = true
        specialityLbl.isHidden = true
    }
    
    
    func setupUI(model: DoctorFencing, isForspecialty: Bool) {
        
        if isForspecialty {
            specialityLbl.isHidden = false
            specialityLbl.setFont(font: .bold(size: .BODY))
            specialityLbl.textColor = .appLightTextColor
            specialityLbl.text = model.speciality
        } else {
            if model.mappProducts == "" {
                brandMatrisIndicator.isHidden = true
            } else {
                brandMatrisIndicator.isHidden = false
            }
        }
        

    }
    
    
   func setCheckBox(isToset: Bool) {
       lblNameLeadingConstraint.constant = 15 + 30
       menuIcon.isHidden = false
    }
    
}
