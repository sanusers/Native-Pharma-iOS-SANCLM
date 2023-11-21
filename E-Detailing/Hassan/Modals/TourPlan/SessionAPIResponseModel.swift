//
//  SessionAPIResponseModel.swift
//  E-Detailing
//
//  Created by San eforce on 20/11/23.
//

import Foundation
class SessionAPIResponseModel : Codable {
    let div: String
    let SFCode: String
    let SFName: String
    let tpData : [TPData]
    
        enum CodingKeys: String, CodingKey {
            case div
            case SFCode
            case SFName
            case tpData
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.div =  container.safeDecodeValue(forKey: .div)
        self.SFCode =  container.safeDecodeValue(forKey: .SFCode)
        self.SFName =  container.safeDecodeValue(forKey: .SFName)
        self.tpData = try container.decodeIfPresent([TPData].self, forKey: .tpData) ?? [TPData]()
    }
    
    init() {
        div = ""
        SFCode = ""
        SFName = ""
        tpData = [TPData]()
    }
    
}


class TPData: Codable {
    let changeStatus : String
    let date : String
    let day : String
    let dayNo: String
    let entryMode : String
    let rejectionReason: String
    let sessions : [Sessions]
    let submittedTime : SubmittedTime
    
    enum CodingKeys: String, CodingKey {
        case changeStatus
        case date
        case day
        case dayNo
        case entryMode
        case rejectionReason
        case sessions
        case submittedTime
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.changeStatus = container.safeDecodeValue(forKey: .changeStatus)
        self.date = container.safeDecodeValue(forKey: .date)
        self.day = container.safeDecodeValue(forKey: .day)
        self.dayNo = container.safeDecodeValue(forKey: .dayNo)
        self.entryMode = container.safeDecodeValue(forKey: .entryMode)
        self.rejectionReason = container.safeDecodeValue(forKey: .rejectionReason)
        self.sessions = try container.decodeIfPresent([Sessions].self, forKey: .sessions) ?? [Sessions]()
        self.submittedTime = try container.decodeIfPresent(SubmittedTime.self, forKey: .submittedTime) ?? SubmittedTime()
    }
    
    init() {
        changeStatus = ""
        date = ""
        day = ""
        dayNo = ""
        entryMode = ""
        rejectionReason = ""
        sessions = [Sessions]()
        submittedTime = SubmittedTime()
    }
    
}


class SubmittedTime: Codable {
    let date : String
    let timezone : String
    let timezone_type : String
    
    enum CodingKeys: String, CodingKey {
        case date
        case timezone
        case timezone_type
    }
     
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = container.safeDecodeValue(forKey: .date)
        self.timezone = container.safeDecodeValue(forKey: .timezone)
        self.timezone_type = container.safeDecodeValue(forKey: .timezone_type)
    }
    
    init() {
        
        date = ""
        timezone = ""
        timezone_type = ""
    }
    
    
}

class Sessions: Codable {
    let FWFlg : String
    let HQCodes : String
    let HQNames : String
    let WTCode : String
    let WTName : String
    let chemCode : String
    let chemName : String
    let cipCode : String
    let cipName : String
    let clusterCode : String
    let clusterName : String
    let drCode : String
    let drName : String
    let hospCode : String
    let hospName : String
    let jwCode : String
    let jwName : String
    let remarks : String
    let stockistCode : String
    let stockistName : String
    let unListedDrCode : String
    let unListedDrName : String
    
    enum CodingKeys: String, CodingKey {
        case FWFlg
        case HQCodes
        case HQNames
        case WTCode
        case WTName
        case chemCode
        case chemName
        case cipCode
        case cipName
        case clusterCode
        case clusterName
        case drCode
        case drName
        case hospCode
        case hospName
        case jwCode
        case jwName
        case remarks
        case stockistCode
        case stockistName
        case unListedDrCode
        case unListedDrName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.FWFlg = container.safeDecodeValue(forKey: .FWFlg)
        self.HQCodes = container.safeDecodeValue(forKey: .HQCodes)
        self.HQNames = container.safeDecodeValue(forKey: .HQNames)
        self.WTCode = container.safeDecodeValue(forKey: .WTCode)
        self.WTName = container.safeDecodeValue(forKey: .WTName)
        self.chemCode = container.safeDecodeValue(forKey: .chemCode)
        self.chemName = container.safeDecodeValue(forKey: .chemName)
        self.cipCode = container.safeDecodeValue(forKey: .cipCode)
        self.cipName = container.safeDecodeValue(forKey: .cipName)
        self.clusterCode = container.safeDecodeValue(forKey: .clusterCode)
        self.clusterName = container.safeDecodeValue(forKey: .clusterName)
        self.drCode = container.safeDecodeValue(forKey: .drCode)
        self.drName = container.safeDecodeValue(forKey: .drName)
        self.hospCode = container.safeDecodeValue(forKey: .hospCode)
        self.hospName = container.safeDecodeValue(forKey: .hospName)
        self.jwCode = container.safeDecodeValue(forKey: .jwCode)
        self.jwName = container.safeDecodeValue(forKey: .jwName)
        self.remarks = container.safeDecodeValue(forKey: .remarks)
        self.stockistCode = container.safeDecodeValue(forKey: .stockistCode)
        self.stockistName = container.safeDecodeValue(forKey: .stockistName)
        self.unListedDrCode = container.safeDecodeValue(forKey: .unListedDrCode)
        self.unListedDrName = container.safeDecodeValue(forKey: .unListedDrName)
    }
    
    init() {
        FWFlg = ""
        HQCodes = ""
        HQNames = ""
        WTCode = ""
        WTName = ""
        chemCode = ""
        chemName = ""
        cipCode = ""
        cipName = ""
        clusterCode = ""
        clusterName = ""
        drCode = ""
        drName = ""
        hospCode = ""
        hospName = ""
        jwCode = ""
        jwName = ""
        remarks = ""
        stockistCode = ""
        stockistName = ""
        unListedDrCode = ""
        unListedDrName = ""
    }
    
}
