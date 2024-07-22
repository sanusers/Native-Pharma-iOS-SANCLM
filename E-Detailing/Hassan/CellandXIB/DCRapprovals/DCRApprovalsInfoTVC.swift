//
//  DCRApprovalsInfoTVC.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import UIKit


protocol DCRApprovalsInfoTVCDelegate: AnyObject {
    
    func didDCRinfoTapped(index: Int )
    
}

class DCRApprovalsInfoTVC: UITableViewCell {

    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var shadowView: ShadowView!
    @IBOutlet var optionsBtn: UIButton!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet var timeLbl: UILabel!
    weak var delegate : DCRApprovalsInfoTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // shadowView.elevate(2)
       // shadowView.layer.cornerRadius = 5
        shadowView.backgroundColor = .appWhiteColor
        nameLbl.textColor = .appTextColor
        timeLbl.textColor = .appLightTextColor

        imgProfile.layer.cornerRadius =  imgProfile.height / 2
    }
    
    func populateDCRArroval() {
        
 
        
        nameLbl.setFont(font: .bold(size: .BODY))
        timeLbl.setFont(font: .medium(size: .SMALL))
        
        nameLbl.text =  "Ram kumar"
        timeLbl.text = "Nandhanam"
        
    }
    
    func topopulateCell(_ model: TodayCallsModel) {
        nameLbl.setFont(font: .medium(size: .BODY))
        timeLbl.setFont(font: .medium(size: .SMALL))
        
        nameLbl.text =  "\(model.name)(\(model.designation))"
        timeLbl.text = model.vstTime
        
        if model.custType == 1 {
            imgProfile.image = UIImage(named: "ListedDoctor")
        } else if model.custType == 2 {
            imgProfile.image = UIImage(named: "Chemist")
        } else if model.custType == 5 {
            imgProfile.image = UIImage(named: "cip")
        } else if model.custType == 4 {
            imgProfile.image = UIImage(named: "Doctor")
        } else if model.custType == 6 {
            imgProfile.image = UIImage(named: "hospital")
        } else if model.custType == 3 {
            imgProfile.image = UIImage(named: "Stockist")
        }
        
    }
    
}
