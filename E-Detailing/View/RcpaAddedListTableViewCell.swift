//
//  RcpaAddedListTableViewCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 07/09/23.
//

import Foundation
import UIKit


class RcpaAddedListTableViewCell : UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
    
    
    @IBOutlet weak var viewCompetitorList: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
}
