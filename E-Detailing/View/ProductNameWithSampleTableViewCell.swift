//
//  ProductNameWithSampleTableViewCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 28/10/23.
//

import Foundation
import UIKit


class ProductNameWithSampleTableViewCell : UITableViewCell {
    
    
    
    @IBOutlet weak var btnSelected: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblSample: UILabel!
    
    
    var product : Objects! {
        didSet {
            lblName.text = product.Object.name
            
            let productMode = product.Object.productMode ?? ""
            
            if ((productMode?.contains("sample")) != nil) && ((productMode?.contains("sale")) != nil) {
                lblSample.text = "SM/SL"
                lblSample.textColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(1.0))
                lblSample.backgroundColor = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.15))
            }else if ((productMode?.contains("sample")) != nil) {
                lblSample.text = "SM"
                lblSample.textColor = UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(1.0))
                lblSample.backgroundColor = UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(0.15))
                
            }else if ((productMode?.contains("sale")) != nil){
                lblSample.text = "SL"
                lblSample.textColor = UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(1.0))
                lblSample.backgroundColor = UIColor(red: CGFloat(61.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(244.0/255.0), alpha: CGFloat(0.15))
            }
            
            if product.priority != "" {
                lblSample.text = product.priority
                lblSample.textColor = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(1.0))
                lblSample.backgroundColor = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(137.0/255.0), alpha: CGFloat(0.15))
            }
            
            btnSelected.isSelected = product.isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

