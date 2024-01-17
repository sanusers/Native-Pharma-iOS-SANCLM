//
//  TodayCallsModel.swift
//  E-Detailing
//
//  Created by San eforce on 17/01/24.
//

import Foundation

class TodayCallsModel: Codable {
    let aDetSLNo: String
    let custCode: String
    let custName: String
    let custType: Int
    let synced: Int
    let transSlNo: String
    let vstTime: String
    var name: String
    var designation: String
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.aDetSLNo = container.safeDecodeValue(forKey: .aDetSLNo)
        self.custCode = container.safeDecodeValue(forKey: .custCode)
        self.custName = container.safeDecodeValue(forKey: .custName)
        self.custType = container.safeDecodeValue(forKey: .custType)
        self.synced = container.safeDecodeValue(forKey: .synced)
        self.transSlNo = container.safeDecodeValue(forKey: .transSlNo)
        self.vstTime = container.safeDecodeValue(forKey: .vstTime)
        
        // Computed properties to extract name and designation
         name = custName.components(separatedBy: " --- ")[0]
        
         let components = custName.components(separatedBy: "[")
        designation = components.count > 1 ? components[1].replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "") : ""
        
    }
    
    
    enum CodingKeys: String, CodingKey {
        case aDetSLNo = "ADetSLNo"
        case custCode =  "CustCode"
        case custName = "CustName"
        case custType = "CustType"
        case synced = "Synced"
        case transSlNo = "Trans_SlNo"
        case vstTime = "vstTime"
        
    }
    
    init() {
        self.aDetSLNo = String()
        self.custCode = String()
        self.custName = String()
        self.custType = Int()
        self.synced = Int()
        self.transSlNo = String()
        self.vstTime = String()
        self.name = String()
        self.designation = String()
    }
    
}
