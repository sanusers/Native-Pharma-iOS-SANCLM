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
    
    var homeVM: HomeViewModal?
    var imgUrl : String!
    
    var weburl : String! 
    var iosUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeVM = HomeViewModal()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
     //   self.navigationController?.isNavigationBarHidden = true
        
        let data = AppDefaults.shared.getConfig()
        let url = URL(string: data.webUrl + data.logoImg)!
        
        Dispatch.background {
            // do stuff
            print("Data fetching")
            var imageData : Data?
            if let data = try? Data(contentsOf: url) {
                imageData = data
                let imgData : [String : Any] = ["name" : AppDefaults.shared.appConfig!.logoImg , "data" : data]
                AppDefaults.shared.save(key: .logoImage, value: imgData)
            Dispatch.main {
                // update UI
                self.imgLogo.image = UIImage(data: imageData ?? Data())
            }
        }
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
    
    func doUserLogin(param: [String: Any]) {
        dump(param)
        homeVM?.doUserLogin(params: param, api: .actionLogin, { responseData in
            switch responseData {
                
            case .success(let loginData):
                dump(loginData)
//                if loginData.successCode == 0 {
//                    ConfigVC().showToast(controller: self, message: loginData.statusMessage, seconds: 2)
//                }
            case .failure(let error):
                dump(error)
            }
        })
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
        
//        var params = [String: Any]()
//        params["name"] = userId
//        params["password"] = password
//        params["versionNo"] = "V.1.0"
//        params["mode"] = "iOS-Edeting"
//        params["Device_version"] = version
//        params["device_id"] = ""
//        params["Device_name"] = modelName
//        params["AppDeviceRegId"] = ""
//        params["password"] = password
//        params["location"] = ""
//        let toSendParams = ["data" : params.toString()]
       
        
        let urlStr = appMainURL + "action/login" //"login"  // "http://crm.saneforce.in/apps/ConfigiOSEdet.json"
        
  
        let paramStr = ["name" : userId,"password" : password,"versionNo": "i.1.0","mode" : "iOS-Edeting","Device_version": version,"device_id" : "","Device_name" : modelName,"AppDeviceRegId" : "", "location" : ""]

        print(paramStr)

        let param = ["data" : paramStr.toString()]
     //   doUserLogin(param: param)

        print(urlStr)
        print(param)

        let date = Date()

        print(date)
        AF.request(urlStr,method: .post,parameters: param).responseJSON{ (response) in

            switch response.result {

                case .success(_):
                    do {
                        let apiResponse = response
                        //try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)

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


