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
                let chemists = searchText == "" ? DBManager.shared.getChemist() :  DBManager.shared.getChemist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return CallViewModel(call: chemists[index], type: .chemist)
            case .stockist:
                let stockists = searchText == "" ? DBManager.shared.getStockist() :  DBManager.shared.getStockist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return CallViewModel(call: stockists[index], type: .stockist)
            case .unlistedDoctor:
                let unlistedDoctor = searchText == "" ? DBManager.shared.getUnListedDoctor() :  DBManager.shared.getUnListedDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return CallViewModel(call: unlistedDoctor[index], type: .unlistedDoctor)
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
        
        
        if appsetup.geoTagNeed == 0 {
            
        }else {
            
        }
        let doctors = searchText == "" ? DBManager.shared.getDoctor() :  DBManager.shared.getDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return CallViewModel(call: doctors[index], type: .doctor)
    }
    
    
    func numberofDoctorsRows(_ type : DCRType, searchText : String) -> Int {
        switch type {
        case .doctor:
            let doctors = searchText == "" ? DBManager.shared.getDoctor() :  DBManager.shared.getDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return doctors.count
        case .chemist:
            let chemists = searchText == "" ? DBManager.shared.getChemist() :  DBManager.shared.getChemist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return chemists.count
        case .stockist:
            let stockists = searchText == "" ? DBManager.shared.getStockist() :  DBManager.shared.getStockist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return stockists.count
        case .unlistedDoctor:
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
