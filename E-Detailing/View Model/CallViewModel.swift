//
//  CallViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 11/08/23.
//

import Foundation


class CallListViewModel {
    
    private var callListArray =  [CallViewModel]()
    private var dcrActivityList = [DcrActivityViewModel]()
    
    func fetchDataAtIndex(index : Int, type : DCRType, searchText : String) -> CallViewModel {
        
        
        switch type {
            case .doctor:
//                let doctors = searchText == "" ? DBManager.shared.getDoctor() :  DBManager.shared.getDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
//                    return CallViewModel(call: doctors[index], type: .doctor)
                return self.fetchDoctorAtIndex(index: index, type: .doctor, searchText: searchText)
            case .chemist:
                let chemists = searchText == "" ? DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)) :  DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            let aCallViewmodel = CallViewModel(call: chemists[index], type: .chemist)
            return aCallViewmodel.toRetriveDCRdata(dcrcall: aCallViewmodel.call)
              //  return CallViewModel(call: chemists[index], type: .chemist)
            case .stockist:
                let stockists = searchText == "" ? DBManager.shared.getStockist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)) :  DBManager.shared.getStockist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            let aCallViewmodel = CallViewModel(call: stockists[index], type: .stockist)
            return aCallViewmodel.toRetriveDCRdata(dcrcall: aCallViewmodel.call)
            
              //  return CallViewModel(call: stockists[index], type: .stockist)
            case .unlistedDoctor:
                let unlistedDoctor = searchText == "" ? DBManager.shared.getUnListedDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)) :  DBManager.shared.getUnListedDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            
            let aCallViewmodel = CallViewModel(call: unlistedDoctor[index], type: .unlistedDoctor)
            return aCallViewmodel.toRetriveDCRdata(dcrcall: aCallViewmodel.call)
            
              //  return CallViewModel(call: unlistedDoctor[index], type: .unlistedDoctor)
            case .hospital:
                let doctor = DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
             //   return CallViewModel(call: doctor[index], type: .hospital)
            
            let aCallViewmodel = CallViewModel(call: doctor[index], type: .hospital)
            return aCallViewmodel.toRetriveDCRdata(dcrcall: aCallViewmodel.call)
           
            case .cip:
                let doctor = DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            
            let aCallViewmodel = CallViewModel(call: doctor[index], type: .cip)
            return aCallViewmodel.toRetriveDCRdata(dcrcall: aCallViewmodel.call)
            
               // return CallViewModel(call: doctor[index], type: .cip)
        }
    }
    
    func fetchDoctorAtIndex(index : Int, type : DCRType, searchText : String) -> CallViewModel {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        
        if appsetup.geoTagNeed == 0 {
            
        }else {
            
        }
        let doctors = searchText == "" ? DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)) :  DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
        
        let docObj = doctors[index] 
        let aCallViewmodel = CallViewModel(call: docObj , type: .doctor)
        return aCallViewmodel.toRetriveDCRdata(dcrcall: aCallViewmodel.call)
    }
    
    
    func numberofDoctorsRows(_ type : DCRType, searchText : String) -> Int {
        switch type {
        case .doctor:
            let doctors = searchText == "" ? DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)) :  DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return doctors.count
        case .chemist:
            let chemists = searchText == "" ? DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)) :  DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return chemists.count
        case .stockist:
            let stockists = searchText == "" ? DBManager.shared.getStockist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)) :  DBManager.shared.getStockist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return stockists.count
        case .unlistedDoctor:
            let unlistedDoctors = searchText == "" ? DBManager.shared.getUnListedDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)) :  DBManager.shared.getUnListedDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return unlistedDoctors.count
        case .hospital:
            return DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).count
        case .cip:
            return DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)).count
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
    
    
    
    var name: String = ""
    var code: String = ""
    var dob: String = ""
    var dow: String = ""
    var mobile: String = ""
    var email: String = ""
    var address: String = ""
    var qualification: String = ""
    var category: String = ""
    var speciality: String = ""
    var territory: String = ""
    var cateCode: String = ""
    var specialityCode : String = ""
    var townCode : String = ""
    var townName : String = ""
    init(call: AnyObject, type: DCRType) {
        self.call = call
        self.type = type
    }
    
    func toRetriveDCRdata(dcrcall: AnyObject?) -> CallViewModel {
        switch self.type {
            
        case .doctor:
            if let doccall = dcrcall as? DoctorFencing {
               name = doccall.name ?? ""
               code = doccall.code ?? ""
               dob = doccall.dob ?? ""
               dow = doccall.dow ?? ""
               mobile = doccall.mobile ?? ""
               email = doccall.docEmail ?? ""
               address = doccall.addrs ?? ""
               qualification = doccall.docDesig ?? ""
               category = doccall.category ?? ""
               speciality = doccall.speciality ?? ""
                territory = doccall.townName ?? ""
                townCode = doccall.townCode ?? ""
                specialityCode = doccall.specialityCode ?? ""
                cateCode = doccall.categoryCode ?? ""
            }
        case .chemist:
            if let doccall = dcrcall as? Chemist {
               name = doccall.name ?? ""
               code = doccall.code ?? ""
  
               mobile = doccall.chemistMobile ?? ""
               email = doccall.chemistEmail ?? ""
               address = doccall.addr ?? ""
            
               category =  ""
               speciality =  ""
                territory = doccall.townName ?? ""
                townCode = doccall.townCode ?? ""
                specialityCode = ""
                cateCode = ""
            }
        case .stockist:
            if let doccall = dcrcall as? Stockist {
               name = doccall.name ?? ""
               code = doccall.code ?? ""
       
               mobile = doccall.stkMobile ?? ""
               email = doccall.stkEmail ?? ""
               address = doccall.addr ?? ""
            
               category =  ""
               speciality =  ""
                territory = doccall.townName ?? ""
                townCode = doccall.townCode ?? ""
                specialityCode = ""
                cateCode = ""
                
            }
        case .unlistedDoctor:
            if let doccall = dcrcall as? UnListedDoctor {
               name = doccall.name ?? ""
               code = doccall.code ?? ""
               dob = ""
               dow = ""
               mobile = doccall.mobile ?? ""
               email = doccall.email ?? ""
               address = doccall.addrs ?? ""
               qualification =  ""
               category = doccall.category ?? ""
               speciality = doccall.specialtyName ?? ""
                territory = doccall.townName ?? ""
                townCode = doccall.townCode ?? ""
                specialityCode = ""
                cateCode = ""
            }
        case .hospital:
            print("Yet yo implement")
        case .cip:
            print("Yet yo implement")
        }
        return self
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
