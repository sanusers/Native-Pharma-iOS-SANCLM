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

class SessionDetail : NSObject, NSCoding {

    var sessionName : String!
    var workType: [WorkType]?
    var selectedWorkTypeIndex: Int? = nil
    var searchedWorkTypeIndex: Int? = nil
    var selectedHQIndex: Int? = nil
    var searchedHQIndex: Int? = nil
    var isForFieldWork : Bool? = false
    var workTypeCode: String?
    var selectedClusterID: [String : Bool]?
    //  var selectedHeadQuaterID: [String : Bool]?
    var selectedjointWorkID: [String : Bool]?
    var selectedlistedDoctorsID: [String : Bool]?
    var selectedchemistID: [String : Bool]?
    var selectedStockistID: [String : Bool]?
    var selectedUnlistedDoctorsID: [String : Bool]?
    var headQuates: [Subordinate]?
    var cluster: [Territory]?
    var jointWork: [JointWork]?
    var listedDoctors: [DoctorFencing]?
    var chemist: [Chemist]?
    var stockist: [Stockist]?
    var unlistedDoctors: [UnListedDoctor]?
    var isToshowTerritory: Bool?
    var FWFlg : String?
    var HQCodes : String?
    var HQNames : String?
    var WTCode : String?
    var WTName : String?
    var chemCode : String?
    var chemName : String?
    var cipCode : String?
    var cipName : String?
    var clusterCode : String?
    var clusterName : String?
    var drCode : String?
    var drName : String?
    var hospCode : String?
    var hospName : String?
    var jwCode : String?
    var jwName : String?
    var remarks : String?
    var stockistCode : String?
    var stockistName : String?
    var unListedDrCode : String?
    var unListedDrName : String?
    
