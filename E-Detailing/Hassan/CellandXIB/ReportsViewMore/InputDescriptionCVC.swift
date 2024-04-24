//
//  InputDescriptionCVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/04/24.
//

import UIKit

class InputDescriptionCVC: UICollectionViewCell {

    @IBOutlet var inputName: UILabel!
    
    @IBOutlet var inputCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func topopulateCell(modelStr: SampleInput) {
        inputName.text = modelStr.prodName
        inputCount.text = modelStr.noOfSamples
    }

}
