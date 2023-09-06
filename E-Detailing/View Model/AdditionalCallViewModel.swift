//
//  AdditionalCallViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 17/08/23.
//

import Foundation


class AdditionalCallsListViewModel {
    
    private var additionalCallListViewModel = [AdditionalCallViewModel] ()
    
    func addAdditionalCallViewModel(_ vm : AdditionalCallViewModel) {
        additionalCallListViewModel.append(vm)
    }
    
    
    func numberOfSelectedRows() -> Int {
        return additionalCallListViewModel.count
    }
    
    func getAdditionalCallData() -> [AdditionalCallViewModel]{
        return additionalCallListViewModel
    }
    
    func removeAtindex(_ index :Int) {
        additionalCallListViewModel.remove(at: index)
    }
    
    func fetchDataAtIndex(_ index :Int) -> AdditionalCallViewModel {
        return additionalCallListViewModel[index]
    }
    
    func removeById(id : String) {
        additionalCallListViewModel.removeAll{$0.code == id}
    }
        
    func fetchAdditionalCallData(_ index : Int) -> Objects {
        let additionalCall = DBManager.shared.getDoctor()
        
        let value = self.getAdditionalCallData()
        let isSelected = value.filter{$0.code.contains(additionalCall[index].code ?? "")}
        return Objects(Object: additionalCall[index], isSelected:  isSelected.isEmpty ? false : true)
    }
    
    
    func numberofAdditionalCalls() -> Int {
        return DBManager.shared.getDoctor().count
    }
    
}

class AdditionalCallViewModel {
    
    let additionalCall : DoctorFencing
    
    init(additionalCall: DoctorFencing) {
        self.additionalCall = additionalCall
    }
    
    var name : String {
        return additionalCall.name ?? ""
    }
    
    var code : String {
        return additionalCall.code ?? ""
    }
    
    var townCode : String {
        return additionalCall.townCode ?? ""
    }
    
    var townName : String {
        return additionalCall.townName ?? ""
    }
    
}
