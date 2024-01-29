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
        presentationIV.contentMode = .scaleAspectFit
        if let image = UIImage(data: model.slideData) {
            // The downloaded data represents an image
            presentationIV.image = image
            print("Downloaded data is an image.")
        } else {
            // The downloaded data is not an image
            print("Downloaded data is of an unknown type.")
        }
    }
    
    
    


}
