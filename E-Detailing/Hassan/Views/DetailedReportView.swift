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
        return reportsModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BasicReportsInfoTVC = tableView.dequeueReusableCell(withIdentifier: "BasicReportsInfoTVC") as!  BasicReportsInfoTVC
        cell.selectionStyle = .none
        let modal = reportsModel?[indexPath.row] ?? ReportsModel()
        cell.populateCell(modal)
        cell.nextActionVIew.addTap {
            let vc = ViewDayReportVC.initWithStory()
            self.detailedreporsVC.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = reportsModel?[indexPath.row] ?? ReportsModel()
        //
        let isTohideCheckin = isTohideCheckin(model)
        let isTohideCheckout = isTohideCheckout(model)
        
        if isTohideCheckin && isTohideCheckout  {
          //  cellHeight = cellHeight - 70
        }
        
        var count = Int()
        if model.chm != 0 {

            count += 1
        }
        
        if model.cip != 0 {

            count += 1
        }
        
        if model.drs != 0 {

            count += 1
        }
        
        
        if model.stk != 0 {

            count += 1
        }
     
        
        if model.udr != 0 {

            count += 1
        }
        
        if model.hos != 0 {

            count += 1
        }
       // remarksAndPlansView
        let isTohideRemarks = isTohideRemarks(model)
        let isTohideplanCollection = isTohideplanCollection(count:  count )
        
         
        if isTohideRemarks && isTohideplanCollection {
            cellHeight = cellHeight - 75
        } else {
         
        }
        
        
        return cellHeight
    }
    
    
}


class DetailedReportView: BaseView {
    
    
    @IBOutlet var titleLBL: UILabel!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var sortCalenderView: UIView!
    
    @IBOutlet var sortSearchView: UIView!
    
    @IBOutlet var sortFiltersView: UIView!
    
    
    @IBOutlet var reportsTable: UITableView!
    
    var cellHeight: CGFloat = 255
    
    var reportsModel : [ReportsModel]?
    
    var detailedreporsVC : DetailedReportVC!
    override func didLoad(baseVC: BaseViewController) {
     
        self.detailedreporsVC = baseVC as? DetailedReportVC
  
    }
    
    override func willAppear(baseVC: BaseViewController) {
    
        self.detailedreporsVC = baseVC as? DetailedReportVC
    
       
        detailedreporsVC.toSetParamsAndGetResponse()
      
    }
    
    func cellRegistration() {
        reportsTable.register(UINib(nibName: "BasicReportsInfoTVC", bundle: nil), forCellReuseIdentifier: "BasicReportsInfoTVC")
    }
    
    func toLoadData() {
        reportsTable.delegate = self
        reportsTable.dataSource = self
        reportsTable.reloadData()
    }
    
    func toConfigureCellHeight() {
        
    }
    
    func setupUI() {
        toConfigureCellHeight()
        cellRegistration()
        reportsTable.separatorStyle = .none
        self.backgroundColor = .appGreyColor
        sortCalenderView.layer.borderColor = UIColor.appTextColor.cgColor
        sortCalenderView.layer.borderWidth = 0.5
        
        
        sortCalenderView.backgroundColor = .appWhiteColor
       // sortCalenderView.elevate(2)
        sortCalenderView.layer.cornerRadius = 5
        
        sortSearchView.backgroundColor = .appWhiteColor
       // sortSearchView.elevate(2)
        sortSearchView.layer.cornerRadius = 5
        
       // sortFiltersView.elevate(2)
        sortFiltersView.layer.cornerRadius = 5
        
        toLoadData()
    }
}
