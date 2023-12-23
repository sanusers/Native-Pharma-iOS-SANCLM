//
//  ViewAllInfoTVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/12/23.
//

import UIKit

extension ViewAllInfoTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {

        case 2:
            return 3
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.width, height: 200)
            
            
        case 1:
            return CGSize(width: collectionView.width, height: 100)
      
        case 2:
            return CGSize(width: collectionView.width, height: 30)
            
        case 3:
            return CGSize(width: collectionView.width, height: 50)
        case 4:
            return CGSize(width: collectionView.width, height: 75)
        case 5:
            return CGSize(width: collectionView.width, height: 50)
        default:
            return CGSize()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: VisitInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "VisitInfoCVC", for: indexPath) as! VisitInfoCVC
            return cell
            
        case 1:
            let cell: TimeInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeInfoCVC", for: indexPath) as! TimeInfoCVC
            return cell
        case 2:
            
       
            switch indexPath.row {
            case 0:
                let cell: ProductSectionTitleCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSectionTitleCVC", for: indexPath) as! ProductSectionTitleCVC
                cell.holderVoew.backgroundColor = .appGreyColor
                return cell
            default:
                let cell: ProductsDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsDescriptionCVC", for: indexPath) as! ProductsDescriptionCVC
                return cell
            }
       
            
            
            
        case 3:
            let cell: rcpaCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "rcpaCVC", for: indexPath) as! rcpaCVC
            return cell
        case 4:
            let cell: ReportsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportsCVC", for: indexPath) as! ReportsCVC
            return cell
        case 5:
            let cell: ViewmoreCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewmoreCVC", for: indexPath) as! ViewmoreCVC
            cell.addTap {
                self.delegate?.didLessTapped()
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

protocol ViewAllInfoTVCDelegate: AnyObject {
    func didLessTapped()
        
    
}

class ViewAllInfoTVC: UITableViewCell {

    @IBOutlet var extendedInfoCollection: UICollectionView!
    weak var delegate: ViewAllInfoTVCDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        extendedInfoCollection.isScrollEnabled = false
        cellRegistration()
        toLoadData()
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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
