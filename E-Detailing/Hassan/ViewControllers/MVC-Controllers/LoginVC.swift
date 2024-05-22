//
//  LoginVC.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 13/03/2024.
//

import Alamofire

import UIKit
import CoreData

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}


extension LoginVC: MediaDownloaderDelegate {
    func mediaDownloader(_ downloader: MediaDownloader, didUpdateProgress progress: Float) {
        print("")
    }
    
    func mediaDownloader(_ downloader: MediaDownloader, didFinishDownloadingData data: Data?) {
        print("")
        self.imgLogo.image = UIImage(data: data ?? Data())
        
    }
    
    func mediaDownloader(_ downloader: MediaDownloader, didEncounterError error: any Error) {
        print("Error no slide found")
    }
}

class LoginVC : UIViewController {

    
    
    
    func setupui() {
        txtUserName.delegate = self
        txtPassWord.delegate = self
        contentsHolderview.elevate(2)
        contentsHolderview.layer.cornerRadius = 5
        lblUserID.setFont(font: .bold(size: .BODY))
        lblUserID.textColor = .appTextColor
        lblPassword.setFont(font: .bold(size: .BODY))
        lblPassword.textColor = .appTextColor
        lblVersion.setFont(font: .medium(size: .SMALL))
        lblVersion.textColor = .appLightTextColor
        
        txtUserName.font = UIFont(name: "Satoshi-Medium", size: 14)
        txtPassWord.font = UIFont(name: "Satoshi-Medium", size: 14)
        lblPoweredBy.setFont(font: .medium(size: .BODY))
        lblPoweredBy.textColor = .appLightTextColor
        txtPassWord.isSecureTextEntry = true
        setEyeimage()
        PasswordIVHolderView.addTap {
            self.txtPassWord.isSecureTextEntry =  self.txtPassWord.isSecureTextEntry == true ? false : true
            self.setEyeimage()
        }
       // txtUserName.text = "mgr123"
       // txtPassWord.text = "123"
    }
    @IBOutlet var contentsHolderview: UIView!
    
    @IBOutlet var lblUserID: UILabel!
    
    @IBOutlet var lblPoweredBy: UILabel!
    
    @IBOutlet var lblPassword: UILabel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!

    @IBOutlet weak var lblVersion: UILabel!

    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet var viewPasswordIV: UIImageView!
    @IBOutlet var PasswordIVHolderView: UIView!
    
