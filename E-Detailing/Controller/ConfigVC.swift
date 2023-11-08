//
//  ConfigVC.swift
//  E-Detailing
//
//  Created by NAGAPRASATH N on 27/05/23.
//

import Foundation
import UIKit
import Alamofire
import Combine


class ConfigVC : UIViewController {
    
    
    @IBOutlet weak var txtWebUrl: UITextField!
    @IBOutlet weak var txtLicenceKey: UITextField!
    @IBOutlet weak var txtDeviceId: UITextField!
    @IBOutlet weak var txtLanguage: UITextField!
    
    var config = [AppConfig]()
    var homeVM: HomeViewModal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeVM = HomeViewModal()
        [txtWebUrl,txtLicenceKey,txtDeviceId,txtLanguage].forEach { textfield in
            textfield?.layer.borderColor = AppColors.primaryColorWith_25per_alpha.cgColor
            textfield?.layer.borderWidth = 1.5
            textfield?.layer.cornerRadius = 5
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield?.frame.height ?? 50))
            
            textfield?.leftView = paddingView
            textfield?.leftViewMode = .always
        }
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        
        let deviceid = UIDevice.current.identifierForVendor?.description
        
        print(deviceid ?? "")
        
        self.txtDeviceId.text = "\(uuid ?? "")"
        
        
        let uv = Locale.current.languageCode
        
        print(uv)
        
        if #available(iOS 16, *) {
            let lan = Locale.current.language
            
            print(lan)
            
        } else {
            
            let lan = Locale.current.languageCode
            
            print(lan)
        }
    }
    
    
    
    
    
    
    @IBAction func saveSettingsAction(_ sender: UIButton) {
        print("save")
        
        _ = self.txtWebUrl.text
        if self.txtWebUrl.text!.isEmpty {
            self.showToast(controller: self, message: "Please Enter Web URL", seconds: 2.0)
            return
        }
        
        if self.txtLicenceKey.text!.isEmpty {
            self.showToast(controller: self, message: "Please Enter License Key", seconds: 2.0)
            return
        }
        toValidateURL()
    }
    
    

    func toValidateURL() {
        
        let webUrl = self.txtWebUrl.text ?? ""
        APIBaseUrl = webUrl
        print(APIUrl)
        print(APIBaseUrl)
        let licenseKey = self.txtLicenceKey.text ?? ""
        LicenceKey = licenseKey
        let param = [String: Any]()
        homeVM!.getConfigData(params: param, api: .none) { result in
            switch result {
                
            case .success(let response):
                print(response)
                let config = response.filter{$0.key.caseInsensitiveCompare(licenseKey) == .orderedSame}
                print(config)
                
                guard let appConfig = config.first else {
                    self.showToast(controller: self, message: "Invalid License Key", seconds: 2.0)
                    return
                }
                do {
                    try AppDefaults.shared.toSaveEncodedData(object: appConfig.config, key: .config) {_ in
                        
                    }
                } catch {
                    print("Unable to save")
                }
                
                DispatchQueue.main.async {
                    let loginVC = UIStoryboard.loginVC
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func showToast(controller: UIViewController, message : String, seconds: Double) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15

        
        DispatchQueue.main.async {
            controller.present(alert, animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
        
    }

    
    
}



