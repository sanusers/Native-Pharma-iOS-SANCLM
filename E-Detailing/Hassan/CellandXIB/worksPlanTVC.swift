//
//  worksPlanTVC.swift
//  E-Detailing
//
//  Created by San eforce on 09/11/23.
//

import UIKit

extension worksPlanTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WorkPlansInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkPlansInfoCVC", for: indexPath) as! WorkPlansInfoCVC
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 5, height: 100)
    }
    
    
}

class worksPlanTVC: UITableViewCell {

    @IBOutlet var overallContentsHolderView: UIView!
    
    @IBOutlet var dateLbl: UILabel!
    
    @IBOutlet var optionsIV: UIImageView!
    
    @IBOutlet var workTitLbl: UILabel!
    
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var workPlansInfoCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5
        self.overallContentsHolderView.elevate(2)
        self.overallContentsHolderView.layer.cornerRadius = 5
        if let layout = self.workPlansInfoCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.collectionView?.isScrollEnabled = false
        }
        cellRegistration()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellRegistration() {
        workPlansInfoCollection.register(UINib(nibName: "WorkPlansInfoCVC", bundle: nil), forCellWithReuseIdentifier: "WorkPlansInfoCVC")
    }
    
    func toLOadData() {
        workPlansInfoCollection.delegate = self
        workPlansInfoCollection.dataSource = self
        workPlansInfoCollection.reloadData()
    }
    
}
