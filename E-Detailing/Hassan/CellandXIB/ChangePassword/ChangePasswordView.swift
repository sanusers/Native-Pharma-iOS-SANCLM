//
//  ChangePasswordView.swift
//  E-Detailing
//
//  Created by San eforce on 27/02/24.
//

protocol ChangePasswordViewDelegate: AnyObject {
    func didClose()
    func didUpdate()
}

import Foundation
import UIKit
class ChangePasswordView: UIView {
    
    
    @IBOutlet var lblChangePassword: UILabel!
    
    @IBOutlet var closeIV: UIImageView!
    
    @IBOutlet var lblOldPassword: UILabel!
    
    @IBOutlet var oldPasswordTF: UITextField!
    
    @IBOutlet var viewoldPasswordIV: UIImageView!
    
    @IBOutlet var lblNewPassword: UILabel!
    
    @IBOutlet var oldPasswordTFholderStack: UIStackView!
    
    
    @IBOutlet var newPasswordTFholderStack: UIStackView!
    
    @IBOutlet var newPasswordTF: UITextField!
    
    @IBOutlet var viewnewPasswordIV: UIImageView!
    
    
    
    @IBOutlet var lblRepeatPassword: UILabel!
    @IBOutlet var repeatPasswordTFholderStack: UIStackView!
    
    @IBOutlet var repeatPasswordTF: UITextField!
    
    @IBOutlet var viewrepeatPasswordIV: UIImageView!
    
    @IBOutlet var btnUpdate: UIButton!
    
    
    var delegate: ChangePasswordViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
      

    }
    
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
       
     }
    

    @IBAction func didTapupdate(_ sender: Any) {
        self.delegate?.didUpdate()
    }
    
    private func loadFromNib() -> UIView? {
        let nibName = "ChangePasswordView"
        let bundle = Bundle.main
        let nibContents = bundle.loadNibNamed(nibName, owner: self, options: nil)
        return nibContents?.first as? UIView
    }
    
    func setupUI() {
        lblChangePassword.setFont(font: .bold(size:  .BODY))
        lblNewPassword.setFont(font: .bold(size:  .BODY))
        lblOldPassword.setFont(font: .bold(size:  .BODY))
        lblChangePassword.setFont(font: .bold(size:  .BODY))
        
        lblRepeatPassword.setFont(font: .bold(size:  .BODY))
        
        
        self.layer.cornerRadius = 5
        btnUpdate.layer.cornerRadius = 5
        oldPasswordTFholderStack.layer.borderColor = UIColor.appGreyColor.cgColor
        oldPasswordTFholderStack.layer.borderWidth = 1
        oldPasswordTFholderStack.layer.cornerRadius = 5
        
        newPasswordTFholderStack.layer.borderColor = UIColor.appGreyColor.cgColor
        newPasswordTFholderStack.layer.borderWidth = 1
        newPasswordTFholderStack.layer.cornerRadius = 5
        
        repeatPasswordTFholderStack.layer.borderColor = UIColor.appGreyColor.cgColor
        repeatPasswordTFholderStack.layer.borderWidth = 1
        repeatPasswordTFholderStack.layer.cornerRadius = 5
        closeIV.addTap {
            self.delegate?.didClose()
        }
    }

    
}
