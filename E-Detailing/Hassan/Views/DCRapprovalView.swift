//
//  DCRapprovalView.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import Foundation
import UIKit

extension DCRapprovalView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case approvalTable :
            return 10
        default:
            return 3
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
        case approvalTable :
            return tableView.height / 11
        default:
            switch indexPath.row {
                
            case 0:
                //top - 10 || MR name - 60 ||Date info - 60 || work type info 2 *  90 (Max) || bottom 15
                return 290 + 15
            case 1:
                return 60
            case 2:
                return 70 * 4
            default:
                return 0
                
            }
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case approvalTable :
            let cell: DCRApprovalsTVC = approvalTable.dequeueReusableCell(withIdentifier: "DCRApprovalsTVC", for: indexPath) as! DCRApprovalsTVC
            cell.selectionStyle = .none
            cell.approcalDateLbl.textColor = .appTextColor
            cell.mrNameLbl.textColor = .appTextColor
            cell.contentHolderView.backgroundColor = .appWhiteColor
            cell.contentHolderView.layer.cornerRadius = 5
            cell.accessoryIV.image = UIImage(named: "chevlon.right")
            cell.accessoryIV.tintColor = .appTextColor
            cell.dateHolderView.layer.cornerRadius = 5
            cell.dateHolderView.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
            
            if selectedBrandsIndex == indexPath.row {
                cell.contentHolderView.backgroundColor = .appTextColor
                cell.dateHolderView.backgroundColor = .appWhiteColor
                cell.mrNameLbl.textColor = .appWhiteColor
                cell.accessoryIV.tintColor = .appWhiteColor
            }
            
            cell.addTap {[weak self] in
                guard let welf = self else {return}
                welf.selectedBrandsIndex = indexPath.row
                welf.approvalTable.reloadData()
              //  welf.approvalCollection.reloadData()
                welf.loadApprovalDetailTable()
            }
            
     return cell
        default:
            switch indexPath.row {
            case 0:
                let cell: DCRApprovalsWorkTypeTVC = approvalDetailsTable.dequeueReusableCell(withIdentifier: "DCRApprovalsWorkTypeTVC") as! DCRApprovalsWorkTypeTVC
                cell.selectionStyle = .none
                cell.toloadData()
                return cell
                
            case 1:
                let cell: VisitsCountTVC = tableView.dequeueReusableCell(withIdentifier: "VisitsCountTVC", for: indexPath) as! VisitsCountTVC
                cell.delegate = self
                cell.toloadData()
           //     cell.wtModel = self.reportsModel
                cell.topopulateCell(model: ReportsModel())
                cell.selectionStyle = .none
                return cell
            case 2:
                
                let cell: DCRAllApprovalsTVC = tableView.dequeueReusableCell(withIdentifier: "DCRAllApprovalsTVC", for: indexPath) as! DCRAllApprovalsTVC
                cell.rootController = self.dcrApprovalVC
              //  cell.populateDCRArroval()
             //   cell.delegate = self
             //   cell.toloadData()
           //     cell.wtModel = self.reportsModel
            //    cell.topopulateCell(model: ReportsModel())
                cell.selectionStyle = .none
                return cell
                
                
            default:
                return UITableViewCell()
            }
          
        }
        

    }
    
    
}

class DCRapprovalView : BaseView {
    
    
    @IBOutlet var approvalTitle: UILabel!
    
    @IBOutlet weak var topNavigationView: UIView!
    
    
    @IBOutlet weak var collectionHolderView: UIView!
    
    @IBOutlet weak var backHolderView: UIView!
    
    
    @IBOutlet weak var approvalDetailsTable: UITableView!
    
    
    @IBOutlet weak var approvalTable: UITableView!
    
    
    @IBOutlet var searchHolderView: UIView!
    
    @IBOutlet var rejectView: UIView!
    
    @IBOutlet var approveView: UIView!
    
    
    
    var dcrApprovalVC : DCRapprovalVC!
    var selectedBrandsIndex: Int = 0
    var selectedType: CellType = .Doctor
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.dcrApprovalVC = baseVC as? DCRapprovalVC
        initTaps()
        setupUI()
        cellregistration()
        loadApprovalTable()
      
    }
    
    func setupUI() {
        self.backgroundColor = .appSelectionColor
        collectionHolderView.layer.cornerRadius = 5
        searchHolderView.layer.cornerRadius = 5
        rejectView.layer.cornerRadius = 5
        approveView.layer.cornerRadius = 5
        rejectView.backgroundColor = .appLightPink
        approveView.backgroundColor = .appGreen
    }
    
    func loadApprovalTable() {
        approvalTable.delegate = self
        approvalTable.dataSource = self
        approvalTable.reloadData()
    }
    
    func loadApprovalDetailTable() {
        approvalDetailsTable.delegate = self
        approvalDetailsTable.dataSource = self
        approvalDetailsTable.reloadData()
    }
    
    func cellregistration() {
        approvalTable.register(UINib(nibName: "DCRApprovalsTVC", bundle: nil), forCellReuseIdentifier: "DCRApprovalsTVC")
        
        approvalDetailsTable.register(UINib(nibName: "DCRApprovalsWorkTypeTVC", bundle: nil), forCellReuseIdentifier: "DCRApprovalsWorkTypeTVC")
        
        approvalDetailsTable.register(UINib(nibName: "VisitsCountTVC", bundle: nil), forCellReuseIdentifier: "VisitsCountTVC")
        
        approvalDetailsTable.register(UINib(nibName: "DCRAllApprovalsTVC", bundle: nil), forCellReuseIdentifier: "DCRAllApprovalsTVC")
        
        
    }

    
    func initTaps() {
        backHolderView.addTap {
            self.dcrApprovalVC.navigationController?.popViewController(animated: true)
        }
    }
    
}
extension DCRapprovalView: VisitsCountTVCDelegate {
    func typeChanged(index: Int, type: CellType) {
        
        guard self.selectedType != type else {
            return
        }
        
        if index != 0 {
            
            if LocalStorage.shared.getBool(key: .isConnectedToNetwork) {
             //   self.viewDayReportVC.toSetParamsAndGetResponse(index)
            } else {
                self.toCreateToast("Please connect to internet.")
            }
            
           
        }

        self.selectedType = type
    }
    
    
}
