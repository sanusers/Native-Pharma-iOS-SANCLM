//
//  PlayLoadedPresentationCVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import UIKit

class PlayLoadedPresentationCVC: UICollectionViewCell {

    @IBOutlet var holderVIew: UIView!
    
    @IBOutlet var presentationIV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCell(model: SlidesModel) {

            let data =  model.slideData
            let utType = model.utType
            presentationIV.toSetImageFromData(utType: utType, data: data)
            presentationIV.contentMode = .scaleAspectFit

    }
    
}
