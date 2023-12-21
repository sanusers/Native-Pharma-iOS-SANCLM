//
//  DetailedReportView.swift
//  E-Detailing
//
//  Created by San eforce on 20/12/23.
//

import Foundation
import UIKit


extension DetailedReportView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BasicReportsInfoTVC = tableView.dequeueReusableCell(withIdentifier: "BasicReportsInfoTVC") as!  BasicReportsInfoTVC
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}


class DetailedReportView: BaseView {
    
    
    @IBOutlet var titleLBL: UILabel!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var sortCalenderView: UIView!
    
    @IBOutlet var sortSearchView: UIView!
    
    @IBOutlet var sortFiltersView: UIView!
    
    
    @IBOutlet var reportsTable: UITableView!
    
    var detailedreporsVC : DetailedReportVC!
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.detailedreporsVC = baseVC as? DetailedReportVC
  
    }
    
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.detailedreporsVC = baseVC as? DetailedReportVC
      //  toLoadData()
        setupUI()
       // cellregistration()
    }
    
    func cellRegistration() {
        reportsTable.register(UINib(nibName: "BasicReportsInfoTVC", bundle: nil), forCellReuseIdentifier: "BasicReportsInfoTVC")
    }
    
    func toLoadData() {
        reportsTable.delegate = self
        reportsTable.dataSource = self
        reportsTable.reloadData()
    }
    
    func setupUI() {
        cellRegistration()
        reportsTable.separatorStyle = .none
        self.backgroundColor = .appGreyColor
        sortCalenderView.layer.borderColor = UIColor.appTextColor.cgColor
        sortCalenderView.layer.borderWidth = 0.5
        
        
        sortCalenderView.backgroundColor = .appWhiteColor
        sortCalenderView.elevate(2)
        sortCalenderView.layer.cornerRadius = 5
        
        sortSearchView.backgroundColor = .appWhiteColor
        sortSearchView.elevate(2)
        sortSearchView.layer.cornerRadius = 5
        
        sortFiltersView.elevate(2)
        sortFiltersView.layer.cornerRadius = 5
        
        toLoadData()
    }
}
