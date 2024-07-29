//
//  TourPlanApprovalView.swift
//  SAN ZEN
//
//  Created by San eforce on 26/07/24.
//

import Foundation
import UIKit
import CoreData

extension TourPlanApprovalView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case approvalTable :
            guard let approvalList = isSearched ? filteredApprovalList : approvalList else { return 0}
            return approvalList.count
         //   return 10
        default:
            return 2
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
                return 10 + 60 + 60 + 15
            case 1:
                //session height - 670 + 100
                guard let approvalDetails = self.approvalDetails else {  return 0 }
                let model = approvalDetails[indexPath.row]
                if !model.isExtended {
                   return 10 + 60 + 10
                } else {
                    return 10 + 60 + 670 + 100  + 10
                }
               
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
            
            guard let approvalList = isSearched ? filteredApprovalList : approvalList  else {
                return UITableViewCell()
           }
            let model = approvalList[indexPath.row]
            cell.populateCell(model)
            
            
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
               // welf.loadApprovalDetailTable()
                Shared.instance.showLoaderInWindow()
                let additionalParam = TPdetailParam(month: model.mnth, year: model.yr, sfcode: model.sfCode)
                welf.tourPlanApprovalVC.getTPapprovalDetail(additionalparam: additionalParam, vm: UserStatisticsVM()) { approvalDetailModel in
                    Shared.instance.removeLoaderInWindow()
                    guard let approvalDetailModel = approvalDetailModel else {return}
                    //dump(approvalDetailModel)
                    welf.selectedType = .All
                    welf.approvalDetails = approvalDetailModel
                    welf.loadApprovalDetailTable()
                }
            }
            
     return cell
        default:
            switch indexPath.row {
            case 0:
                let cell: TourPlanApprovalinfoTVC = approvalDetailsTable.dequeueReusableCell(withIdentifier: "TourPlanApprovalinfoTVC") as! TourPlanApprovalinfoTVC
                cell.selectionStyle = .none
                guard let approvalDetails = self.approvalDetails, let approvalList = approvalList?[selectedBrandsIndex ?? 0] else {return UITableViewCell()}
               
                cell.toPopulatecell(model: approvalDetails, list: approvalList)
                return cell
                
            case 1:
                let cell: TourplanApprovalDetailedInfoTVC = tableView.dequeueReusableCell(withIdentifier: "TourplanApprovalDetailedInfoTVC", for: indexPath) as! TourplanApprovalDetailedInfoTVC

                guard let approvalDetails = self.approvalDetails else {  return UITableViewCell() }
                let model = approvalDetails[indexPath.row]
                cell.populateCell(model: model)
                
                cell.chevlonIV.addTap {[weak self] in
                    guard let welf = self else {return}
                    model.isExtended = !model.isExtended
                    
                    welf.loadApprovalDetailTable()
                }
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
          
        }
        

    }
    
    
}

class TourPlanApprovalView : BaseView, UITextFieldDelegate {
    
    
    @IBOutlet var approvalTitle: UILabel!
    
    @IBOutlet weak var topNavigationView: UIView!
    
    
    @IBOutlet weak var collectionHolderView: UIView!
    
    @IBOutlet weak var backHolderView: UIView!
    
    
    @IBOutlet weak var approvalDetailsTable: UITableView!
    
    
    @IBOutlet weak var approvalTable: UITableView!
    
    
    @IBOutlet var searchHolderView: UIView!
    
    @IBOutlet var rejectView: UIView!
    
