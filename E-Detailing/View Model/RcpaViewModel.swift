//
//  RcpaViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 02/09/23.
//

import Foundation


class RcpaListViewModel {
    
    private var rcpaListViewModel = [RcpaViewModel]()
    
    
    func addRcpaCompetitor (_ VM : RcpaViewModel) {
        rcpaListViewModel.insert(VM, at: 0)
    }
    
    func numberOfCompetitorRows() -> Int {
        return rcpaListViewModel.count
    }
    
    
    func removeAtIndex(_ index : Int) {
        rcpaListViewModel.remove(at: index)
    }
    
    
}

class RcpaViewModel {
    
    let rcpaHeaderData : RcpaHeaderData
    
    init(rcpaHeaderData: RcpaHeaderData) {
        self.rcpaHeaderData = rcpaHeaderData
    }
    
    
    
}


struct RcpaHeaderData {
    
    var chemist : AnyObject
    
    var product : AnyObject
    
    var quantity : String
    
    var total : String
    
    var rate : String
    
    
    
    
}
