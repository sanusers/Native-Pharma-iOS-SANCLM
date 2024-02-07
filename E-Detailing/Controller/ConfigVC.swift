////
////  ConfigVC.swift
////  E-Detailing
////
////  Created by NAGAPRASATH N on 27/05/23.
////
//
//import Foundation
//import UIKit
//import Alamofire
//import Combine
//
//
//class ConfigVC : UIViewController {
//
//
//    @IBOutlet weak var txtWebUrl: UITextField!
//    @IBOutlet weak var txtLicenceKey: UITextField!
//    @IBOutlet weak var txtDeviceId: UITextField!
//    @IBOutlet weak var txtLanguage: UITextField!
//
//    var config = [AppConfig]()
//    var homeVM: HomeViewModal?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.homeVM = HomeViewModal()
//        [txtWebUrl,txtLicenceKey,txtDeviceId,txtLanguage].forEach { textfield in
//            textfield?.layer.borderColor = AppColors.primaryColorWith_25per_alpha.cgColor
//            textfield?.layer.borderWidth = 1.5
//            textfield?.layer.cornerRadius = 5
//
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield?.frame.height ?? 50))
//
//            textfield?.leftView = paddingView
//            textfield?.leftViewMode = .always
//        }
//        let uuid = UIDevice.current.identifierForVendor?.uuidString
//
//        let deviceid = UIDevice.current.identifierForVendor?.description
//
//        print(deviceid ?? "")
//
//        self.txtDeviceId.text = "\(uuid ?? "")"
//
//
//        let uv = Locale.current.languageCode
//
//        print(uv)
//
//        if #available(iOS 16, *) {
//            let lan = Locale.current.language
//
//            print(lan)
//
//        } else {
//
//            let lan = Locale.current.languageCode
//
//            print(lan)
//        }
//    }
//
//
//
//
//
//
//    @IBAction func saveSettingsAction(_ sender: UIButton) {
//        print("save")
//
//        _ = self.txtWebUrl.text
//        if self.txtWebUrl.text!.isEmpty {
//            self.showToast(controller: self, message: "Please Enter Web URL", seconds: 2.0)
//            return
//        }
//
//        if self.txtLicenceKey.text!.isEmpty {
//            self.showToast(controller: self, message: "Please Enter License Key", seconds: 2.0)
//            return
//        }
//        toValidateURL()
//    }
//
//
//
//    func toValidateURL() {
//
//        let webUrl = self.txtWebUrl.text ?? ""
//        APIBaseUrl = webUrl
//        print(APIUrl)
//        print(APIBaseUrl)
//        let licenseKey = self.txtLicenceKey.text ?? ""
//        LicenceKey = licenseKey
//        let param = [String: Any]()
//        homeVM!.getConfigData(params: param, api: .none) { result in
//            switch result {
//            case .success(let response):
//                print(response)
//                let config = response.filter{$0.key.caseInsensitiveCompare(licenseKey) == .orderedSame}
//                print(config)
//
//                guard let appConfig = config.first else {
//                    self.showToast(controller: self, message: "Invalid License Key", seconds: 2.0)
//                    return
//                }
//                do {
//                    try AppDefaults.shared.toSaveEncodedData(object: appConfig.config, key: .config) {_ in
//
//                    }
//                } catch {
//                    print("Unable to save")
//                }
//
//                DispatchQueue.main.async {
//                    let loginVC = UIStoryboard.loginVC
//                    self.navigationController?.pushViewController(loginVC, animated: true)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    func showToast(controller: UIViewController, message : String, seconds: Double) {
//
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//
//        alert.view.backgroundColor = .black
//        alert.view.alpha = 0.5
//        alert.view.layer.cornerRadius = 15
//
//
//        DispatchQueue.main.async {
//            controller.present(alert, animated: true)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
//            alert.dismiss(animated: true)
//        }
//
//    }
//
//
//
//}
//
//
//
//
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        [txtWebUrl,txtLicenceKey,txtDeviceId,txtLanguage].forEach { textfield in
            textfield?.layer.borderColor = AppColors.primaryColorWith_25per_alpha.cgColor
            textfield?.layer.borderWidth = 1.5
            textfield?.layer.cornerRadius = 5
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield?.frame.height ?? 50))
            
            textfield?.leftView = paddingView
            textfield?.leftViewMode = .always
        }
        