    @IBOutlet var approveView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var searchTF: UITextField!
    var isSearched = false
    var tpDeviateReasonView:  TPdeviateReasonView?
    var filteredApprovalList: [TourPlanApprovalModel]?
    var approvalDetails: [TourPlanApprovalDetailModel]?
    var tourPlanApprovalVC : TourPlanApprovalVC!
    var selectedBrandsIndex: Int?
    var selectedType: CellType = .All
    var approvalList: [TourPlanApprovalModel]?
    var isRemarksadded = false
    var dayRemarks = ""
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.tourPlanApprovalVC = baseVC as? TourPlanApprovalVC
        initTaps()
        setupUI()
        cellregistration()
        callAPI()
      
    }
    
    override func didLayoutSubviews(baseVC: BaseViewController) {
     super.didLayoutSubviews(baseVC: baseVC)
        
        let  tpDeviateVIewwidth = self.bounds.width / 1.7
        let  tpDeviateVIewheight = self.bounds.height / 2.7
        
        let  tpDeviateVIewcenterX = self.bounds.midX - (tpDeviateVIewwidth / 2)
        let tpDeviateVIewcenterY = self.bounds.midY - (tpDeviateVIewheight / 2)
        
        
        tpDeviateReasonView?.frame = CGRect(x: tpDeviateVIewcenterX, y: tpDeviateVIewcenterY, width: tpDeviateVIewwidth, height: tpDeviateVIewheight)
    }
    
    func callAPI() {
        Shared.instance.showLoaderInWindow()
        tourPlanApprovalVC.fetchTPapproval(vm: UserStatisticsVM()) {[weak self] approvalist in
            Shared.instance.removeLoaderInWindow()
            guard let welf = self, let approvalist = approvalist else {return}
            welf.approvalList = approvalist
            welf.loadApprovalTable()
          //  loadApprovalDetailTable()
         //   welf.dcrApprovalVC.fetchFirstIndex()
            
        }
    }

    func setupUI() {
        self.backgroundColor = .appSelectionColor
        backgroundView.isHidden = true
        collectionHolderView.layer.cornerRadius = 5
        searchHolderView.layer.cornerRadius = 5
        rejectView.layer.cornerRadius = 5
        approveView.layer.cornerRadius = 5
        rejectView.backgroundColor = .appLightPink
        approveView.backgroundColor = .appGreen
        searchTF.delegate = self
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
        
        approvalDetailsTable.register(UINib(nibName: "TourPlanApprovalinfoTVC", bundle: nil), forCellReuseIdentifier: "TourPlanApprovalinfoTVC")
        
        approvalDetailsTable.register(UINib(nibName: "TourplanApprovalDetailedInfoTVC", bundle: nil), forCellReuseIdentifier: "TourplanApprovalDetailedInfoTVC")
        
    }

    
    func initTaps() {
        backHolderView.addTap {
            self.tourPlanApprovalVC.navigationController?.popViewController(animated: true)
        }
        
        rejectView.addTap { [weak self] in
            guard let welf = self else {return}
            if !welf.isRemarksadded && welf.dayRemarks.isEmpty {
                welf.deviateAction(isForremarks: false)
                return
            }
           
        }
        
        backgroundView.addTap { [weak self] in
            guard let welf = self else {return}
            welf.didClose()
        }
        
        approveView.addTap {[weak self] in
            //guard let welf = self else {return}
             print("Yet to")

        }
        
    }
    
    func deviateAction(isForremarks: Bool) {
        backgroundView.isHidden = false
        backgroundView.alpha = 0.3
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case tpDeviateReasonView:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
            case backgroundView:
                aAddedView.isUserInteractionEnabled = true
            default:
                print("Yet to implement")
                aAddedView.isUserInteractionEnabled = false
                
                
            }
            
        }
        
        tpDeviateReasonView = self.tourPlanApprovalVC.loadCustomView(nibname: XIBs.tpDeviateReasonView) as? TPdeviateReasonView
        tpDeviateReasonView?.delegate = self
        
        tpDeviateReasonView?.addedSubviewDelegate = self
        tpDeviateReasonView?.isForRemarks = false
        tpDeviateReasonView?.isForRejection = true
        tpDeviateReasonView?.setupui()
        self.addSubview(tpDeviateReasonView ?? TPdeviateReasonView())
    }
    
}
extension TourPlanApprovalView : addedSubViewsDelegate {
    func didUpdateCustomerCheckin(dcrCall: CallViewModel) {
        print("Yet to implement")
    }
    
    func didUpdateFilters(filteredObjects: [NSManagedObject]) {
        print("yes action")
    }
    
    
    func showAlertToNetworks(desc: String, isToclearacalls: Bool) {

    }
    
    
    func redirectToSettings() {

    }
    
    func showAlert(desc: String) {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: AppName, alertDescription: desc, okAction: "Ok")
        commonAlert.addAdditionalCancelAction {
            print("no action")
        }
    }
    
    
    
    
    func didClose() {
        backgroundView.isHidden = true
        self.subviews.forEach { aAddedView in
            
            switch aAddedView {
 
            case tpDeviateReasonView:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
                isRemarksadded = false
                dayRemarks = ""
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
                
                // aAddedView.alpha = 1
                
            }
            
        }
    }

    func didUpdate() {
    
    }
    
    
}
extension TourPlanApprovalView : SessionInfoTVCDelegate {
    func remarksAdded(remarksStr: String, index: Int) {
        
        guard !remarksStr.isEmpty else {
         toCreateToast("Kindly add reason for rejection")
            
            return}
        self.isRemarksadded = true
        self.dayRemarks = remarksStr
        
        backgroundView.isHidden = true
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case tpDeviateReasonView:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0

            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
            }

        }

    }
    
    
}
