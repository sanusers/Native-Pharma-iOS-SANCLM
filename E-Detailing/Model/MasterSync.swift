//
//  MasterSync.swift
//  E-Detailing
//
//  Created by SANEFORCE on 28/06/23.
//

import Foundation


enum MasterCellType : Int {
    
    case syncAll = 0
    case listedDoctor = 1
    case chemist = 2
    case stockist = 3
    case unLstDoctor = 4
    case cip = 5
    case hospital = 6
    case subordinate = 7
    case slides = 8
    case Product = 9
    case input = 10
    case cluster = 11
    case stockBalance = 12
    
    var name : String {
        switch self {
            
        case .syncAll:
            return "Sync All"
        case .listedDoctor:
            return "Listed Doctor"
        case .chemist:
            return "Chemist"
        case .stockist:
            return "Stockist"
        case .unLstDoctor:
            return "UnListed Doctor"
        case .cip:
            return "CIP"
        case .hospital:
            return "Hospital"
        case .subordinate:
            return "Subordinate"
        case .slides:
            return "Slides"
        case .Product:
            return "Product"
        case .input:
            return "input"
        case .cluster:
            return "Cluster"
        case .stockBalance:
            return "Stock Balance"
        }
    }
    
    var groupDetail : [MasterInfo] {
        switch self {
            
        case .syncAll:
            return [MasterInfo.slides,MasterInfo.worktype]
        case .listedDoctor:
            return [MasterInfo.doctorFencing,MasterInfo.doctorClass,MasterInfo.category,MasterInfo.speciality,MasterInfo.qualifications,MasterInfo.competitors,MasterInfo.departments,MasterInfo.docFeedback,MasterInfo.empty,MasterInfo.syncAll]
        case .chemist:
            return [MasterInfo.chemists,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        case .stockist:
            return [MasterInfo.stockists,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        case .unLstDoctor:
            return [MasterInfo.unlistedDoctors,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        case .cip:
            return [MasterInfo.subordinate,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        case .hospital:
            return [MasterInfo.subordinateMGR,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        case .subordinate:
            return [MasterInfo.subordinate,MasterInfo.subordinateMGR,MasterInfo.jointWork,MasterInfo.syncAll]
        case .slides:
            return [MasterInfo.slides,MasterInfo.slideBrand,MasterInfo.slideSpeciality,MasterInfo.syncAll]
        case .Product:
            return [MasterInfo.products,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        case .input:
            return [MasterInfo.inputs,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        case .cluster:
            return [MasterInfo.clusters,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        case .stockBalance:
            return [MasterInfo.stockBalance,MasterInfo.empty,MasterInfo.empty,MasterInfo.syncAll]
        }
    }
}

//[MasterInfo.slides,MasterInfo.doctorFencing,MasterInfo.chemists,MasterInfo.stockists,MasterInfo.unlistedDoctors,MasterInfo.worktype,MasterInfo.clusters,MasterInfo.myDayPlan,MasterInfo.subordinate,MasterInfo.subordinateMGR,MasterInfo.jointWork,MasterInfo.products,
//                   MasterInfo.inputs,MasterInfo.brands,MasterInfo.competitors,MasterInfo.slideSpeciality,MasterInfo.slideBrand,MasterInfo.speciality,MasterInfo.departments,MasterInfo.category,MasterInfo.qualifications,MasterInfo.doctorClass,MasterInfo.setups,MasterInfo.customSetup]

enum `MasterInfo` : String {
    case holidays = "Holidays"
    case weeklyOff = "Weekly Off"
    case tableSetup = "Table Setup"
    case worktype = "Work Types"
    case headquartes = "Headquarters"
    case competitors = "Competitors"
    case inputs = "Inputs"
    case slideBrand = "Slide Brand"
    case products = "Products"
    case slides = "Slides"
    case slideSpeciality = "Slide Speciality"
    case brands = "Brands"
    case departments = "Departments"
    case speciality = "Speciality"
    case category = "Category"
    case qualifications = "Qualifications"
    case doctorClass = "Doctorclass"
    case docTypes = "DocTypes"
    case ratingDetails = "Rating Details"
    case ratingFeedbacks = "Rating Feedbacks"
    case speakerList = "Speaker List"
    case participantList = "Participant List"
    case indicationList = "Indication List"
    case setups = "Setups"
    case clusters = "Clusters"
    case doctors = "Doctors"
    case chemists = "Chemists"
    case stockists = "Stockists"
    case unlistedDoctors = "Unlisted Doctors"
    case institutions = "Institutions"
    case jointWork = "Jointworks"
    
    case subordinate = "Subordinate"
    case subordinateMGR = "Subordinate MGR"
    
    case doctorFencing = "Listed Doctor"
    case docFeedback = "Doctor Feedback"
    case myDayPlan = "My Day Plan"
    case customSetup = "Custom Setup"
    case leaveType = "Leave Type"
    case tourPlanStatus = "Tour Plan Status"
    case visitControl = "Visit Control"
    case stockBalance = "Stock Balance"
    case mapCompDet = "map Comp Det"
    case empty = "Empty"
    case syncAll = "Sync All"
    case getTP = "Tour Plan"
 
    var getUrl : String {
        
        let mainUrl = AppDefaults.shared.webUrl + AppDefaults.shared.iosUrl
        
        switch self {
            
        case .headquartes:
            return String(format: "%@GET/HQ", mainUrl)
        case .ratingDetails:
            return String(format: "%@GET/RatingInf", mainUrl)
        case .ratingFeedbacks:
            return String(format: "%@GET/RatingFeedbk", mainUrl)
        case .speakerList:
            return String(format: "%@GET/Speaker", mainUrl)
        case .participantList:
            return String(format: "%@GET/Participant", mainUrl)
        case .indicationList:
            return String(format: "%@GET/Indication", mainUrl)
        case .setups,.customSetup:
            return String(format: "%@table/setups", mainUrl) // crm.saneforce.in/iOSServer/db_ios.php?axn=table/setups table/leave
        case .doctors:
            return String(format: "%@GET/Doctors", mainUrl)
        case .institutions:
            return String(format: "%@GET/Hospitals", mainUrl)
        case .leaveType:
            return String(format: "%@table/leave", mainUrl)
            
        case .tourPlanStatus,.visitControl,.stockBalance,.mapCompDet:
            return String(format: "%@table/additionaldcrmasterdata", mainUrl)
        
        case .products,.inputs,.brands,.competitors :
            return String(format: "%@table/products", mainUrl)
        
        case .subordinate , .subordinateMGR, .jointWork:
            return String(format: "%@table/subordinates", mainUrl)
        case .doctorFencing ,.chemists ,.stockists,.unlistedDoctors,.worktype ,.clusters,.myDayPlan,.speciality,.departments,.doctorClass,.docTypes,.qualifications,.category,.docFeedback :
            return String(format: "%@table/dcrmasterdata", mainUrl)
        case .tableSetup:
            return String(format: "%@table/setups", mainUrl)
            
        case .weeklyOff:
            return String(format: "%@table/dcrmasterdata", mainUrl)
            
        case .holidays:
            return String(format: "%@table/dcrmasterdata", mainUrl)
            
        case .getTP:
            return String(format: "%@get/tp", mainUrl)
        default :
            return String(format: "%@table/slides", mainUrl) //
        }
    }
    
    var getParams  : [String : Any] {
        
        switch self{
            
        case .worktype:
            return MasterSyncParams.workTypeParams
        case .competitors:
            return MasterSyncParams.competitorParams
        case .inputs:
            return MasterSyncParams.inputParams
        case .slideBrand:
            return MasterSyncParams.slideBrandParams
        case .products:
            return MasterSyncParams.productParams
        case .slides:
            return MasterSyncParams.productSlideParams
        case .brands:
            return MasterSyncParams.brandParams
        case .departments:
            return MasterSyncParams.departsParams
        case .speciality:
            return MasterSyncParams.specialityParams
        case .category:
            return MasterSyncParams.categoryParams
        case .qualifications:
            return MasterSyncParams.qualificationParams
        case .doctorClass:
            return MasterSyncParams.classParams
        case .docTypes:
            return MasterSyncParams.typeParams
        case .ratingDetails:
            return [String : Any]()
        case .ratingFeedbacks:
            return [String : Any]()
        case .speakerList:
            return [String : Any]()
        case .participantList:
            return [String : Any]()
        case .indicationList:
            return [String : Any]()
        case .headquartes:
            return [String : Any]()
        case .setups:
            return MasterSyncParams.setupParams
        case .clusters:
            return MasterSyncParams.territoryParams
        case .doctors:
            return [String : Any]()
        case .chemists:
            return MasterSyncParams.chemistParams
        case .stockists:
            return MasterSyncParams.stockistParams
        case .unlistedDoctors:
            return MasterSyncParams.unListedDoctorParams
        case .institutions:
            return [String : Any]()
        case .jointWork:
            return MasterSyncParams.jointWorkParams
        case .subordinate:
            return MasterSyncParams.subordinateParams
        case .subordinateMGR:
            return MasterSyncParams.subordinateMgrParams
        case .doctorFencing:
            return MasterSyncParams.doctorFencingParams
        case .myDayPlan:
            return MasterSyncParams.myDayPlanParams
        case .syncAll:
            return [String : Any]()
        case .slideSpeciality:
            return MasterSyncParams.slideSpecialityParams
        case .docFeedback:
            return MasterSyncParams.docFeedBackParams
        case .customSetup:
            return MasterSyncParams.customSetupParams
        case .leaveType:
            return MasterSyncParams.leaveTypeParams
        case .tourPlanStatus:
            return MasterSyncParams.tpStatusParams
        case .visitControl:
            return MasterSyncParams.visitControlParams
        case .stockBalance:
            return MasterSyncParams.stockBalanceParams
        case .mapCompDet:
            return MasterSyncParams.mapCompdetParams
        case .empty:
            return [String : Any]()
        case .tableSetup:
            return MasterSyncParams.tableSetupParams
        case .weeklyOff:
            return MasterSyncParams.weelyoffSetupParams
        case .holidays:
            return MasterSyncParams.holidaySetupParams
        case .getTP:
            return MasterSyncParams.tourPlanSetupParams
        }
 
    }
}

struct MasterSyncParams {
    
    static var productSlideParams : [String : Any ] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        let paramString = "{\"tableName\":\"getprodslides\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var subordinateParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getsubordinate\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var subordinateMgrParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getsubordinatemgr\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var doctorFencingParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let sfCode = MasterSyncVC.shared.getSFCode
        
        let paramString = "{\"tableName\":\"getdoctors\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(sfCode)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var chemistParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getchemist\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var stockistParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getstockist\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var unListedDoctorParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getunlisteddr\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var workTypeParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getworktype\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var territoryParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getterritory\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var myDayPlanParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let date = Date().toString(format: "yyyy-MM-dd 00:00:00")
        
        let paramString = "{\"tableName\":\"gettodaytpnew\",\"ReqDt\":\"\(date)\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var jointWorkParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getjointwork\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var productParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getproducts\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var inputParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getinputs\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var brandParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getbrands\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var competitorParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getmap_compdet\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    } // getmap_compdet getcompdet
    
    static var slideSpecialityParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getslidespeciality\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var slideBrandParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getslidebrand\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var specialityParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getspeciality\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var departsParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getdeparts\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var categoryParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getcategorys\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var qualificationParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getquali\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var classParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getclass\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var typeParams : [String : Any] {
      //  let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"gettypes\",\"sfcode\":\"MR0026\",\"division_code\":\"8,\",\"Rsf\":\"MR0026\",\"sf_type\":\"1\",\"Designation\":\"TBM\",\"state_code\":\"28\",\"subdivision_code\":\"62,\"}"
        
        return ["data" : paramString]
    }
    
    static var docFeedBackParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getdrfeedback\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var setupParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getsetups\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var customSetupParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getcustomsetup\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    
    static var leaveTypeParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getleavetype\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var tpStatusParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"gettpstatus\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var stockBalanceParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getstockbalance\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var visitControlParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getvisit_contro\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var mapCompdetParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"getmapcompdet\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    static var tableSetupParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let paramString = "{\"tableName\":\"gettpsetup\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"
        
        return ["data" : paramString]
    }
    
    
    static var weelyoffSetupParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        let year = Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year
        
        let paramString = "{\"tableName\":\"getweeklyoff\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\",\"year\":\"\(year!)\"}"
        
        return ["data" : paramString]
        

    }
    
    static var holidaySetupParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        let year = Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year
        
        let paramString = "{\"tableName\":\"getholiday\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\",\"year\":\"\(year!)\"}"
        
        return ["data" : paramString]
        
      //  {"tableName":"getholiday","sfcode":"MR0026","division_code":"8,","Rsf":"MR0026","sf_type":"1","Designation":"TBM","state_code":"28","subdivision_code":"62,","year":"2023"}

    }
    
    
    static var tourPlanSetupParams : [String : Any] {
        let appsetup = AppDefaults.shared.getAppSetUp()
        var param = [String: Any]()
        param["tableName"] = "getall_tp"
        param["sfcode"] = "\(appsetup.sfCode!)"
        param["division_code"] = "\(appsetup.divisionCode!)"
        param["Rsf"] = "\(appsetup.sfCode!)"
        param["sf_type"] = "\(appsetup.sfType!)"
        param["Designation"] = "\(appsetup.dsName!)"
        param["state_code"] = "\(appsetup.stateCode!)"
        param["subdivision_code"] = "\(appsetup.subDivisionCode!)"
        
        let currentDate = Date()
        let calendar = Calendar.current

        // Get the current month and year components
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)

        // Convert the components to strings and add them to your parameters
        param["tp_month"] = "\(month),"
        param["tp_year"] = "\(year),"
        
      //  param["tp_month"] = "12,"
      //  param["tp_year"] = "2023,"
        
        
        var jsonDatum = Data()

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: [])
            jsonDatum = jsonData
            // Convert JSON data to a string
            if let tempjsonString = String(data: jsonData, encoding: .utf8) {
                print(tempjsonString)

            }
            

        } catch {
            print("Error converting parameter to JSON: \(error)")
        }
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum

        
        return toSendData
    }
}


//{"tableName":"gettodaytpnew","ReqDt":"2023-06-24 00:00:00","sfcode":"MR0026","division_code":"8,","Rsf":"MR0026","sf_type":"1","Designation":"TBM","state_code":"28","subdivision_code":"62,"}
