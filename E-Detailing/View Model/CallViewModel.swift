//
//  CallViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 11/08/23.
//

import Foundation
import CoreLocation


typealias filterDoctorsCallBack = (_ doctors: [DoctorFencing]) -> Void

class CallListViewModel {
    
    private var callListArray =  [CallViewModel]()
    private var dcrActivityList = [DcrActivityViewModel]()
    
    var doctors = [DoctorFencing]()
    var chemists = [Chemist]()
    var stockists = [Stockist]()
    var unListedDoctors = [UnListedDoctor]()
    
    func fetchDataAtIndex(index : Int, type : DCRType, searchText : String) -> CallViewModel {
        
        
        switch type {
            case .doctor:
                
//                let doctors = searchText == "" ? DBManager.shared.getDoctor() :  DBManager.shared.getDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
//                    return CallViewModel(call: doctors[index], type: .doctor)
                return self.fetchDoctorAtIndex(index: index, type: .doctor, searchText: searchText)
            case .chemist:
//                let chemists = searchText == "" ? DBManager.shared.getChemist() :  DBManager.shared.getChemist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
//                return CallViewModel(call: chemists[index], type: .chemist)
            return self.fetchChemistAtIndex(index: index, type: .chemist, searchText: searchText)
            case .stockist:
//                let stockists = searchText == "" ? DBManager.shared.getStockist() :  DBManager.shared.getStockist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
//                return CallViewModel(call: stockists[index], type: .stockist)
                return fetchStockistAtIndex(index: index, type: .stockist, searchText: searchText)
            case .unlistedDoctor:
//                let unlistedDoctor = searchText == "" ? DBManager.shared.getUnListedDoctor() :  DBManager.shared.getUnListedDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
//                return CallViewModel(call: unlistedDoctor[index], type: .unlistedDoctor)
                return fetchUnListedDoctorAtIndex(index: index, type: .unlistedDoctor, searchText: searchText)
            case .hospital:
                let doctor = DBManager.shared.getDoctor()
                return CallViewModel(call: doctor[index], type: .hospital)
            case .cip:
                let doctor = DBManager.shared.getDoctor()
                return CallViewModel(call: doctor[index], type: .cip)
        }
    }
    
