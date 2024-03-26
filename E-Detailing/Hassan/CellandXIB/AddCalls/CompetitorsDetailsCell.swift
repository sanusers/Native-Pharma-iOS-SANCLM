//
//  CompetitorsDetailsCell.swift
//  E-Detailing
//
//  Created by San eforce on 26/03/24.
//

import UIKit

class CompetitorsDetailsCell: UITableViewCell {
    

    
    @IBOutlet var compProductHolder: UIView!
    
    @IBOutlet var compProductLbl: UILabel!
    @IBOutlet var compCompanyLbl: UILabel!
    @IBOutlet var compCompanyHolder: UIView!
    @IBOutlet var valueHolder: UIView!
    
    @IBOutlet var valueLbl: UILabel!
    
    @IBOutlet var qtyHolde: UIView!
    
    @IBOutlet var qtyLbl: UILabel!
    @IBOutlet var rateLbl: UILabel!
    @IBOutlet var rateHolder: UIView!
    @IBOutlet var deleteHolder: UIView!
    @IBOutlet var commentsHolder: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let curvedViews : [UIView] = [    compCompanyHolder, compProductHolder, rateHolder, valueHolder]
        
        curvedViews.forEach {
            $0.layer.cornerRadius = 3
            $0.backgroundColor = .appLightTextColor.withAlphaComponent(0.1)
        }
        
        qtyHolde.layer.borderWidth = 1
        qtyHolde.layer.cornerRadius = 3
        qtyHolde.layer.borderColor = UIColor.appLightTextColor.withAlphaComponent(0.2).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
