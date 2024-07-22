//
//  DCRApprovalsTVC.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import UIKit

class DCRApprovalsTVC: UITableViewCell {

    @IBOutlet var contentHolderView: UIView!
    @IBOutlet var accessoryIV: UIImageView!
    @IBOutlet var mrNameLbl: UILabel!
    
    @IBOutlet var dateHolderView: UIView!
    @IBOutlet var approcalDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mrNameLbl.setFont(font: .bold(size: .BODY))
        approcalDateLbl.setFont(font: .medium(size: .BODY))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
