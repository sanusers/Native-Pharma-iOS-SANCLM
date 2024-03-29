//
//  RcpaAddedListTableViewCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 07/09/23.
//

import Foundation
import UIKit


class RcpaAddedListTableViewCell : UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet var lblValue: UILabel!
    
    @IBOutlet weak var btnDelete: UIButton!

    
    @IBOutlet var viewQtyHolder: UIView!
    @IBOutlet var viewRateHolder: UIView!
    
    @IBOutlet var viewTotalHolder: UIView!
    
    @IBOutlet var viewValueHolder: UIView!

    
    
    var rcpaProduct : RCPAdetailsModal! {

        didSet {
          //  self.lblName.text = self.rcpaProduct.addedProduct?.name ?? ""
//            self.lblQty.text = self.rcpaProduct.addedQuantity
//            self.lblRate.text = self.rcpaProduct.addedRate ?? ""
//            self.lblValue.text = self.rcpaProduct.addedValue ?? ""
//            self.lblTotal.text = self.rcpaProduct.totalValue ?? ""
            

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnDelete.setTitle("", for: .normal)
        viewQtyHolder.layer.cornerRadius = 3
        viewRateHolder.layer.cornerRadius = 3
        viewTotalHolder.layer.cornerRadius = 3
        viewValueHolder.layer.cornerRadius = 3
        
        viewRateHolder.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        viewValueHolder.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        viewTotalHolder.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        viewQtyHolder.layer.borderWidth = 1
        viewQtyHolder.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.1).cgColor
//        self.viewCompetitorList.layer.cornerRadius = 5
//        self.viewCompetitorList.layer.borderWidth = 1
//        self.viewCompetitorList.layer.borderColor = AppColors.primaryColorWith_10per_alpha.cgColor
        
    }
    
}
