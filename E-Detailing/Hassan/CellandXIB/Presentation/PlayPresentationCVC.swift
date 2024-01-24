//
//  PlayPresentationCVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import UIKit

class PlayPresentationCVC: UICollectionViewCell {
    @IBOutlet var holderIV: UIView!
    
    @IBOutlet var presentationIV: UIImageView!
    @IBOutlet var holderViewWidth: NSLayoutConstraint!
    @IBOutlet var holderViewHeight: NSLayoutConstraint!
    
//    var isCellSelected {
//        didSet {
//
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderIV.backgroundColor = .clear
    
        
    }
    

    

}
