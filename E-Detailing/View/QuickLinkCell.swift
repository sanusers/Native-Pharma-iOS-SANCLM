//
//  QuickLinkCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 22/07/23.
//

import UIKit



class QuickLinkCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var viewCell: UIView!
    
    
    var link : QuicKLink!{
        didSet{
            self.imgLogo.image = link.image
            self.lblName.text = link.name
            self.viewCell.backgroundColor = link.color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