    public func encode(with coder: NSCoder) {
        coder.encode(sessionName, forKey: Key.sessionName.rawValue)
        coder.encode(isForFieldWork, forKey: Key.isForFieldWork.rawValue)
        coder.encode(isToshowTerritory, forKey: Key.isToshowTerritory.rawValue)
        coder.encode(selectedClusterID, forKey: Key.selectedClusterID.rawValue)
        coder.encode(selectedjointWorkID, forKey: Key.selectedjointWorkID.rawValue)
        coder.encode(selectedlistedDoctorsID, forKey: Key.selectedlistedDoctorsID.rawValue)
        coder.encode(selectedchemistID, forKey: Key.selectedchemistID.rawValue)
        coder.encode(selectedStockistID, forKey: Key.selectedStockistID.rawValue)
        coder.encode(selectedUnlistedDoctorsID, forKey: Key.selectedUnlistedDoctorsID.rawValue)
        coder.encode(workTypeCode, forKey: Key.workTypeCode.rawValue)
        coder.encode(FWFlg, forKey: Key.FWFlg.rawValue)
        coder.encode(HQCodes, forKey: Key.HQCodes.rawValue)
        coder.encode(HQNames, forKey: Key.HQNames.rawValue)
        coder.encode(WTCode, forKey: Key.WTCode.rawValue)
        coder.encode(WTName, forKey: Key.WTName.rawValue)
        coder.encode(chemCode, forKey: Key.chemCode.rawValue)
        coder.encode(chemName, forKey: Key.chemName.rawValue)
        coder.encode(cipCode, forKey: Key.cipCode.rawValue)
        coder.encode(cipName, forKey: Key.cipName.rawValue)
        coder.encode(clusterCode, forKey: Key.clusterCode.rawValue)
        coder.encode(clusterName, forKey: Key.clusterName.rawValue)
        coder.encode(drCode, forKey: Key.drCode.rawValue)
        coder.encode(drName, forKey: Key.drName.rawValue)
        coder.encode(hospCode, forKey: Key.hospCode.rawValue)
        coder.encode(hospName, forKey: Key.hospName.rawValue)
        coder.encode(jwCode, forKey: Key.jwCode.rawValue)
        coder.encode(jwName, forKey: Key.jwName.rawValue)
        coder.encode(remarks, forKey: Key.remarks.rawValue)
        coder.encode(stockistCode, forKey: Key.stockistCode.rawValue)
        coder.encode(stockistName, forKey: Key.stockistName.rawValue)
        coder.encode(unListedDrCode, forKey: Key.unListedDrCode.rawValue)
        coder.encode(unListedDrName, forKey: Key.unListedDrName.rawValue)
    }
    
    
    public required convenience init?(coder decoder: NSCoder) {
       
        let sessionName = decoder.decodeObject(forKey: Key.sessionName.rawValue) as! String
        let isToshowTerritory = decoder.decodeObject(forKey: Key.isToshowTerritory.rawValue) as! Bool
        let isForFieldWork = decoder.decodeObject(forKey: Key.isForFieldWork.rawValue) as! Bool
        let selectedClusterID = decoder.decodeObject(forKey: Key.selectedClusterID.rawValue) as! [String: Bool]
        // Uncomment the line below if needed
        // let selectedHeadQuaterID = decoder.decodeObject(forKey: Key.selectedHeadQuaterID.rawValue) as! [String: Bool]
        let selectedjointWorkID = decoder.decodeObject(forKey: Key.selectedjointWorkID.rawValue) as! [String: Bool]
        let selectedlistedDoctorsID = decoder.decodeObject(forKey: Key.selectedlistedDoctorsID.rawValue) as! [String: Bool]
        let selectedchemistID = decoder.decodeObject(forKey: Key.selectedchemistID.rawValue) as! [String: Bool]
        let selectedStockistID = decoder.decodeObject(forKey: Key.selectedStockistID.rawValue) as! [String: Bool]
        let selectedUnlistedDoctorsID = decoder.decodeObject(forKey: Key.selectedUnlistedDoctorsID.rawValue) as! [String: Bool]
        let workTypeCode = decoder.decodeObject(forKey: Key.workTypeCode.rawValue) as! String
        let FWFlg = decoder.decodeObject(forKey: Key.FWFlg.rawValue) as! String
        let HQCodes = decoder.decodeObject(forKey: Key.HQCodes.rawValue) as! String
        let HQNames = decoder.decodeObject(forKey: Key.HQNames.rawValue) as! String
        let WTCode = decoder.decodeObject(forKey: Key.WTCode.rawValue) as! String
        let WTName = decoder.decodeObject(forKey: Key.WTName.rawValue) as! String
        let chemCode = decoder.decodeObject(forKey: Key.chemCode.rawValue) as! String
        let chemName = decoder.decodeObject(forKey: Key.chemName.rawValue) as! String
        let cipCode = decoder.decodeObject(forKey: Key.cipCode.rawValue) as! String
        let cipName = decoder.decodeObject(forKey: Key.cipName.rawValue) as! String
        let clusterCode = decoder.decodeObject(forKey: Key.clusterCode.rawValue) as! String
        let clusterName = decoder.decodeObject(forKey: Key.clusterName.rawValue) as! String
        let drCode = decoder.decodeObject(forKey: Key.drCode.rawValue) as! String
        let drName = decoder.decodeObject(forKey: Key.drName.rawValue) as! String
        let hospCode = decoder.decodeObject(forKey: Key.hospCode.rawValue) as! String
        let hospName = decoder.decodeObject(forKey: Key.hospName.rawValue) as! String
        let jwCode = decoder.decodeObject(forKey: Key.jwCode.rawValue) as! String
        let jwName = decoder.decodeObject(forKey: Key.jwName.rawValue) as! String
        let remarks = decoder.decodeObject(forKey: Key.remarks.rawValue) as! String
        let stockistCode = decoder.decodeObject(forKey: Key.stockistCode.rawValue) as! String
        let stockistName = decoder.decodeObject(forKey: Key.stockistName.rawValue) as! String
        let unListedDrCode = decoder.decodeObject(forKey: Key.unListedDrCode.rawValue) as! String
        let unListedDrName = decoder.decodeObject(forKey: Key.unListedDrName.rawValue) as! String

        // Use the decoded values to initialize the object
        self.init(
            sessionName: sessionName, isToshowTerritory: isToshowTerritory, isForFieldWork: isForFieldWork,
            selectedClusterID: selectedClusterID,
          
            // Uncomment the line below if needed
            
            // selectedHeadQuaterID: selectedHeadQuaterID,
            selectedjointWorkID: selectedjointWorkID,
            selectedlistedDoctorsID: selectedlistedDoctorsID,
            selectedchemistID: selectedchemistID,
            selectedStockistID: selectedStockistID,
            selectedUnlistedDoctorsID: selectedUnlistedDoctorsID,
            workTypeCode: workTypeCode,
            FWFlg: FWFlg,
            HQCodes: HQCodes,
            HQNames: HQNames,
            WTCode: WTCode,
            WTName: WTName,
            chemCode: chemCode,
            chemName: chemName,
            cipCode: cipCode,
            cipName: cipName,
            clusterCode: clusterCode,
            clusterName: clusterName,
            drCode: drCode,
            drName: drName,
            hospCode: hospCode,
            hospName: hospName,
            jwCode: jwCode,
            jwName: jwName,
            remarks: remarks,
            stockistCode: stockistCode,
            stockistName: stockistName,
            unListedDrCode: unListedDrCode,
            unListedDrName: unListedDrName
        )
    }
    
    
    enum Key: String, CodingKey {
  
