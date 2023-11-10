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
    var cellType : CellType = .session
    var workType = [WorkTypeModal]()
    var cluster = [ClusterModal]()
    var sessionCount = 1
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.showMenu()
    }
    //MARK:- initializers
    func initView(){
       // closeBtn.isHidden = true
      //  closeBtn.setTitle("", for: .normal)
        cellRegistration()
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
        
        
//        [selectView,addSessionView,clearview,saveView].forEach { view in
//            view?.layer.borderColor =  view == addSessionView ? UIColor.systemGreen.cgColor : UIColor.gray.cgColor
//            view.layer.borderWidth = view == selectView || clearview  || addSessionView ? 0 : 1.5
//            view.layer.cornerRadius = 5
//            view.elevate(1)
//        }
        
        
        
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
        
        
     //   tableHolderView.elevate(2)
     //   tableHolderView.layer.cornerRadius = 5
        self.menuTable.layoutIfNeeded()
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: Notification.Name("hideMenu"), object: nil)
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
    
    func setPageType(_ pagetype: CellType) {
        switch pagetype {
        case .session:
            self.cellType = .session
            addSessionView.isHidden = false
            saveView.isHidden = true
            clearview.isHidden = true
            self.selectViewHeightCons.constant = 0
            self.selectView.isHidden = true
            self.menuTable.reloadData()
        case .workType:
            self.cellType = .workType
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.selectViewHeightCons.constant = 50
            self.selectView.isHidden = false
            self.countView.isHidden = true
            self.selectView.isHidden = false
            self.menuTable.reloadData()
        case .cluster:
            self.cellType = .cluster
            addSessionView.isHidden = true
            saveView.isHidden = false
            clearview.isHidden = false
            self.countView.isHidden = false
            self.selectViewHeightCons.constant = 50
            self.selectView.isHidden = false
            self.selectView.isHidden = false
            self.menuTable.reloadData()
        }
    }
    
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        
        hideMenuAndDismiss()
    }
    

    
    func initGestures(){
        self.sideMenuHolderView.addAction(for: .tap) {
            self.hideMenuAndDismiss()
        }

        saveView.addTap {
            switch self.cellType {
                
            case .session:
                break
            case .workType:
                self.setPageType(.cluster)
                
                
               
            case .cluster:
              //  self.multiSelectionAPI()
                break
            }
            
       
            
           
        }
        
        selectView.addTap {
            
            self.setPageType(.session)
        }
        
        addSessionView.addTap {
            self.sessionCount += 1
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
            return sessionCount
        case .workType:
            return 3
        case .cluster:
            return 3
        }
       
        //self.menuVC.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType {
            
        case .session:
            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
            cell.selectionStyle = .none
            cell.clusterView.addTap {
                self.cellType = .cluster
                self.setPageType(.cluster)
             
              //  tableView.reloadData()
            }
            cell.workTypeView.addTap {
                self.cellType = .workType
                self.setPageType(.workType)
             
               // tableView.reloadData()
            }
            
                cell.deleteIcon.isHidden = false
            
            
            cell.deleteIcon.addTap {
                self.sessionCount -= 1
                tableView.reloadData()
               // self.didLayoutSubviews(baseVC: self.menuVC)
            }
            
            return cell
        case .workType:
            let cell = tableView.dequeueReusableCell(withIdentifier:"WorkTypeCell" ) as! WorkTypeCell
            let item = self.workType[indexPath.row]
            cell.workTypeLbl.text = item.name
            if self.selectedWorkTyprIndex == indexPath.row {
                cell.workTypeLbl.textColor = .green
              
                
            }
            else {
                cell.workTypeLbl.textColor = .label
               
                //cell.didSelected = cell.didSelected == true ? false : true
            }
            cell.addTap {
                if self.selectedWorkTyprIndex == indexPath.row {
                    self.selectedWorkTyprIndex = nil
                    self.selectTitleLbl.text = "Select"
                    item.isSelected = false
                } else {
                    self.selectedWorkTyprIndex = indexPath.row
                    self.selectTitleLbl.text = "Selected"
                    item.isSelected = true
                }
                
                tableView.reloadData()
            }
            
          
            cell.selectionStyle = .none
            return cell


        case .cluster:
            let cell = tableView.dequeueReusableCell(withIdentifier:MenuTCell.identifier ) as! MenuTCell
            let item = self.cluster[indexPath.row]
            cell.lblName?.text = item.name
            if item.isSelected {
                cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
            } else {
                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
            }
            
     
            cell.addTap {
                
                   
                item.isSelected = item.isSelected == true ? false : true
                var count = 0
                self.cluster.forEach { cluster in
                    if cluster.isSelected {
                        count += 1
                   
                    } else {
                       
                    }
                }
                
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
        }
        

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellType {
            
        case .session:
            return tableView.height / 1.1
        case .workType:
            return tableView.height / 10
        case .cluster:
            return tableView.height / 10
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
    
    
    
    
    func toSendBodyData<T: Codable>(dataType: T.Type)  {
        // Convert JSON string to Data
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // Decode JSON to Swift struct
                let saveTP = try JSONDecoder().decode([String: T].self, from: jsonData)
                
                // Encode Swift struct back to JSON Data
                if let encodedData = try? JSONEncoder().encode(saveTP) {
                    if let jsonString = String(data: encodedData, encoding: .utf8) {
                        print(jsonString)
                       
                        // Use this jsonString as parameters in the POST request
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    func singleSelectionAPI(completion: @escaping  (Bool) -> ()) {
        // Specify the URL for the POST request
        let url = URL(string: "http://sanffa.info/api/api_pharma?&divisionCode=22%2C&rSF=MR4822&axn=table%2Flist&orderBy=&sfCode=MR4822")!

        // Create the POST request body
        let requestBody: [String: Any] = [
            "tableName": "mas_worktype",
            "coloumns": ["type_code as id", "Wtype as name", "Hlfdy_flag as Hlfdy_flag"],
            "today": "",
            "where": "[\"isnull(Active_flag,0)=0\"]",
            "or": "",
            "wt": "",
            "sfCode": "MR4822",
            "orderBy": "",
            "divisionCode": "22"
        ]

        // Convert the dictionary to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            // Create a URLSession data task
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    completion(false)
                    return
                }

                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                    completion(true)
                    // Handle and parse the response data as needed
                }
            }

            // Execute the task
            task.resume()

        } catch {
            print("Error creating JSON data: \(error)")
        }
    }
    
    
    func multiSelectionAPI() {

        // Specify the URL for the POST request
        let url = URL(string: "http://sanffa.info/api/api_pharma?&divisionCode=22%2C&rSF=MR4822&axn=table%2Flist&orderBy=%5B%22name%20asc%22%5D&sfCode=MR4822")!

        // Create the POST request body
        let requestBody: [String: Any] = [
            "tableName": "vwTown_Master_APP",
            "coloumns": ["town_code as id", "town_name as name", "Tcodes", "Ter_lat", "Ter_long", "Territory_radious", "Territory_Visit", "Territory_Cat"],
            "today": "",
            "where": ["isnull(Town_Activation_Flag,0)=0"],
            "or": "",
            "wt": "",
            "orderBy": ["name asc"],
            "divisionCode": "22"
        ]

        // Convert the dictionary to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            // Create a URLSession data task
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                    // Handle and parse the response data as needed
                }
            }

            // Execute the task
            task.resume()

        } catch {
            print("Error creating JSON data: \(error)")
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


