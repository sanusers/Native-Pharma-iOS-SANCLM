//
//  CallViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 11/08/23.
//

import Foundation


class CallListViewModel {
    
    private var callListArray =  [CallViewModel]()
    
    
    func fetchDataAtIndex(index : Int, type : DCRType) -> CallViewModel {
        
        switch type {
            
            case .doctor:
                let doctor = DBManager.shared.getDoctor()
                return CallViewModel(call: doctor[index], type: .doctor)
            case .chemist:
                let chemist = DBManager.shared.getChemist()
                return CallViewModel(call: chemist[index], type: .chemist)
            case .stockist:
                let stockist = DBManager.shared.getStockist()
                return CallViewModel(call: stockist[index], type: .stockist)
            case .unlistedDoctor:
                let unlistedDoctor = DBManager.shared.getUnListedDoctor()
                return CallViewModel(call: unlistedDoctor[index], type: .unlistedDoctor)
            case .hospital:
                let doctor = DBManager.shared.getDoctor()
                return CallViewModel(call: doctor[index], type: .hospital)
            case .cip:
                let doctor = DBManager.shared.getDoctor()
                return CallViewModel(call: doctor[index], type: .cip)
        }
    }
    
    func numberofDoctorsRows(_ type : DCRType) -> Int {
        switch type {
        case .doctor:
            return DBManager.shared.getDoctor().count
        case .chemist:
            return DBManager.shared.getChemist().count
        case .stockist:
            return DBManager.shared.getStockist().count
        case .unlistedDoctor:
            return DBManager.shared.getUnListedDoctor().count
        case .hospital:
            return DBManager.shared.getDoctor().count
        case .cip:
            return DBManager.shared.getDoctor().count
        }
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


 
struct DcrActivityType {
    
    var name : String
    var type : DCRType
}