    let network: ReachabilityManager = ReachabilityManager.sharedInstance
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var homeVM: HomeViewModal?

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func addObserverForTimeZoneChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkModified(_:)) , name: NSNotification.Name("connectionChanged"), object: nil)

    }
    
    func setEyeimage() {
        
        viewPasswordIV.image = txtPassWord.isSecureTextEntry == true ? UIImage(systemName: "eye") :  UIImage(systemName: "eye.slash")
        
        viewPasswordIV.alpha =  viewPasswordIV.image == UIImage(systemName: "eye") ? 0.3 : 1
        
 
    }
    
    func toSetupAlert(text: String, istoValidate : Bool? = false) {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "E - Detailing", alertDescription: text, okAction: "Ok")
        commonAlert.addAdditionalOkAction(isForSingleOption: true) {
            print("no action")
           // self.openSettings()

   
        }
    }
    
    func checkReachability() {
        network.isReachable() {  reachability in
            
            
            switch reachability.reachability.connection {
                
            case .unavailable, .none:
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                self.toSetupAlert(text: "Internet connection is required to login user.")
            case .wifi, .cellular:
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
               
            }
            
         
        }

        network.isUnreachable() { reachability in
         
            
            switch reachability.reachability.connection {
                
            case .unavailable, .none:
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                self.toSetupAlert(text: "Internet connection is required to login user.")
            case .wifi, .cellular:
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
             
                
            }
        }
       
        
    }
    
    class func initWithStory() -> LoginVC {
        let loginVC : LoginVC = UIStoryboard.Hassan.instantiateViewController()

        return loginVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeVM = HomeViewModal()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupui()
        checkReachability()
        addObserverForTimeZoneChange()
        let data = AppDefaults.shared.getConfig()


//        Dispatch.background {
//            // do stuff
//            print("Data fetching")
//            var imageData : Data?
//            if let data = try? Data(contentsOf: url) {
//                imageData = data
//                let imgData : [String : Any] = ["name" : AppDefaults.shared.appConfig!.logoImg , "data" : data]
//                AppDefaults.shared.save(key: .logoImage, value: imgData)
//            Dispatch.main {
//                // update UI
//                self.imgLogo.image = UIImage(data: imageData ?? Data())
//            }
//        }
//        }
        Pipelines.shared.downloadData(mediaURL: data.config.logoImg, delegate: self)

    }
    
    

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    

    

    @IBAction func resetConfiguration(_ sender: UIButton) {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            startBackgroundTaskWithLoader(delegate: appDelegate)
        }
                
    }
    
    @objc func networkModified(_ notification: NSNotification) {
        
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let status = dict["Type"] as? String{
                DispatchQueue.main.async {
                    if status == ReachabilityManager.ReachabilityStatus.notConnected.rawValue {
                        
                        self.toCreateToast("Please check your internet connection.")
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                    } else if  status == ReachabilityManager.ReachabilityStatus.wifi.rawValue || status ==  ReachabilityManager.ReachabilityStatus.cellular.rawValue   {
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
                    }
                }
            }
        }
    }

    func doUserLogin(_ param: [String: Any], paramData: JSON) {
        dump(param)
        
        Shared.instance.showLoaderInWindow()
        
        homeVM?.doUserLogin(params: param, api: .actionLogin, paramData: paramData) { responseData in
            Shared.instance.removeLoaderInWindow()
            switch responseData {

            case .success(let loginData):
                dump(loginData)
                if !(loginData.isSuccess ?? false) {
                    LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserLoggedIn, value: false)
                    self.toCreateToast(loginData.successMessage ?? "Failed to login")
                } else {
                    do {
                      try  AppDefaults.shared.toSaveEncodedData(object: loginData, key: .appSetUp) { isSaved in
                          if isSaved {
                              LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserLoggedIn, value: true)
                              self.navigate()
                          } else {
                              LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserLoggedIn, value: false)
                              self.toCreateToast(loginData.successMessage ?? "Failed to save user config data")
                          }
                        }
                    } catch {
                        print("Unable to save data")
                    }
                }
            case .failure(let error):
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserLoggedIn, value: false)
                dump(error)
                self.toCreateToast(error.rawValue)
            }
        }
    }

    
    func navigate() {
      
        let appsetup = AppDefaults.shared.getAppSetUp()
        if appsetup.sfType == 2 {
            LocalStorage.shared.setBool(LocalStorage.LocalValue.isMR, value: false)
            
        } else {
            LocalStorage.shared.setBool(LocalStorage.LocalValue.isMR, value: true)
        }
        
        appDelegate.setupRootViewControllers()
        
    }
    
    
    
    

    @IBAction func loginAction(_ sender: UIButton) {
        
        if !LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
            self.toSetupAlert(text: "Internet connection is required to login user.")
            return
        }
        

        let userId = self.txtUserName.text ?? ""
        let password = self.txtPassWord.text ?? ""


        if userId.isEmpty {
            self.toCreateToast("Please Enter User ID")
          
            return

        }else if password.isEmpty {
            self.toCreateToast("Please Enter Password")
        
            return
        }

        let version = UIDevice.current.systemVersion
        let modelName = UIDevice.current.model


        let param: [String: Any] = [
            "name": userId,
            "password": password,
            "versionNo": "i.1.0",
            "mode": "iOS-Edeting",
            "Device_version": version,
            "device_id": "",
            "Device_name": modelName,
            "AppDeviceRegId": "",
            "location": ""
        ]
        
    
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)
        
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        doUserLogin(toSendData, paramData: param)

    }
    
    func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
    
    
    func startBackgroundTaskWithLoader(delegate: AppDelegate?) {
        
        guard let appDelegate = delegate else {
            return
        }
        
        // Show loader on the main thread
        DispatchQueue.main.async {
            Shared.instance.showLoaderInWindow()
        }
        
        // Begin a background task and store its identifier
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            // End the background task if the expiration handler is called
            self?.endBackgroundTask()
        }
        
        // Perform API calls or other background activities
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.resetCoreDataStack(delegate: appDelegate) { isCompleted in
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            do {
                try self.clearDocumentsAndData()
                dispatchGroup.leave()
            } catch {
                print("Error clearing documents and data: \(error.localizedDescription)")
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.recreatePersistentStore(delegate: appDelegate) { isCreated in
                
            }
            
            dispatchGroup.notify(queue: .main) {
                // Hide your loader here
                Shared.instance.removeLoaderInWindow()
                appDelegate.setupRootViewControllers()
                // Call endBackgroundTask when the task completes if it's not already stopped
                self.endBackgroundTask()
            }
        }
    }
    
    
    func clearDocumentsAndData() throws {
        let fileManager = FileManager.default
        let urls = [
            fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
            fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first
        ].compactMap { $0 }

        for url in urls {
            let contents = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for item in contents {
                try fileManager.removeItem(at: item)
            }
        }
    }
    
    func resetCoreDataStack(delegate: AppDelegate?, completion: @escaping (Bool) -> Void) {
        
        UserDefaults.resetDefaults()
        Shared.instance.toReset()
        guard let appDelegate = delegate else {
            completion(false)
            return
        }
        
        // Get a reference to the NSPersistentStoreCoordinator
        let storeContainer = appDelegate.persistentContainer.persistentStoreCoordinator
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                // Delete each existing persistent store
                for store in storeContainer.persistentStores {
                    try storeContainer.destroyPersistentStore(at: store.url!, ofType: store.type, options: nil)
                }
                
                // Create a new container and ensure it loads persistent stores synchronously
                let newContainer = NSPersistentContainer(name: "E-Detailing")
                
                var loadError: Error?
                let semaphore = DispatchSemaphore(value: 0)
                
                newContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
                    if let error = error as NSError? {
                        loadError = error
                    }
                    semaphore.signal()
                })
                
                semaphore.wait()
                
                if let error = loadError {
                    throw error
                }
                
                DispatchQueue.main.async {
                    appDelegate.persistentContainer = newContainer
                    completion(true)
                }
            } catch {
                print("Failed to reset Core Data stack: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    
    
    private func recreatePersistentStore(delegate: AppDelegate, completion: @escaping (Bool) -> Void) {
        let persistentContainer = delegate.persistentContainer
        let storeCoordinator = persistentContainer.persistentStoreCoordinator
        guard let storeURL = storeCoordinator.persistentStores.first?.url else {
            completion(false)
            return
        }
        
        persistentContainer.performBackgroundTask { context in
            do {
                try storeCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
                try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                completion(true)
            } catch {
                print("Error recreating persistent store: \(error)")
                completion(false)
            }
        }
    }
    
//    func resetCoreDataStack(delegate: AppDelegate?, completion: @escaping (Bool) -> Void) {
//        UserDefaults.resetDefaults()
//        Shared.instance.toReset()
//        
//        guard let appDelegate = delegate else {
//            completion(false)
//            return
//        }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entityNames = appDelegate.persistentContainer.managedObjectModel.entities.compactMap { $0.name }
//        
//        let dispatchGroup = DispatchGroup()
//        var didEncounterError = false
//        
//        for entityName in entityNames {
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            
//            dispatchGroup.enter()
//            
//            managedContext.perform {
//                do {
//                    try managedContext.execute(batchDeleteRequest)
//                    try managedContext.save()
//                } catch {
//                    print("Error clearing \(entityName): \(error)")
//                    didEncounterError = true
//                }
//                dispatchGroup.leave()
//            }
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            completion(!didEncounterError)
//        }
//    }

    func removeData(at url: URL) {
        let fileManager = FileManager.default
    
        // Check if the file exists
        if fileManager.fileExists(atPath: url.path) {
            do {
                // Remove the file
                try fileManager.removeItem(at: url)
                print("File successfully removed")
            } catch {
                print("Failed to remove file: \(error)")
            }
        } else {
            print("File does not exist")
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
