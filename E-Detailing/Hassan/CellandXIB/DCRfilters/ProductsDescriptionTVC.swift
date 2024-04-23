//
//  ProductsDescriptionTVC.swift
//  E-Detailing
//
//  Created by San eforce on 18/03/24.
//

import UIKit

class ProductsDescriptionTVC: UITableViewCell {

    @IBOutlet var rcpaLbl: UILabel!
    @IBOutlet var rxQTYlbl: UILabel!
    @IBOutlet var samplesLbl: UILabel!
    @IBOutlet var promoterLbl: UILabel!
    @IBOutlet var productLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func topopulateCell(modelStr: SampleProduct){
        //SECREMET 1 MG ( 0 ), )
//        let productDescArr = modelStr.components(separatedBy: " ")
//        self.productLbl.text = productDescArr[0]
//        self.promoterLbl.text = "Yes"
//        samplesLbl.text =
        
        self.productLbl.text = modelStr.prodName
        let tickIconString = "\u{2713}"
        print(tickIconString) // This will print: ✓
        if let promoted = modelStr.isPromoted {
            let promotedIcon =  promoted ? tickIconString : "x"
           // isPromoted = promotedIcon
            self.promoterLbl.text =  promotedIcon
            self.promoterLbl.textColor = promoted ? .appGreen : .appTextColor
        } else {
            self.promoterLbl.text = ""
        }
        self.samplesLbl.text = modelStr.noOfSamples == "" ? "-" :  String(modelStr.noOfSamples.dropLast())
        self.rxQTYlbl.text = modelStr.rxQTY == "" ? "-" :   String(modelStr.rxQTY.dropLast())
        self.rcpaLbl.text = modelStr.rcpa == "" ? "-" :  String(modelStr.rcpa.dropLast())
    }
    
}
