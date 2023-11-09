//
//  WorkPlansInfoCVC.swift
//  E-Detailing
//
//  Created by San eforce on 09/11/23.
//

import UIKit

class WorkPlansInfoCVC: UICollectionViewCell {

    @IBOutlet var plansIVHolder
    : UIView!
    @IBOutlet var plansIV: UIImageView!
    
    @IBOutlet var countsHolder: UIView!
    @IBOutlet var countsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plansIVHolder.layer.cornerRadius  =  plansIVHolder.height / 2
        countsHolder.layer.cornerRadius =  countsHolder.height / 2
      
        
    }

}
