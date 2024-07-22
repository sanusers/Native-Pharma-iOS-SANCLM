//
//  DCRApprovalsWorkTypeTVC.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import UIKit

extension DCRApprovalsWorkTypeTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      //  let count = self.wtModel?.wtype
        
//        if self.wtModel?.halfDayFWType != "" {
//            return 2
//        } else {
//            return 1
//        }
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DCRApprovalsWorkSheetsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "DCRApprovalsWorkSheetsCVC", for: indexPath) as! DCRApprovalsWorkSheetsCVC
       
        
//        if self.wtModel?.halfDayFWType != "" {
//            if indexPath.row == 1 {
//                cell.isLastElement = true
//            } else {
//                cell.isLastElement = false
//            }
//        } else {
//            cell.isLastElement = true
//        }
//        cell.populateCell(model: self.wtModel ?? ReportsModel())

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: 80)
    }
    

    
}

class DCRApprovalsWorkTypeTVC: UITableViewCell {
    @IBOutlet var tableHolderView: UIView!
    
    @IBOutlet var worktypeCollection: UICollectionView!
    
    @IBOutlet var mrNameLbl: UILabel!
    @IBOutlet var submittedDateLbl: UILabel!
    @IBOutlet var activityDateLbl: UILabel!
    
    var wtModel:  ReportsModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        cellRegistration()
        
    }
    
    func setupUI() {
        worktypeCollection.isScrollEnabled = false
        tableHolderView.layer.cornerRadius = 5
        tableHolderView.layer.borderWidth = 1
        tableHolderView.layer.borderColor = UIColor.appGreyColor.cgColor

    }
    
    func toloadData() {
        worktypeCollection.delegate = self
        worktypeCollection.dataSource = self
        worktypeCollection.reloadData()
    }
    func cellRegistration() {
        worktypeCollection.register(UINib(nibName: "DCRApprovalsWorkSheetsCVC", bundle: nil), forCellWithReuseIdentifier: "DCRApprovalsWorkSheetsCVC")
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

