//
//  LeaveApprovalView.swift
//  SAN ZEN
//
//  Created by San eforce on 24/07/24.
//

import Foundation
import UIKit

extension LeaveApprovalView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:  LeaveApprovalTVC = tableView.dequeueReusableCell(withIdentifier: "LeaveApprovalTVC", for: indexPath) as! LeaveApprovalTVC
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height / 3
    }
    
    
}

class LeaveApprovalView : BaseView {
    
    
    @IBOutlet var approvalTitle: UILabel!
    
    @IBOutlet weak var topNavigationView: UIView!
    
    
    @IBOutlet weak var tableHolderView: UIView!
    
    @IBOutlet weak var backHolderView: UIView!
    
    
    @IBOutlet weak var approvalDetailsTable: UITableView!
    

    @IBOutlet var searchHolderView: UIView!


    var leaveApprovalVC : LeaveApprovalVC!
    var selectedBrandsIndex: Int?

    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.leaveApprovalVC = baseVC as? LeaveApprovalVC
        initTaps()
        setupUI()
        cellregistration()
       // callAPI()
        toLoadData()
        
    }
    
    func initTaps() {
        
        backHolderView.addTap {
            self.leaveApprovalVC.navigationController?.popViewController(animated: true)
        }
    }
    
    func cellregistration() {
        approvalDetailsTable.register(UINib(nibName: "LeaveApprovalTVC", bundle: nil), forCellReuseIdentifier: "LeaveApprovalTVC")
    }
    
    func toLoadData() {
        approvalDetailsTable.delegate = self
        approvalDetailsTable.dataSource = self
        approvalDetailsTable.reloadData()
    }
    
    func callAPI() {
       // Shared.instance.showLoaderInWindow()
       // dcrApprovalVC.fetchApprovalList(vm: UserStatisticsVM()) {[weak self] approvalist in
         //   Shared.instance.removeLoaderInWindow()
          //  guard let welf = self, let approvalist = approvalist else {return}
         //   welf.approvalList = approvalist
         //   welf.loadApprovalTable()
            
      //  }
    }
    
    func setupUI() {
        self.backgroundColor = .appSelectionColor
        approvalDetailsTable.backgroundColor = .clear
        approvalDetailsTable.separatorStyle = .none
        approvalDetailsTable.layer.cornerRadius = 5
        searchHolderView.layer.cornerRadius = 5

    }
}
