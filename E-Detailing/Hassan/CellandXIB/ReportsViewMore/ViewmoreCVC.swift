//
//  ViewmoreCVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/12/23.
//

import UIKit

class ViewmoreCVC: UICollectionViewCell {

    @IBOutlet var viewLessLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewLessLbl.textColor = .appTextColor
        viewLessLbl.setFont(font: .bold(size: .BODY))
    }

}
