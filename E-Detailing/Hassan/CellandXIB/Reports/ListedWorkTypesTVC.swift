//
//  ListedWorkTypesTVC.swift
//  E-Detailing
//
//  Created by San eforce on 22/12/23.
//

import UIKit

extension ListedWorkTypesTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WTsheetCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "WTsheetCVC", for: indexPath) as! WTsheetCVC
        
        if indexPath.row == 3 {
            cell.seperatorView.isHidden = true
        } else {
            cell.seperatorView.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: 60)
    }
    

    
}

class ListedWorkTypesTVC: UITableViewCell {
    @IBOutlet var tableHolderView: UIView!
    
    @IBOutlet var worktypeCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        cellRegistration()
        toloadData()
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
        worktypeCollection.register(UINib(nibName: "WTsheetCVC", bundle: nil), forCellWithReuseIdentifier: "WTsheetCVC")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
