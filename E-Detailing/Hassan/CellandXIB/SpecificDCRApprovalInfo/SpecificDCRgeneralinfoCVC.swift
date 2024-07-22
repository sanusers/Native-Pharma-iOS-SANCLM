//
//  SpecificDCRgeneralinfoCVC.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import UIKit

class SpecificDCRgeneralinfoCVC: UICollectionViewCell {
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
    
    @IBOutlet var bottomSeperator: UIView!
    
    
    @IBOutlet var topSeperator: UIView!
    
    @IBOutlet var cellSeperatorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func toPopulateCell(model: DetailedReportsModel) {
        // self.userTypeIV.image = UIImage(named: "")
         self.typeName.text = model.name
         self.visitTimeDesc.text = model.visitTime == "" ? "-" :  model.visitTime

        
        
         self.modifiedTimeDesc.text = model.modTime == "" ? "-" :  model.modTime
   
        
         self.clusterDesc.text = model.territory == "" ? "-" : model.territory

         self.pobDesc.text = model.pobValue == 0 ? "-" : "\(model.pobValue)"
        
         self.jointWorkDesc.text = model.wWith == "" ? "-" : model.wWith
       
        
    }

    func setupUI() {
        let seperators: [UIView] = [ bottomSeperator, topSeperator, cellSeperatorView]
        seperators.forEach { aView in
            aView.backgroundColor = .appSelectionColor
        }
        
        
        let titleLbl : [UILabel] =  [visitTime, modifiedTime, cluster, pobLbl,  jointWork]
        
        
        titleLbl.forEach { lbl in

                lbl.setFont(font: .medium(size: .BODY))
      
                lbl.textColor = .appLightTextColor
            
               
            
            
          
        }
        
        let descLbl : [UILabel] =   [visitTimeDesc, modifiedTimeDesc, clusterDesc, pobDesc, typeName,  jointWorkDesc]
        descLbl.forEach { lbl in
            lbl.setFont(font: .bold(size: .BODY))
            lbl.textColor = .appTextColor
        }
        
    }
    
    
    

    

}
