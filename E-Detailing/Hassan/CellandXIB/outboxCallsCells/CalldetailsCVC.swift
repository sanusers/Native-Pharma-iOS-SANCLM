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

}
