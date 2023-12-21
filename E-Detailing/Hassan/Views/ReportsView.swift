//
//  ReportsView.swift
//  E-Detailing
//
//  Created by San eforce on 20/12/23.
//

import Foundation
import UIKit

extension ReportsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportInfoArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReportTypesCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportTypesCVC", for: indexPath) as!  ReportTypesCVC
        let modal = reportInfoArr?[indexPath.row]
        
        cell.reportTypeIV.image = UIImage(named: modal?.image ?? "")
        cell.reportTypeLbl.text = modal?.name
        
        cell.addTap {
            let vc = DetailedReportVC.initWithStory()
            self.reporsVC.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 4, height: collectionView.height / 6)
    }
    
    
}

class ReportsView : BaseView {
    
    
    struct ReportInfo {
        let name: String
        let image: String
    }
    
    enum cellType {
        
    }
    
    @IBOutlet var reportTitle: UILabel!
    
    @IBOutlet weak var topNavigationView: UIView!
    
    
    @IBOutlet weak var collectionHolderView: UIView!
    
    
    @IBOutlet weak var reportsCollection: UICollectionView!
    
    var reporsVC : ReportsVC!
    var reportInfoArr : [ReportInfo]?
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.reporsVC = baseVC as? ReportsVC
  
    }
    
    
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.reporsVC = baseVC as? ReportsVC
        toLoadData()
        setupUI()
        cellregistration()
    }
    
    func setupUI() {
        reportTitle.setFont(font: .bold(size: .SUBHEADER))
        collectionHolderView.backgroundColor = .appSelectionColor
        
        let dayReport = ReportInfo(name: "Day Report", image: "Day Report")
        let monthlyReport = ReportInfo(name: "Monthly Report", image: "Monthly")
        let dayCheckReport = ReportInfo(name: "Day Check in Report", image: "Day Check in")
        let customerReport = ReportInfo(name: "Customer Check in Report", image: "Checkin")
        let visitReport = ReportInfo(name: "Visit Monitor", image: "Visit")
        
     var areportInfoArr = [ReportInfo]()
        areportInfoArr.append(dayReport)
        areportInfoArr.append(monthlyReport)
        areportInfoArr.append(dayCheckReport)
        areportInfoArr.append(customerReport)
        areportInfoArr.append(visitReport)
        
        self.reportInfoArr = areportInfoArr
        
    }
    
    func cellregistration() {
        reportsCollection.register(UINib(nibName: "ReportTypesCVC", bundle: nil), forCellWithReuseIdentifier: "ReportTypesCVC")
    }
    
    func toLoadData() {
        reportsCollection.delegate = self
        reportsCollection.dataSource = self
        reportsCollection.reloadData()
    }
    
}
