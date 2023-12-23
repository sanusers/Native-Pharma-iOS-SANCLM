//
//  rcpaCVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/12/23.
//

import UIKit

class rcpaCVC: UICollectionViewCell {
    
    @IBOutlet var elevationView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        elevationView.elevate(2)
        elevationView.layer.cornerRadius = 5
    }

}
