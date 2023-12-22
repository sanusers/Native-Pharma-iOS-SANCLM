//
//  VisitsCountCVC.swift
//  E-Detailing
//
//  Created by San eforce on 22/12/23.
//

import UIKit

class VisitsCountCVC: UICollectionViewCell {

    @IBOutlet var visualBlurView: UIVisualEffectView!
    
    @IBOutlet var holderView: UIView!
    
    @IBOutlet var typesLbl: UILabel!
    @IBOutlet var countsLbl: UILabel!
    @IBOutlet var contsView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func toPopulatecell() {
        holderView.layer.cornerRadius = 2
        contsView.layer.cornerRadius = contsView.height / 2
        countsLbl.setFont(font: .medium(size: .BODY))
        typesLbl.setFont(font: .medium(size: .BODY))
    }

}
