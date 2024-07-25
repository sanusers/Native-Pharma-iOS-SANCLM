//
//  LeaveApprovalTVC.swift
//  SAN ZEN
//
//  Created by San eforce on 24/07/24.
//

import UIKit

class LeaveApprovalTVC: UITableViewCell {
    @IBOutlet var contentHolderView: UIView!
    @IBOutlet var empCodeTitle: UILabel!
    
    @IBOutlet var approveView: UIView!
    @IBOutlet var rejectView: UIView!
    @IBOutlet var reasonDesc: UILabel!
    @IBOutlet var reasonTitle: UILabel!
    @IBOutlet var addressonDesc: UILabel!
    @IBOutlet var addressonTitle: UILabel!
    @IBOutlet var noofDaysDesc: UILabel!
    @IBOutlet var noofDaysTitle: UILabel!
    @IBOutlet var toDesc: UILabel!
    @IBOutlet var toTitle: UILabel!
    @IBOutlet var fromDesc: UILabel!
    @IBOutlet var fromTitlr: UILabel!
    @IBOutlet var leaveTypeDesc: UILabel!
    @IBOutlet var leaveTypeTitle: UILabel!
    @IBOutlet var empCodeDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        contentHolderView.layer.cornerRadius = 5
        contentHolderView.elevate(2)
        approveView.layer.cornerRadius = 5
        rejectView.layer.cornerRadius = 5
        approveView.backgroundColor = .appGreen
        rejectView.backgroundColor = .appLightPink
        [toTitle, fromTitlr, empCodeTitle, leaveTypeTitle, noofDaysTitle, addressonTitle, reasonTitle].forEach { label in
            label?.setFont(font: .medium(size: .BODY))
            label?.textColor = .appLightTextColor
        }
        
        [toDesc, fromDesc, empCodeDesc, leaveTypeDesc, noofDaysDesc, addressonDesc, reasonDesc].forEach { label in
            label?.setFont(font: .bold(size: .BODY))
            label?.textColor = .appTextColor
        }
        
        
        
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
