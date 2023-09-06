//
//  TaggingViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 30/08/23.
//

import Foundation



class CustomerListViewModel {
    
    let customerListViewModel = [CustomerViewModel]()
    
    
    func fetchDataAtIndex(_ index : Int , type : TaggingType, searchText : String) -> CustomerViewModel {
        
        
        switch type {
            
            case .doctor:
                let doctors = searchText == "" ? DBManager.shared.getDoctor() : DBManager.shared.getDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return CustomerViewModel(tag: doctors[index], type: .doctor)
            case .chemist:
                let chemists = searchText == "" ? DBManager.shared.getChemist() :  DBManager.shared.getChemist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return CustomerViewModel(tag: chemists[index], type: .chemist)
            case .stockist:
                let stockists = searchText == "" ? DBManager.shared.getStockist() :  DBManager.shared.getStockist().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return CustomerViewModel(tag: stockists[index], type: .stockist)
            case .unlistedDoctor:
                let unListedDoctors = searchText == "" ? DBManager.shared.getUnListedDoctor() :  DBManager.shared.getUnListedDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
                return CustomerViewModel(tag: unListedDoctors[index], type: .unlistedDoctor)
        }
    }
    
    
    func numberOfRows (_ type : TaggingType , searchText : String) -> Int{
        
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
                let unListedDoctors = searchText == "" ? DBManager.shared.getUnListedDoctor() :  DBManager.shared.getUnListedDoctor().filter{($0.name?.lowercased() ?? "").contains(searchText.lowercased())}
            return unListedDoctors.count
        }
    }
    
    
    
}

class CustomerViewModel {
    
    let tag : AnyObject
    let type : TaggingType
    
    
    init(tag: AnyObject, type: TaggingType) {
        self.tag = tag
        self.type = type
    }
    
    var name : String {
        return tag.name ?? ""
    }
    
    var code : String {
        return tag.code ?? ""
    }
    
    var category : String {
        if type == TaggingType.doctor {
            return tag.category ?? ""
        }
        return ""
    }
    
    var townName : String {
        return tag.townName ?? ""
    }
    
    var speciality : String {
        if type == TaggingType.doctor {
            return tag.speciality ?? ""
        }
        return ""
    }
    
    var geoCount : String {
        if type == TaggingType.doctor {
            return tag.geoTagCnt ?? ""
        }
        return ""
    }
    
    var maxCount : String {
        if type == TaggingType.doctor {
            return tag.maxGeoMap ?? ""
        }
        return ""
    }
    
    var tagType : String {
        return type.rawValue
    }
    
    
    
}
