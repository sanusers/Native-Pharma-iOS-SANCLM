//
//  MasterSyncTbCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 28/06/23.
//

import UIKit



class MasterSyncTbCell : UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    
    
    @IBOutlet weak var btnArrow: UIButton!
    
    @IBOutlet weak var btnSyncAll: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.setFont(font: .bold(size: .BODY))
        btnSyncAll.layer.cornerRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
