//
//  DCRTaggingCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 26/08/23.
//

import Foundation
import UIKit



class DCRTaggingCell : UICollectionViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSpeciality: UILabel!
    @IBOutlet weak var lblCluster: UILabel!
    
    
    
    @IBOutlet weak var lblTagCount: UILabel!
    @IBOutlet weak var btnView: UIButton!
    
    
    var customer : CustomerViewModel! {
        didSet {
            self.lblName.text = customer.name
            self.lblCategory.text = customer.category
            self.lblSpeciality.text = customer.speciality
            self.lblCluster.text = customer.townName
            self.lblTagCount.text = (customer.geoCount) + "/" + (customer.maxCount)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