     case sessionName
     case isToshowTerritory
     case selectedClusterID
        case isForFieldWork
      //  case selectedWorkTypeIndex
     //case //selectedHeadQuaterID
     case selectedjointWorkID
     case selectedlistedDoctorsID
     case selectedchemistID
     case selectedStockistID
     case selectedUnlistedDoctorsID
     case workTypeCode
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
    
    
     init(isForFieldWork: Bool = false,
                  WTCode: String = "",
                  WTName: String = "") {
        self.isForFieldWork = isForFieldWork
        self.WTCode = WTCode
        self.WTName = WTName
    }
    
    init(
        sessionName: String = "",
        isToshowTerritory: Bool = false,
        isForFieldWork: Bool = false,
        selectedClusterID: [String: Bool] = [:],

        selectedjointWorkID: [String: Bool] = [:],
        selectedlistedDoctorsID: [String: Bool] = [:],
        selectedchemistID: [String: Bool] = [:],
        selectedStockistID: [String: Bool] = [:],
        selectedUnlistedDoctorsID: [String: Bool] = [:],
        workTypeCode: String = "",
        FWFlg: String = "",
        HQCodes: String = "",
        HQNames: String = "",
        WTCode: String = "",
        WTName: String = "",
        chemCode: String = "",
        chemName: String = "",
        cipCode: String = "",
        cipName: String = "",
        clusterCode: String = "",
        clusterName: String = "",
        drCode: String = "",
        drName: String = "",
        hospCode: String = "",
        hospName: String = "",
        jwCode: String = "",
        jwName: String = "",
        remarks: String = "",
        stockistCode: String = "",
        stockistName: String = "",
        unListedDrCode: String = "",
        unListedDrName: String = ""
    ) {
        self.sessionName = sessionName
        self.isToshowTerritory = isToshowTerritory
        self.selectedClusterID = selectedClusterID
        self.isForFieldWork = isForFieldWork
        // Uncomment the line below if needed
        // self.selectedHeadQuaterID = selectedHeadQuaterID
        self.selectedjointWorkID = selectedjointWorkID
        self.selectedlistedDoctorsID = selectedlistedDoctorsID
        self.selectedchemistID = selectedchemistID
        self.selectedStockistID = selectedStockistID
        self.selectedUnlistedDoctorsID = selectedUnlistedDoctorsID
        self.workTypeCode = workTypeCode
        self.FWFlg = FWFlg
        self.HQCodes = HQCodes
        self.HQNames = HQNames
        self.WTCode = WTCode
        self.WTName = WTName
        self.chemCode = chemCode
        self.chemName = chemName
        self.cipCode = cipCode
        self.cipName = cipName
        self.clusterCode = clusterCode
        self.clusterName = clusterName
        self.drCode = drCode
        self.drName = drName
        self.hospCode = hospCode
        self.hospName = hospName
        self.jwCode = jwCode
        self.jwName = jwName
        self.remarks = remarks
        self.stockistCode = stockistCode
        self.stockistName = stockistName
        self.unListedDrCode = unListedDrCode
        self.unListedDrName = unListedDrName
    }
    
