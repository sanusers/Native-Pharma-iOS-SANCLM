//
//  RcpaViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 02/09/23.
//

import Foundation

class RcpaAddedListViewModel {
    
    private var rcpaAddedListViewModel = [RcpaAddedViewModel]()
    
    func addRcpaChemist(_ VM : RcpaAddedViewModel) {
        rcpaAddedListViewModel.append(VM)
    }
    
    func addRcpaProductAtSection(_ section : Int , product : rcpaProduct) {
        rcpaAddedListViewModel[section].rcpaChemist.products.append(product)
    }
    
    func addRcpaCompetitorProductAtProduct(_ section : Int,row : Int, product : RcpaHeaderData) {
        rcpaAddedListViewModel[section].rcpaChemist.products[section].rcpas.append(product)
    }
    
    
    func fetchAtRowIndex(_ section : Int , row : Int) -> rcpaProduct {
        return rcpaAddedListViewModel[section].rcpaChemist.products[row]
    }
    
    
    func numberofSections(_ section : Int) -> Int {
        return rcpaAddedListViewModel.count
    }
    
    func numberofRowsInSection(_ section : Int) -> Int{
        return rcpaAddedListViewModel[section].rcpaChemist.products.count
    }
    
    func numberofListsInRows(_ section : Int , row : Int) -> Int {
        return rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas.count
    }
    
    
}

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
    
    
    func fetchAtIndex(_ index : Int) -> RcpaViewModel {
        return rcpaListViewModel[index]
    }
    
    func setCompetitorCompanyAtIndex(_ index : Int,name : String,code : String) {
        rcpaListViewModel[index].rcpaHeaderData.updateCompetitorCompany(name, code: code)
    }
    
    func setCompetitorBrandAtIndex(_ index : Int,name : String,code : String){
        rcpaListViewModel[index].rcpaHeaderData.updateCompetitorBrand(name, code: code)
    }
    
    
}


class RcpaAddedViewModel {
    
    var rcpaChemist : RcpaChemist
    
    init(rcpaChemist: RcpaChemist) {
        self.rcpaChemist = rcpaChemist
    }
    
    
    var chemistName : String {
        return rcpaChemist.chemist.name ?? ""
    }
    
    var chemistCode : String {
        return rcpaChemist.chemist.code ?? ""
    }
    
    
    
    
}


class RcpaViewModel {
    
    var rcpaHeaderData : RcpaHeaderData
    
    init(rcpaHeaderData: RcpaHeaderData) {
        self.rcpaHeaderData = rcpaHeaderData
    }
    
    var productName : String {
        return rcpaHeaderData.product.name// ?? ""
    }
    
    var competitorCompanyName : String {
        return rcpaHeaderData.competitorCompanyName
    }
    
    var competitorCompanyCode : String {
        return rcpaHeaderData.competitorCompanyCode
    }
    
    var competitorBrandName : String {
        return rcpaHeaderData.competitorBrandName
    }
    
    var competitorBrandCode : String {
        return rcpaHeaderData.competitorBrandCode
    }
    
    var competitorQty : String {
        return rcpaHeaderData.competitorQty
    }
    
    var competitorRate : String {
        return rcpaHeaderData.competitorRate
    }
    
    var competitorTotal : String {
        return rcpaHeaderData.competitorTotal
    }
}


struct RcpaChemist {
    var chemist : AnyObject
    
    var products = [rcpaProduct]()
    
}

struct rcpaProduct {
    
    var product : AnyObject
    
    var quantity : String
    
    var total : String
    
    var rate : String
    
    var rcpas = [RcpaHeaderData]()
    
}

struct RcpaHeaderData {
    
    var chemist : AnyObject
    
    var product : AnyObject
    
    var quantity : String
    
    var total : String
    
    var rate : String
    
    var competitorCompanyName : String
    
    var competitorCompanyCode : String
    
    var competitorBrandName : String
    
    var competitorBrandCode : String
    
    var competitorRate : String
    
    var competitorTotal : String
    
    var competitorQty : String
    
    var remarks : String
    
    
    mutating func updateCompetitorCompany (_ name : String , code : String) {
        competitorCompanyName = name
        competitorCompanyCode = code
    }
    
    mutating func updateCompetitorBrand (_ name : String , code : String) {
        
        competitorBrandCode = code
        competitorBrandName = name
    }
    
    mutating func updateCompetitorQty (_ value : String) {
        competitorQty = value
    }
    
    
    mutating func remarks (_ remark : String) {
        remarks = remark
    }
    
    
}
