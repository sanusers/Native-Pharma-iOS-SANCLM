//
//  MasterSyncCell.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 03/06/23.
//

import UIKit


class MasterSyncCell : UICollectionViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnSync: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.setFont(font: .bold(size: .BODY))
        lblName.textColor = .appTextColor
        
        lblCount.setFont(font: .bold(size: .BODY))
        lblCount.textColor = .appLightTextColor
        
        
        btnSync.backgroundColor = .appTextColor
    }
    
}