    func fetchDoctorAtIndex(index : Int, type : DCRType, searchText : String) -> CallViewModel {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        if appsetup.geoTagNeed == 1 {
            let doctorS = searchText == "" ? self.doctors : self.doctors.filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: doctorS[index], type: .doctor)
            
        }else {
            let doctors = searchText == "" ? DBManager.shared.getDoctor() : DBManager.shared.getDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: doctors[index], type: .doctor)
        }
    }
    
    func fetchChemistAtIndex(index : Int, type : DCRType, searchText : String) -> CallViewModel {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        if appsetup.geoTagNeedChe == 1 {
            let chemists = searchText == "" ? self.chemists :  self.chemists.filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: chemists[index], type: .chemist)
        }else {
            let chemists = searchText == "" ? DBManager.shared.getChemist() :  DBManager.shared.getChemist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: chemists[index], type: .chemist)
        }
    }
    
    func fetchStockistAtIndex(index : Int, type : DCRType, searchText : String) -> CallViewModel {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        if appsetup.geoTagNeedStock == 1 {
            let stockists = searchText == "" ? self.stockists :  self.stockists.filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: stockists[index], type: .stockist)
        }else {
            let stockists = searchText == "" ? DBManager.shared.getStockist() :  DBManager.shared.getStockist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: stockists[index], type: .stockist)
        }
    }
    
    func fetchUnListedDoctorAtIndex(index : Int, type : DCRType, searchText : String) -> CallViewModel {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        if appsetup.geoTagNeedUnList == 1 {
            let unlistedDoctor = searchText == "" ? self.unListedDoctors : self.unListedDoctors.filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: unlistedDoctor[index], type: .unlistedDoctor)
        }else {
            let unlistedDoctor = searchText == "" ? DBManager.shared.getUnListedDoctor() :  DBManager.shared.getUnListedDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: unlistedDoctor[index], type: .unlistedDoctor)
        }
        
    }
    
    func fetchDoctorBasedonLocation() -> [DoctorFencing]{
        var doctors = DBManager.shared.getDoctor()
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        var radiusL = CLLocationDistance()
        if let radius = appsetup.disRad{
            if let radiusFloat = Float(radius){
                let radiusmeter = radiusFloat * 1300
                radiusL = CLLocationDistance(radiusmeter)
            }
        }
        
        let coordinate = LocationManager.shared.currentLocation
        
        
        if let coordinate = coordinate {
            let currentLocation: CLLocation = CLLocation(latitude: coordinate.latitude,
                                                         longitude: coordinate.longitude)
            var filterdDoc = [DoctorFencing]()
            for item in doctors{
                if item.lat != "" && item.long != ""{
                    let doctorLat: CLLocationDegrees = CLLocationDegrees(item.lat!)!
                    let doctorLon: CLLocationDegrees = CLLocationDegrees(item.long!)!
                    
                    let doctorLocation: CLLocation = CLLocation(latitude: doctorLat, longitude: doctorLon)
                    let distanceInMeters: CLLocationDistance = currentLocation.distance(from: doctorLocation)
                    if(distanceInMeters <= radiusL)
                    {
                        filterdDoc.append(item)
                    }
                }
            }
            doctors.removeAll()
            
            var out = [DoctorFencing]()

            for element in filterdDoc {
                let itms=out.filter { $0.code == element.code}
                if itms.count<1 {
                    out.append(element)
                }
            }
            
            doctors = out
            
            self.doctors = doctors
            return doctors
        }else {
            print("Location Nil")
        }
        return [DoctorFencing]()
    }
    
    func fetchChemistBasedonLocation() -> [Chemist]{
        var chemists = DBManager.shared.getChemist()
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        var radiusL = CLLocationDistance()
        if let radius = appsetup.disRad{
            if let radiusFloat = Float(radius){
                let radiusmeter = radiusFloat * 1300
                radiusL = CLLocationDistance(radiusmeter)
            }
        }
        
        let coordinate = LocationManager.shared.currentLocation
        
        
        if let coordinate = coordinate {
            let currentLocation: CLLocation = CLLocation(latitude: coordinate.latitude,
                                                         longitude: coordinate.longitude)
            var filterdChm = [Chemist]()
            for item in chemists{
                if item.lat != "" && item.long != ""{
                    let chemistLat: CLLocationDegrees = CLLocationDegrees(item.lat!)!
                    let chemistLon: CLLocationDegrees = CLLocationDegrees(item.long!)!
                    
                    let chemistLocation: CLLocation = CLLocation(latitude: chemistLat, longitude: chemistLon)
                    let distanceInMeters: CLLocationDistance = currentLocation.distance(from: chemistLocation)
                    if(distanceInMeters <= radiusL)
                    {
                        filterdChm.append(item)
                    }
                }
            }
            chemists.removeAll()
            
            var out = [Chemist]()

            for element in filterdChm {
                let itms=out.filter { $0.code == element.code}
                if itms.count<1 {
                    out.append(element)
                }
            }
            
            chemists = out
            
            self.chemists = chemists
            return chemists
        }else {
            print("Location Nil")
        }
        
        return [Chemist]()
    }
    
    func fetchStockistBasedonLocation() -> [Stockist]{
        var stockists = DBManager.shared.getStockist()
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        var radiusL = CLLocationDistance()
        if let radius = appsetup.disRad{
            if let radiusFloat = Float(radius){
                let radiusmeter = radiusFloat * 1300
                radiusL = CLLocationDistance(radiusmeter)
            }
        }
        
        let coordinate = LocationManager.shared.currentLocation
        
        
        if let coordinate = coordinate {
            let currentLocation: CLLocation = CLLocation(latitude: coordinate.latitude,
                                                         longitude: coordinate.longitude)
            var filterdStk = [Stockist]()
            for item in stockists{
                if item.lat != "" && item.long != ""{
                    let stockistLat: CLLocationDegrees = CLLocationDegrees(item.lat!)!
                    let stockistLon: CLLocationDegrees = CLLocationDegrees(item.long!)!
                    
                    let stockistLocation: CLLocation = CLLocation(latitude: stockistLat, longitude: stockistLon)
                    let distanceInMeters: CLLocationDistance = currentLocation.distance(from: stockistLocation)
                    if(distanceInMeters <= radiusL)
                    {
                        filterdStk.append(item)
                    }
                }
            }
            stockists.removeAll()
            
            var out = [Stockist]()

            for element in filterdStk {
                let itms=out.filter { $0.code == element.code}
                if itms.count<1 {
                    out.append(element)
                }
            }
            
            stockists = out
            
            self.stockists = stockists
            return stockists
        }else {
            print("Location Nil")
        }
        
        return [Stockist]()
    }
    
    func fetchUnListedDoctorBasedonLocation() -> [UnListedDoctor]{
        var unListedDoctors = DBManager.shared.getUnListedDoctor()
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        var radiusL = CLLocationDistance()
        if let radius = appsetup.disRad{
            if let radiusFloat = Float(radius){
                let radiusmeter = radiusFloat * 1300
                radiusL = CLLocationDistance(radiusmeter)
            }
        }
        
        let coordinate = LocationManager.shared.currentLocation
        
        
        if let coordinate = coordinate {
            let currentLocation: CLLocation = CLLocation(latitude: coordinate.latitude,
                                                         longitude: coordinate.longitude)
            var filterdDoc = [UnListedDoctor]()
            for item in unListedDoctors{
                if item.lat != "" && item.long != ""{
                    let doctorLat: CLLocationDegrees = CLLocationDegrees(item.lat!)!
                    let doctorLon: CLLocationDegrees = CLLocationDegrees(item.long!)!
                    
                    let doctorLocation: CLLocation = CLLocation(latitude: doctorLat, longitude: doctorLon)
                    let distanceInMeters: CLLocationDistance = currentLocation.distance(from: doctorLocation)
                    if(distanceInMeters <= radiusL)
                    {
                        filterdDoc.append(item)
                    }
                }
            }
            unListedDoctors.removeAll()
            
            var out = [UnListedDoctor]()

            for element in filterdDoc {
                let itms=out.filter { $0.code == element.code}
                if itms.count<1 {
                    out.append(element)
                }
            }
            
            unListedDoctors = out
            
            self.unListedDoctors = unListedDoctors
            return unListedDoctors
        }else {
            print("Location Nil")
        }
        
        return [UnListedDoctor]()
    }
    
    
    func numberofDoctorsRows(_ type : DCRType, searchText : String) -> Int {
        let appsetup = AppDefaults.shared.getAppSetUp()
        switch type {
        case .doctor:
            self.doctors = self.fetchDoctorBasedonLocation()
            
            if  appsetup.geoTagNeed == 1{
                let doctors = searchText == "" ? self.doctors : self.doctors.filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return doctors.count
            }
            
            let doctors = searchText == "" ? DBManager.shared.getDoctor() : DBManager.shared.getDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return doctors.count
        case .chemist:
            self.chemists = self.fetchChemistBasedonLocation()
            
            if appsetup.geoTagNeedChe == 1 {
                let chemists = searchText == "" ? self.chemists : self.chemists.filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return chemists.count
            }
            
            let chemists = searchText == "" ? DBManager.shared.getChemist() : DBManager.shared.getChemist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return chemists.count
        case .stockist:
            self.stockists = self.fetchStockistBasedonLocation()
            
            if appsetup.geoTagNeedStock == 1{
                let stockists = searchText == "" ? self.stockists : self.stockists.filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return stockists.count
            }
            let stockists = searchText == "" ? DBManager.shared.getStockist() : DBManager.shared.getStockist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return stockists.count
        case .unlistedDoctor:
            self.unListedDoctors = self.fetchUnListedDoctorBasedonLocation()
            
            if appsetup.geoTagNeedUnList == 1 {
                let unlistedDoctors = searchText == "" ? self.unListedDoctors : self.unListedDoctors.filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return unlistedDoctors.count
            }
            let unlistedDoctors = searchText == "" ? DBManager.shared.getUnListedDoctor() :  DBManager.shared.getUnListedDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return unlistedDoctors.count
        case .hospital:
            return DBManager.shared.getDoctor().count
        case .cip:
            return DBManager.shared.getDoctor().count
        }
    }
    
    func addDcrActivity(_ vm : DcrActivityViewModel){
        dcrActivityList.append(vm)
    }
    
    func fetchAtIndex(_ index : Int) -> DcrActivityViewModel {
        return dcrActivityList[index]
    }
    
    func numberofDcrs() -> Int {
        return dcrActivityList.count
    }
}


