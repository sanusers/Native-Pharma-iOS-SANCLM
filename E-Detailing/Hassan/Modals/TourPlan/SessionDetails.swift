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
class SessionDetail {

   var workType: [WorkType]?
   var selectedWorkTypeIndex: Int? = nil
    var isForFieldWork: Bool = true
   var selectedClusterID: [String : Bool]
    var selectedHeadQuaterID: [String : Bool]
    var selectedjointWorkID: [String : Bool]
    var selectedlistedDoctorsID: [String : Bool]
    var selectedchemistID: [String : Bool]
   var headQuates: [Subordinate]?
   var cluster: [Territory]?
   var jointWork: [JointWork]?
   var listedDoctors: [DoctorFencing]?
   var chemist: [Chemist]?
    var stackList : [Stockist]?
    var selectedClusterIndices : [Int]
    var selectedHeadQuatersIndices : [Int]
    var selectedJointWorkIndices : [Int]
    var selectedDoctorsIndices : [Int]
    var selectedChemistIndices : [Int]


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
        
        self.selectedClusterIndices = [Int]()
        self.selectedHeadQuatersIndices = [Int]()
        self.selectedJointWorkIndices = [Int]()
        self.selectedDoctorsIndices = [Int]()
        self.selectedChemistIndices = [Int]()
    }
    }

class SessionDetailsArr {
    var sessionDetails : [SessionDetail]

    init() {
        self.sessionDetails = [SessionDetail]()
    }
}
