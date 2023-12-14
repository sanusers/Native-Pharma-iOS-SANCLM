//
//  SessionAPIResponseModel.swift
//  E-Detailing
//
//  Created by San eforce on 20/11/23.
//

import Foundation

class GeneralResponseModal : Codable {
    let success : String?
    let msg : String?
    let isSuccess: Bool?
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case msg = "msg"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success =  container.safeDecodeValue(forKey: .success)
        self.msg =  container.safeDecodeValue(forKey: .msg)
        self.isSuccess = success ==  "false" ? false : true
    }
    
    
    init() {
        success = ""
        msg = ""
        self.isSuccess = false
    }
}

//class SessionResponseModel: Codable {
//
//}

class SessionResponseModel: Codable {
    let previous, current, next: [SessionDetails]
   // let next: [JSONAny]
    
    enum CodingKeys: String, CodingKey {
        case previous
        case current
        case next
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.previous = try container.decode([SessionDetails].self, forKey: .previous)
        self.current = try container.decode([SessionDetails].self, forKey: .current)
        self.next = try container.decode([SessionDetails].self, forKey: .next)
    }
    
}

class SessionDetails: Codable {
    let sfCode: String
    let sfName: String
    let div, mnth, yr, dayno: String
    let changeStatus, rejectionReason, dt: String
    let tpDt: TimeInfo
    let wtCode, wtCode2, wtCode3: String
    let wtName: String
    let wtName2: String
    let wtName3, clusterCode, clusterCode2, clusterCode3: String
    let clusterName, clusterName2, clusterName3: String
    let clusterSFS: String
    let clusterSFNms: String
    let jwCodes, jwNames, jwCodes2, jwNames2: String
    let jwCodes3, jwNames3, drCode, drName: String
    let drTwoCode, drTwoName, drThreeCode, drThreeName: String
    let chemCode, chemName, chemTwoCode, chemTwoName: String
    let chemThreeCode, chemThreeName, stockistCode, stockistName: String
    let stockistTwoCode, stockistTwoName, stockistThreeCode, stockistThreeName: String
    let day: String
    let tourMonth, tourYear: Int
    let tpmonth: String
    let tpday: String
    let dayRemarks: String
    let dayRemarks2: String
    let dayRemarks3, access, eFlag: String
    let fwFlg, fwFlg2: String
    let fwFlg3: String
    let hqCodes: String
    let hqNames: String
    let hqCodes2, hqNames2, hqCodes3, hqNames3: String
    let submittedTimeDt: String
    let submittedTime: TimeInfo
    let entryMode: String


    
    enum CodingKeys: String, CodingKey {
        case sfCode = "SFCode"
        case sfName = "SFName"
        case div = "Div"
        case mnth = "Mnth"
        case yr = "Yr"
        case dayno
        case changeStatus = "Change_Status"
        case rejectionReason = "Rejection_Reason"
        case dt
        case tpDt = "TPDt"
        case wtCode = "WTCode"
        case wtCode2 = "WTCode2"
        case wtCode3 = "WTCode3"
        case wtName = "WTName"
        case wtName2 = "WTName2"
        case wtName3 = "WTName3"
        case clusterCode = "ClusterCode"
        case clusterCode2 = "ClusterCode2"
        case clusterCode3 = "ClusterCode3"
        case clusterName = "ClusterName"
        case clusterName2 = "ClusterName2"
        case clusterName3 = "ClusterName3"
        case clusterSFS = "ClusterSFs"
        case clusterSFNms = "ClusterSFNms"
        case jwCodes = "JWCodes"
        case jwNames = "JWNames"
        case jwCodes2 = "JWCodes2"
        case jwNames2 = "JWNames2"
        case jwCodes3 = "JWCodes3"
        case jwNames3 = "JWNames3"
        case drCode = "Dr_Code"
        case drName = "Dr_Name"
        case drTwoCode = "Dr_two_code"
        case drTwoName = "Dr_two_name"
        case drThreeCode = "Dr_three_code"
        case drThreeName = "Dr_three_name"
        case chemCode = "Chem_Code"
        case chemName = "Chem_Name"
        case chemTwoCode = "Chem_two_code"
        case chemTwoName = "Chem_two_name"
        case chemThreeCode = "Chem_three_code"
        case chemThreeName = "Chem_three_name"
        case stockistCode = "Stockist_Code"
        case stockistName = "Stockist_Name"
        case stockistTwoCode = "Stockist_two_code"
        case stockistTwoName = "Stockist_two_name"
        case stockistThreeCode = "Stockist_three_code"
        case stockistThreeName = "Stockist_three_name"
        case day = "Day"
        case tourMonth = "Tour_Month"
        case tourYear = "Tour_Year"
        case tpmonth, tpday
        case dayRemarks = "DayRemarks"
        case dayRemarks2 = "DayRemarks2"
        case dayRemarks3 = "DayRemarks3"
        case access
        case eFlag = "EFlag"
        case fwFlg = "FWFlg"
        case fwFlg2 = "FWFlg2"
        case fwFlg3 = "FWFlg3"
        case hqCodes = "HQCodes"
        case hqNames = "HQNames"
        case hqCodes2 = "HQCodes2"
        case hqNames2 = "HQNames2"
        case hqCodes3 = "HQCodes3"
        case hqNames3 = "HQNames3"
        case submittedTimeDt = "submitted_time_dt"
        case submittedTime = "submitted_time"
        case entryMode = "Entry_mode"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sfCode = container.safeDecodeValue(forKey: .sfCode)
        self.sfName = container.safeDecodeValue(forKey: .sfName)
        self.div = container.safeDecodeValue(forKey: .div)
        self.mnth = container.safeDecodeValue(forKey: .mnth)
        self.yr = container.safeDecodeValue(forKey: .yr)
        self.dayno = container.safeDecodeValue(forKey: .dayno)
        self.changeStatus = container.safeDecodeValue(forKey: .changeStatus)
        self.rejectionReason = container.safeDecodeValue(forKey: .rejectionReason)
        self.dt = container.safeDecodeValue(forKey: .dt)
        self.tpDt = try container.decode(TimeInfo.self, forKey: .tpDt)
        self.wtCode = container.safeDecodeValue(forKey: .wtCode)
        self.wtCode2 = container.safeDecodeValue(forKey: .wtCode2)
        self.wtCode3 = container.safeDecodeValue(forKey: .wtCode3)
        self.wtName = container.safeDecodeValue(forKey: .wtName)
        self.wtName2 = container.safeDecodeValue(forKey: .wtName2)
        self.wtName3 = container.safeDecodeValue(forKey: .wtName3)
        self.clusterCode = container.safeDecodeValue(forKey: .clusterCode)
        self.clusterCode2 = container.safeDecodeValue(forKey: .clusterCode2)
        self.clusterCode3 = container.safeDecodeValue(forKey: .clusterCode3)
        self.clusterName = container.safeDecodeValue(forKey: .clusterName)
        self.clusterName2 = container.safeDecodeValue(forKey: .clusterName2)
        self.clusterName3 = container.safeDecodeValue(forKey: .clusterName3)
        self.clusterSFS = container.safeDecodeValue(forKey: .clusterSFS)
        self.clusterSFNms = container.safeDecodeValue(forKey: .clusterSFNms)
        self.jwCodes = container.safeDecodeValue(forKey: .jwCodes)
        self.jwNames = container.safeDecodeValue(forKey: .jwNames)
        self.jwCodes2 = container.safeDecodeValue(forKey: .jwCodes2)
        self.jwNames2 = container.safeDecodeValue(forKey: .jwNames2)
        self.jwCodes3 = container.safeDecodeValue(forKey: .jwCodes3)
        self.jwNames3 = container.safeDecodeValue(forKey: .jwNames3)
        self.drCode = container.safeDecodeValue(forKey: .drCode)
        self.drName = container.safeDecodeValue(forKey: .drName)
        self.drTwoCode = container.safeDecodeValue(forKey: .drTwoCode)
        self.drTwoName = container.safeDecodeValue(forKey: .drTwoName)
        self.drThreeCode = container.safeDecodeValue(forKey: .drThreeCode)
        self.drThreeName = container.safeDecodeValue(forKey: .drThreeName)
        self.chemCode = container.safeDecodeValue(forKey: .chemCode)
        self.chemName = container.safeDecodeValue(forKey: .chemName)
        self.chemTwoCode = container.safeDecodeValue(forKey: .chemTwoCode)
        self.chemTwoName = container.safeDecodeValue(forKey: .chemTwoName)
        self.chemThreeCode = container.safeDecodeValue(forKey: .chemThreeCode)
        self.chemThreeName = container.safeDecodeValue(forKey: .chemThreeName)
        self.stockistCode = container.safeDecodeValue(forKey: .stockistCode)
        self.stockistName = container.safeDecodeValue(forKey: .stockistName)
        self.stockistTwoCode = container.safeDecodeValue(forKey: .stockistTwoCode)
        self.stockistTwoName = container.safeDecodeValue(forKey: .stockistTwoName)
        self.stockistThreeCode = container.safeDecodeValue(forKey: .stockistThreeCode)
        self.stockistThreeName = container.safeDecodeValue(forKey: .stockistThreeName)
        self.day = container.safeDecodeValue(forKey: .day)
        self.tourMonth = try container.decode(Int.self, forKey: .tourMonth)
        self.tourYear = try container.decode(Int.self, forKey: .tourYear)
        self.tpmonth = container.safeDecodeValue(forKey: .tpmonth)
        self.tpday = container.safeDecodeValue(forKey: .tpday)
        self.dayRemarks = container.safeDecodeValue(forKey: .dayRemarks)
        self.dayRemarks2 = container.safeDecodeValue(forKey: .dayRemarks2)
        self.dayRemarks3 = container.safeDecodeValue(forKey: .dayRemarks3)
        self.access = container.safeDecodeValue(forKey: .access)
        self.eFlag = container.safeDecodeValue(forKey: .eFlag)
        self.fwFlg = container.safeDecodeValue(forKey: .fwFlg)
        self.fwFlg2 = container.safeDecodeValue(forKey: .fwFlg2)
        self.fwFlg3 = container.safeDecodeValue(forKey: .fwFlg3)
        self.hqCodes = container.safeDecodeValue(forKey: .hqCodes)
        self.hqNames = container.safeDecodeValue(forKey: .hqNames)
        self.hqCodes2 = container.safeDecodeValue(forKey: .hqCodes2)
        self.hqNames2 = container.safeDecodeValue(forKey: .hqNames2)
        self.hqCodes3 = container.safeDecodeValue(forKey: .hqCodes3)
        self.hqNames3 = container.safeDecodeValue(forKey: .hqNames3)
        self.submittedTimeDt = container.safeDecodeValue(forKey: .submittedTimeDt)
        self.submittedTime = try container.decode(TimeInfo.self, forKey: .submittedTime)
        self.entryMode = container.safeDecodeValue(forKey: .entryMode)
    }
}



class TimeInfo: Codable {
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

