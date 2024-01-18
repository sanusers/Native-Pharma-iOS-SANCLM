//
//  outboxCollapseTVC.swift
//  E-Detailing
//
//  Created by San eforce on 18/01/24.
//

import UIKit



class outboxCollapseTVC: UITableViewHeaderFooterView {

    @IBOutlet var headerRefreshView: UIView!
    @IBOutlet var seperatorView: UIView!
    @IBOutlet var collapseIV: UIImageView!
    @IBOutlet var syncIV: UIImageView!
    @IBOutlet var vxView: UIVisualEffectView!
    @IBOutlet var dateLbl: UILabel!
     var delegate:  CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        headerRefreshView.layer.cornerRadius = 3
        seperatorView.backgroundColor = .appLightTextColor
        self.collapseIV.addTap {
            self.delegate?.toggleSection(self, section: self.section)
        }
        
        // Initialization code
        dateLbl.setFont(font: .bold(size: .BODY))
        dateLbl.textColor = .appTextColor
        vxView.backgroundColor = .appLightPink
//        if #available(iOS 13.0, *) {
//            collapseIV.image = UIImage(systemName: "chevron.down")
//            syncIV.image = UIImage(named: "arrow.triangle.2.circlepath")
//            syncIV.tintColor = .appLightPink
//        } else {
//            // Fallback on earlier versions
//            collapseIV.image = UIImage(named: "arrowDown")
//            syncIV.image = UIImage(named: "white_refresh")
//
//        }
        
      
        
    }

    func populateCell() {
        
    }

    
}
