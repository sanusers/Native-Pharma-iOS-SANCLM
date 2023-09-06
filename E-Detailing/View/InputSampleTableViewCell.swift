//
//  InputSampleTableViewCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 21/08/23.
//

import Foundation
import UIKit


class InputSampleTableViewCell : UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtSampleQty: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    
    
    var inputSample : InputViewModel! {
        didSet {
            self.lblName.text = inputSample.name
            self.txtSampleQty.text = inputSample.inputCount
        }
    }
    
    var jointWorkSample : JointWorkViewModel! {
        didSet {
            self.lblName.text = jointWorkSample.name
        }
    }
    
    var additionalCallSample : AdditionalCallViewModel! {
        didSet {
            self.lblName.text = additionalCallSample.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
