//
//  DayReportView.swift
//  E-Detailing
//
//  Created by San eforce on 22/12/23.
//

import Foundation
import UIKit


extension DayReportView: VisitsCountTVCDelegate {
    func typeChanged(index: Int, type: CellType) {
        
        self.viewDayReportVC.toSetParamsAndGetResponse(index)
        self.selectedType = type
    }
    
    
}

extension DayReportView : ViewAllInfoTVCDelegate {

    
    func didLessTapped(islessTapped: Bool, isrcpaTapped: Bool,  index: Int) {
        self.selectedIndex = index
        let model = self.detailedReportsModelArr?[index]
        
        if islessTapped {
            model?.isCellExtended = false
            model?.isRCPAExtended = false
        } else {
            model?.isCellExtended = !islessTapped
            model?.isRCPAExtended = isrcpaTapped
        }
        
    
        self.toLoadData()
        let indexpath = IndexPath(row: index, section: 2)
        aDayReportsTable.scrollToRow(at: indexpath, at: .top, animated: true)
        
//        if islessTapped && !isrcpaTapped {
//            self.isForViewmore = false
//            self.toLoadData()
//        } else if !islessTapped && isrcpaTapped{
//            self.isForViewmore = true
//            self.isForRCPA = isrcpaTapped
//            self.toLoadData()
//        } else {
//            self.isForViewmore = true
//            self.isForRCPA = isrcpaTapped
//            self.toLoadData()
//        }
        

    }
    
    
    
    
}

extension DayReportView: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
           
            if self.reportsModel?.halfDayFWType != "" {
                return 2
            } else {
                return 1
            }
        case 1:
            if self.isTohideCount {
                return 0
            } else {
                return 1
            }
           
        case 2:
            return    self.detailedReportsModelArr?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
//            let cell: WTsheetTVC = tableView.dequeueReusableCell(withIdentifier: "WTsheetTVC", for: indexPath) as! WTsheetTVC
//            return cell
                        let cell: ListedWorkTypesTVC = tableView.dequeueReusableCell(withIdentifier: "ListedWorkTypesTVC", for: indexPath) as! ListedWorkTypesTVC
            cell.wtModel = self.reportsModel
            cell.toloadData()
            cell.selectionStyle = .none
                        return cell
            
            
        case 1:
            let cell: VisitsCountTVC = tableView.dequeueReusableCell(withIdentifier: "VisitsCountTVC", for: indexPath) as! VisitsCountTVC
            cell.delegate = self
            cell.wtModel = self.reportsModel
            cell.topopulateCell(model: self.reportsModel ?? ReportsModel())
            cell.selectionStyle = .none
            return cell
        case 2:
            let model =    self.detailedReportsModelArr?[indexPath.row]
         
            if model?.isCellExtended == false  {
                let cell: VisitInfoTVC = tableView.dequeueReusableCell(withIdentifier: "VisitInfoTVC", for: indexPath) as! VisitInfoTVC
                cell.selectionStyle = .none
                cell.elevationView.elevate(5)
                cell.elevationView.layer.cornerRadius = 5
                
                cell.userTypeIV.image = self.selectedType.image
                cell.toPopulateCell(model: model ?? DetailedReportsModel())
                
                cell.viewMoreDesc.addTap {
                    print("Tapped")
                    model?.isCellExtended = true
                    self.selectedIndex = indexPath.row
                   // self.isForViewmore = true
                    self.toLoadData()
                }
                return cell
            } else {
                let cell: ViewAllInfoTVC = tableView.dequeueReusableCell(withIdentifier: "ViewAllInfoTVC", for: indexPath) as! ViewAllInfoTVC
                cell.selectedIndex = self.selectedIndex
                cell.delegate = self
                cell.typeImage = self.selectedType.image
               //let model = self.detailedReportsModelArr?[indexPath.row]
                cell.detailedReportModel = model
                cell.cellType = model?.isRCPAExtended ?? false ? .showRCPA : .hideRCPA
                cell.reportModel = self.reportsModel
                cell.toSetDataSourceForProducts()
                cell.hideLocationSection()
                cell.toLoadData()
                cell.selectionStyle = .none
                return cell
            }

            

            
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if self.reportsModel?.halfDayFWType != "" {
                return 200 / 2
            } else {
                return 200 / 3
            }
        case 1:
           
            return tableView.height / 9
        default:
            let model =    self.detailedReportsModelArr?[indexPath.row]
            
            if model?.isCellExtended == false {
               return  240
            }
            else if  model?.isCellExtended == true &&  model?.isRCPAExtended == false  {
               //25 elevation padding, 60 header height (product)
                
                
               // (170 - visit info, 100 - Time info, product title header - 60, products cell - 30 Each, RCPA Cell - 60, Remarks - 75, show options - 50)
                
                var timeinfoHeight = CGFloat()
                 if self.viewDayReportVC.isToReduceLocationHeight {
                     timeinfoHeight = 0
                 } else {
                     timeinfoHeight = 100
                 }
                
                
               let productCellHeight = toCalculateProductsHeight(index: indexPath.row)
                return 170 + timeinfoHeight + 60 + 60 + 75 + 50 + productCellHeight + 25
                //595 + 10 + 60
            } else if model?.isRCPAExtended == true  && model?.isCellExtended == true {
                // 50 - elevation padding
                // (170 - visit info, 100 - Time info, product title header - 60, products cell - 30 Each, RCPA - 60, Remarks - 75, show options - 50 )
               var timeinfoHeight = CGFloat()
                if self.viewDayReportVC.isToReduceLocationHeight {
                    timeinfoHeight = 0
                } else {
                    timeinfoHeight = 100
                }
                let productCellHeight = toCalculateProductsHeight(index: indexPath.row)
                 return 170 + timeinfoHeight + 60 + 60 + 75 + 50 + productCellHeight + 100 + 50
                
                
               // return 595 + 100 + 10 + 60
            } else {
                return CGFloat()
            }
            
        }
    }
    
    func toCalculateProductsHeight(index : Int) -> CGFloat {
        var productStrArr : [String] = []
        productStrArr.removeAll()
        productStrArr.append("This is Title String")
        productStrArr.append(contentsOf: self.detailedReportsModelArr?[index].products.components(separatedBy: ",") ?? [])
        if productStrArr.last ==  "  )" {
            productStrArr.removeLast()
        }
        
        return CGFloat(productStrArr.count * 30)
        
      
    }
    
}

