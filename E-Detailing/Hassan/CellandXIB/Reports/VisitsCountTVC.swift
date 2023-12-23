//
//  VisitsCountTVC.swift
//  E-Detailing
//
//  Created by San eforce on 22/12/23.
//

import UIKit

extension VisitsCountTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: VisitsCountCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "VisitsCountCVC", for: indexPath) as! VisitsCountCVC
        let model = self.type[indexPath.row]
        cell.type = model
        cell.toPopulatecell()
        cell.holderView.layer.borderWidth = 0
        if indexPath.row == 0 {
            cell.holderView.layer.borderColor = model.coclor.cgColor
            cell.holderView.layer.borderWidth = 1
        }
//        if cell.selectedIndex == indexPath.row {
//            cell.holderView.layer.borderColor = model.coclor.cgColor
//            cell.holderView.layer.borderWidth = 1
//        } else {
//            cell.holderView.layer.borderColor = UIColor.clear.cgColor
//            cell.holderView.layer.borderWidth = 0
//        }
        
       // cell.addTap {
          //  cell.selectedIndex = indexPath.row
         //   self.toloadData()
     //   }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 8, height: collectionView.height)
    }
    
    
}

class VisitsCountTVC: UITableViewCell {
    
    
    

    @IBOutlet var visitTypesCVC: UICollectionView!
    
    var type: [CellType] = [.All, .Doctor, .Chemist, .Stockist, .Hospital]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellRegistration()
        toloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellRegistration() {
        
        if let layout = self.visitTypesCVC.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.collectionView?.isScrollEnabled = false
        }
        
        visitTypesCVC.register(UINib(nibName: "VisitsCountCVC", bundle: nil), forCellWithReuseIdentifier: "VisitsCountCVC")
    }
    
    func toloadData() {
        visitTypesCVC.delegate = self
        visitTypesCVC.dataSource = self
        visitTypesCVC.reloadData()
    }
    
}
