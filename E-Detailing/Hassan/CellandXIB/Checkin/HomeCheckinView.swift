//
//  HomeCheckinView.swift
//  E-Detailing
//
//  Created by San eforce on 28/02/24.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import CoreData


struct CheckinInfo {
    let address: String?
    let checkinDateTime: String?
    let latitude: Double?
    let longitude: Double?
}

class HomeCheckinView: UIView, CLLocationManagerDelegate {
    @IBOutlet var checkinBtn: ShadowButton!
    
    @IBOutlet var closeIV: UIImageView!
    @IBOutlet var notifyLbl: UILabel!
    @IBOutlet var dateTimeLbl: UILabel!
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var checkinTitltLbl: UILabel!
    var appsetup : AppSetUp?
    var delegate:  addedSubViewsDelegate?
    var userstrtisticsVM: UserStatisticsVM?
    var locManager : CLLocationManager?
    var currentLocation: CLLocation?
    var latitude: Double?
    var longitude: Double?
    var address: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override init(frame: CGRect) {
        super.init(frame: frame)
      

    }
    
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
       
     }
    
    func requestAuth(completion: @escaping (Bool) -> Void) {
        guard let locManager = locManager, var currentLocation = currentLocation else {
            completion(false)
            return
        }

        locManager.delegate = self

        locManager.requestWhenInUseAuthorization()

        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location ?? CLLocation()
            latitude = (currentLocation.coordinate.latitude)
            longitude = (currentLocation.coordinate.longitude)
  completion(true)
        } else {
            completion(false)
            delegate?.showAlert()
        }
    }
    
    

    
    


    func getAddressString(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()

        let location = CLLocation(latitude: latitude, longitude: longitude)

        geocoder.reverseGeocodeLocation(location) { (places, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let place = places?.first {
                var addressString = ""
                if let subThoroughfare = place.subThoroughfare {
                    addressString += "\(subThoroughfare),"
                }
                
                if let thoroughfare = place.thoroughfare {
                    addressString += " \(thoroughfare),"
                }

        

                if let locality = place.locality {
                    addressString += " \(locality),"
                }

                if let administrativeArea = place.administrativeArea {
                    addressString += " \(administrativeArea),"
                }

                if let postalCode = place.postalCode {
                    addressString += " \(postalCode)"
                }

                completion(addressString)
            } else {
                completion(nil)
            }
        }
    }
    
    func  callAPI() {
        guard let appsetup = self.appsetup else {return}
        
//    http://edetailing.sanffa.info/iOSServer/db_api.php/?axn=save%2Factivity
//
//    {
//    "tableName": "savetp_attendance",
//    "sfcode": "MR5940",
//    "division_code": "63,",
//    "lat": 13.03001856,
//    "long": 80.24146891,
//    "address": "No 4, Pasumpon Muthuramalinga Thevar Rd, Nandanam Extension, Nandanam, Chennai, Tamil Nadu 600035, India",
//    "update": "0",
//    "Appver": "V2.0.8",
//    "Mod": "Android-Edet",
//    "sf_emp_id": "12",
//    "sfname": "Shiva Kumar MR 1",
//    "Employee_Id": "",
//    "Check_In": "14:19:54",
//    "Check_Out": "",
//    "DateTime": "2024-02-28 14:19:54"
//    }
        ///date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)

        let datestr = dateString
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let upDatedDateString = dateFormatter.string(from: currentDate)
        
        
        ///time
        dateFormatter.dateFormat = "HH:mm:ss"

        let timeString = dateFormatter.string(from: currentDate)

        let timestr = (timeString)
        
        
        var param: [String: Any] = [:]
        param["tableName"] = "savetp_attendance"
        param["sfcode"] = appsetup.sfCode
        param["division_code"] = appsetup.divisionCode
        param["lat"] = latitude
        param["long"] = longitude
        param["address"] = address
        param["update"] = "0"
        param["Appver"] = "V2.0.8"
        param["Mod"] = "iOS-Edet"
        param["sf_emp_id"] = appsetup.sfEmpId
        param["sfname"] = appsetup.sfName
        param["Employee_Id"] = appsetup.sfName
        param["Check_In"] = timestr
        param["Check_Out"] = ""
        param["DateTime"] = datestr
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)

        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        print(param)
        
        self.userstrtisticsVM?.registerCheckin(params: toSendData, api: .checkin, paramData: param) { result in

            switch result {

            case .success(let response):
                self.toCreateToast(response.success ?? "Checkin registered successfully")

                LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserCheckedin, value: true)

                LocalStorage.shared.setSting(LocalStorage.LocalValue.lastCheckedInDate, text: upDatedDateString)

                self.saveLogininfoToCoreData() {_ in
                    
                    self.delegate?.didUpdate()
                    
                }
                
               
                
            case .failure(let error):
                self.toCreateToast(error.rawValue)
                
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserCheckedin, value: true)

                LocalStorage.shared.setSting(LocalStorage.LocalValue.lastCheckedInDate, text: upDatedDateString)
                
                self.saveLogininfoToCoreData() {_ in
                    
                    self.delegate?.didUpdate()
                    
                }
                
          
            }

        }
    }
    
    
    
    
    func saveLogininfoToCoreData(completion: @escaping (Bool) -> Void) {
        

        
        let checkinInfo =  CheckinInfo(address: self.address, checkinDateTime: self.getCurrentFormattedDateString(), latitude: self.latitude ?? Double(), longitude: self.longitude ?? Double())
        CoreDataManager.shared.removeAllCheckins()
        
        CoreDataManager.shared.saveCheckinsToCoreData(checkinInfo: checkinInfo) {isCompleted in
            completion(true)
        }
    }
    
    func getCurrentFormattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        return dateFormatter.string(from: Date())
    }
    
    @IBAction func didTapCheckin(_ sender: Any) {
        
        locManager = CLLocationManager()
        currentLocation = CLLocation()
        requestAuth() {[weak self] isPermissiongranted in
            guard let welf = self else {return}
            if isPermissiongranted {
                welf.getAddressString(latitude:   welf.latitude ?? Double(), longitude:   welf.longitude ?? Double()) {address in
                    welf.address = address
                    
                    if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
                        welf.callAPI()
                    } else {
                        self?.toCreateToast("Please connect to network to register login")
                    }
                  
                }
            } else {
                return
            }
        }
      //  let appsetup = AppDefaults.shared.getAppSetUp()
        
   
        
    }
    
    func setupUI() {
        
        
        self.layer.cornerRadius = 5
        checkinTitltLbl.setFont(font: .bold(size: .SUBHEADER))
        userNameLbl.setFont(font: .bold(size: .BODY))
        dateTimeLbl.setFont(font: .medium(size: .BODY))
        notifyLbl.setFont(font: .bold(size: .BODY))
        notifyLbl.textColor = .appLightTextColor
        checkinTitltLbl.textColor = .appTextColor
        userNameLbl.textColor = .appTextColor
        dateTimeLbl.textColor = .appTextColor
        
        closeIV.addTap {
            self.delegate?.didClose()
            
        }
        
        dateTimeLbl.text = getCurrentFormattedDateString()
        let wavingHandEmoji = "\u{1F44B}"
        
        
        guard let username = appsetup?.sfName else {
            return
        }
        
        userNameLbl.text = "Hi \(username)! \(wavingHandEmoji)"
        
        
    }
    
}


