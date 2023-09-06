//
//  ProductSampleTableViewCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 11/08/23.
//

import UIKit


class ProductSampleTableViewCell : UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    
    
    @IBOutlet weak var txtSampleQty: UITextField!
    @IBOutlet weak var txtRxQty: UITextField!
    @IBOutlet weak var txtRcpaQty: UITextField!
    
    
    @IBOutlet weak var btnDelete: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
