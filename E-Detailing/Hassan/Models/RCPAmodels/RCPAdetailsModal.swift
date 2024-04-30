//
//  RCPAdetailsModal.swift
//  E-Detailing
//
//  Created by San eforce on 27/03/24.
//

import Foundation


struct AdditionalCompetitorsInfo {
    var competitor: Competitor?
    var qty: String?
    var remarks: String?
    var rate: String?
    var value: String?
}

struct ProductWithCompetiors {
    var addedProduct : Product?
    var competitorsInfo: [AdditionalCompetitorsInfo]?
    
}



struct ProductDetails {
    var addedProduct: [ProductWithCompetiors]?
    var addedQuantity: [String]?
    var addedRate: [String]?
    var addedValue: [String]?
    var addedTotal: [String]?
}

 class RCPAdetailsModal  {
    
    var addedChemist: Chemist?
    var addedProductDetails : ProductDetails?
  //  var competitor: [Competitor]?
    var totalValue: String?
    
    init() {
    addedChemist = Chemist()

    addedProductDetails = ProductDetails()
 //   competitor = [Competitor]()

        
        
    }
    
    func summonedTotal(rate: String, quantity: String) -> String {
    let rateInt: Int = Int(rate) ?? 0
        let intQuantity: Int = Int(quantity) ?? 0
        
        return "\(rateInt * intQuantity)"
    }
    
}