    override init() {
        self.sessionName = String()
        self.isToshowTerritory = false
        self.selectedClusterID = [String : Bool]()
        //  self.selectedHeadQuaterID = [String : Bool]()
        self.isForFieldWork = false
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
    
    func toRemoveValues() {
//        self.isToshowTerritory = false
//        self.isForFieldWork = false
        self.selectedClusterID = [String : Bool]()
        self.selectedjointWorkID = [String : Bool]()
        self.selectedlistedDoctorsID = [String : Bool]()
        self.selectedchemistID = [String : Bool]()
        self.selectedStockistID = [String : Bool]()
        self.selectedUnlistedDoctorsID = [String : Bool]()
        self.selectedHQIndex = nil
        self.searchedHQIndex = nil
      //  self.selectedWorkTypeIndex = nil
        self.HQCodes = ""
        self.HQNames = ""
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
      //  self.remarks = ""
        self.stockistCode = ""
        self.stockistName = ""
        self.unListedDrCode = ""
        self.unListedDrName = ""
    }
}

public class SessionDetailsArr: NSObject, NSCoding  {
    
//    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("SessionDetailsArr")
    
    
    public func encode(with coder: NSCoder) {
        coder.encode(changeStatus, forKey: Key.changeStatus.rawValue)
        coder.encode(date, forKey: Key.date.rawValue)
        coder.encode(rawDate, forKey: Key.rawDate.rawValue)
        coder.encode(day, forKey: Key.day.rawValue)
        coder.encode(dayNo, forKey: Key.dayNo.rawValue)
        coder.encode(entryMode, forKey: Key.entryMode.rawValue)
        coder.encode(rejectionReason, forKey: Key.rejectionReason.rawValue)
        coder.encode(sessionDetails, forKey: Key.sessionDetails.rawValue)
    }
    

    
    public required convenience init?(coder decoder: NSCoder) {
        let mchangeStatus =   decoder.decodeObject(forKey: Key.changeStatus.rawValue) as! String
      
        let mdate = decoder.decodeObject(forKey: Key.date.rawValue) as! String
        let mrawDate = decoder.decodeObject(forKey: Key.rawDate.rawValue) as! Date
        let mday = decoder.decodeObject(forKey: Key.day.rawValue) as! String
        let mdayNo = decoder.decodeObject(forKey: Key.dayNo.rawValue) as! String
        let mentryMode = decoder.decodeObject(forKey: Key.entryMode.rawValue) as! String
        let mrejectionReason = decoder.decodeObject(forKey: Key.rejectionReason.rawValue) as! String
        let msessionDetails = decoder.decodeObject(forKey: Key.sessionDetails.rawValue) as! [SessionDetail]
        
        self.init(changeStatus: mchangeStatus, date: mdate, rawDate: mrawDate, day: mday, dayNo: mdayNo, entryMode: mentryMode, rejectionReason: mrejectionReason, sessionDetails: msessionDetails)
    }
    

    
    var changeStatus : String!
    var date : String!
    var rawDate : Date!
    var day : String!
    var dayNo: String!
    var entryMode : String!
    var rejectionReason: String!
    var sessionDetails : [SessionDetail]!
    
    init(changeStatus: String, date: String, rawDate: Date, day: String, dayNo: String, entryMode: String, rejectionReason: String, sessionDetails: [Any]) {
     
        self.changeStatus = changeStatus
        self.date = date
        self.rawDate = rawDate
        self.day = day
        self.dayNo = dayNo
        self.entryMode = entryMode
        self.rejectionReason = rejectionReason
        self.sessionDetails = sessionDetails as? [SessionDetail]
    }
    
    
    enum Key: String, CodingKey {
        case changeStatus
        case date
        case rawDate
        case day
        case dayNo
        case entryMode
        case rejectionReason
        case sessionDetails
        
    }

    override init() {
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


public class TourPlanArr : NSObject, NSCoding {

    
    var Div: String!
    var SFCode: String!
    var SFName: String!
    var arrOfPlan : [SessionDetailsArr]!
    
    
    enum Key: String, CodingKey {
        case Div
        case SFCode
        case SFName
        case arrOfPlan
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(Div, forKey: Key.Div.rawValue)
        coder.encode(SFCode, forKey: Key.SFCode.rawValue)
        coder.encode(SFName, forKey: Key.SFName.rawValue)
        coder.encode(arrOfPlan, forKey: Key.arrOfPlan.rawValue)
    }
    
    
    public required convenience init?(coder decoder: NSCoder) {
        let mDiv =   decoder.decodeObject(forKey: Key.Div.rawValue) as! String
        let mSFCode = decoder.decodeObject(forKey: Key.SFCode.rawValue) as! String
        let mSFName = decoder.decodeObject(forKey: Key.SFName.rawValue) as! String
        let marrOfPlan = decoder.decodeObject(forKey: Key.arrOfPlan.rawValue) as! [SessionDetailsArr]
        self.init(Div: mDiv, SFCode: mSFCode, SFName: mSFName, arrOfPlan: marrOfPlan)
    }
    
    
    init(Div: String, SFCode: String, SFName: String, arrOfPlan: [SessionDetailsArr]) {
        self.Div = Div
        self.SFCode = SFCode
        self.SFName = SFName
        self.arrOfPlan = arrOfPlan
    }
    
    override init() {
        Div = ""
        SFCode = ""
        SFName = ""
        arrOfPlan = [SessionDetailsArr]()
    }
}

class EachDatePlan : NSObject, NSCoding{
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("EachDatePlan")

    var tourPlanArr : [TourPlanArr]!
    
    enum Key: String, CodingKey {
        case tourPlanArr
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(tourPlanArr, forKey: Key.tourPlanArr.rawValue)
    }
    
    public required convenience init?(coder decoder: NSCoder) {
        let mtourPlanArr =   decoder.decodeObject(forKey: Key.tourPlanArr.rawValue) as! [TourPlanArr]
        self.init(tourPlanArr: mtourPlanArr)
    }
    
    init(tourPlanArr:  [TourPlanArr]) {
        self.tourPlanArr = tourPlanArr
    }
    
    override init() {
        tourPlanArr = [TourPlanArr]()
    }
}



