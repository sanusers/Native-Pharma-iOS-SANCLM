//
//  SessionDetails.swift
//  E-Detailing
//
//  Created by San eforce on 14/11/23.
//

import Foundation


class TableSetupModel: Codable {
    let SF_code : String
    let AddsessionNeed : String
    let AddsessionCount : String
    let DrNeed : String
    let ChmNeed : String
    let JWNeed : String
    let ClusterNeed : String
    let clustertype : String
    let div : String
    let StkNeed : String
    let Cip_Need : String
    let HospNeed : String
    let FW_meetup_mandatory : String
    let max_doc : String
    let tp_objective : String
    let Holiday_Editable : String
    let Weeklyoff_Editable : String
    let UnDrNeed : Int
    
    
    enum CodingKeys: String, CodingKey {
        case SF_code
        case AddsessionNeed
        case AddsessionCount
        case DrNeed
        case ChmNeed
        case JWNeed
        case ClusterNeed
        case clustertype
        case div
        case StkNeed
        case Cip_Need
        case HospNeed
        case FW_meetup_mandatory
        case max_doc
        case tp_objective
        case Holiday_Editable
        case Weeklyoff_Editable
        case UnDrNeed
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.SF_code = container.safeDecodeValue(forKey: .SF_code)
        self.AddsessionNeed = container.safeDecodeValue(forKey: .AddsessionNeed)
        self.AddsessionCount = container.safeDecodeValue(forKey: .AddsessionCount)
        self.DrNeed = container.safeDecodeValue(forKey: .DrNeed)
        self.ChmNeed = container.safeDecodeValue(forKey: .ChmNeed)
        self.JWNeed = container.safeDecodeValue(forKey: .JWNeed)
        self.ClusterNeed = container.safeDecodeValue(forKey: .ClusterNeed)
        self.clustertype = container.safeDecodeValue(forKey: .clustertype)
        self.div = container.safeDecodeValue(forKey: .div)
        self.StkNeed = container.safeDecodeValue(forKey: .StkNeed)
        self.Cip_Need = container.safeDecodeValue(forKey: .Cip_Need)
        self.HospNeed = container.safeDecodeValue(forKey: .HospNeed)
        self.FW_meetup_mandatory = container.safeDecodeValue(forKey: .FW_meetup_mandatory)
        self.max_doc = container.safeDecodeValue(forKey: .max_doc)
        self.tp_objective = container.safeDecodeValue(forKey: .tp_objective)
        self.Holiday_Editable = container.safeDecodeValue(forKey: .Holiday_Editable)
        self.Weeklyoff_Editable = container.safeDecodeValue(forKey: .Weeklyoff_Editable)
        self.UnDrNeed = container.safeDecodeValue(forKey: .UnDrNeed)
    }
    
    init() {
        SF_code = ""
         AddsessionNeed = "0"
         AddsessionCount = "3"
         DrNeed = "0"
         ChmNeed = "0"
         JWNeed = "0"
         ClusterNeed = "1"
         clustertype = "1"
         div = "63"
         StkNeed = "0"
         Cip_Need = "0"
         HospNeed = "1"
         FW_meetup_mandatory = "0"
         max_doc = "0"
         tp_objective = "1"
         Holiday_Editable = "0"
         Weeklyoff_Editable = "0"
         UnDrNeed = 0
    }
    
}

class SessionDetail {
    var sessionName : String
    var workType: [WorkType]?
    var selectedWorkTypeIndex: Int? = nil
    var searchedWorkTypeIndex: Int? = nil
    var selectedHQIndex: Int? = nil
    var searchedHQIndex: Int? = nil
    var isForFieldWork: Bool = true
    var workTypeCode: String? = nil
    var selectedClusterID: [String : Bool]
  //  var selectedHeadQuaterID: [String : Bool]
    var selectedjointWorkID: [String : Bool]
    var selectedlistedDoctorsID: [String : Bool]
    var selectedchemistID: [String : Bool]
    var selectedStockistID: [String : Bool]
    var selectedUnlistedDoctorsID: [String : Bool]
    var headQuates: [Subordinate]?
    var cluster: [Territory]?
    var jointWork: [JointWork]?
    var listedDoctors: [DoctorFencing]?
    var chemist: [Chemist]?
    var stockist: [Stockist]?
    var unlistedDoctors: [UnListedDoctor]?
    var isToshowTerritory: Bool
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
    
    init() {
        sessionName = String()
        self.workType = [WorkType]()
        self.headQuates = [Subordinate]()
        self.cluster = [Territory]()
        self.jointWork = [JointWork]()
        self.listedDoctors = [DoctorFencing]()
        self.chemist = [Chemist]()
        self.isToshowTerritory = false
        self.selectedClusterID = [String : Bool]()
      //  self.selectedHeadQuaterID = [String : Bool]()
        self.selectedjointWorkID = [String : Bool]()
        self.selectedlistedDoctorsID = [String : Bool]()
        self.selectedchemistID = [String : Bool]()
        self.selectedStockistID = [String : Bool]()
        self.selectedUnlistedDoctorsID = [String : Bool]()
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
    var rawDate : Date
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
        rawDate = Date()
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

class EachDatePlan {
    var tourPlanArr : [TourPlanArr]
    init() {
        tourPlanArr = [TourPlanArr]()
    }
}



