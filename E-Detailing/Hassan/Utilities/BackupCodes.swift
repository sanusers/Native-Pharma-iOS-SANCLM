//func toSetParams(_ tourPlanArr: TourPlanArr) -> [String: Any] {
//    var param = [String: Any]()
//    param["Div"] = tourPlanArr.Div
//    param["SFCode"] = tourPlanArr.SFCode
//    param["SFName"] = tourPlanArr.SFName
//    param["tpData"] = [Any]()
//    var tpparam = [String: Any]()
//    var sessionArr = [Any]()
//    tourPlanArr.arrOfPlan.enumerated().forEach { index, allDayPlans in
//        tpparam["changeStatus"] = allDayPlans.changeStatus
//        tpparam["date"] = allDayPlans.date
//        tpparam["day"] = allDayPlans.day
//        tpparam["dayNo"] = allDayPlans.dayNo
//        tpparam["entryMode"] = allDayPlans.entryMode
//        tpparam["rejectionReason"] = allDayPlans.rejectionReason
//        tpparam["sessions"] = [Any]()
//
//        allDayPlans.sessionDetails.forEach { session in
//            var sessionParam = [String: Any]()
//            sessionParam["FWFlg"] = session.FWFlg
//            sessionParam["HQCodes"] = session.HQCodes
//            sessionParam["HQNames"] = session.HQNames
//            sessionParam["WTCode"] = session.WTCode
//            sessionParam["WTName"] = session.WTName
//            sessionParam["chemCode"] = session.chemCode
//            sessionParam["chemName"] = session.chemName
//            sessionParam["clusterCode"] = session.clusterCode
//            sessionParam["clusterName"] = session.clusterName
//            sessionParam["drCode"] = session.drCode
//            sessionParam["drName"] = session.drName
//            sessionParam["jwCode"] = session.jwCode
//            sessionParam["jwName"] = session.jwName
//            sessionParam["remarks"] = session.remarks
//
//            sessionArr.append(sessionParam)
//        }
//        tpparam["sessions"] = sessionArr
//        var info = [String: Any]()
//        info["date"] = "\(Date())"
//        info["timezone"] = "3"
//        info["timezone_type"] = "\(TimeZone.current.identifier)"
//        tpparam["submittedTime"] = info
//    }
//    param["tpData"] = tpparam
//    
//    let stringJSON = param.toString()
//    print(stringJSON)
//    
//    return param
//}



