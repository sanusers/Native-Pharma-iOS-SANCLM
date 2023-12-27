//
//  ProductSectionTitleCVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/12/23.
//

import UIKit

class ProductSectionTitleCVC: UICollectionViewCell {

    
    @IBOutlet var holderVoew: UIView!
    
    @IBOutlet var rcpaLbl: UILabel!
    @IBOutlet var rxQTYlbl: UILabel!
    @IBOutlet var samplesLbl: UILabel!
    @IBOutlet var promoterLbl: UILabel!
    @IBOutlet var productLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let titleLbls : [UILabel] = [rcpaLbl, rxQTYlbl, samplesLbl, promoterLbl, productLbl]
        
        titleLbls.forEach { label in
            label.textColor = .appTextColor
            label.setFont(font: .bold(size: .BODY))
        }
        holderVoew.setSpecificCornersForTop(cornerRadius: 5)
    }

}
