//
//  DCRfiltersView.swift
//  E-Detailing
//
//  Created by San eforce on 16/03/24.
//

import UIKit


protocol DCRfiltersViewDelegate: AnyObject {
    func isFiltersupdated(_ addedFiltercount: Int, isItemAdded: Bool)
}


extension DCRfiltersView: collectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.addedFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: addedFiltersCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "addedFiltersCVC", for: indexPath) as! addedFiltersCVC
        cell.filtersTit.text = self.addedFilters[indexPath.row].rawValue
      
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        if   self.addedFilters.count % 2 == 0 {
            height = collectionView.height  / 2
        } else {
       
            height = collectionView.height
        }
        
        return CGSize(width: collectionView.width / 2.1, height: height)
    }
    
}

class DCRfiltersView: UIView {
    
    
    func cellregistration() {
        if let layout = self.filtersCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.collectionView?.isScrollEnabled = true
        }
        filtersCollection.register(UINib(nibName: "addedFiltersCVC", bundle: nil), forCellWithReuseIdentifier: "addedFiltersCVC")
        
    }
    
    enum AddedFilters: String {
        case speciality
        case category
        case territory
        case dcrClass = "Class"
    }
    
    @IBOutlet var titleLbl: UILabel!
    

     @IBOutlet var closeIV: UIImageView!
    
    @IBOutlet var filtersView: UIView!
    
    @IBOutlet var filtersViewHeight: NSLayoutConstraint! // 130
    
    @IBOutlet var viewAddcontion: UIView!
    
    @IBOutlet var filtersCollection: UICollectionView!
    
    @IBOutlet var btnCLear: ShadowButton!
    
    @IBOutlet var btnApply: ShadowButton!
    
    @IBOutlet var removeFiltersIV: UIButton!
    
    //@IBOutlet var viewAddfiltersHeight: NSLayoutConstraint!
    
    @IBOutlet var filtersCollectionHeight: NSLayoutConstraint! // 60

    weak var delegate: DCRfiltersViewDelegate?
    weak var addedSubviewDelegate :  addedSubViewsDelegate?
    var addedFilters: [AddedFilters] = [.speciality, .category]
    
    
    func toLOadData() {
        filtersCollection.delegate = self
        filtersCollection.dataSource = self
        filtersCollection.reloadData()
    }
    
    func setupUI() {
        cellregistration()
        toLOadData()
        viewAddcontion.layer.borderWidth = 1
        viewAddcontion.layer.borderColor = UIColor.appGreen.cgColor
        viewAddcontion.layer.cornerRadius = 5
        removeFiltersIV.setTitle("", for: .normal)
        self.layer.cornerRadius = 5
        initTaps()
    }
    
    func initTaps() {
        viewAddcontion.addTap {
            if self.addedFilters.count == 4 {
                return
            }
            self.toAddorRemoveFilters(istoadd: true, index: self.addedFilters.count)
        }
        
        self.removeFiltersIV.addTap {
            if self.addedFilters.count == 2 {
                return
            }
            self.toAddorRemoveFilters(istoadd: false, index: self.addedFilters.count - 1)
        }
    }
    
    func toAddorRemoveFilters(istoadd: Bool, index: Int) {
        
        if istoadd {
            switch index {
            case 2:
                if !addedFilters.contains(.territory) {
                    addedFilters.append(.territory)
                    filtersCollectionHeight.constant = 60 + 60 + 10
                    filtersViewHeight.constant = 130 + 60 + 10
                }
            case 3:
        
                if !addedFilters.contains(.dcrClass) {
                    addedFilters.append(.dcrClass)
                    filtersCollectionHeight.constant = 60 + 60 + 10
                    filtersViewHeight.constant = 130 + 60 + 10
                }

            default:
                print("Yet to implement")
            }
            
            delegate?.isFiltersupdated(addedFilters.count, isItemAdded: istoadd)
            self.toLOadData()
        } else {
            
            switch index {
            case 2 :
                filtersCollectionHeight.constant = 60
                filtersViewHeight.constant = 130
            case 3:
                filtersCollectionHeight.constant = 60
                filtersViewHeight.constant = 130
            default:
//                filtersCollectionHeight.constant = 60
//                filtersViewHeight.constant = 130
                print("Yet to implement")
            }
            
            addedFilters.remove(at: index)
  
        delegate?.isFiltersupdated(addedFilters.count, isItemAdded: istoadd)
        self.toLOadData()
            self.filtersCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
}
