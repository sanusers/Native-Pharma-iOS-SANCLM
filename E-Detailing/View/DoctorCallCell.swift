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
    
    
    @IBOutlet weak var btnTownName: UIButton!
    
    
    var CallDetail : CallViewModel! {
        didSet{
            self.lblName.text = CallDetail.name
            self.lblTownName.text = CallDetail.townName
            self.lblCategory.text = CallDetail.categoryName
            self.lblSpecialty.text =  CallDetail.specialityName
            
            
            self.btnTownName.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            
            self.btnTownName.setTitle(CallDetail.townName, for: .normal)
            
            self.btnTownName.backgroundColor = UIColor(red: CGFloat(241.0/255.0), green: CGFloat(83.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(0.2))
            
            
            
            
            
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
