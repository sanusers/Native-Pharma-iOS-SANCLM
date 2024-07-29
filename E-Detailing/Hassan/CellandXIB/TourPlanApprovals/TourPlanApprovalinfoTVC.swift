//
//  TourPlanApprovalinfoTVC.swift
//  SAN ZEN
//
//  Created by San eforce on 26/07/24.
//

import UIKit


class TourPlanApprovalinfoTVC: UITableViewCell {
    
    @IBOutlet var mrNameLbl: UILabel!
    @IBOutlet var tourPlannedforLbl: UILabel!
    @IBOutlet var totalPlannedDaysLbl: UILabel!
    @IBOutlet var weeklyoffDaysLbl: UILabel!
   // var detailsmodel:  [ApprovalDetailsModel]?
   // var listModel: ApprovalsListModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // setupUI()
      //  cellRegistration()
        
    }
    func toPopulatecell(model: [TourPlanApprovalDetailModel], list: TourPlanApprovalModel) {
        mrNameLbl.text = list.sfName
        tourPlannedforLbl.text = "\(list.mnth) \(list.yr)"
        totalPlannedDaysLbl.text = "\(model.count)"
        weeklyoffDaysLbl.text = "\(model.filter { $0.fwFlg == "W" }.count)" 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
