//
//  AdditionalCallSampleEntryTableViewCell.swift
//  E-Detailing
//
//  Created by San eforce on 22/03/24.
//

import UIKit

class AdditionalCallSampleEntryTableViewCell : UITableViewCell {
    
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var txtAvailableStock: UITextField!
    @IBOutlet weak var txtSampleStock: UITextField!
    
    @IBOutlet weak var btnProduct: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var viewProduct: UIView!
    
    
    var product : ProductViewModel! {
        didSet {
            self.lblName.text = product.name
            self.txtAvailableStock.text = product.availableCount
            self.txtSampleStock.text = product.sampleCount
        }
    }
    
    var input : InputViewModel!{
        didSet {
            self.lblName.text = input.name
            self.txtAvailableStock.text = input.input.availableCount
            self.txtSampleStock.text = input.inputCount
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtSampleStock.layer.cornerRadius = 5
        txtSampleStock.layer.borderColor = AppColors.primaryColorWith_40per_alpha.cgColor
        txtSampleStock.layer.borderWidth = 1
        
        txtAvailableStock.layer.cornerRadius = 5
        txtAvailableStock.layer.borderColor = AppColors.primaryColorWith_40per_alpha.cgColor
        txtAvailableStock.layer.borderWidth = 1
        
        viewProduct.layer.cornerRadius = 5
        viewProduct.layer.borderColor = AppColors.primaryColorWith_40per_alpha.cgColor
        viewProduct.layer.borderWidth = 1.5
    }
}
