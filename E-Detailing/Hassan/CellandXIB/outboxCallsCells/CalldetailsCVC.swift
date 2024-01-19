//
//  CalldetailsCVC.swift
//  E-Detailing
//
//  Created by San eforce on 18/01/24.
//

import UIKit

class CalldetailsCVC: UICollectionViewCell {
    @IBOutlet var callSubDetailVIew: UIView!
    @IBOutlet var callSubdetailHeightConst: NSLayoutConstraint! //90
    
    @IBOutlet var optionsIV: UIImageView!
    @IBOutlet var optionsHolderView: UIView!
    @IBOutlet var callsDCR_IV: UIImageView!
    
    @IBOutlet var callDCRinfoLbl: UILabel!
    
    @IBOutlet var timeinfoLbl: UILabel!
    
    @IBOutlet var callStatusLbl: UILabel!
    
    @IBOutlet var callStatusVxVIew: UIVisualEffectView!
    
    
    @IBOutlet var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        callDCRinfoLbl.setFont(font: .medium(size: .BODY))
        callDCRinfoLbl.textColor = .appTextColor
        timeinfoLbl.setFont(font: .medium(size: .SMALL))
        timeinfoLbl.textColor = .appLightTextColor
        callStatusLbl.setFont(font: .medium(size: .BODY))
        statusView.layer.cornerRadius = 3
    }
    
    func topopulateCell(_ model: TodayCallsModel) {
        callDCRinfoLbl.text = "\(model.name)(\(model.designation))"
        timeinfoLbl.text = model.vstTime
        
        if model.designation == "Doctor" {
            callsDCR_IV.image = UIImage(named: "ListedDoctor")
        } else if model.designation == "Chemist" {
            callsDCR_IV.image = UIImage(named: "Chemist")
        } else if model.designation == "CIP" {
            callsDCR_IV.image = UIImage(named: "cip")
        } else if model.designation == "UnlistedDr." {
            callsDCR_IV.image = UIImage(named: "Doctor")
        } else if model.designation == "Hospital" {
            callsDCR_IV.image = UIImage(named: "hospital")
        } else if model.designation == "Stockist" {
            callsDCR_IV.image = UIImage(named: "Stockist")
        }
        
    }

}
