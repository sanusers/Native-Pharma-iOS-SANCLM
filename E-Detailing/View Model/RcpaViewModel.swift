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
        rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas.append(product)
    }
    
    func isChemistAdded(_ code : String) -> Bool {
        
        let VM = rcpaAddedListViewModel.filter{$0.chemistCode.contains(code)}
        return VM.isEmpty ? false : true
    }
    
    func chemistAtSection (_ chemistcode : String, productCode : String) -> (chemistIndex : Int, productIndex : Int){
        
        
        if let chmIndex = rcpaAddedListViewModel.firstIndex(where: { chemist in
            chemist.chemistCode  == chemistcode
        }){
            
            if let productIndex = rcpaAddedListViewModel[chmIndex].rcpaChemist.products.firstIndex(where: { product in
                product.product.code == productCode
            }){
                return (chmIndex, productIndex)
            }else {
                return (chmIndex,-1)
            }
        }else {
            return (-1,-1)
        }
    }
    
    func rcpaAtSectionIndex (_ chemistcode : String, productCode : String, rcpaCompanyCode : String, rcpaBrandCode : String) -> (chemistIndex : Int,productIndex : Int,rcpaIndex : Int) {
        
        if let chmIndex = rcpaAddedListViewModel.firstIndex(where: { chemist in
            chemist.chemistCode  == chemistcode
        }){
            
            if let productIndex = rcpaAddedListViewModel[chmIndex].rcpaChemist.products.firstIndex(where: { product in
                product.product.code == productCode
            }){
                
                if let rcpaIndex = rcpaAddedListViewModel[chmIndex].rcpaChemist.products[productIndex].rcpas.firstIndex(where: { rcpa in
                    rcpa.competitorCompanyCode == rcpaCompanyCode && rcpa.competitorBrandCode == rcpaBrandCode
                }){
                    return (chmIndex, productIndex,rcpaIndex)
                }else {
                    return (chmIndex, productIndex,-1)
                }
            }else {
                return (chmIndex,-1,-1)
            }
        }else {
            return (-1,-1,-1)
        }
    }
    
    func getRcpas() -> [RcpaAddedViewModel]{
        return rcpaAddedListViewModel
    }
    
    
    func fetchAtSection(_ section : Int) -> RcpaAddedViewModel {
        return rcpaAddedListViewModel[section]
    }
    
    func fetchAtRowIndex(_ section : Int , row : Int) -> rcpaProduct {
        return rcpaAddedListViewModel[section].rcpaChemist.products[row]
    }
    
    
    func deleteSection (_ section : Int) {
        rcpaAddedListViewModel.remove(at: section)
    }
    
    func deleteAtRows (_ section : Int , row : Int) {
        rcpaAddedListViewModel[section].rcpaChemist.products.remove(at: row)
    }
    
    func deleteAtRcpa(_ section : Int, row : Int , index : Int) {
        rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas.remove(at: index)
    }
    
    func updateProductIsViewTapped (_ section : Int,row : Int, isTapped : Bool) {
        rcpaAddedListViewModel[section].rcpaChemist.products[row].updateIsViewTapped(isTapped)
    }
    
    func numberofSections() -> Int {
        return rcpaAddedListViewModel.count
    }
    
    func numberofRowsInSection(_ section : Int) -> Int{
        if rcpaAddedListViewModel.isEmpty {
            return 0
        }
        return rcpaAddedListViewModel[section].rcpaChemist.products.count
    }
    
    func numberofListsInRows(_ section : Int , row : Int) -> Int {
        return rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas.count
    }
    
    func setCompetitorCompanyAtSectionIndex(_ section : Int, row : Int, compRow : Int,name : String,code : String) {
        rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas[compRow].updateCompetitorCompany(name, code: code)
    }
    
    func setCompetitorBrandAtSectionIndex(_ section : Int, row : Int, compRow : Int,name : String,code : String){
        rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas[compRow].updateCompetitorBrand(name, code: code)
    }
    
    func setCompetitorBrandQtyAtSectionIndex(_ section : Int, row : Int, compRow : Int,qty : String){
        rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas[compRow].updateCompetitorQty(qty)
    }
    
    func setCompetitorBrandRateAtSectionIndex(_ section : Int, row : Int, compRow : Int,rate : String){
        rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas[compRow].updateCompetitorRate(rate)
    }
    
    func setCompetitorBrandTotalAtSectionIndex(_ section : Int, row : Int, compRow : Int,total : String){
        rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas[compRow].updateCompetitorTotal(total)
    }
    
    func setCompetitorBrandRemarksAtSectionIndex(_ section : Int, row : Int, compRow : Int,remarks : String){
        rcpaAddedListViewModel[section].rcpaChemist.products[row].rcpas[compRow].remarks(remarks)
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
    
    func removeAll() {
        rcpaListViewModel.removeAll()
    }
    
    func fetchAtIndex(_ index : Int) -> RcpaViewModel {
        return rcpaListViewModel[index]
    }
    
    func fetchAtProduct(code : String) -> [RcpaViewModel] {
        return rcpaListViewModel.filter{$0.productCode == code}
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
        return rcpaHeaderData.product?.name ?? ""
    }
    
    var productCode : String {
        return rcpaHeaderData.product?.code ?? ""
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
    
    var isViewTapped : Bool
    
    mutating func updateIsViewTapped (_ isTapped : Bool){
        isViewTapped = isTapped
    }
    
}

struct RcpaHeaderData {
    
    var chemist : AnyObject?
    
    var product : AnyObject?
    
    var quantity : String
    
    var total : String
    
    var rate : String
    
    var competitorCompanyName : String
    
    var competitorCompanyCode : String = ""
    
    var competitorBrandName : String
    
    var competitorBrandCode : String = ""
    
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
    
    mutating func updateCompetitorRate (_ value : String) {
        competitorRate = value
    }
    
    mutating func updateCompetitorTotal (_ value : String) {
        competitorTotal = value
    }
    
    mutating func remarks (_ remark : String) {
        remarks = remark
    }
    
    
}
