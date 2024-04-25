//
//  DetailedInfoTVC.swift
//  E-Detailing
//
//  Created by San eforce on 25/04/24.
//

import UIKit

class DetailedInfoTVC: UITableViewCell {
    @IBOutlet var brandName: UILabel!
    
    @IBOutlet var reviewLbl: UILabel!
    
    @IBOutlet var commentsIV: UIImageView!
    
    @IBOutlet var timeLine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
