//
//  SplashVIew.swift
//  E-Detailing
//
//  Created by San eforce on 03/05/24.
//


import Foundation
import UIKit
import CoreLocation

extension SplashView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != previousAuthorizationStatus {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                print("Location services enabled")
                // Perform your actions here or notify the user
            case .denied, .restricted:
                print("Location services disabled")
                // setupNoGPSalert()
            case .notDetermined:
                print("Location services not determined")
            @unknown default:
                break
            }
            previousAuthorizationStatus = status
        }
        
        print(previousAuthorizationStatus)
    }
}

class SplashView: BaseView{
    var previousAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    var splashVC : SplashVC!
    var locationManager = CLLocationManager()
    @IBOutlet var btnLogout: UIButton!
    @IBOutlet var lblMenuTitle: UILabel!
    @IBOutlet var imgAppIcon: UIImageView!
    
    @IBOutlet weak var SplashImageHolderView: UIView!
    let network: ReachabilityManager = ReachabilityManager.sharedInstance
    override
    func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.splashVC = baseVC as? SplashVC
        setupUI()
        //initView()
        //locationManager.delegate = self
        checkReachability()
        addObserverForTimeZoneChange()
        
    }
    
    func initView(){


    
        }
    
    func setUIfortimeZoneChanges() {
       lblMenuTitle.text = "OOPS! you have accidentally changed time zone. Set the time zone to update automatically."
       btnLogout.isHidden = false
       
    }
    
    
    func setupNoGPSalert() {
  
        lblMenuTitle.text = "App requires user location. please enable location services"
        btnLogout.isHidden = false
    }
    
    func setupNoNetworkAlert() {
  
        lblMenuTitle.text = "Please connect to internet to validate timezone"
        btnLogout.isHidden = false
    }
    
    func addObserverForTimeZoneChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkModified(_:)) , name: NSNotification.Name("connectionChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(timeZoneChanged), name: UIApplication.significantTimeChangeNotification, object: nil)
    }
    
    @objc func networkModified(_ notification: NSNotification) {
        
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let status = dict["Type"] as? String{
                DispatchQueue.main.async {
                    if status == ReachabilityManager.ReachabilityStatus.notConnected.rawValue  {
                        
                        self.toCreateToast("Please check your internet connection.")
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                        self.setupNoNetworkAlert()
                        
                    } else if  status == ReachabilityManager.ReachabilityStatus.wifi.rawValue || status ==  ReachabilityManager.ReachabilityStatus.cellular.rawValue   {
                        
                        self.toCreateToast("You are now connected.")
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
                        self.timeZoneChanged()
                    }
                }
            }
        }
    }
    
    func checkReachability() {
        network.isReachable() {  reachability in
            
            
            switch reachability.reachability.connection {
                
            case .unavailable, .none:
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                self.setupNoNetworkAlert()
            case .wifi, .cellular:
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
               
            }
            
         
        }

        network.isUnreachable() { reachability in
         
            
            switch reachability.reachability.connection {
                
            case .unavailable, .none:
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                self.setupNoNetworkAlert()
            case .wifi, .cellular:
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
             
                
            }
        }
       
        
    }
        
    
    func setupUI() {
        btnLogout.layer.cornerRadius = 5
        btnLogout.layer.borderWidth = 1
        btnLogout.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.2).cgColor
        btnLogout.isHidden = true
        lblMenuTitle.text = ""
        //OOPS! you have accidentally changes time zone. Set the time zone to update automatically.
        SplashImageHolderView.elevate(2, shadowColor: .lightGray, opacity: 0.5)
        imgAppIcon.clipsToBounds = true
        SplashImageHolderView.layer.cornerRadius = 12
        imgAppIcon.layer.cornerRadius  = 12
        
        if splashVC.isTimeZoneChanged {
            self.setUIfortimeZoneChanges()
        }
    }

    @IBAction func didTapLogout(_ sender: Any) {
        Pipelines.shared.doLogout()
    }
    
    @objc func timeZoneChanged() {
        //var isManualTimeZoneChange = false
        Pipelines.shared.requestAuth() {[weak self] coordinates in
            guard let welf = self else {return}
            guard let nonNilcoordinates = coordinates else {
                welf.toSetupAlert(text: "Location permission reqired.")
                welf.setupNoGPSalert()
                return}
            
            let location = CLLocation(latitude: nonNilcoordinates.latitude ?? Double(), longitude: nonNilcoordinates.longitude ?? Double())
           // let now = location.timestamp
            if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
                CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                    guard let placemark = placemarks?.first else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }

                    if let timeZone = placemark.timeZone {
                        let actualTimeZone = timeZone.identifier
                        var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
                        if actualTimeZone == localTimeZoneIdentifier {
                            welf.onSetRootViewController()
                            LocalStorage.shared.setBool(LocalStorage.LocalValue.isTimeZoneChanged, value: false)
                            welf.lblMenuTitle.text = "Welcome back!"
                            welf.btnLogout.isHidden = true
                            return
                        } else {
                            welf.toSetupAlert(text: "Oops! Time zone changed. Changing time zone can affect app behavior.")
                            LocalStorage.shared.setBool(LocalStorage.LocalValue.isTimeZoneChanged, value: true)
                            welf.setUIfortimeZoneChanges()
                        }
                    } else {
                        print("Unable to determine user timezone")
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isTimeZoneChanged, value: true)
                  
                    }
                }
            } else {
             
                    welf.setupNoNetworkAlert()
         
              
            }
        }
        
        

     }
    
    func toSetupAlert(text: String, istoValidate : Bool? = false) {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "E - Detailing", alertDescription: text, okAction: "Ok")
        commonAlert.addAdditionalOkAction(isForSingleOption: true) {
            print("no action")
            self.openSettings()

   
        }
    }
    
    func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func onSetRootViewController()
    {
        splashVC.callStartupActions()

    }

}
