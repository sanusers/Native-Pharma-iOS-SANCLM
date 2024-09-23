//
//  ProductsInfoHeader.swift
//  SAN ZEN
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 19/03/24.
//

import UIKit
import Foundation
class ProductsInfoHeader: UITableViewHeaderFooterView {
    let appSetup = AppDefaults.shared.getAppSetUp()
    @IBOutlet var productNameLbl: UILabel!
    @IBOutlet var lblSample: UILabel!
    @IBOutlet var lblRCPA: UILabel!
    @IBOutlet var lblRxQty: UILabel!
    
    var call: AnyObject! {
        didSet {
            switch call {
            case is DoctorFencing:
                productNameLbl.text =  appSetup.docProductCaption ?? "Products"
                lblRxQty.text = appSetup.docRxQCap
                lblSample.text = appSetup.docSampleQCap

                lblRxQty.isHidden = isDoctorProductRXneeded ? false : true
                lblRCPA.isHidden =  isDoctorRCPAneeded ? false : true
                lblSample.isHidden = isDoctorProductSampleNeeded ? false : true
            case is Chemist:
                productNameLbl.text =  appSetup.chmProductCaption ?? "Products"
                lblRxQty.text = appSetup.chmQcap ?? "Rx Qty"
                lblSample.text = appSetup.chmSampleCap ?? "Sample"
                
                
                lblRxQty.isHidden = isChemistProductRXneeded ? false : true
                lblRCPA.isHidden =  isChemistRCPAneeded ? false : true
                lblSample.isHidden = isChemistProductSampleNeeded ? false : true
            case is Stockist:
                productNameLbl.text =  appSetup.stkProductCaption ?? "Products"
                lblRxQty.text = appSetup.stkQCap ?? "Rx Qty"
                lblSample.text =  "Sample"
                
                lblRxQty.isHidden = isStockistProductRXneeded ? false : true
                lblRCPA.isHidden =   true
                lblSample.isHidden = isStockistProductSampleNeeded ? false : true
            case is UnListedDoctor:
                productNameLbl.text =  appSetup.ulProductCaption ?? "Products"
                lblRxQty.text = appSetup.nlRxQCap ?? "Rx Qty"
                lblSample.text = appSetup.nlSampleQCap ?? "Sample"
                
                lblRxQty.isHidden = isUnListedDoctorProductRXneeded ? false : true
                lblRCPA.isHidden =  isUnListedDoctorRCPAneeded ? false : true
                lblSample.isHidden = false
            default:
                print("Yet to")
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     //   guard let call = call else {return}
        

    }

}
