//
//  DoctorCallCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 07/08/23.
//

import UIKit


class DoctorCallCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSpecialty: UILabel!
    @IBOutlet weak var lblTownName: UILabel!
    
    
    var CallDetail : CallViewModel! {
        didSet{
            self.lblName.text = CallDetail.name
            self.lblTownName.text = CallDetail.townName
            self.lblCategory.text = CallDetail.categoryName
            self.lblSpecialty.text =  CallDetail.specialityName
            
            
//            if DCRType.doctor == CallDetail.type || DCRType.unlistedDoctor == CallDetail.type {
//                self.lblCategory.text = CallDetail.category
//                self.lblSpecialty.text =  CallDetail.speciality
//            }else {
//                self.lblCategory.text = ""
//                self.lblSpecialty.text = ""
//            }
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
