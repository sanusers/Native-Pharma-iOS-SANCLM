//
//  HomeSideMenuTVC.swift
//  E-Detailing
//
//  Created by San eforce on 11/01/24.
//

import UIKit

class HomeSideMenuTVC: UITableViewCell {

    @IBOutlet var sideMenuTitle: UILabel!
    @IBOutlet var sideMenuIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sideMenuTitle.setFont(font: .medium(size: .BODY))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell() {
        
    }
    
}
