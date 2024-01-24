//
//  SelectPresentationCVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import UIKit

class SelectPresentationCVC: UICollectionViewCell {

    @IBOutlet var selectionImage: UIImageView!
    @IBOutlet var selectionView: UIView!
    @IBOutlet var presentationIV: UIImageView!
    @IBOutlet var contentsHolderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentsHolderView.layer.cornerRadius = 5
        contentsHolderView.layer.borderColor = UIColor.appLightTextColor.cgColor
        contentsHolderView.layer.borderWidth = 1
        selectionView.layer.cornerRadius = selectionView.height / 2
        selectionView.backgroundColor = .appWhiteColor
        selectionImage.tintColor = .appGreen
        selectionImage.image = UIImage(systemName: "checkmark.circle.fill")
        
    }

}