class CallViewModel {
    
    let call : AnyObject
    let type : DCRType
    
    init(call: AnyObject, type: DCRType) {
        self.call = call
        self.type = type
    }
    
    var name : String {
        return call.name ?? ""
    }
    
    var code : String {
        return call.code ?? ""
    }
    
    var townCode : String {
        return call.townCode ?? ""
    }
    
    var townName : String {
        return call.townName ?? ""
    }
    
    var cateCode : String {
        if type == DCRType.doctor {
            return call.categoryCode ?? ""
        }
        return ""
    }
    
    var categoryName : String {
        if type == DCRType.doctor {
            return call.category ?? ""
        }
        return ""
    }
    
    var specialityCode : String {
        if type == DCRType.doctor {
            return call.specialityCode ?? ""
        }
        return ""
    }
    
    var specialityName : String {
        if type == DCRType.doctor {
            return call.speciality ?? ""
        }
        return ""
    }
    
}


class DcrActivityViewModel {
    
    let activityType : DcrActivityType
    
    init(activityType: DcrActivityType) {
        self.activityType = activityType
    }
    
    var name : String {
        return activityType.name
    }
    
    var type : DCRType {
        return activityType.type
    }
}
 
struct DcrActivityType {
    
    var name : String
    var type : DCRType
}




