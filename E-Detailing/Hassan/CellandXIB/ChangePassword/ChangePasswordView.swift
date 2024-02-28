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

extension ChangePasswordView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let appsetup = AppDefaults.shared.getAppSetUp()
        let userPassword = appsetup.sfPassword
        
        guard let text = textField.text as NSString? else {
            return true
        }
        
        let updatedText = text.replacingCharacters(in: range, with: string)
        
        switch textField {
        case oldPasswordTF:
            if updatedText == userPassword {
                passwordValidationLbl.isHidden = true
                isOldePasswordVerified = true
                newPasswordTF.isUserInteractionEnabled = true
                repeatPasswordTF.isUserInteractionEnabled = true
                checkButtonStatus()
            } else {
                passwordValidationLbl.isHidden = false
                passwordValidationLbl.text = "Entered Password is incorrect"
                isOldePasswordVerified = false
                newPasswordTF.isUserInteractionEnabled = false
                repeatPasswordTF.isUserInteractionEnabled = false
                checkButtonStatus()
            }
            
        case newPasswordTF:
            if newpasswordStr != updatedText {
                repeatPasswordTF.text = ""
                isRepeatPasswordVerified = false
            }
            
            if updatedText.count > 7 && updatedText.containsSpecialCharacter {
                newpasswordStr = updatedText
                passwordValidationLbl.isHidden = true
                isNewPasswordVerified = true
                checkButtonStatus()
            } else {
                passwordValidationLbl.isHidden = false
                passwordValidationLbl.text = "Password should be alphanumeric, special character, min 8 char, combination upper case."
                isNewPasswordVerified = false
                checkButtonStatus()
            }
            
        case repeatPasswordTF:
            if updatedText == newPasswordTF.text {
                passwordValidationLbl.isHidden = true
                isRepeatPasswordVerified = true
                checkButtonStatus()
            } else {
                passwordValidationLbl.isHidden = false
                passwordValidationLbl.text = "Repeated password is incorrect"
                isRepeatPasswordVerified = false
                checkButtonStatus()
            }
            
        default:
            viewnewPasswordIV.alpha = 1
            viewrepeatPasswordIV.alpha = 1
            viewoldPasswordIV.alpha = 1
        }
        
        return true
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//        let appsetup = AppDefaults.shared.getAppSetUp()
//        let userPassword = appsetup.sfPassword
//        switch textField {
//        case oldPasswordTF:
//            guard let passwd = textField.text, !passwd.isEmpty else {
//                
//                return}
//            if passwd == userPassword {
//         
//                passwordValidationLbl.isHidden = true
//                isOldePasswordVerified = true
//                newPasswordTF.isUserInteractionEnabled = true
//                repeatPasswordTF.isUserInteractionEnabled = true
//                
//                checkButtonStatus()
//            } else {
//              
//                passwordValidationLbl.isHidden = false
//                passwordValidationLbl.text = "Entered Password is incorrect"
//                isOldePasswordVerified = false
//                newPasswordTF.isUserInteractionEnabled = false
//                repeatPasswordTF.isUserInteractionEnabled = false
//                checkButtonStatus()
//            }
//            
//     
//        case newPasswordTF:
//            guard let passwd = textField.text, !passwd.isEmpty else {
//                
//                return}
//            
//            if newpasswordStr != passwd {
//                repeatPasswordTF.text = ""
//                isRepeatPasswordVerified = false
//            }
//            
//            if passwd.count>7 && passwd.containsSpecialCharacter {
//                newpasswordStr = passwd
//                passwordValidationLbl.isHidden = true
//                isNewPasswordVerified = true
//                checkButtonStatus()
//            } else {
//              
//                passwordValidationLbl.isHidden = false
//                passwordValidationLbl.text = "Password should be alphanumeric, special character, min 8 char, combination upper case."
//                isNewPasswordVerified = false
//                checkButtonStatus()
//            }
//            
//   
//        case repeatPasswordTF:
//          
//            guard let passwd = textField.text, !passwd.isEmpty else {
//                
//                return}
//            if passwd == newPasswordTF.text {
//         
//                passwordValidationLbl.isHidden = true
//                isRepeatPasswordVerified = true
//                checkButtonStatus()
//            } else {
//              
//                passwordValidationLbl.isHidden = false
//                passwordValidationLbl.text = "Repeated password is incorrect"
//                isRepeatPasswordVerified = false
//                checkButtonStatus()
//            }
//            
//        default:
//            viewnewPasswordIV.alpha = 1
//            viewrepeatPasswordIV.alpha = 1
//            viewoldPasswordIV.alpha = 1
//        }
//    }
}