class DayReportView: BaseView {
    
//    func toSetDataSourceForProducts() {
//        productStrArr.removeAll()
//        productStrArr.append("This is Title String")
//        productStrArr.append(contentsOf: detailedReportModel?.products.components(separatedBy: ",") ?? [])
//        if productStrArr.last ==  "  )" {
//            productStrArr.removeLast()
//        }
//
//
//    }
    
    var viewDayReportVC : ViewDayReportVC!
    
    @IBOutlet weak var topNavigationView: UIView!
    @IBOutlet weak var pageTitleLbl: UILabel!
    @IBOutlet weak var backHolderView: UIView!
    @IBOutlet weak var filtersHolderView: UIView!
    @IBOutlet weak var searchHolderVIew: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var ussrNameLbl: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var rejectedSeperatorView: UIView!
    @IBOutlet weak var rejectedView: UIView!
    @IBOutlet weak var rejectedViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rejectedTitLbl: UILabel!
    @IBOutlet weak var rejectedReasonLbl: UILabel!
    @IBOutlet weak var aDayReportsTable: UITableView!
    var selectedType: CellType = .All
    @IBOutlet var tableHeader: UIView!
    @IBOutlet var tableContentsHolder: UIView!
    @IBOutlet var sortView: UIView!
    var isForViewmore = false
    var isForRCPA = false
    var rejectedHeight: CGFloat =  70
    var detailedReportsModelArr : [DetailedReportsModel]?
    var selectedIndex: Int? = nil
    var reportsModel : ReportsModel?
    var isTohideCount : Bool = false
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.viewDayReportVC = baseVC as? ViewDayReportVC
        self.viewDayReportVC.appdefaultSetup = AppDefaults.shared.getAppSetUp()
        self.viewDayReportVC.toSetParamsAndGetResponse(0)
        setupUI()
    }
    
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.viewDayReportVC = baseVC as? ViewDayReportVC
        
       
       
   
    }
    
    func initialSerups() {
        cellregistration()
        toLoadData()
    }
    
    func setupUI() {
        self.aDayReportsTable.tableHeaderView = tableHeader
        seperatorView.backgroundColor = .appSelectionColor
        ussrNameLbl.setFont(font: .bold(size: .SUBHEADER))
        ussrNameLbl.textColor = .appLightPink
        self.ussrNameLbl.text = "\(viewDayReportVC.appdefaultSetup!.sfName!) - \(viewDayReportVC.appdefaultSetup!.desig!) - designation"
        initTaps()
        mockData()
        sortView.layer.cornerRadius = 5
        tableContentsHolder.layer.cornerRadius = 5
        tableContentsHolder.backgroundColor = .appWhiteColor
        searchHolderVIew.backgroundColor = .appWhiteColor
        searchHolderVIew.layer.cornerRadius = 5
        self.backgroundColor = .appGreyColor
        aDayReportsTable.separatorStyle = .none
    }
    
    func initTaps() {
        backHolderView.addTap {
            self.viewDayReportVC.navigationController?.popViewController(animated: true)
        }
    }
    
    func cellregistration() {
        aDayReportsTable.register(UINib(nibName: "VisitsCountTVC", bundle:nil), forCellReuseIdentifier: "VisitsCountTVC")
        aDayReportsTable.register(UINib(nibName: "VisitInfoTVC", bundle:nil), forCellReuseIdentifier: "VisitInfoTVC")
      //  aDayReportsTable.register(UINib(nibName: "WTsheetTVC", bundle:nil), forCellReuseIdentifier: "WTsheetTVC")
        
        aDayReportsTable.register(UINib(nibName: "ListedWorkTypesTVC", bundle:nil), forCellReuseIdentifier: "ListedWorkTypesTVC")
        
        aDayReportsTable.register(UINib(nibName: "ViewAllInfoTVC", bundle:nil), forCellReuseIdentifier: "ViewAllInfoTVC")
    }
    
    func toLoadData() {
      
        aDayReportsTable.delegate = self
        aDayReportsTable.dataSource = self
        aDayReportsTable.reloadData()
    }
    
    func mockData() {
//        let count = 2
//        var detailedModelArr = [DetailedReportsModel]()
//        for _ in 0...count - 1 {
//            let anElement = DetailedReportsModel()
//            detailedModelArr.append(anElement)
//        }
        
       // self.detailedReportsModelArr = viewDayReportVC.d
        
        self.rejectedView.isHidden = true
        self.rejectedView.frame.size.height = 0
        self.aDayReportsTable.tableHeaderView?.frame.size.height = 50
        self.reportsModel = viewDayReportVC.reportsModel
       
        var  count : Int = 0
        count =  self.reportsModel!.chm +  self.reportsModel!.hos + self.reportsModel!.stk + self.reportsModel!.drs + self.reportsModel!.udr + self.reportsModel!.cip
        if count == 0 {
            isTohideCount = true
        }
        
    }
    
    
}
