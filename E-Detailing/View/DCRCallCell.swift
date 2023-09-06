//
//  DCRCallCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 31/07/23.
//

import UIKit



class DCRCallCell: UITableViewCell {
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProfile.Border_Radius(border_height: 0.0, isborder: false, radius: 24)
    }
}