class ChangePasswordView: UIView {
    func checkButtonStatus() {
        if isOldePasswordVerified && isNewPasswordVerified && isRepeatPasswordVerified {
            btnUpdate.alpha = 1
            btnUpdate.isUserInteractionEnabled = true
        } else {
            btnUpdate.alpha = 0.5
            btnUpdate.isUserInteractionEnabled = false
        }
            
            
            
    }
    
    func initTaps() {
        viewnewPasswordIV.addTap { [weak self] in
            guard let welf = self else {return}
            welf.newPasswordTF.isSecureTextEntry =  welf.newPasswordTF.isSecureTextEntry == true ? false : true
            welf.setEyeimage()
          
        }
        
        viewoldPasswordIV.addTap {[weak self] in
            guard let welf = self else {return}
            welf.oldPasswordTF.isSecureTextEntry =  welf.oldPasswordTF.isSecureTextEntry == true ? false : true
            welf.setEyeimage()
            
        }
        
        viewrepeatPasswordIV.addTap {[weak self] in
            guard let welf = self else {return}
            welf.repeatPasswordTF.isSecureTextEntry =  welf.repeatPasswordTF.isSecureTextEntry == true ? false : true
            welf.setEyeimage()
        }
    }
    
    enum TextFields {
        case oldPasswordTF
        case newPasswordTF
        case repeatPasswordTF
    }
    
    
    func setTextfiledDelegates() {
        oldPasswordTF.isSecureTextEntry = true
        newPasswordTF.isSecureTextEntry = true
        repeatPasswordTF.isSecureTextEntry = true
        oldPasswordTF.delegate = self
        newPasswordTF.delegate = self
        repeatPasswordTF.delegate = self
        
    }
    var newpasswordStr = ""
    var selectedTF : TextFields = .oldPasswordTF
    var isOldePasswordVerified = false
    var isNewPasswordVerified = false
    var isRepeatPasswordVerified = false
    @IBOutlet var passwordValidationLbl: UILabel!
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

    func setEyeimage() {
        
        viewnewPasswordIV.image = newPasswordTF.isSecureTextEntry == true ? UIImage(systemName: "eye") :  UIImage(systemName: "eye.slash")
        
        viewnewPasswordIV.alpha =  viewnewPasswordIV.image == UIImage(systemName: "eye") ? 0.5 : 1
        
        viewrepeatPasswordIV.image = repeatPasswordTF.isSecureTextEntry == true ? UIImage(systemName: "eye") :  UIImage(systemName: "eye.slash")
        
        viewrepeatPasswordIV.alpha =  viewrepeatPasswordIV.image == UIImage(systemName: "eye") ? 0.5 : 1
        
        viewoldPasswordIV.image = oldPasswordTF.isSecureTextEntry == true ? UIImage(systemName: "eye") :  UIImage(systemName: "eye.slash")
        
        
        viewoldPasswordIV.alpha =  viewoldPasswordIV.image == UIImage(systemName: "eye") ? 0.5 : 1
    }
    
    
    func setupUI() {
        setTextfiledDelegates()
        
        setEyeimage()
        
        initTaps()
        passwordValidationLbl.setFont(font: .medium(size: .SMALL))
        passwordValidationLbl.textColor = .appLightPink
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
        checkButtonStatus()
        newPasswordTF.isUserInteractionEnabled = false
        repeatPasswordTF.isUserInteractionEnabled = false
        passwordValidationLbl.isHidden = true
        closeIV.addTap {
            self.delegate?.didClose()
        }
    }

    
}
