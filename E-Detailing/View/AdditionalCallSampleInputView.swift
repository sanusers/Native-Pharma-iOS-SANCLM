//
//  AdditionalCallSampleInputView.swift
//  E-Detailing
//
//  Created by SANEFORCE on 18/10/23.
//

import Foundation
import UIKit


class AdditionalCallSampleInputView: UIView {
    
    
    
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var lblInput: UILabel!
    @IBOutlet weak var lblInputQty: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var product : ProductViewModel! {
        didSet {
            lblProduct.text = product.name
            lblProductQty.text = product.sampleCount

        }
    }
    
    var input : InputViewModel! {
        didSet {

            lblInput.text = input.name
            lblInputQty.text = input.inputCount
        }
    }
    
    
    class func instanceFromNib() -> AdditionalCallSampleInputView{
        return Bundle.main.loadNibNamed("AdditionalCallSampleInputView", owner: self, options: nil)?.first as! AdditionalCallSampleInputView
    }
    
}
