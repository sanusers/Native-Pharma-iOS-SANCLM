//
//  DetailedReportView.swift
//  E-Detailing
//
//  Created by San eforce on 20/12/23.
//

import Foundation
import UIKit
class DetailedReportView: BaseView {
    
    
    @IBOutlet var titleLBL: UILabel!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var sortCalenderView: UIView!
    
    @IBOutlet var sortSearchView: UIView!
    
    @IBOutlet var sortFiltersView: UIView!
    
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
    
    func setupUI() {
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
    }
}
