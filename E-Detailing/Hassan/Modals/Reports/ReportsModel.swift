//
//  ReportsModel.swift
//  E-Detailing
//
//  Created by San eforce on 21/12/23.
//

import Foundation


class ReportsModelArr: Codable {
    let reportsModelArr : [ReportsModel]
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.reportsModelArr = try container.decode([ReportsModel].self, forKey: .reportsModelArr)
    }
    
    init() {
        self.reportsModelArr = [ReportsModel]()
    }
}

class ReportsModel: Codable {
    let aCode, adate, rptdate: String
    let typ: Int
    let sfCode, sfName: String
    let activityDate: TimeInfo
    let wtype, fwFlg: String
    let drs, chm, stk, udr: Int
    let hos, cip: Int
    let intime, outtime, inaddress, outaddress: String
    let desigCode, halfDayFWType, remarks: String
    let rmdr: Int
    let terrWrk: String

    
    init() {
        self.aCode = String()
        self.adate = String()
        self.rptdate = String()
        self.typ = Int()
        self.sfCode = String()
        self.sfName = String()
        self.activityDate = TimeInfo()
        self.wtype = String()
        self.fwFlg = String()
        self.drs = Int()
        self.chm = Int()
        self.stk = Int()
        self.udr = Int()
        self.hos = Int()
        self.cip = Int()
        self.intime = String()
        self.outtime = String()
        self.inaddress = String()
        self.outaddress = String()
        self.desigCode = String()
        self.halfDayFWType = String()
        self.remarks = String()
        self.rmdr = Int()
        self.terrWrk = String()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.aCode = container.safeDecodeValue(forKey: .aCode)
        self.adate = container.safeDecodeValue(forKey: .adate)
        self.rptdate = container.safeDecodeValue(forKey: .rptdate)
        self.typ = container.safeDecodeValue(forKey: .typ)
        self.sfCode = container.safeDecodeValue(forKey: .sfCode)
        self.sfName = container.safeDecodeValue(forKey: .sfName)
        self.activityDate = try container.decode(TimeInfo.self, forKey: .activityDate)
        self.wtype = container.safeDecodeValue(forKey: .wtype)
        self.fwFlg = container.safeDecodeValue(forKey: .fwFlg)
        self.drs = container.safeDecodeValue(forKey: .drs)
        self.chm = container.safeDecodeValue(forKey: .chm)
        self.stk = container.safeDecodeValue(forKey: .stk)
        self.udr = container.safeDecodeValue(forKey: .udr)
        self.hos = container.safeDecodeValue(forKey: .hos)
        self.cip = container.safeDecodeValue(forKey: .cip)
        self.intime = container.safeDecodeValue(forKey: .intime)
        self.outtime = container.safeDecodeValue(forKey: .outtime)
        self.inaddress = container.safeDecodeValue(forKey: .inaddress)
        self.outaddress = container.safeDecodeValue(forKey: .outaddress)
        self.desigCode = container.safeDecodeValue(forKey: .desigCode)
        self.halfDayFWType = container.safeDecodeValue(forKey: .halfDayFWType)
        self.remarks = container.safeDecodeValue(forKey: .remarks)
        self.rmdr = container.safeDecodeValue(forKey: .rmdr)
        self.terrWrk = container.safeDecodeValue(forKey: .terrWrk)
    }
    
    enum CodingKeys: String, CodingKey {
        case aCode = "ACode"
        case adate = "Adate"
        case rptdate
        case typ = "Typ"
        case sfCode = "SF_Code"
        case sfName = "SF_Name"
        case activityDate = "Activity_Date"
        case wtype
        case fwFlg = "FWFlg"
        case drs = "Drs"
        case chm = "Chm"
        case stk = "Stk"
        case udr = "Udr"
        case hos = "Hos"
        case cip = "Cip"
        case intime, outtime, inaddress, outaddress
        case desigCode = "Desig_Code"
        case halfDayFWType = "HalfDay_FW_Type"
        case remarks
        case rmdr = "Rmdr"
        case terrWrk = "TerrWrk"
    }
}
