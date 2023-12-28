//
//  ViewAllInfoTVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/12/23.
//

import UIKit

extension ViewAllInfoTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        switch self.cellType {
            
        case .showRCPA:
           
            //MARK: - rcpa cell (+1 section)
            return 7
        case .hideRCPA:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch section {
        case 1:
            if self.isTohideLocationInfo {
                return 0
            } else {
                return 1
            }
        case 2:
            return  productStrArr.count
        case 3:
            return 1
        default:
            switch self.cellType {
                
            case .showRCPA:
                switch section {
                    //MARK: - rcpa cell (+1 section)
                case 4:
                    return 3
                default:
                    return 1
                }
            case .hideRCPA:
                switch section {
                default:
                    return 1
                }
            }
        }
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.width, height: 190)
            
            
        case 1:
            return CGSize(width: collectionView.width, height: 100)
      
        case 2:
            return CGSize(width: collectionView.width, height: 30)
            
        case 3:
            return CGSize(width: collectionView.width, height: 60)
        default:
            switch self.cellType {
                
            case .showRCPA:
                switch indexPath.section {

                    
                    //MARK: - rcpa cell (+1 section)
                case 4:
                    return CGSize(width: collectionView.width, height: 30)
                    
                case 5:
                    return CGSize(width: collectionView.width, height: 75)
                case 6:
                    return CGSize(width: collectionView.width, height: 50)
                default:
                    return CGSize()
                }
            case .hideRCPA:
                switch indexPath.section {
                case 4:
                    return CGSize(width: collectionView.width, height: 75)
                case 5:
                    return CGSize(width: collectionView.width, height: 50)
                default:
                    return CGSize()
                }
            }
        }
        
        


    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Create and return the header view
        if indexPath.section == 2 {
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomHeaderView.identifier, for: indexPath) as! CustomHeaderView
                headerView.titleLabel.text = "Product"
                return headerView
            }
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Return the size of your header
        if section == 2 {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: VisitInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "VisitInfoCVC", for: indexPath) as! VisitInfoCVC
            cell.typeIV.image = self.typeImage ?? UIImage()
            cell.toPopulateCell(model: self.detailedReportModel ?? DetailedReportsModel())
            return cell
            
        case 1:
            let cell: TimeInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeInfoCVC", for: indexPath) as! TimeInfoCVC
            cell.toPopulateCell(model: self.reportModel ?? ReportsModel())
            return cell
        case 2:
            
            
            switch indexPath.row {
            case 0:
                let cell: ProductSectionTitleCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSectionTitleCVC", for: indexPath) as! ProductSectionTitleCVC
                cell.holderVoew.backgroundColor = .appGreyColor
                return cell
            default:
                let cell: ProductsDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsDescriptionCVC", for: indexPath) as! ProductsDescriptionCVC
                let modelStr = self.productStrArr[indexPath.row]
                cell.topopulateCell(modelStr: modelStr)
                
                return cell
            }
        case 3:
            let cell: rcpaCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "rcpaCVC", for: indexPath) as! rcpaCVC
            cell.addTap {
                self.cellType =   self.cellType == .showRCPA ?  .hideRCPA : .showRCPA
                self.delegate?.didLessTapped(islessTapped: false, isrcpaTapped: self.cellType  == .hideRCPA ?  false : true )
                //self.cellType == .showRCPA ? true : false
                self.extendedInfoCollection.reloadData()
            }
            return cell
        default:
            switch self.cellType {
                
            case .showRCPA:
                switch indexPath.section {
                    //MARK: - rcpa cell (+1 section)
                case 4:
                    switch indexPath.row {
                    case 0:
                        let cell: ProductSectionTitleCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSectionTitleCVC", for: indexPath) as! ProductSectionTitleCVC
                        cell.holderVoew.backgroundColor = .appGreyColor
                        return cell
                    default:
                        let cell: ProductsDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsDescriptionCVC", for: indexPath) as! ProductsDescriptionCVC
                        return cell
                    }
                case 5:
                    let cell: ReportsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportsCVC", for: indexPath) as! ReportsCVC
                    return cell
                    
                    
                case 6:
                    let cell: ViewmoreCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewmoreCVC", for: indexPath) as! ViewmoreCVC
                    cell.addTap {
                        
                        self.delegate?.didLessTapped(islessTapped: true, isrcpaTapped: false)
                    }
                    return cell
                    
                default:
                    return UICollectionViewCell()
                }
            case .hideRCPA:
                switch indexPath.section {
                case 4:
                    let cell: ReportsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportsCVC", for: indexPath) as! ReportsCVC
                    return cell
                case 5:
                    let cell: ViewmoreCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewmoreCVC", for: indexPath) as! ViewmoreCVC
                    cell.addTap {
                        
                        self.delegate?.didLessTapped(islessTapped: true, isrcpaTapped: false)
                    }
                    return cell
                    
                default:
                    return UICollectionViewCell()
                }
            }
        }
        

        
    }
    
    
}

