//
//  VisitInfoTVC.swift
//  E-Detailing
//
//  Created by San eforce on 21/12/23.
//

import UIKit

class VisitInfoTVC: UITableViewCell {
    
    @IBOutlet var elevationView: UIView!
    
    @IBOutlet var visitTime: UILabel!
    
    @IBOutlet var visitTimeDesc: UILabel!
    
    
    @IBOutlet var cluster: UILabel!
    
    @IBOutlet var clusterDesc: UILabel!
    
    
    @IBOutlet var pobLbl: UILabel!
    
    @IBOutlet var feedBack: UILabel!
    
    @IBOutlet var jointWork: UILabel!
    
    @IBOutlet var remarks: UILabel!
    
    
    
    @IBOutlet var pobDesc: UILabel!
    
    
    @IBOutlet var modifiedTime: UILabel!
    
    @IBOutlet var modifiedTimeDesc: UILabel!
    
    @IBOutlet var feedBaxkDesc: UILabel!
    
    
    @IBOutlet var viewMoreDesc: UILabel!
    
    
    @IBOutlet var userTitle: UILabel!
    
    @IBOutlet var userTypeIV: UIImageView!
    
    @IBOutlet var topSeperator: UIView!
    
    @IBOutlet var seperatorView: UIView!
    
    @IBOutlet var holderStach: UIStackView!
    @IBOutlet var bottomSeperator: UIView!
    
    @IBOutlet var remarksSeperator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        
        let seperators: [UIView] = [remarksSeperator, bottomSeperator, seperatorView, topSeperator]
        seperators.forEach { aView in
            aView.backgroundColor = .appSelectionColor
        }
    
        
        let titleLbl : [UILabel] =  [visitTime, modifiedTime, cluster, pobLbl, feedBack, jointWork, remarks]
        
        
        titleLbl.forEach { lbl in
   
                lbl.setFont(font: .medium(size: .BODY))
                lbl.textColor = .appLightTextColor
            
            
          
        }
        
        let descLbl : [UILabel] =   [visitTimeDesc, modifiedTimeDesc, clusterDesc, pobDesc, feedBaxkDesc, viewMoreDesc, userTitle]
        descLbl.forEach { lbl in
            lbl.setFont(font: .bold(size: .BODY))
            lbl.textColor = .appTextColor
        }

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override class func awakeFromNib() {
       
        
    }
    
}
func applyCornerRadiusAndElevation(to view: UIView, cornerRadius: CGFloat, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
    // Apply corner radius
    view.layer.cornerRadius = cornerRadius
    view.layer.masksToBounds = true
    
    // Apply elevation (shadow)
    view.layer.shadowColor = shadowColor.cgColor
    view.layer.shadowOffset = shadowOffset
    view.layer.shadowOpacity = shadowOpacity
    view.layer.shadowRadius = shadowRadius
    view.layer.shouldRasterize = true
    view.layer.rasterizationScale = UIScreen.main.scale
}