extension CoreDataManager {
    
    func removeAllCheckins() {
        let fetchRequest: NSFetchRequest<ChekinInfo> = NSFetchRequest(entityName: "ChekinInfo")

        do {
            let slideBrands = try context.fetch(fetchRequest)
            for brand in slideBrands {
                context.delete(brand)
            }

            try context.save()
        } catch {
            print("Error deleting slide brands: \(error)")
        }
    }
    
    
    func saveCheckinsToCoreData(checkinInfo: CheckinInfo, completion: (Bool) -> ()) {
      
        
                let context = self.context
                // Create a new managed object
                if let entityDescription = NSEntityDescription.entity(forEntityName: "ChekinInfo", in: context) {
                    let savedCDChekinInfo = ChekinInfo(entity: entityDescription, insertInto: context)

                    // Convert properties
                    savedCDChekinInfo.address = checkinInfo.address
                    savedCDChekinInfo.checkinDateTime = checkinInfo.checkinDateTime
                    savedCDChekinInfo.latitude = checkinInfo.latitude ?? Double()
                    savedCDChekinInfo.longitude = checkinInfo.longitude ?? Double()
                    // Save to Core Data
                    do {
                        try context.save()
                        completion(true)
                    } catch {
                        print("Failed to save to Core Data: \(error)")
                        completion(false)
                    }
                }
          
        
    }
    
    func fetchCheckininfo(completion: ([ChekinInfo]) -> () )  {
        do {
           let savedChekinInfo = try  context.fetch(ChekinInfo.fetchRequest())
            completion(savedChekinInfo )
            
        } catch {
            print("unable to fetch movies")
        }
       
    }
}