//func fetchDoctor(docCompletion : @escaping filterDoctorsCallBack){ //
//    var doctors = DBManager.shared.getDoctor()
//    
//    let appsetup = AppDefaults.shared.getAppSetUp()
//    
//    var radiusL = CLLocationDistance()
//    if let radius = appsetup.disRad{
//        if let radiusFloat = Float(radius){
//            let radiusmeter = radiusFloat * 1300
//            radiusL = CLLocationDistance(radiusmeter)
//        }
//    }
//    
//    LocationManager.shared.getCurrentLocation { (coordinate) in
//        let currentLocation: CLLocation = CLLocation(latitude: coordinate.latitude,
//                                                     longitude: coordinate.longitude)
//        var filterdDoc = [DoctorFencing]()
//        for item in doctors{
//            if item.lat != "" && item.long != ""{
//                let doctorLat: CLLocationDegrees = CLLocationDegrees(item.lat!)!
//                let doctorLon: CLLocationDegrees = CLLocationDegrees(item.long!)!
//                
//                let doctorLocation: CLLocation = CLLocation(latitude: doctorLat, longitude: doctorLon)
//                let distanceInMeters: CLLocationDistance = currentLocation.distance(from: doctorLocation)
//                if(distanceInMeters <= radiusL)
//                {
//                    filterdDoc.append(item)
//                }
//            }
//        }
//        doctors.removeAll()
//        
//        var out = [DoctorFencing]()
//
//        for element in filterdDoc {
//            let itms=out.filter { $0.code == element.code}
//            if itms.count<1 {
//                out.append(element)
//            }
//        }
//        
//        doctors = out //filterdDoc
//        docCompletion(filterdDoc)
//    }
//}