//        AF.request("http://crm.sanclm.info/Apps/ConfigiOS.json").responseJSON{ (responseFeed) in
//            print(responseFeed)
//
//        }
        
        
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        
        let deviceid = UIDevice.current.identifierForVendor?.description
        
        print(deviceid ?? "")
        
//        self.txtWebUrl.text = "crm.saneforce.in"
//
//        self.txtLicenceKey.text = "PHP"
        
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
        
        
        
//        AF.request("http://crm.saneforce.in/apps/ConfigiOSEdet.json").responseJSON{ (responseFeed) in
//            print(responseFeed)
//
//        }
        
        // http://crm.saneforce.in/apps/ConfigiOSEdet.json
        
       // AF.request("http://crm.sanclm.info/Apps/ConfigiOS.json").responseDecodable(completionHandler: <#T##(DataResponse<Decodable, AFError>) -> Void#>)
        
        
        
//        AF.request("http://crm.sanclm.info/Apps/ConfigiOS.json").responseDecodable{ (response) in
//
//            print(response)
//
//        }
        
        
        
    }
    
    
    
    
    
    
    @IBAction func saveSettingsAction(_ sender: UIButton) {
        print("save")
        
        let v = self.txtWebUrl.text
        if self.txtWebUrl.text!.isEmpty {
            self.showToast(controller: self, message: "Please Enter Web URL", seconds: 2.0)
            return
        }
        
        if self.txtLicenceKey.text!.isEmpty {
            self.showToast(controller: self, message: "Please Enter License Key", seconds: 2.0)
            return
        }
        
        self.configUrl()
        
        self.saveConfig()
//        let loginVC = UIStoryboard.loginVC
//        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    func saveConfig() {
        
        let webUrl = self.txtWebUrl.text ?? ""
        
        let licenseKey = self.txtLicenceKey.text ?? ""
        
        
        let urlStr = "http://\(webUrl)/apps/ConfigiOS.json"

        
        // Edet
        
//        AF.request(urlStr,method: .get,encoding: URLEncoding.default).responseJSON{ (responseFeed) in
//            print(responseFeed)
//
//
//            switch responseFeed.result {
//
//            case .success():
//                do {
//
//                }catch {
//
//                }
//
//            case .failure():
//                self.showToast(controller: self, message: "Invalid Access Configuration Url / Connection Failed", seconds: 2.0)
//
//            }
//
//
//            self.config = responseFeed.map{AppConfig(fromDictionary: $0)}
//
//            print(self.config)
//
//
//        }
        
        
        
    }
    
    
    
    func configUrl() {
        
        let webUrl = self.txtWebUrl.text ?? ""
        
        let licenseKey = self.txtLicenceKey.text ?? ""
        
        let urlStr = "http://\(webUrl.replacingOccurrences(of: " ", with: ""))/apps/ConfigiOS.json" // ConfigiOSEdet
        
        
        
        let url = URL(string: urlStr)!
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        
        
        print(request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(data as Any)
            
            if error != nil || data == nil {
                self.showToast(controller: self, message: "Invalid Access Configuration Url / Connection Failed", seconds: 2.0)
            }
            
           // self.showToast(controller: self, message: "Invalid Access Configuration Url / Connection Failed", seconds: 2.0)
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            
            if let response = responseJSON as? [[String: Any]] {
                print(response)
                
                self.config = response.map{AppConfig(fromDictionary: $0)}
                
                let config = self.config.filter{$0.licenseKey.caseInsensitiveCompare(licenseKey) == .orderedSame}
                
                print(config)
                guard let appConfig = config.first else {
                    self.showToast(controller: self, message: "Invalid License Key", seconds: 2.0)
                    return
                }
                
                AppDefaults.shared.save(key: .config, value: appConfig.toDictionary())
                let appconfig = AppDefaults.shared.getConfig()
                iosEndPoint = appconfig.config.iosUrl
                webEndPoint = appconfig.config.webUrl
                slideEndPoint = appconfig.config.slideUrl
                
                AppMainAPIURL = iosEndPoint
                AppMainSlideURL = slideEndPoint
                
                dump(APIUrl)
                dump(appMainURL)
                dump(slideURL)
                
                DispatchQueue.main.async {
                    let loginVC = UIStoryboard.loginVC
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
 
            }
            
        }.resume()
        
        AF.request(urlStr,method: .get).responseDecodable(of: AppConfig.self) { (response) in
            
            print("5")
            print(response)
        
          
            print("5")
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


// 'TEST123VP','456'
