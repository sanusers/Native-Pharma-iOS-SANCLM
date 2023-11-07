//
//  LoginVC.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 29/05/23.
//

import Alamofire

import UIKit


class LoginVC : UIViewController {
    
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    
    @IBOutlet weak var lblVersion: UILabel!
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    
    var imgUrl : String!
    
    var weburl : String! 
    var iosUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
     //   self.navigationController?.isNavigationBarHidden = true
        
        let data = AppDefaults.shared.getConfig()
        let url = URL(string: data.webUrl + data.logoImg)!
        
        if let data = try? Data(contentsOf: url) {
            
            let imgData : [String : Any] = ["name" : AppDefaults.shared.appConfig!.logoImg , "data" : data]
            AppDefaults.shared.save(key: .logoImage, value: imgData)
            self.imgLogo.image = UIImage(data: data)
         }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func resetConfiguration(_ sender: UIButton) {
        
        AppDefaults.shared.reset()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.setupRootViewControllers()
        }
    }
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        let userId = self.txtUserName.text ?? ""
        let password = self.txtPassWord.text ?? ""
        
        
        if userId.isEmpty {
            ConfigVC().showToast(controller: self, message: "Please Enter User ID", seconds: 2)
            return
            
        }else if password.isEmpty {
            ConfigVC().showToast(controller: self, message: "Please Enter Password", seconds: 2)
            return
        }
        
        let version = UIDevice.current.systemVersion
        let modelName = UIDevice.current.model
        
        
        print(AppDefaults.shared.appConfig!.webUrl)
        print(AppDefaults.shared.appConfig!.iosUrl)
        
        let urlStr = appMainURL + "action/login" //"login"  // "http://crm.saneforce.in/apps/ConfigiOSEdet.json"
        
        let params = "{\"name\" : \(userId),\"password\" : \(password), \"versionNo\" : \"V.1.0\",\"mode\": \"iOS-Edeting\",\"Device_version\" : \(version),\"device_id\" : \"\",\"Device_name\" : \(modelName),\"AppDeviceRegId\" : \"\", \"location\" : \"\"}"
        
        
        let paramStr = ["name" : userId,"password" : password,"versionNo": "i.1.0","mode" : "iOS-Edeting","Device_version": version,"device_id" : "","Device_name" : modelName,"AppDeviceRegId" : "", "location" : ""]
        
        print(params)
        
        let param = ["data" : paramStr.toString()]
        
        print(urlStr)
        print(param)

        let date = Date()
        
        print(date)
        AF.request(urlStr,method: .post,parameters: param).responseData(){ (response) in
            
            switch response.result {
                
                case .success(_):
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        let date1 = Date()
                        
                        print(date1)
        
                        print("ssususnbjbo")
                        print(apiResponse)
                        print("ssusus")
                        
                        let status = self.getStatus(json: apiResponse)
                        
                        if status.isOk {
                            
                            AppDefaults.shared.save(key: .appSetUp, value: status.info)
                            
                            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                                appDelegate.setupRootViewControllers()
                            }
                        }
                        
                    }catch {
                        
                    }
                case .failure(let error):
                
                    ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                    print(error)
                    return
            }
            
            print("2")
            print(response)
            print("2")
        }
    }
    
    
    public func getStatus(json:Any?, isShowToast:Bool = true) -> (isOk:Bool, info:[String:Any]) {
        guard let info:[String:Any] = json as? [String:Any] else {
            return (false, [:])
        }
        var status = false
        if let statusBool = info["success"] as? Bool {
            status = statusBool
        }
        if status {
            if let errormsg = info["msg"] as? String{
                if isShowToast {
                   // let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    ConfigVC().showToast(controller: self, message: errormsg, seconds: 2)
                    
                   // appdelegate.window?.rootViewController?.showToast(with: errormsg)
                }
            }else if let errormsg = info["Msg"] as? String{
                if isShowToast {
                   // let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    ConfigVC().showToast(controller: self, message: errormsg, seconds: 2)
                   // appdelegate.window?.rootViewController?.showToast(with: errormsg)
                }
            }
            return (true, info)
        }
        else {
            
            if let errormsg = info["msg"] as? String{
                if isShowToast {
//                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                    appdelegate.window?.rootViewController?.showToast(with: errormsg)
                    
                    ConfigVC().showToast(controller: self, message: errormsg, seconds: 2)
                    //showAlert(title: "", message: errormsg, style: .alert, buttons: ["OK"], controller: nil, completion: nil)
                }
            }else if let errormsg = info["Msg"] as? String{
                if isShowToast {
//                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                    appdelegate.window?.rootViewController?.showToast(with: errormsg)
                    
                    ConfigVC().showToast(controller: self, message: errormsg, seconds: 2)
                    //showAlert(title: "", message: errormsg, style: .alert, buttons: ["OK"], controller: nil, completion: nil)
                }
            }
            return (false, info)
        }
    }
}



extension Dictionary{
    func toString() -> String{
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted){
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
            if let jsonString = jsonString{
                return jsonString
            }
        }
        return self.description
    }
}





//        AF.request(urlStr,method: .post,parameters: param).responseString { (response) in
//            print("3")
//            print(response)
//            print("3")
//        }
//
//
//        AF.request(urlStr,method: .post,parameters: param).response { (response) in
//            print("4")
//            print(response)
//            print("4")
//        }
//
//        AF.request(urlStr,method: .post,parameters: param).responseDecodable(of: Config.self) { (response) in
//
//            print("5")
//            print(response)
//            print("5")
//        }



// AF.request(urlStr,method: .post,parameters: param).re

//        AF.request(url).responseDecodable(of: Config.self){ (responseFeed) in
//
//            print(responseFeed)
//
//
//
//            let homeVC = UIStoryboard.homeVC
//            self.navigationController?.pushViewController(homeVC, animated: true)
//        }



//        AF.request(urlStr,method: .post,parameters: param).responseJSON{ (response) in
//
//            print("1")
//            print(response)
//            print("1")
//
//            switch response.result {
//
//                case .success(_):
//                    do {
//                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
//
//
//
//                        print(apiResponse)
//                    }catch {
//
//                    }
//                case .failure(let error):
//                    print(error)
//                    return
//            }
//
//        }




//    {"name":"EMR123","password":"123","versionNo":"N TS - 1","mode":"Android-App","Device_version":"12","device_id":"e060ab25e4c9f7a1","Device_name":"220333QBI(Xiaomi)","AppDeviceRegId":"d37A27Z4TBuOoTT2vAVcFs:APA91bFHhkVZq1uMig_JHzACXDVj2aXVstqHAJyoLVUIiQK6KlO73-f1YYjpz3hzOAu50nem6nTQfNrgfuUL0l06NtF5_Am3eAUSRKQvW4-SNCgjMcBC8Kub_oXgr6DgpiMrgPZhWhI8","location":"0.0:0.0"}


//        let jsonData = try? JSONSerialization.data(withJSONObject: params)
//
//        let url = URL(string: urlStr)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData

//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//
//            }
//
//        }.resume()
