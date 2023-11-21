//
//  SessionDetails.swift
//  E-Detailing
//
//  Created by San eforce on 14/11/23.
//

import Foundation

class MenuWorkType: Codable {
    let code: String
    let eTabs: String
    let fwFlg: String
    let index: Int
    let name: String
    let sfCode: String
    let terrslFlg: String
    let tpDCR: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.eTabs = try container.decode(String.self, forKey: .eTabs)
        self.fwFlg = try container.decode(String.self, forKey: .fwFlg)
        self.index = try container.decode(Int.self, forKey: .index)
        self.name = try container.decode(String.self, forKey: .name)
        self.sfCode = try container.decode(String.self, forKey: .sfCode)
        self.terrslFlg = try container.decode(String.self, forKey: .terrslFlg)
        self.tpDCR = try container.decode(String.self, forKey: .tpDCR)
    }
    
    init() {
        code = String()
        eTabs = String()
        fwFlg = String()
        index = Int()
        name = String()
        sfCode = String()
        terrslFlg = String()
        tpDCR = String()
    }
    
}

class MenuheadQuaters: Codable {
    let code: String
    let eTabs: String
    let fwFlg: String
    let index: Int
    let name: String
    let sfCode: String
    let terrslFlg: String
    let tpDCR: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.eTabs = try container.decode(String.self, forKey: .eTabs)
        self.fwFlg = try container.decode(String.self, forKey: .fwFlg)
        self.index = try container.decode(Int.self, forKey: .index)
        self.name = try container.decode(String.self, forKey: .name)
        self.sfCode = try container.decode(String.self, forKey: .sfCode)
        self.terrslFlg = try container.decode(String.self, forKey: .terrslFlg)
        self.tpDCR = try container.decode(String.self, forKey: .tpDCR)
    }
    
    init() {
        code = String()
        eTabs = String()
        fwFlg = String()
        index = Int()
        name = String()
        sfCode = String()
        terrslFlg = String()
        tpDCR = String()
    }
    
}

class Menucluster: Codable {
    let code: String
    let eTabs: String
    let fwFlg: String
    let index: Int
    let name: String
    let sfCode: String
    let terrslFlg: String
    let tpDCR: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.eTabs = try container.decode(String.self, forKey: .eTabs)
        self.fwFlg = try container.decode(String.self, forKey: .fwFlg)
        self.index = try container.decode(Int.self, forKey: .index)
        self.name = try container.decode(String.self, forKey: .name)
        self.sfCode = try container.decode(String.self, forKey: .sfCode)
        self.terrslFlg = try container.decode(String.self, forKey: .terrslFlg)
        self.tpDCR = try container.decode(String.self, forKey: .tpDCR)
    }
    
    init() {
        code = String()
        eTabs = String()
        fwFlg = String()
        index = Int()
        name = String()
        sfCode = String()
        terrslFlg = String()
        tpDCR = String()
    }
    
}

class MenujointWork: Codable {
    let code: String
    let eTabs: String
    let fwFlg: String
    let index: Int
    let name: String
    let sfCode: String
    let terrslFlg: String
    let tpDCR: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.eTabs = try container.decode(String.self, forKey: .eTabs)
        self.fwFlg = try container.decode(String.self, forKey: .fwFlg)
        self.index = try container.decode(Int.self, forKey: .index)
        self.name = try container.decode(String.self, forKey: .name)
        self.sfCode = try container.decode(String.self, forKey: .sfCode)
        self.terrslFlg = try container.decode(String.self, forKey: .terrslFlg)
        self.tpDCR = try container.decode(String.self, forKey: .tpDCR)
    }
    
    init() {
        code = String()
        eTabs = String()
        fwFlg = String()
        index = Int()
        name = String()
        sfCode = String()
        terrslFlg = String()
        tpDCR = String()
    }
    
}

class MenulistedDoc: Codable {
    let code: String
    let eTabs: String
    let fwFlg: String
    let index: Int
    let name: String
    let sfCode: String
    let terrslFlg: String
    let tpDCR: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.eTabs = try container.decode(String.self, forKey: .eTabs)
        self.fwFlg = try container.decode(String.self, forKey: .fwFlg)
        self.index = try container.decode(Int.self, forKey: .index)
        self.name = try container.decode(String.self, forKey: .name)
        self.sfCode = try container.decode(String.self, forKey: .sfCode)
        self.terrslFlg = try container.decode(String.self, forKey: .terrslFlg)
        self.tpDCR = try container.decode(String.self, forKey: .tpDCR)
    }
    
    init() {
        code = String()
        eTabs = String()
        fwFlg = String()
        index = Int()
        name = String()
        sfCode = String()
        terrslFlg = String()
        tpDCR = String()
    }
    
}