protocol ViewAllInfoTVCDelegate: AnyObject {
    func didLessTapped(islessTapped: Bool, isrcpaTapped: Bool)
        
    
}

class ViewAllInfoTVC: UITableViewCell {

    enum CellType {
        case showRCPA
        case hideRCPA
    }
    
    
    @IBOutlet var extendedInfoCollection: UICollectionView!
    weak var delegate: ViewAllInfoTVCDelegate?
    var rcpaTapped: Bool = false
    //var selectedType: CellType = .All
    var cellType: CellType = .hideRCPA
    var reportModel: ReportsModel?
    var detailedReportModel: DetailedReportsModel?
    var productStrArr : [String] = []
    var typeImage: UIImage?
    var isTohideLocationInfo = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        extendedInfoCollection.elevate(4)
        extendedInfoCollection.layer.cornerRadius = 5
        extendedInfoCollection.isScrollEnabled = false
        cellRegistration()
       // toLoadData()
    }
    
    func hideLocationSection() {
        if reportModel?.intime == "" &&  reportModel?.outtime == "" &&  reportModel?.inaddress == "" && reportModel?.outaddress == "" {
            isTohideLocationInfo = true
        }
    }
    
    func toSetDataSourceForProducts() {
        productStrArr.removeAll()
        productStrArr.append("This is Title String")
        productStrArr.append(contentsOf: detailedReportModel?.products.components(separatedBy: ",") ?? [])
        if productStrArr.last ==  "  )" {
            productStrArr.removeLast()
        }
        
         
    }
    
    func toLoadData() {
        extendedInfoCollection.delegate = self
        extendedInfoCollection.dataSource = self
        extendedInfoCollection.reloadData()
    }
    
    func cellRegistration() {
        
        extendedInfoCollection.register(UINib(nibName: "VisitInfoCVC", bundle: nil), forCellWithReuseIdentifier: "VisitInfoCVC")
        extendedInfoCollection.register(UINib(nibName: "TimeInfoCVC", bundle: nil), forCellWithReuseIdentifier: "TimeInfoCVC")
        extendedInfoCollection.register(UINib(nibName: "ProductSectionTitleCVC", bundle: nil), forCellWithReuseIdentifier: "ProductSectionTitleCVC")
        extendedInfoCollection.register(UINib(nibName: "rcpaCVC", bundle: nil), forCellWithReuseIdentifier: "rcpaCVC")
        extendedInfoCollection.register(UINib(nibName: "ReportsCVC", bundle: nil), forCellWithReuseIdentifier: "ReportsCVC")
        extendedInfoCollection.register(UINib(nibName: "ViewmoreCVC", bundle: nil), forCellWithReuseIdentifier: "ViewmoreCVC")
        
        extendedInfoCollection.register(UINib(nibName: "ProductsDescriptionCVC", bundle: nil), forCellWithReuseIdentifier: "ProductsDescriptionCVC")
        
        extendedInfoCollection.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.identifier)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
