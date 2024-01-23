//
//  CreatedPresentationCVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/01/24.
//

import UIKit

class CreatedPresentationCVC: UICollectionViewCell {

    @IBOutlet var holderView: UIView!
    
    @IBOutlet var optionsHolderView: UIView!
    @IBOutlet var slideDescriptionLbl: UILabel!
    @IBOutlet var slideTitleLbl: UILabel!
    @IBOutlet var presentationIV: UIImageView!
    
    @IBOutlet var bottomContentsHolder: UIView!
    @IBOutlet var optionsIV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        holderView.backgroundColor = .appWhiteColor
        bottomContentsHolder.backgroundColor = .appTextColor
        holderView.layer.cornerRadius = 5
        bottomContentsHolder.backgroundColor = .appTextColor
        slideTitleLbl.setFont(font: .bold(size: .BODY))
        slideTitleLbl.textColor = .appWhiteColor
        slideDescriptionLbl.setFont(font: .medium(size: .SMALL))
        slideDescriptionLbl.textColor = .appWhiteColor
        optionsIV.transform =  optionsIV.transform.rotated(by: .pi  * 1.5)
        optionsIV.tintColor = .appWhiteColor
    }

}
