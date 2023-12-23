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
          //  cellHeight = cellHeight - 80
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

extension DetailedReportView: SortVIewDelegate {
    func didSelected(index: Int?, isTosave: Bool) {
        selectedSortIndex = index
        isSortPresented =  isSortPresented ? false : true
        addOrRemoveSort(isSortPresented)
    }

}

class DetailedReportView: BaseView {
    
    
    @IBOutlet var titleLBL: UILabel!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var sortCalenderView: UIView!
    
    @IBOutlet var sortSearchView: UIView!
    
    @IBOutlet var sortFiltersView: UIView!
    
    @IBOutlet var filterDateTF: UITextField!
    
    @IBOutlet var reportsTable: UITableView!
    
    @IBOutlet var searchTF: UITextField!
    var selectedSortIndex: Int? = nil
    
    var isSortPresented = false
    
    var cellHeight: CGFloat = 265
    
    var reportsModel : [ReportsModel]?
    let datePicker = UIDatePicker()
    
    private lazy var sortView: SortVIew = {
        let customView = SortVIew(frame: CGRect(x: (self.width / 2) - (self.width / 3) / 2, y: (self.height / 2) - 150, width: self.width / 3, height: 300))
     
        customView.delegate = self
        return customView
    }()
    
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
    
    func initTaps() {

 
        
        
        
      
        
        sortFiltersView.addTap {
            self.isSortPresented =  self.isSortPresented ? false : true
            UIView.animate(withDuration: 1.0,
                           delay: 0.15,
                           usingSpringWithDamping: 2.0,
                           initialSpringVelocity: 5.0,
                           options: [.curveEaseOut],
                           animations: {

                self.addOrRemoveSort(self.isSortPresented)

                           }, completion: nil)
        }
        

    }
    func showDatePicker(){
      //Formate Date
      datePicker.datePickerMode = .date
        datePicker.tintColor = .appTextColor
   
     //ToolBar
     let toolbar = UIToolbar();
     toolbar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedatePicker));
       doneButton.tintColor = .appTextColor
      //  let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelDatePicker));
        cancelButton.tintColor = .appLightPink
        toolbar.setItems([doneButton,cancelButton], animated: true)
//spaceButton,
        filterDateTF.inputAccessoryView = toolbar
        filterDateTF.inputView = datePicker

   }
    
    @objc func donedatePicker(){

     let formatter = DateFormatter()
     formatter.dateFormat = "dd MMM yyyy"
     filterDateTF.text = formatter.string(from: datePicker.date)
     self.endEditing(true)
   }
    
    @objc func cancelDatePicker(){
       self.endEditing(true)
     }
   
    func addOrRemoveSort(_ isToAdd: Bool) {
        let views: [UIView] = [self.reportsTable, self.sortCalenderView, self.sortSearchView]
        if isToAdd {
            views.forEach { aView in
                aView.alpha = 1
                aView.isUserInteractionEnabled = true
                
                self.sortView.removeFromSuperview()
            }
        } else {
            views.forEach { aView in
                aView.alpha = 0.3
                aView.isUserInteractionEnabled = false
                self.sortView.selectedIndex = selectedSortIndex
                self.sortView.toLoadData()
                self.addSubview(self.sortView)
            }
        }
    }
    
    func setupUI() {
       //searchTF.placeholder = UIFont(name: "Satoshi-Bold", size: 14)
        searchTF.font = UIFont(name: "Satoshi-Bold", size: 14)
        titleLBL.setFont(font: .bold(size: .BODY))
        filterDateTF.inputView = datePicker
        filterDateTF.font = UIFont(name: "Satoshi-Bold", size: 14)
     
        filterDateTF.text = "Select Date"
        showDatePicker()
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
        initTaps()
    }
}
