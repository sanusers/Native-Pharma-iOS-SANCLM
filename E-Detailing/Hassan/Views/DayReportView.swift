//
//  DayReportView.swift
//  E-Detailing
//
//  Created by San eforce on 22/12/23.
//

import Foundation
import UIKit

extension DayReportView : ViewAllInfoTVCDelegate {
    func didLessTapped(islessTapped: Bool, isrcpaTapped: Bool) {
        
        if islessTapped && !isrcpaTapped {
            self.isForViewmore = false
            self.toLoadData()
        } else if !islessTapped && isrcpaTapped{
            self.isForViewmore = true
            self.isForRCPA = isrcpaTapped
            self.toLoadData()
        } else {
            self.isForViewmore = true
            self.isForRCPA = isrcpaTapped
            self.toLoadData()
        }
        

    }
    
    
    
    
}

extension DayReportView: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 1
        case 1:
            return 1
        case 2:
            return 1
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
            cell.selectionStyle = .none
                        return cell
            
            
        case 1:
            let cell: VisitsCountTVC = tableView.dequeueReusableCell(withIdentifier: "VisitsCountTVC", for: indexPath) as! VisitsCountTVC
            cell.selectionStyle = .none
            return cell
        case 2:
            
            if !isForViewmore {
                let cell: VisitInfoTVC = tableView.dequeueReusableCell(withIdentifier: "VisitInfoTVC", for: indexPath) as! VisitInfoTVC
                cell.selectionStyle = .none
                cell.elevationView.elevate(5)
                cell.elevationView.layer.cornerRadius = 5
                
                cell.viewMoreDesc.addTap {
                    print("Tapped")
                    self.isForViewmore = true
                    self.toLoadData()
                }
                return cell
            } else {
                let cell: ViewAllInfoTVC = tableView.dequeueReusableCell(withIdentifier: "ViewAllInfoTVC", for: indexPath) as! ViewAllInfoTVC
                cell.delegate = self
                
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
            return 200
        case 1:
            return tableView.height / 9
        default:
            
            if !isForViewmore {
               return  240
            }
            
            else if isForViewmore &&  !isForRCPA {
               //10 elevation padding, 60 header height (product)
                return 595 + 10 + 60
            } else if isForRCPA && isForViewmore {
                return 595 + 100 + 10 + 60
            } else {
                return CGFloat()
            }
            
        }
    }
    
    
}

class DayReportView: BaseView {
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
    
    @IBOutlet var tableContentsHolder: UIView!
    @IBOutlet var sortView: UIView!
    var isForViewmore = false
    var isForRCPA = false
    var rejectedHeight: CGFloat =  70
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.viewDayReportVC = baseVC as? ViewDayReportVC
  
    }
    
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.viewDayReportVC = baseVC as? ViewDayReportVC
        toLoadData()
        setupUI()
        cellregistration()
    }
    func setupUI() {
        sortView.layer.cornerRadius = 5
        tableContentsHolder.layer.cornerRadius = 5
        tableContentsHolder.backgroundColor = .appWhiteColor
        searchHolderVIew.backgroundColor = .appWhiteColor
        searchHolderVIew.layer.cornerRadius = 5
        self.backgroundColor = .appGreyColor
        aDayReportsTable.separatorStyle = .none
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
    
    
}
