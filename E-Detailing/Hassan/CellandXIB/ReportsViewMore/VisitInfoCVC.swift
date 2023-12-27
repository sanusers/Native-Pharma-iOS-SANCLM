//
//  VisitInfoCVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/12/23.
//

import UIKit

class VisitInfoCVC: UICollectionViewCell {
    @IBOutlet var typeIV: UIImageView!
    
    @IBOutlet var typeName: UILabel!
    
    @IBOutlet var visitTime: UILabel!
    
    @IBOutlet var visitTimeDesc: UILabel!
    
    @IBOutlet var cluster: UILabel!
    
    @IBOutlet var clusterDesc: UILabel!
    
    @IBOutlet var modifiedTime: UILabel!
    
    @IBOutlet var modifiedTimeDesc: UILabel!
    
    @IBOutlet var pobLbl: UILabel!
    
    @IBOutlet var pobDesc: UILabel!
    
    @IBOutlet var jointWork: UILabel!
    
    
    @IBOutlet var jointWorkDesc: UILabel!
    
    @IBOutlet var feedBack: UILabel!
    
    @IBOutlet var feedBaxkDesc: UILabel!
    
    @IBOutlet var remarks: UILabel!
    
    @IBOutlet var remarksDesc: UILabel!
    
    
    @IBOutlet var bottomSeperator: UIView!
    
    @IBOutlet var remarksSeperator: UIView!
    
    @IBOutlet var topSeperator: UIView!
    
    @IBOutlet var cellSeperatorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    func setupUI() {
        let seperators: [UIView] = [remarksSeperator, bottomSeperator, topSeperator, cellSeperatorView]
        seperators.forEach { aView in
            aView.backgroundColor = .appSelectionColor
        }
        
        
        let titleLbl : [UILabel] =  [visitTime, modifiedTime, cluster, pobLbl, feedBack, jointWork, remarks]
        
        
        titleLbl.forEach { lbl in

                lbl.setFont(font: .medium(size: .BODY))
      
                lbl.textColor = .appLightTextColor
            
               
            
            
          
        }
        
        let descLbl : [UILabel] =   [visitTimeDesc, modifiedTimeDesc, clusterDesc, pobDesc, feedBaxkDesc, typeName,  jointWorkDesc, remarksDesc]
        descLbl.forEach { lbl in
            lbl.setFont(font: .bold(size: .BODY))
            lbl.textColor = .appTextColor
        }
        
    }
    
    
    

    
    
}
