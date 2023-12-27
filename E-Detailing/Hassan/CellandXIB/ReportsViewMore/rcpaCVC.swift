//
//  rcpaCVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/12/23.
//

import UIKit

class rcpaCVC: UICollectionViewCell {
    @IBOutlet var seperatorView: UIView!
    
    @IBOutlet var elevationView: UIView!
    
    @IBOutlet var lblRCPA: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblRCPA.textColor = .appTextColor
        lblRCPA.setFont(font: .medium(size: .BODY))
        elevationView.elevate(2)
        elevationView.layer.cornerRadius = 5
        seperatorView.backgroundColor = .appSelectionColor
    }

}
