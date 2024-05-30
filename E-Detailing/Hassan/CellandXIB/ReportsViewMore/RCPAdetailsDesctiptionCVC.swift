//
//  RCPAdetailsDesctiptionCVC.swift
//  E-Detailing
//
//  Created by San eforce on 30/05/24.
//

import UIKit

class RCPAdetailsDesctiptionCVC: UICollectionViewCell {

    @IBOutlet var productNameLbl: UILabel!
    
    @IBOutlet var productQtyLbl: UILabel!
    
    @IBOutlet var chemistNameLBl: UILabel!
    
    @IBOutlet var competitorNameLbl: UILabel!
    
    
    @IBOutlet var competitorProductNameLbl: UILabel!
    
    
    @IBOutlet var competitorProductQty: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let labels: [UILabel] = [productNameLbl, productQtyLbl, chemistNameLBl, competitorNameLbl, competitorProductNameLbl, competitorProductQty]
        labels.forEach { aLabel in
            aLabel.setFont(font: .medium(size: .BODY))
            aLabel.textColor = .appTextColor
        }
    }

}
