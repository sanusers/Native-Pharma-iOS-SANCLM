//
//  ReportTypesCVC.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 20/12/23.
//

import UIKit

class ReportTypesCVC: UICollectionViewCell {
    
    @IBOutlet var elevateView: UIView!
    @IBOutlet var reportTypeIV: UIImageView!
    
    
    @IBOutlet var reportTypeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        elevateView.elevate(2)
        elevateView.layer.cornerRadius = 5
        elevateView.backgroundColor = .appWhiteColor
        reportTypeLbl.setFont(font: .bold(size: .BODY))
        // Initialization code
    }

}
