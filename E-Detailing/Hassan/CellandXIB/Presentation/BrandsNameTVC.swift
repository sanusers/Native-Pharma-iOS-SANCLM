//
//  BrandsNameTVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import UIKit

class BrandsNameTVC: UITableViewCell {

    @IBOutlet var contentsHolderView: UIView!
    
    @IBOutlet var brandsTitle: UILabel!
    @IBOutlet var countsLbl: UILabel!
    @IBOutlet var countsVXVew: UIVisualEffectView!
    @IBOutlet var accessoryIV: UIImageView!
    @IBOutlet var countsHolderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentsHolderView.backgroundColor = .appWhiteColor
       
        contentsHolderView.layer.cornerRadius = 5
        countsHolderView.layer.cornerRadius = 3
        countsVXVew.backgroundColor = .appGreen
        countsLbl.textColor = .appGreen
        countsLbl.setFont(font: .bold(size: .SMALL))
        brandsTitle.textColor = .appTextColor
        brandsTitle.setFont(font: .bold(size: .BODY))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
