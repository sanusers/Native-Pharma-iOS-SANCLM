//
//  ReportsView.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 20/12/23.
//

import Foundation
import UIKit

extension ReportsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportInfoArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReportTypesCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportTypesCVC", for: indexPath) as!  ReportTypesCVC
        if let modal = reportInfoArr?[indexPath.row]  {

            cell.setupUI(type: reporsVC.pageType, modal: modal)
    
        }
   
        cell.addTap { [weak self] in
            guard let welf = self else {return}
            switch welf.reporsVC.pageType  {
                
            case .reports:
                if indexPath.row == 0 {
                    let vc = DetailedReportVC.initWithStory()
                    welf.reporsVC.navigationController?.pushViewController(vc, animated: true)
                }
            case .approvals:
                print("Yet to implement")
            case .myResource:
                
                if let modal = welf.reportInfoArr?[indexPath.row]  {

                    
                    
                    let vc = SpecifiedMenuVC.initWithStory(nil, celltype: welf.toRetriveCellType(name: modal.name) ?? .listedDoctor)
                    welf.reporsVC.modalPresentationStyle = .custom
                    welf.reporsVC.navigationController?.present(vc, animated: false)
            
                }
                
      
            }
            
 
            
     
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 4, height: collectionView.height / 6)
    }
    
    func toRetriveCellType(name: String) -> MenuView.CellType? {
        
        if MenuView.CellType(rawValue: name)?.rawValue ?? "" ==  MenuView.CellType.listedDoctor.rawValue {
            return MenuView.CellType.doctorInfo
        }
        
        if MenuView.CellType(rawValue: name)?.rawValue ?? "" ==  MenuView.CellType.chemist.rawValue {
            return MenuView.CellType.chemistInfo
        }
        
        
        if MenuView.CellType(rawValue: name)?.rawValue ?? "" ==  MenuView.CellType.stockist.rawValue {
            return MenuView.CellType.stockistInfo
        }
        
        if MenuView.CellType(rawValue: name)?.rawValue ?? "" ==  MenuView.CellType.unlistedDoctor.rawValue {
            return MenuView.CellType.unlistedDoctorinfo
        }
        
        return MenuView.CellType(rawValue: name)
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
    
    @IBOutlet weak var backHolderView: UIView!
    
    
    @IBOutlet weak var reportsCollection: UICollectionView!
    
    var reporsVC : ReportsVC!
    var reportInfoArr : [ReportInfo]?
    var pagetype: ReportsVC.PageType = .reports
    lazy var contentDict : Array<JSON> = [JSON]()
   
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.reporsVC = baseVC as? ReportsVC
        setupUI()
        cellregistration()
  
    }
    
    
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.reporsVC = baseVC as? ReportsVC
      

    }
    
    func initTaps() {
        backHolderView.addTap {
            self.reporsVC.navigationController?.popViewController(animated: true)
        }
    }
    
    func setPagetype(pagetype: ReportsVC.PageType) {
        switch pagetype {
            
        case .reports:
            self.reportTitle.text = "Reports"
           // contentDict
            contentDict = [["Day Report" : "Day Report"], ["Monthly Report": "Monthly"], ["Day Check in Report": "Day Check in"], ["Customer Check in Report" : "Day Check in"], ["Visit Monitor" : "Visit"]]
       
          
             
                reportInfoArr = generateModel(contentDict: contentDict as! [[String: String]])
            
            
           
        case .approvals:
            self.reportTitle.text = "Approvals"
            contentDict = Array<JSON>()
            
        case .myResource:
            self.reportTitle.text = "My Resource"
            contentDict = Array<JSON>()
            self.reportInfoArr = generateModel(contentDict: toSetupResources())
        }
        toLoadData()
    }
    
    func setupUI() {
        initTaps()
        reportTitle.setFont(font: .bold(size: .SUBHEADER))
        collectionHolderView.backgroundColor = .appSelectionColor
       
        setPagetype(pagetype: reporsVC.pageType)

        
        
        
       
    }
    
    func generateModel(contentDict: [[String: String]]) -> [ReportInfo] {
        var modelArray: [ReportInfo] = []
        contentDict.forEach { aDict in
            for (name, image) in aDict {
                let reportInfo = ReportInfo(name: name, image: image)
                modelArray.append(reportInfo)
            }
        }
  

        return modelArray
    }
    
    
    func toSetupResources() -> [[String: String]] {
        let appsetup = AppDefaults.shared.getAppSetUp()

        
   
        let docDict: [String: String] = [MenuView.CellType.listedDoctor.rawValue: String(DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).count)]
        
        contentDict.append(docDict)
        
        if appsetup.chmNeed == 0 {
      
            let  checmistDict: [String: String] = [MenuView.CellType.chemist.rawValue : String(DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).count)]
            
            contentDict.append(checmistDict)
        }
        if appsetup.stkNeed == 0 {
       
            let  StockistDict: [String: String] = [MenuView.CellType.stockist.rawValue : String(DBManager.shared.getStockist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).count)]
            
            contentDict.append(StockistDict)
        }
        
        
        if appsetup.unlNeed == 0 {
        
            let  UnlistedDict: [String: String] = [MenuView.CellType.unlistedDoctor.rawValue : String(DBManager.shared.getUnListedDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).count)]
            
            contentDict.append(UnlistedDict)
        }
        if appsetup.cipNeed == 0 {
       
            let  cipDict: [String: String] = ["CIP" : "0"]
            
            contentDict.append(cipDict)
        }
        if appsetup.hospNeed == 0 {
        
            let  hospDict: [String: String] = ["Hospital" : ""]
            
            contentDict.append(hospDict)
        }
        
        let  hospDict: [String: String] = ["Input" : String(DBManager.shared.getInput().count)]
        contentDict.append(hospDict)
        let  ProductDict: [String: String] = ["Product" : String(DBManager.shared.getProduct().count)]
        contentDict.append(ProductDict)
        let  ClusterDict: [String: String] = ["Cluster": String(DBManager.shared.getTerritory(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).count)]
        contentDict.append(ClusterDict)
        let  DoctorDict: [String: String] = ["Doctor Visit" : String(DBManager.shared.getVisitControl().count)]
        contentDict.append(DoctorDict)
        let  HolidayDict: [String: String] = ["Holiday / Weekly off"  : "\(String(DBManager.shared.getHolidays().count)) / \(String(DBManager.shared.getWeeklyOff().count))"]
        contentDict.append(HolidayDict)
        
        return contentDict as!  [[String: String]]
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