class Menuchemist: Codable {
    let code: String
    let eTabs: String
    let fwFlg: String
    let index: Int
    let name: String
    let sfCode: String
    let terrslFlg: String
    let tpDCR: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.eTabs = try container.decode(String.self, forKey: .eTabs)
        self.fwFlg = try container.decode(String.self, forKey: .fwFlg)
        self.index = try container.decode(Int.self, forKey: .index)
        self.name = try container.decode(String.self, forKey: .name)
        self.sfCode = try container.decode(String.self, forKey: .sfCode)
        self.terrslFlg = try container.decode(String.self, forKey: .terrslFlg)
        self.tpDCR = try container.decode(String.self, forKey: .tpDCR)
    }
    
    init() {
        code = String()
        eTabs = String()
        fwFlg = String()
        index = Int()
        name = String()
        sfCode = String()
        terrslFlg = String()
        tpDCR = String()
    }
    
}


//extension WorkType: Codable {
//    public func encode(to encoder: Encoder) throws {
//        <#code#>
//    }
//
//
//
//}
//
//
//extension Subordinate: Codable {
//
//}
//
//extension Territory: Codable {
//
//}
//
//
//extension JointWork : Codable {
//
//}
//
//extension DoctorFencing : Codable {
//
//}
//
//extension chemist: Codable {
//
//}

class SessionDetail {
    
    var workType: [WorkType]?
    var selectedWorkTypeIndex: Int? = nil
    var searchedWorkTypeIndex: Int? = nil
  
    var isForFieldWork: Bool = true
    var workTypeCode: String? = nil
    var selectedClusterID: [String : Bool]
    //  var searchedClusterID: [String : Bool]
    var selectedHeadQuaterID: [String : Bool]
    var selectedjointWorkID: [String : Bool]
    var selectedlistedDoctorsID: [String : Bool]
    var selectedchemistID: [String : Bool]
    var headQuates: [Subordinate]?
    var cluster: [Territory]?
    var jointWork: [JointWork]?
    var listedDoctors: [DoctorFencing]?
    var chemist: [Chemist]?

   var FWFlg : String
   var HQCodes : String
   var HQNames : String
   var WTCode : String
   var WTName : String
   var chemCode : String
   var chemName : String
   var cipCode : String
   var cipName : String
   var clusterCode : String
   var clusterName : String
   var drCode : String
   var drName : String
   var hospCode : String
   var hospName : String
   var jwCode : String
   var jwName : String
   var remarks : String
   var stockistCode : String
   var stockistName : String
   var unListedDrCode : String
   var unListedDrName : String
    
    //    var selectedClusterIndices : [Int]
    //    var searchedClusterIndices : [Int]
    //    var selectedHeadQuatersIndices : [Int]
    //    var selectedJointWorkIndices : [Int]
    //    var selectedDoctorsIndices : [Int]
    //    var selectedChemistIndices : [Int]
    
    
    init() {
        self.workType = [WorkType]()
        self.headQuates = [Subordinate]()
        self.cluster = [Territory]()
        self.jointWork = [JointWork]()
        self.listedDoctors = [DoctorFencing]()
        self.chemist = [Chemist]()
        
        self.selectedClusterID = [String : Bool]()
        self.selectedHeadQuaterID = [String : Bool]()
        self.selectedjointWorkID = [String : Bool]()
        self.selectedlistedDoctorsID = [String : Bool]()
        self.selectedchemistID = [String : Bool]()
        self.workTypeCode = ""
        self.FWFlg = ""
        self.HQCodes = ""
        self.HQNames = ""
        self.WTCode = ""
        self.WTName = ""
        self.chemCode = ""
        self.chemName = ""
        self.cipCode = ""
        self.cipName = ""
        self.clusterCode = ""
        self.clusterName = ""
        self.drCode = ""
        self.drName = ""
        self.hospCode = ""
        self.hospName = ""
        self.jwCode = ""
        self.jwName = ""
        self.remarks = ""
        self.stockistCode = ""
        self.stockistName = ""
        self.unListedDrCode = ""
        self.unListedDrName = ""
    }
}

class SessionDetailsArr {
    var changeStatus : String
    var date : String
    var day : String
    var dayNo: String
    var entryMode : String
    var rejectionReason: String
    var sessionDetails : [SessionDetail]

    init() {
        changeStatus = String()
        date  = String()
        day  = String()
        dayNo = String()
        entryMode  = String()
        rejectionReason = String()
        sessionDetails = [SessionDetail]()
    }
}


class TourPlanArr {
    var Div: String
    var SFCode: String
    var SFName: String
    var arrOfPlan : [SessionDetailsArr]
    
    init() {
        Div = ""
        SFCode = ""
        SFName = ""
        arrOfPlan = [SessionDetailsArr]()
    }
}