//class MenuWorkType: Codable {
//    let code: String
//    let eTabs: String
//    let fwFlg: String
//    let index: Int
//    let name: String
//    let sfCode: String
//    let terrslFlg: String
//    let tpDCR: String
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.code = container.safeDecodeValue(forKey: .code)
//        self.eTabs = container.safeDecodeValue(forKey: .eTabs)
//        self.fwFlg = container.safeDecodeValue(forKey: .fwFlg)
//        self.index = container.safeDecodeValue(forKey: .index)
//        self.name = container.safeDecodeValue(forKey: .name)
//        self.sfCode = container.safeDecodeValue(forKey: .sfCode)
//        self.terrslFlg = container.safeDecodeValue(forKey: .terrslFlg)
//        self.tpDCR = container.safeDecodeValue(forKey: .tpDCR)
//    }
//    
//    init() {
//        code = String()
//        eTabs = String()
//        fwFlg = String()
//        index = Int()
//        name = String()
//        sfCode = String()
//        terrslFlg = String()
//        tpDCR = String()
//    }
//    
//}
//
//class MenuheadQuaters: Codable {
//    let code: String
//    let eTabs: String
//    let fwFlg: String
//    let index: Int
//    let name: String
//    let sfCode: String
//    let terrslFlg: String
//    let tpDCR: String
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.code = container.safeDecodeValue(forKey: .code)
//        self.eTabs = container.safeDecodeValue(forKey: .eTabs)
//        self.fwFlg = container.safeDecodeValue(forKey: .fwFlg)
//        self.index = container.safeDecodeValue(forKey: .index)
//        self.name = container.safeDecodeValue(forKey: .name)
//        self.sfCode = container.safeDecodeValue(forKey: .sfCode)
//        self.terrslFlg = container.safeDecodeValue(forKey: .terrslFlg)
//        self.tpDCR = container.safeDecodeValue(forKey: .tpDCR)
//    }
//    
//    init() {
//        code = String()
//        eTabs = String()
//        fwFlg = String()
//        index = Int()
//        name = String()
//        sfCode = String()
//        terrslFlg = String()
//        tpDCR = String()
//    }
//    
//}
//
//class Menucluster: Codable {
//    let code: String
//    let eTabs: String
//    let fwFlg: String
//    let index: Int
//    let name: String
//    let sfCode: String
//    let terrslFlg: String
//    let tpDCR: String
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.code = container.safeDecodeValue(forKey: .code)
//        self.eTabs = container.safeDecodeValue(forKey: .eTabs)
//        self.fwFlg = container.safeDecodeValue(forKey: .fwFlg)
//        self.index = container.safeDecodeValue(forKey: .index)
//        self.name = container.safeDecodeValue(forKey: .name)
//        self.sfCode = container.safeDecodeValue(forKey: .sfCode)
//        self.terrslFlg = container.safeDecodeValue(forKey: .terrslFlg)
//        self.tpDCR = container.safeDecodeValue(forKey: .tpDCR)
//    }
//    
//    init() {
//        code = String()
//        eTabs = String()
//        fwFlg = String()
//        index = Int()
//        name = String()
//        sfCode = String()
//        terrslFlg = String()
//        tpDCR = String()
//    }
//    
//}
//
//class MenujointWork: Codable {
//    let code: String
//    let eTabs: String
//    let fwFlg: String
//    let index: Int
//    let name: String
//    let sfCode: String
//    let terrslFlg: String
//    let tpDCR: String
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.code = container.safeDecodeValue(forKey: .code)
//        self.eTabs = container.safeDecodeValue(forKey: .eTabs)
//        self.fwFlg = container.safeDecodeValue(forKey: .fwFlg)
//        self.index = container.safeDecodeValue(forKey: .index)
//        self.name = container.safeDecodeValue(forKey: .name)
//        self.sfCode = container.safeDecodeValue(forKey: .sfCode)
//        self.terrslFlg = container.safeDecodeValue(forKey: .terrslFlg)
//        self.tpDCR = container.safeDecodeValue(forKey: .tpDCR)
//    }
//    
//    init() {
//        code = String()
//        eTabs = String()
//        fwFlg = String()
//        index = Int()
//        name = String()
//        sfCode = String()
//        terrslFlg = String()
//        tpDCR = String()
//    }
//    
//}
//
//class MenulistedDoc: Codable {
//    let code: String
//    let eTabs: String
//    let fwFlg: String
//    let index: Int
//    let name: String
//    let sfCode: String
//    let terrslFlg: String
//    let tpDCR: String
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.code = container.safeDecodeValue(forKey: .code)
//        self.eTabs = container.safeDecodeValue(forKey: .eTabs)
//        self.fwFlg = container.safeDecodeValue(forKey: .fwFlg)
//        self.index = container.safeDecodeValue(forKey: .index)
//        self.name = container.safeDecodeValue(forKey: .name)
//        self.sfCode = container.safeDecodeValue(forKey: .sfCode)
//        self.terrslFlg = container.safeDecodeValue(forKey: .terrslFlg)
//        self.tpDCR = container.safeDecodeValue(forKey: .tpDCR)
//    }
//    
//    init() {
//        code = String()
//        eTabs = String()
//        fwFlg = String()
//        index = Int()
//        name = String()
//        sfCode = String()
//        terrslFlg = String()
//        tpDCR = String()
//    }
//    
//}
//
//class Menuchemist: Codable {
//    let code: String
//    let eTabs: String
//    let fwFlg: String
//    let index: Int
//    let name: String
//    let sfCode: String
//    let terrslFlg: String
//    let tpDCR: String
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.code = container.safeDecodeValue(forKey: .code)
//        self.eTabs = container.safeDecodeValue(forKey: .eTabs)
//        self.fwFlg = container.safeDecodeValue(forKey: .fwFlg)
//        self.index = container.safeDecodeValue(forKey: .index)
//        self.name = container.safeDecodeValue(forKey: .name)
//        self.sfCode = container.safeDecodeValue(forKey: .sfCode)
//        self.terrslFlg = container.safeDecodeValue(forKey: .terrslFlg)
//        self.tpDCR = container.safeDecodeValue(forKey: .tpDCR)
//    }
//    
//    init() {
//        code = String()
//        eTabs = String()
//        fwFlg = String()
//        index = Int()
//        name = String()
//        sfCode = String()
//        terrslFlg = String()
//        tpDCR = String()
//    }
//    
//}
