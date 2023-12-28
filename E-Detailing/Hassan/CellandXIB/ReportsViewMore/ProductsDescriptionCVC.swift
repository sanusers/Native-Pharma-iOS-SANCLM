//
//  ProductsDescriptionCVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/12/23.
//

import UIKit

class ProductsDescriptionCVC: UICollectionViewCell {

    @IBOutlet var seperatorView: UIView!
    @IBOutlet var holderVoew: UIStackView!
    
    @IBOutlet var rcpaLbl: UILabel!
    @IBOutlet var rxQTYlbl: UILabel!
    @IBOutlet var samplesLbl: UILabel!
    @IBOutlet var promoterLbl: UILabel!
    @IBOutlet var productLbl: UILabel!
    var productsArr : [String] = []
    
    func topopulateCell(modelStr: String){
        //SECREMET 1 MG ( 0 ), )
//        let productDescArr = modelStr.components(separatedBy: " ")
//        self.productLbl.text = productDescArr[0]
//        self.promoterLbl.text = "Yes"
//        samplesLbl.text = 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let titleLbls : [UILabel] = [rcpaLbl, rxQTYlbl, samplesLbl, promoterLbl, productLbl]
        
        titleLbls.forEach { label in
            label.textColor = .appTextColor
            label.setFont(font: .medium(size: .BODY))
        }
        
        seperatorView.backgroundColor = .appSelectionColor
    }

}
