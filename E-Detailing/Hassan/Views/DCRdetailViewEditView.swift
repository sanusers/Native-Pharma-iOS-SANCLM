//
//  DCRdetailViewEditView.swift
//  E-Detailing
//
//  Created by San eforce on 06/03/24.
//

import Foundation
import UIKit
class DCRdetailViewEditView: BaseView {
    var dcrdetailViewEditVc : DCRdetailViewEditVC!
   
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var lblGender: UILabel!
    
    @IBOutlet var maleTapView: UIView!
    
    @IBOutlet var lblMale: UILabel!
    @IBOutlet var femaleTapView: UIView!
    
    @IBOutlet var lblFemale: UILabel!
    
    @IBOutlet var qualificationLbl: UILabel!
    
    @IBOutlet var qualificationTF: UITextField!
    @IBOutlet var specialityShadowStack: UIStackView!
    
    @IBOutlet var specialityTF: UITextField!
    
    @IBOutlet var specialityLbl: UILabel!
    @IBOutlet var qualificationShadowStack: UIStackView!
    
    
    @IBOutlet var categoryLbl: UILabel!
    
    @IBOutlet var categoryShadowStack: UIStackView!
    
    @IBOutlet var categoryTF: UITextField!
    
    
    @IBOutlet var dobLbl: UILabel!
    
    @IBOutlet var dobShadowStack: UIStackView!
    
    @IBOutlet var dobTF: UITextField!
    
    @IBOutlet var dowLbl: UILabel!
    
    
    @IBOutlet var dowShadoeStack: UIStackView!
    
    
    @IBOutlet var dowTF: UITextField!
    
    @IBOutlet var districtLbl: UILabel!
    
    
    @IBOutlet var districtShadowStack: UIStackView!
    
    @IBOutlet var districtTF: UITextField!
    
    @IBOutlet var cityLbl: UILabel!
    
    
    @IBOutlet var cityTF: UITextField!
    @IBOutlet var cityShadowStack: UIStackView!
    
    
    
    @IBOutlet var addressTitle: UILabel!
    
    
    @IBOutlet var mainAddressLbl: UILabel!
    
    
    @IBOutlet var mainAddressShadowView: UIView!
    @IBOutlet var mainAddressTF: UITextField!
    
    
    @IBOutlet var mobileLbl: UILabel!
    
    
    @IBOutlet var mobilenumberShadoeView: UIView!
    
    @IBOutlet var mobileTF: UITextField!
    
    @IBOutlet var phoneLbl: UILabel!
    
    
    @IBOutlet var phoneNumberShadowView: UIView!
    
    
    @IBOutlet var phoneNumberTF: UITextField!
    
    
    @IBOutlet var emailLbl: UILabel!
    
    @IBOutlet var emailShadowView: UIView!
    
    
    @IBOutlet var emailTF: UITextField!
    
    @IBOutlet var clearLbl: UILabel!
    @IBOutlet var clearVIew: UIView!
    
    
    @IBOutlet var submitView: UIView!
    
    
    @IBOutlet var submitLbl: UILabel!
    
    @IBOutlet var doctorInfoVIew: UIView!
    
    @IBOutlet var backHolderVIew: UIView!
    
    @IBOutlet var contactsInfoView: UIView!
    @IBOutlet var contentsHolder: UIView!
    func setupUI() {
        
        let mainTitles : [UILabel] = [titleLbl, addressTitle, clearLbl, submitLbl]
        
        doctorInfoVIew.backgroundColor = .appWhiteColor
        contactsInfoView.backgroundColor = .appWhiteColor
        
        doctorInfoVIew.layer.cornerRadius = 5
        contactsInfoView.layer.cornerRadius = 5
        
     
        contentsHolder.backgroundColor = .appGreyColor
        mainTitles.forEach {
            $0.setFont(font: .bold(size: .BODY))
            $0.textColor = .appTextColor
        }
        submitLbl.textColor = .appWhiteColor
        titleLbl.textColor = .appWhiteColor
        clearVIew.layer.cornerRadius = 5
        clearVIew.layer.borderColor = UIColor.appLightTextColor.cgColor
        clearVIew.layer.borderWidth = 1
        clearVIew.layer.cornerRadius = 5
        
        
        submitView.layer.cornerRadius = 5
        submitView.backgroundColor = .appTextColor
        
        let subtitles: [UILabel] = [lblGender, qualificationLbl, specialityLbl, categoryLbl, dobLbl, dowLbl, districtLbl, cityLbl, mainAddressLbl, mobileLbl, phoneLbl, emailLbl]
        
        subtitles.forEach {
            $0.setFont(font: .bold(size: .BODY))
            $0.textColor = .appLightTextColor
        }
        
        let shadowViews: [UIView] = [qualificationShadowStack, specialityShadowStack, categoryShadowStack, dobShadowStack, dowShadoeStack, districtShadowStack, cityShadowStack, mainAddressShadowView, mobilenumberShadoeView, phoneNumberShadowView, emailShadowView]
        
        
        shadowViews.forEach {
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.appSelectionColor.cgColor
            
        }
        
        
        let textFields: [UITextField] = [qualificationTF, specialityTF, categoryTF, dowTF, dobTF, districtTF, cityTF, mainAddressTF, mobileTF, phoneNumberTF, emailTF]
        
        textFields.forEach {
            $0.font = UIFont(name: "Satoshi-Bold", size: 14)
        }
        
        lblMale.setFont(font: .medium(size: .BODY))
        lblFemale.setFont(font: .medium(size: .BODY))
    }
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.dcrdetailViewEditVc = baseVC as? DCRdetailViewEditVC
        setupUI()
        
        backHolderVIew.addTap {
            self.dcrdetailViewEditVc.dismiss(animated: true)
        }
  
    }
    
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.dcrdetailViewEditVc = baseVC as? DCRdetailViewEditVC
       // specialityTF
       // qualificationShadowStack
    }
    
}
