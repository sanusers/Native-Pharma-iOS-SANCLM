//
//  AdditionalCallSampleInputView.swift
//  E-Detailing
//
//  Created by SANEFORCE on 18/10/23.
//

import Foundation
import UIKit


class AdditionalCallSampleInputView: UIView {
    
    
    @IBOutlet var inputQtyCurvedView: UIView!
    @IBOutlet var productQtyCurvedVIew: UIView!
    
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var lblInput: UILabel!
    @IBOutlet weak var lblInputQty: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productQtyCurvedVIew.layer.cornerRadius = 3
        inputQtyCurvedView.layer.cornerRadius = 3
        
        productQtyCurvedVIew.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        inputQtyCurvedView.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
    }
    
    var productQty: String! {
        didSet {
            lblProductQty.text = productQty
        }
    }
    
    
    
    var product : Product! {
        didSet {
            lblProduct.text = product.name
        }
    }
    
    var input : Input! {
        didSet {
            lblInput.text = input.name
          
        }
    }
    
    var inputQty : String! {
        didSet {
            lblInputQty.text = inputQty
        }
    }
    
    
    class func instanceFromNib() -> AdditionalCallSampleInputView{
        return Bundle.main.loadNibNamed("AdditionalCallSampleInputView", owner: self, options: nil)?.first as! AdditionalCallSampleInputView
    }
    
}
