//
//  WTsheetTVC.swift
//  E-Detailing
//
//  Created by San eforce on 21/12/23.
//

import UIKit

class WTsheetCVC: UICollectionViewCell {

    @IBOutlet var HQ: UILabel!
    @IBOutlet var cluster: UILabel!
    @IBOutlet var workType: UILabel!
    
    @IBOutlet var clusterDesc: UILabel!
    
    @IBOutlet var workTypeDesc: UILabel!
    @IBOutlet var HQdesc: UILabel!
    @IBOutlet var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    func setupUI() {
        seperatorView.backgroundColor = .appSelectionColor
        
        let titleLbl : [UILabel] = [HQ, cluster, workType ]
        titleLbl.forEach { lbl in
            lbl.setFont(font: .medium(size: .BODY))
            lbl.textColor = .appLightTextColor
        }
        
        
        let descLbl : [UILabel] = [HQdesc, workTypeDesc, clusterDesc]
        
        descLbl.forEach { lbl in
            lbl.setFont(font: .bold(size: .BODY))
            lbl.textColor = .appTextColor
        }
    }
    
}
