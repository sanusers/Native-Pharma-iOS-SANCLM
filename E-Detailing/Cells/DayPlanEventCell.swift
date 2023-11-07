//
//  DayPlanEventCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 31/07/23.
//

import UIKit


class DayPlanEventCell : UICollectionViewCell {
    
    
    
    @IBOutlet weak var lblEvent: UILabel!
    
    
    @IBOutlet weak var viewEvent: UIView!
    
    
    
    @IBOutlet weak var widthEventLblConstrainst: NSLayoutConstraint! {
        didSet {
            widthEventLblConstrainst.isActive = false
        }
    }
    
    
    
    var width1: CGFloat? = nil {
        didSet {
            guard width1 != nil else {
                
                widthEventLblConstrainst.isActive = true
                widthEventLblConstrainst.constant = width1!
                return
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
