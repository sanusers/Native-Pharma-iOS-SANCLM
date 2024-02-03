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


//let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("SessionDetailsArr")
//
//do {
//let data = try NSKeyedArchiver.archivedData(withRootObject: aDaySessions, requiringSecureCoding: false)
//try data.write(to: path)
//} catch {
//print("ERROR: \(error.localizedDescription)")
//}


//MARK: - VC
//
//  MenuVIew.swift
//  E-Detailing
//
//  Created by San eforce on 10/11/23.
//



//import Foundation
//import UIKit
//import CoreData
//
//extension MenuView : UITextViewDelegate {
//    
//}
//
//extension MenuView {
//    func toGetTourPlanResponse() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "d MMMM yyyy"
//        self.sessionDetailsArr.date = dateFormatter.string(from: self.menuVC.selectedDate ?? Date())
//        self.sessionDetailsArr.rawDate = self.menuVC.selectedDate ?? Date()
//        dateFormatter.dateFormat = "EEEE"
//        self.sessionDetailsArr.day = dateFormatter.string(from: self.menuVC.selectedDate ?? Date())
//        
//        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
//        self.sessionDetailsArr.dayNo = dateFormatter.string(from: self.menuVC.selectedDate ?? Date())
//        self.sessionDetailsArr.entryMode = ""
//        self.sessionDetailsArr.rejectionReason = ""
//        
//        
//        let aDaySessions = self.sessionDetailsArr
//        
//        
//        // toCheckSessionInfo() returns unfilled sessions
//        let filteredSessions = toCheckSessionInfo()
//        
//        //New func added
//        
//        if filteredSessions.isEmpty {
//            aDaySessions.sessionDetails?.forEach { session in
//                session.workType = nil
//                session.headQuates = nil
//                session.cluster = nil
//                session.jointWork = nil
//                session.listedDoctors = nil
//                session.chemist = nil
//                session.stockist = nil
//                session.unlistedDoctors = nil
//                if !session.isForFieldWork {
//                    session.toRemoveValues()
//                }
//            }
//            toAppendsessionDetails(aDaySessions: aDaySessions)
//        } else {
//            var sessionIndex = [Int]()
//            filteredSessions.forEach { filteredsessions in
//                aDaySessions.sessionDetails?.enumerated().forEach { daySessionIndex ,daySessions in
//                    if filteredsessions.sessionName == daySessions.sessionName {
//                        sessionIndex.append(daySessionIndex)
//                    }
//                }
//              
//            }
//            
//            toAlertCell(sessionIndex)
//        }
//        
////        if subActivitySeected {
////
////                aDaySessions.sessionDetails?.forEach { session in
////                    session.workType = nil
////                    session.headQuates = nil
////                    session.cluster = nil
////                    session.jointWork = nil
////                    session.listedDoctors = nil
////                    session.chemist = nil
////                }
////                toAppendsessionDetails(aDaySessions: aDaySessions)
////
////        } else {
////            toAlertCell()
////          //  toCreateToast("Please fill required info before saving plan")
////        }
//        
////
////                 let param = [String: Any]()
////
////                sessionResponseVM!.getZstoreData(params: param, api: .zsotoreJSON) { result in
////                            switch result {
////                            case .success(let response):
////                                print(response)
////
////                                do {
////                                    try AppDefaults.shared.toSaveEncodedData(object: response, key: .tourPlan) {_ in
////
////                                    }
////                                } catch {
////                                    print("Unable to save")
////                                }
////                            case .failure(let error):
////                                print(error.localizedDescription)
////                            }
////                        }
//        
//    }
//    
//    struct NotfilledPlans {
//        let planindex: Int
//        let isValidated : Bool
//    }
//    
//    func toCheckSessionInfo() -> [SessionDetail] {
//        let aDaySessions = self.sessionDetailsArr
// 
//        let nonEmptySession =  aDaySessions.sessionDetails?.filter { session in
//            session.WTCode != ""
//        }
//        
//        
//        
////        var notFilledPlans = [NotfilledPlans]()
////
////        aDaySessions.sessionDetails?.enumerated().forEach { index, session in
////            if session.isForFieldWork == true {
////                if session.WTCode == "" {
////                   let notfilledplan = NotfilledPlans(planindex: index, isValidated: false)
////                    notFilledPlans.append(notfilledplan)
////                }
////            }
////        }
//
//        if  aDaySessions.sessionDetails?.count != nonEmptySession?.count {
//                self.toCreateToast("Please fill the required fields to save Plan")
//                return  aDaySessions.sessionDetails?.filter { session in
//                    session.WTCode == ""
//                   
//                } ?? [SessionDetail]()
//            } else {
//                let territoryNeededSessions = aDaySessions.sessionDetails?.filter { session in
//                    session.isToshowTerritory == true
//                }
//                
//                
//                if territoryNeededSessions?.count == 0 {
//                 //   return true
//                    return territoryNeededSessions ?? [SessionDetail]()
//                } else {
//                    let territoryNotFilledSessions = territoryNeededSessions?.filter{ session in
//                       // session.selectedHeadQuaterID.isEmpty  || session.selectedClusterID.isEmpty
//                        session.HQCodes?.isEmpty ?? false  || session.selectedClusterID!.isEmpty
//                        
//                    }
//                    
//                    var subActivitySeected : Bool = true
//                    
//                    if territoryNotFilledSessions?.count == 0 {
//                    
//                        let otherFieldMandatorySessions = nonEmptySession?.filter { session in
//                            session.isForFieldWork == true && tableSetup.FW_meetup_mandatory == "0"
//                        }
//
//                        otherFieldMandatorySessions?.forEach { session in
//                            if self.isDocNeeded {
//                                if session.selectedlistedDoctorsID?.count == 0{
//                                    self.toCreateToast("Please select doctor")
//                                    subActivitySeected = false
//                                }
//                            } else {
//                                if session.selectedjointWorkID?.count == 0 && session.selectedlistedDoctorsID?.count == 0 && session.selectedchemistID?.count == 0 {
//                                    self.toCreateToast("Please fill any one of sub activity fields to save sessions")
//                                    subActivitySeected = false
//                                    
//                                } else {
//                                    subActivitySeected = true
//                                    
//                                }
//                            }
//                            
//                            
//                        }
//                        if subActivitySeected {
//                            return [SessionDetail]()
//                        } else {
//                            return otherFieldMandatorySessions ?? [SessionDetail]()
//                        }
//                        
//                        //subActivitySeected
//                    } else {
//                        self.toCreateToast("Please fill the HeadQuarters and cluster to save sessions")
//                        return territoryNotFilledSessions ?? [SessionDetail]()
//                    }
//                }
//                
//
//                
//                
//    
//              //  return subActivitySeected
//            }
//    }
//    
//    func toValidateRequiredFields(_ sessions: SessionDetailsArr) -> Bool {
//        return false
//    }
//    
//    func toAppendsessionDetails(aDaySessions : SessionDetailsArr) {
//        let appdefaultSetup = AppDefaults.shared.getAppSetUp()
//        let tourPlanArr =  AppDefaults.shared.tpArry
//       // var arrOfPlan = tourPlanArr.arrOfPlan
//        tourPlanArr.Div = appdefaultSetup.divisionCode
//        tourPlanArr.SFCode = appdefaultSetup.sfCode
//        tourPlanArr.SFName = appdefaultSetup.sfName
//        
//      //  tourPlanArr.arrOfPlan?.removeAll()
//        tourPlanArr.arrOfPlan?.append(aDaySessions)
//   
//        
//        
//        var isRemoved = false
//        tourPlanArr.arrOfPlan?.enumerated().forEach { index , sessionDetArr in
//            if tourPlanArr.arrOfPlan?.count ?? 0 > index {
//                if sessionDetArr.date == aDaySessions.date && aDaySessions.changeStatus == "True" {
//                    tourPlanArr.arrOfPlan?.remove(at: index)
//                    isRemoved = true
//                } else {
//                  //  tourPlanArr.arrOfPlan.append(sessionDetailsArr)
//                }
//            }
//     
//            
//        }
//        if isRemoved {
//         //   tourPlanArr.arrOfPlan.append(aDaySessions)
//        }
//      
//
//        _ = self.toSetParams(tourPlanArr)
//
// 
//        AppDefaults.shared.tpArry = tourPlanArr
//        
//        var arrOfPlan = [SessionDetailsArr]()
//        
//      
//        
//            AppDefaults.shared.eachDatePlan.tourPlanArr?.append(AppDefaults.shared.tpArry)
//  
//            
//         arrOfPlan = AppDefaults.shared.tpArry.arrOfPlan ?? [SessionDetailsArr]()
//            
//            
//        var sessionDetails =  [SessionDetailsArr]()
//            
//        AppDefaults.shared.tpArry.arrOfPlan?.forEach { plan in
//            sessionDetails.append(plan)
//        }
//        
//     //   AppDefaults.shared.eachDatePlan.tourPlanArr.append(AppDefaults.shared.tpArry)
//        
//        
//            var isEachDayRemoved = false
//  
//             
//        arrOfPlan.enumerated().forEach { EachDaysessionDetArrIndex, EachDaysessionDetArr  in
//            sessionDetails.enumerated().forEach { tpArrSessionIndex,  tpArrSessionDetArr in
//                if EachDaysessionDetArr.date == tpArrSessionDetArr.date && EachDaysessionDetArr.changeStatus == "True" {
//                    if arrOfPlan.count > EachDaysessionDetArrIndex {
//                        arrOfPlan.remove(at: EachDaysessionDetArrIndex)
//                        isEachDayRemoved = true
//                    }
//                } else {
//                  //  AppDefaults.shared.eachDatePlan.tourPlanArr.append(AppDefaults.shared.tpArry)
//                }
//            }
//        }
//        
//        sessionDetails.forEach { sessionDetArr in
//            sessionDetArr.sessionDetails?.forEach({ session in
//                session.workType = nil
//                session.cluster = nil
//                session.headQuates = nil
//                session.jointWork = nil
//                session.listedDoctors = nil
//                session.chemist = nil
//                session.stockist = nil
//                session.unlistedDoctors = nil
//            })
//        }
//        
//        if isEachDayRemoved {
//            arrOfPlan = sessionDetails
//        }
//           
//        AppDefaults.shared.eachDatePlan.tourPlanArr?.forEach({ tpArr in
//                   // tpArr.arrOfPlan.removeAll()
//                   // tpArr.arrOfPlan = arrOfPlan
//                    tpArr.arrOfPlan = arrOfPlan
//                })
//        
//        var  yetToSavePlanArr = EachDatePlan()
//            
//         yetToSavePlanArr = NSKeyedUnarchiver.unarchiveObject(withFile: EachDatePlan.ArchiveURL.path) as? EachDatePlan ?? EachDatePlan()
//        
//        if yetToSavePlanArr.tourPlanArr?.count == 0 {
//            yetToSavePlanArr = AppDefaults.shared.eachDatePlan
//        } else   {
//            
//          var dayStr = [String]()
//            arrOfPlan.forEach { sessionDetArr in
//                dayStr.append(sessionDetArr.day ?? "")
//            }
//            
//            
//            yetToSavePlanArr.tourPlanArr?.forEach({ tpAarr in
//                let editedArr = tpAarr.arrOfPlan?.filter({ sessionDetArr in
//                    sessionDetArr.changeStatus == "True"
//                })
//          
//                tpAarr.arrOfPlan?.append(contentsOf: arrOfPlan)
//            })
//        }
//        
//
//        
//        // AppDefaults.shared.eachDatePlan
////
////        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("EachDatePlan")
////
////        do {
////        let data = try NSKeyedArchiver.archivedData(withRootObject: yetToSavePlanArr, requiringSecureCoding: false)
////        try data.write(to: path)
////        } catch {
////        print("ERROR: \(error.localizedDescription)")
////        }
//
//        
//        print("saveMeals")
//        let savefinish = NSKeyedArchiver.archiveRootObject(yetToSavePlanArr, toFile: EachDatePlan.ArchiveURL.path)
//             if !savefinish {
//                 print("Error")
//             }
//        
//        self.toCreateToast("Plan added successfully")
//        self.menuVC.menuDelegate?.callPlanAPI()
//        self.hideMenuAndDismiss()
//    }
//    
//    func toSetParams(_ tourPlanArr: TourPlanArr) -> [String: Any] {
//        _ = self.menuVC.selectedDate
//        let dateArr = self.sessionDetailsArr.date?.components(separatedBy: " ") //"1 Nov 2023"
//        let anotherDateArr = self.sessionDetailsArr.dayNo?.components(separatedBy: "/") // MM/dd/yyyy - 09/12/2018
//        var param = [String: Any]()
//        param["SFCode"] = tourPlanArr.SFCode
//        param["SFName"] = tourPlanArr.SFName
//        param["Div"] = tourPlanArr.Div
//        param["Mnth"] = anotherDateArr?[0]
//        param["Yr"] = dateArr?[2]//2023
//        param["Day"] =  dateArr?[0]//1
//        param["Tour_Month"] = anotherDateArr?[0]// 11
//        param["Tour_Year"] = dateArr?[2] // 2023
//        param["tpmonth"] = dateArr?[1]// Nov
//        param["tpday"] = self.sessionDetailsArr.day// Wednesday
//        param["dayno"] = anotherDateArr?[0] // 11
//        let tpDtDate = self.sessionDetailsArr.dayNo?.replacingOccurrences(of: "/", with: "-")
//        param["TPDt"] =  tpDtDate//2023-11-01 00:00:00
//        tourPlanArr.arrOfPlan?.enumerated().forEach { index, allDayPlans in
//            allDayPlans.sessionDetails?.enumerated().forEach { sessionIndex, session in
//               // var sessionParam = [String: Any]()
//                var index = String()
//                if sessionIndex == 0 {
//                    index = ""
//                } else {
//                    index = "\(sessionIndex + 1)"
//                }
//                
//                var drIndex = String()
//                if sessionIndex == 0 {
//                    drIndex = "_"
//                } else if sessionIndex == 1{
//                    drIndex = "_two_"
//                } else if sessionIndex == 2 {
//                    drIndex = "_three_"
//                }
//                param["FWFlg\(index)"] = session.FWFlg
//                param["HQCodes\(index)"] = session.HQCodes
//                param["HQNames\(index)"] = session.HQNames
//                param["WTCode\(index)"] = session.WTCode
//                param["WTName\(index)"] = session.WTName
//                param["chem\(drIndex)Code"] = session.chemCode
//                param["chem\(drIndex)Name"] = session.chemName
//                param["clusterCode\(index)"] = session.clusterCode
//                param["clusterName\(index)"] = session.clusterName
//                param["Dr\(drIndex)Code"] = session.drCode
//                param["Dr\(drIndex)Name"] = session.drName
//                param["jwCodes\(index)"] = session.jwCode
//                param["jwNames\(index)"] = session.jwName
//                param["DayRemarks\(index)"] = session.remarks
//            }
//        }
//        param["submittedTime"] = "\(Date())"
//        param["Mode"] = "Android-App"
//        param["Entry_mode"] = "Apps"
//        param["Approve_mode"] = ""
//        param["Approved_time"] = ""
//        param["app_version"] = "N 1.6.9"
//
//        let stringJSON = param.toString()
//        print(stringJSON)
//
//        return param
//    }
//
//}
//
//class MenuView : BaseView{
//    
//    
//    
//    enum CellType {
//        case edit
//        case session
//        case workType
//        case cluster
//        case headQuater
//        case jointCall
//        case listedDoctor
//        case chemist
//        case stockist
//        case unlistedDoctor
//      //  case FieldWork
//       // case others
//    }
//    
//    var menuVC :  MenuVC!
//    //MARK: Outlets
//    
//    @IBOutlet var lblAddPlan: UILabel!
//    @IBOutlet weak var sideMenuHolderView : UIView!
// 
//    @IBOutlet weak var countLbl: UILabel!
//    
//    @IBOutlet weak var menuTable : UITableView!
//
//    @IBOutlet weak var contentBgView: UIView!
//  
//    @IBOutlet weak var closeTapView: UIView!
//    
//    @IBOutlet weak var selectView: UIView!
//    
//    @IBOutlet weak var countView: UIView!
//    
//    @IBOutlet weak var selectionChevlon: UIImageView!
//    
//    @IBOutlet weak var selectTitleLbl: UILabel!
//    
//    @IBOutlet weak var saveView: UIView!
//    
//    @IBOutlet var lblCLear: UILabel!
//    
//    @IBOutlet var lblSave: UILabel!
//    
//    @IBOutlet weak var clearview: UIView!
//    @IBOutlet weak var addSessionView: UIView!
//    
//    @IBOutlet var tableHolderView: UIView!
//    
//    @IBOutlet var tableHeight: NSLayoutConstraint!
//    
//    @IBOutlet weak var selectViewHeightCons: NSLayoutConstraint!
//    
//    @IBOutlet var searchHolderView: UIView!
//    
//    @IBOutlet var searchTF: UITextField!
//    
//    @IBOutlet var searchHolderHeight: NSLayoutConstraint!
//    
//    @IBOutlet var typesTitleview: UIView!
//    
//    @IBOutlet var typesTitle: UILabel!
//    
//    @IBOutlet var typesTitleHeightConst: NSLayoutConstraint!
//    
//    @IBOutlet var selectAllView: UIView!
//    
//    @IBOutlet var selectAllIV: UIImageView!
//    
//    @IBOutlet var selectAllHeightConst: NSLayoutConstraint!
//    
//    @IBOutlet var noresultsView: UIView!
//    
//    var isSearched: Bool = false
//    var isSearchedWorkTypeSelected: Bool = false
//    ///properties to hold array elements
//    var selectedClusterIndices : [Int] = []
//    var selectedHeadQuatersIndices : [Int] = []
//    var selectedJointWorkIndices : [Int] = []
//    var selectedDoctorsIndices : [Int] = []
//    var selectedChemistIndices : [Int] = []
//    var selectedWorkTypeName : String = ""
//    var cellType : CellType = .session
//    var workTypeArr : [WorkType]?
//    var headQuatersArr : [Subordinate]?
//    var clusterArr : [Territory]?
//    var jointWorkArr : [JointWork]?
//    var listedDocArr : [DoctorFencing]?
//    var chemistArr : [Chemist]?
//    var stockistArr : [Stockist]?
//    var unlisteedDocArr : [UnListedDoctor]?
//    var sessionResponseVM: SessionResponseVM?
//    ///properties to hold session contents
//    var sessionDetailsArr = SessionDetailsArr()
//    var sessionDetail = SessionDetail()
//    let tableSetup = TableSetupModel()
//    ///properties to handle selection:
//    var selectedSession: Int = 0
//    var clusterIDArr : [String]?
//    var isToalartCell = Bool()
//    var alartcellIndex: Int = 0
//    ///Height constraint constants
//    let selectViewHeight: CGFloat = 50
//    let searchVIewHeight: CGFloat = 50
//    let typesTitleHeight: CGFloat = 35
//    ///each field height 75
//    var cellEditStackHeightforFW : CGFloat = 600
//    var cellEditHeightForFW :  CGFloat = 670 + 100
//    var cellStackHeightforFW : CGFloat = 600
//    let cellStackHeightfOthers : CGFloat = 80
//    var cellHeightForFW :  CGFloat = 670 + 100
//    let cellHeightForOthers : CGFloat = 140 + 100
//    var selectAllHeight : CGFloat = 50
//    
//    var isDocNeeded = false
//    var isJointCallneeded = false
//    var isChemistNeeded = false
//    var isSockistNeeded = false
//    var isnewCustomerNeeded = false
//    
//    override func willAppear(baseVC: BaseViewController) {
//        super.willAppear(baseVC: baseVC)
//        self.showMenu()
//    }
//    
//    
//    //MARK: - life cycle
//    override func didLoad(baseVC: BaseViewController) {
//        super.didLoad(baseVC: baseVC)
//        self.menuVC = baseVC as? MenuVC
//        self.initView()
//        self.initGestures()
//        self.ThemeUpdate()
//        setTheme()
//    }
//    
//    func setTheme() {
//        searchTF.textColor = .appTextColor
//        
//      //  [, countLbl, selectTitleLbl, typesTitle]
//        
//        
//        countLbl.textColor = .systemGreen
//        countLbl.setFont(font: .medium(size: .BODY))
//        
//        selectTitleLbl.textColor = .appTextColor
//        selectTitleLbl.setFont(font: .medium(size: .BODY))
//        
//        lblAddPlan.textColor = .appTextColor
//        lblAddPlan.setFont(font: .bold(size: .SUBHEADER))
//        
//        typesTitle.textColor = .appLightTextColor
//        typesTitle.setFont(font: .medium(size: .SMALL))
//        
//       let bottomLbl = [lblAddPlan, lblCLear, lblSave]
//        bottomLbl.forEach { label in
//            
//            label?.textColor =  label == lblSave ? .appWhiteColor :  .appTextColor
//            label?.setFont(font: .bold(size: .BODY))
//        }
//    }
//    
//    //MARK: - function to initialize view
//    func initView(){
//        self.sessionResponseVM = SessionResponseVM()
//        toConfigureTableSetup()
//        searchTF.delegate = self
//        cellRegistration()
//        loadrequiredDataFromDB()
//
//        
//        self.selectTitleLbl.text = "Select"
//        self.countView.isHidden = true
//        self.menuTable.delegate = self
//        self.menuTable.dataSource = self
//  
//       
//        self.selectView.layer.borderWidth = 1
//        self.selectView.layer.borderColor = UIColor.gray.cgColor
//        self.selectView.layer.cornerRadius = 5
//        
//        addSessionView.layer.cornerRadius = 5
//        addSessionView.layer.borderWidth = 1
//        addSessionView.layer.borderColor = UIColor.systemGreen.cgColor
//        addSessionView.elevate(2)
//        
//        saveView.elevate(2)
//        saveView.layer.cornerRadius = 5
//        
//        clearview.elevate(2)
//        clearview.layer.borderColor = UIColor.gray.cgColor
//        clearview.layer.borderWidth = 1
//        clearview.layer.cornerRadius = 5
//        countView.elevate(2)
//        countView.layer.borderColor = UIColor.systemGreen.cgColor
//        countView.layer.borderWidth = 1
//        countView.layer.cornerRadius = 5
//        
//        
//        
//        searchHolderView.elevate(2)
//        searchHolderView.layer.borderColor = UIColor.lightGray.cgColor
//        searchHolderView.layer.borderWidth = 0.5
//        searchHolderView.layer.cornerRadius = 5
//        
//      //  self.menuTable.layoutIfNeeded()
//      //  NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: Notification.Name("hideMenu"), object: nil)
//    }
//
//    func toConfigureTableSetup() {
//        if tableSetup.DrNeed == "0" {
//            self.isDocNeeded = true
//        } else {
//            self.isDocNeeded = false
//            cellStackHeightforFW =  cellStackHeightforFW - 75
//            cellHeightForFW =  cellHeightForFW - 75
//        }
//        
//        
//        if  tableSetup.ChmNeed == "0" {
//            self.isChemistNeeded = true
//        } else {
//            self.isChemistNeeded = false
//            cellStackHeightforFW =  cellStackHeightforFW - 75
//            cellHeightForFW =  cellHeightForFW - 75
//        }
// 
//        if   tableSetup.JWNeed == "0" {
//            self.isJointCallneeded = true
//        } else {
//            self.isJointCallneeded = false
//            cellStackHeightforFW =  cellStackHeightforFW - 75
//            cellHeightForFW =  cellHeightForFW - 75
//        }
//        
//        if tableSetup.StkNeed == "0" {
//            self.isSockistNeeded = true
//        } else {
//            self.isSockistNeeded = false
//            cellStackHeightforFW =  cellStackHeightforFW - 75
//            cellHeightForFW =  cellHeightForFW - 75
//        }
//        
//        if tableSetup.Cip_Need == "0" {
//            self.isnewCustomerNeeded = true
//        } else {
//            self.isnewCustomerNeeded = false
//            cellStackHeightforFW =  cellStackHeightforFW - 75
//            cellHeightForFW =  cellHeightForFW - 75
//        }
//    }
//    
//    func loadrequiredDataFromDB() {
//        
//        self.workTypeArr = DBManager.shared.getWorkType()
//      
//        self.headQuatersArr =  DBManager.shared.getSubordinate()
//     
//        self.clusterArr = DBManager.shared.getTerritory()
//     
//        self.jointWorkArr = DBManager.shared.getJointWork()
//      
//        self.listedDocArr = DBManager.shared.getDoctor()
//       
//        self.chemistArr = DBManager.shared.getChemist()
//         
//        self.stockistArr =  DBManager.shared.getStockist()
//        
//        self.unlisteedDocArr = DBManager.shared.getUnListedDoctor()
//        
//        toGenerateNewSession(self.menuVC.sessionDetailsArr != nil ? false : true)
////isToAddSession: self.menuVC.sessionDetailsArr != nil ? false : true
//    }
//    
//    func toGenerateNewSession(_ istoAddSession: Bool) {
//        
////        sessionDetail = SessionDetail()
////        sessionDetail.workType = workTypeArr?.uniqued()
////        sessionDetail.headQuates =  headQuatersArr?.uniqued()
////        sessionDetail.cluster = clusterArr?.uniqued()
////        sessionDetail.jointWork = jointWorkArr?.uniqued()
////        sessionDetail.listedDoctors = listedDocArr?.uniqued()
////        sessionDetail.chemist = chemistArr?.uniqued()
////        self.sessionDetailsArr.sessionDetails?.append(sessionDetail)
////        setPageType(.session)
//        
//
//        sessionDetail.workType = workTypeArr?.uniqued()
//        sessionDetail.headQuates =  headQuatersArr?.uniqued()
//        sessionDetail.cluster = clusterArr?.uniqued()
//        sessionDetail.jointWork = jointWorkArr?.uniqued()
//        sessionDetail.listedDoctors = listedDocArr?.uniqued()
//        sessionDetail.chemist = chemistArr?.uniqued()
//        sessionDetail.stockist = stockistArr?.uniqued()
//        sessionDetail.unlistedDoctors = unlisteedDocArr?.uniqued()
//        if self.menuVC.sessionDetailsArr != nil  {
//            self.menuVC.sessionDetailsArr?.sessionDetails?.forEach({ eachsessiondetail in
//                eachsessiondetail.workType = workTypeArr?.uniqued()
//                eachsessiondetail.headQuates =  headQuatersArr?.uniqued()
//                eachsessiondetail.cluster = clusterArr?.uniqued()
//                eachsessiondetail.jointWork = jointWorkArr?.uniqued()
//                eachsessiondetail.listedDoctors = listedDocArr?.uniqued()
//                eachsessiondetail.chemist = chemistArr?.uniqued()
//                eachsessiondetail.stockist = stockistArr?.uniqued()
//                eachsessiondetail.unlistedDoctors = unlisteedDocArr?.uniqued()
//                
//            })
//            self.sessionDetailsArr = self.menuVC.sessionDetailsArr ?? SessionDetailsArr()
//            lblAddPlan.text = self.menuVC.sessionDetailsArr?.date ?? ""
//            if  istoAddSession {
//                self.sessionDetailsArr.sessionDetails?.append(sessionDetail)
//                setPageType(.session, for: (self.sessionDetailsArr.sessionDetails?.count ?? 0) - 1)
//                self.selectedSession =  self.sessionDetailsArr.sessionDetails?.count ?? 0 - 1
//            } else {
//                setPageType(.edit)
//            }
//          
//        } else {
//            sessionDetail = SessionDetail()
//            self.sessionDetailsArr.sessionDetails?.append(sessionDetail)
//            setPageType(.session, for: self.sessionDetailsArr.sessionDetails?.count ?? 0 - 1)
//            self.selectedSession =  self.sessionDetailsArr.sessionDetails?.count ?? 0 - 1
//        }
//    }
//    
//    
//    func toRemoveSession(at index: Int) {
//        if isForEdit()  {
//            self.menuVC.sessionDetailsArr?.sessionDetails?.remove(at: index)
//        } else {
//            self.sessionDetailsArr.sessionDetails?.remove(at: index)
//        }
//        self.selectedSession = 0
//        setPageType(self.cellType)
//      
//    }
//    
//    
//    func isForEdit() -> Bool {
//        if self.menuVC.sessionDetailsArr != nil  {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    @objc func hideMenu() {
//        self.hideMenuAndDismiss()
//    }
//    
//    func ThemeUpdate() {
//
//    }
//    
//    
//    func cellRegistration() {
//        
//        menuTable.register(UINib(nibName: "SessionInfoTVC", bundle: nil), forCellReuseIdentifier: "SessionInfoTVC")
//        
//        menuTable.register(UINib(nibName: "SelectAllTypesTVC", bundle: nil), forCellReuseIdentifier: "SelectAllTypesTVC")
//        
//        menuTable.register(UINib(nibName: "EditSessionTVC", bundle: nil), forCellReuseIdentifier: "EditSessionTVC")
//        
//    }
//    
////    override func didLayoutSubviews(baseVC: BaseViewController) {
////        super.didLayoutSubviews(baseVC: baseVC)
////        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
////            if self.menuTable.contentSize.height + 10 >=  self.height - self.height * 0.07 * 0.1  + 35 - 10 {
////                self.tableHeight.constant = self.height - self.height * 0.07 + 35 * 0.1
////            } else {
////                self.tableHeight.constant = self.menuTable.contentSize.height + 10
////            }
////        }
////    }
//    
//    func setPageType(_ pagetype: CellType, for session: Int? = nil, andfor sessions: [Int]? = nil) {
//        switch pagetype {
//            
//        case .edit:
//            self.cellType = .edit
//            addSessionView.isHidden = true
//            self.lblSave.text = "Edit"
//            saveView.isHidden = false
//            clearview.isHidden = true
//            self.selectViewHeightCons.constant = 0
//            self.searchHolderHeight.constant = 0
//            typesTitleHeightConst.constant = 0
//            self.selectView.isHidden = true
//            searchHolderView.isHidden = true
//            typesTitleview.isHidden = true
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            typesTitle.text = ""
//            self.menuTable.separatorStyle = .none
//            if isForEdit()  {
//                if self.menuVC.sessionDetailsArr?.sessionDetails?.count == 0 {
//                     
//                } else {
//                    self.menuVC.sessionDetailsArr?.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//                }
//                
//              //  self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//            } else {
//                if self.sessionDetailsArr.sessionDetails?.count == 0 {
//                     
//                } else {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//                }
//            }
//          
//            
//        case .session:
//            self.cellType = .session
//            addSessionView.isHidden = false
//            saveView.isHidden = false
//            self.lblSave.text = "Save"
//            clearview.isHidden = true
//            self.selectViewHeightCons.constant = 0
//            self.searchHolderHeight.constant = 0
//            typesTitleHeightConst.constant = 0
//            self.selectView.isHidden = true
//            searchHolderView.isHidden = true
//            typesTitleview.isHidden = true
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            typesTitle.text = ""
//            self.menuTable.separatorStyle = .none
//           if self.menuVC.sessionDetailsArr == nil {
//               let dateFormatter = DateFormatter()
//               dateFormatter.dateFormat = "d MMMM yyyy"
//               typesTitle.text = dateFormatter.string(from: self.menuVC.selectedDate ?? Date())
//               typesTitleview.isHidden = false
//               typesTitleHeightConst.constant = typesTitleHeight
//           }
//            
//            if isForEdit()  {
//               if self.menuVC.sessionDetailsArr?.sessionDetails?.count == 0 {
//                    
//               } else {
//                   let count = self.menuVC.sessionDetailsArr?.sessionDetails?.count ?? 0
//                   if count <= selectedSession {
//                     
//                   } else {
//                       self.menuVC.sessionDetailsArr?.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//                   }
//                
//               }
//               
//              //  self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//            } else {
//                if self.sessionDetailsArr.sessionDetails?.count == 0 {
//                     
//                } else {
//                    let count = self.sessionDetailsArr.sessionDetails?.count ?? 0
//                    if count <= selectedSession {
//                     
//                    } else {
//                        self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//                    }
//                    
//                }
//            }
//           
//      
//            
//        case .workType:
//            self.cellType = .workType
//            addSessionView.isHidden = true
//            saveView.isHidden = true
//            clearview.isHidden = true
//            self.selectViewHeightCons.constant = selectViewHeight
//            self.searchHolderHeight.constant =   searchVIewHeight
//            typesTitleHeightConst.constant = typesTitleHeight
//            typesTitleview.isHidden = false
//            self.selectView.isHidden = false
//            self.countView.isHidden = true
//            self.selectView.isHidden = false
//            searchHolderView.isHidden = false
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            typesTitle.text = "Work Type"
//            self.menuTable.separatorStyle = .singleLine
//            if isForEdit()  {
//                if self.menuVC.sessionDetailsArr?.sessionDetails?.count == 0 {
//                     
//                } else {
//                    self.menuVC.sessionDetailsArr?.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//                }
//              //  self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//            } else {
//                if self.sessionDetailsArr.sessionDetails?.count == 0 {
//                     
//                } else {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//                }
//            }
//            
//        
//        case .cluster:
//            self.cellType = .cluster
//            addSessionView.isHidden = true
//            saveView.isHidden = false
//            clearview.isHidden = false
//            self.countView.isHidden = false
//            self.selectViewHeightCons.constant =   selectViewHeight
//            self.searchHolderHeight.constant = searchVIewHeight
//            typesTitleHeightConst.constant = typesTitleHeight
//            typesTitle.text = "Cluster"
//            typesTitleview.isHidden = false
//            self.selectView.isHidden = false
//            searchHolderView.isHidden = false
//            self.countView.isHidden = true
////            selectAllView.isHidden = false
////            selectAllHeightConst.constant = selectAllHeight
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            self.menuTable.separatorStyle = .singleLine
//            self.sessionDetailsArr.sessionDetails?[self.selectedSession].cluster = self.clusterArr
//        
//        case .headQuater:
//            self.cellType = .headQuater
//            addSessionView.isHidden = true
//            saveView.isHidden = false
//            clearview.isHidden = false
//            self.countView.isHidden = false
//            self.selectViewHeightCons.constant =   selectViewHeight
//            self.searchHolderHeight.constant =  searchVIewHeight
//            typesTitleHeightConst.constant = typesTitleHeight
//            typesTitle.text = "Head Quarters"
//            typesTitleview.isHidden = false
//            searchHolderView.isHidden = false
//            self.selectView.isHidden = false
//            self.countView.isHidden = true
////            selectAllView.isHidden = false
////            selectAllHeightConst.constant = selectAllHeight
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            self.menuTable.separatorStyle = .singleLine
//            self.sessionDetailsArr.sessionDetails?[self.selectedSession].headQuates = self.headQuatersArr
//       
//        case .jointCall:
//            self.cellType = .jointCall
//            addSessionView.isHidden = true
//            saveView.isHidden = false
//            clearview.isHidden = false
//            self.countView.isHidden = false
//            self.selectViewHeightCons.constant =  selectViewHeight
//            self.searchHolderHeight.constant = searchVIewHeight
//            typesTitleHeightConst.constant = typesTitleHeight
//            typesTitle.text = "Joint Call"
//            typesTitleview.isHidden = false
//            searchHolderView.isHidden = false
//            self.selectView.isHidden = false
//            self.countView.isHidden = true
////            selectAllView.isHidden = false
////            selectAllHeightConst.constant = selectAllHeight
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            self.menuTable.separatorStyle = .singleLine
//            self.sessionDetailsArr.sessionDetails?[self.selectedSession].jointWork = self.jointWorkArr
//     
//        case .listedDoctor:
//            self.cellType = .listedDoctor
//            addSessionView.isHidden = true
//            saveView.isHidden = false
//            clearview.isHidden = false
//            self.countView.isHidden = false
//            self.selectViewHeightCons.constant =  selectViewHeight
//            self.searchHolderHeight.constant = searchVIewHeight
//            typesTitleHeightConst.constant = typesTitleHeight
//            typesTitle.text = "Listed doctor"
//            typesTitleview.isHidden = false
//            searchHolderView.isHidden = false
//            self.selectView.isHidden = false
//            self.countView.isHidden = true
////            selectAllView.isHidden = false
////            selectAllHeightConst.constant = selectAllHeight
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            self.menuTable.separatorStyle = .singleLine
//            self.sessionDetailsArr.sessionDetails?[self.selectedSession].listedDoctors = self.listedDocArr
//        
//        case .chemist:
//            self.cellType = .chemist
//            addSessionView.isHidden = true
//            saveView.isHidden = false
//            clearview.isHidden = false
//            self.countView.isHidden = false
//            self.selectViewHeightCons.constant = selectViewHeight
//            self.searchHolderHeight.constant = searchVIewHeight
//            typesTitleHeightConst.constant = typesTitleHeight
//            typesTitle.text = "Chemist"
//            searchHolderView.isHidden = false
//            self.selectView.isHidden = false
//            self.countView.isHidden = true
//           // selectAllView.isHidden = false
//            //selectAllHeightConst.constant = selectAllHeight
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            typesTitleview.isHidden = false
//            
//            self.menuTable.separatorStyle = .singleLine
//            self.sessionDetailsArr.sessionDetails?[self.selectedSession].chemist = self.chemistArr
//        case .stockist:
//            self.cellType = .stockist
//            addSessionView.isHidden = true
//            saveView.isHidden = false
//            clearview.isHidden = false
//            self.countView.isHidden = false
//            self.selectViewHeightCons.constant = selectViewHeight
//            self.searchHolderHeight.constant = searchVIewHeight
//            typesTitleHeightConst.constant = typesTitleHeight
//            typesTitle.text = "Stockist"
//            searchHolderView.isHidden = false
//            self.selectView.isHidden = false
//            self.countView.isHidden = true
//           // selectAllView.isHidden = false
//            //selectAllHeightConst.constant = selectAllHeight
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            typesTitleview.isHidden = false
//            
//            self.menuTable.separatorStyle = .singleLine
//            self.sessionDetailsArr.sessionDetails?[self.selectedSession].stockist = self.stockistArr
//        case .unlistedDoctor:
//            self.cellType = .unlistedDoctor
//            addSessionView.isHidden = true
//            saveView.isHidden = false
//            clearview.isHidden = false
//            self.countView.isHidden = false
//            self.selectViewHeightCons.constant = selectViewHeight
//            self.searchHolderHeight.constant = searchVIewHeight
//            typesTitleHeightConst.constant = typesTitleHeight
//            typesTitle.text = "New customers"
//            searchHolderView.isHidden = false
//            self.selectView.isHidden = false
//            self.countView.isHidden = true
//           // selectAllView.isHidden = false
//            //selectAllHeightConst.constant = selectAllHeight
//            selectAllView.isHidden = true
//            selectAllHeightConst.constant = 0
//            typesTitleview.isHidden = false
//            
//            self.menuTable.separatorStyle = .singleLine
//            self.sessionDetailsArr.sessionDetails?[self.selectedSession].unlistedDoctors = self.unlisteedDocArr
//        }
//        
//        
//   
//        self.menuTable.isHidden = false
//        self.searchTF.text = ""
//        self.searchTF.placeholder = "Search"
//        self.noresultsView.isHidden = true
//        self.menuTable.reloadData()
//        var targetRowIndexPath = IndexPath()
//        
//        if sessions == nil {
//            lookupForSession()
//        } else if sessions != nil {
//            let sessionIndex = sessions?.count ?? 0 > 1 ? sessions?.first ?? 0 :  sessions?.last ?? 0
//            self.alartcellIndex = sessionIndex
//            targetRowIndexPath =  IndexPath(row: sessionIndex, section: 0)
//        } else {
//            lookupForSession()
//        }
//        
//        func lookupForSession() {
//            if session == nil {
//                targetRowIndexPath =   IndexPath(row: 0, section: 0)
//            } else {
//                targetRowIndexPath =  IndexPath(row: session ?? 0, section: 0)
//            }
//        }
//
//        if menuTable.indexPathExists(indexPath: targetRowIndexPath)
//        {
//            menuTable.scrollToRow(at: targetRowIndexPath, at: .top, animated: false)
//        }
//       
//    }
//    
//    
//    @IBAction func didTapCloseBtn(_ sender: Any) {
//        
//        hideMenuAndDismiss()
//    }
//    
//
//    
//    func initGestures(){
//        closeTapView.addTap {
//            self.hideMenuAndDismiss()
//        }
//        
//        saveView.addTap { [self] in
//            self.endEditing(true)
//            self.isSearched = false
//            switch self.cellType {
//            case .edit:
//              //  self.menuTable.reloadData()
//              //  self.toGetTourPlanResponse()
//                self.sessionDetailsArr.changeStatus = "True"
//                self.setPageType(.session)
//            case .session:
//               // self.menuTable.reloadData()
//                self.toGetTourPlanResponse()
//            case .workType:
//                if sessionDetailsArr.sessionDetails![selectedSession].isForFieldWork {
//                    setPageType(.session, for: self.selectedSession)
//                } else {
//                    setPageType(.session, for: self.selectedSession)
//                }
//            case .cluster:
//                setPageType(.session, for: self.selectedSession)
//              
//            case .headQuater:
//                setPageType(.session, for: self.selectedSession)
//               
//            case .jointCall:
//                setPageType(.session, for: self.selectedSession)
//               
//            case .listedDoctor:
//               
//                setPageType(.session, for: self.selectedSession)
//                
//            case .chemist:
//                setPageType(.session, for: self.selectedSession)
//
//          
//            case .stockist:
//                setPageType(.session, for: self.selectedSession)
//            case .unlistedDoctor:
//                setPageType(.session, for: self.selectedSession)
//            }
//        }
//        
//        selectView.addTap { [self] in
//            self.endEditing(true)
//            self.isSearched = false
//            switch self.cellType {
//            case .edit:
//                break
//            case .session:
//                break
//            case .workType:
//                if sessionDetailsArr.sessionDetails![selectedSession].isForFieldWork {
//                    setPageType(.session, for: self.selectedSession)
//                } else {
//                    setPageType(.session, for: self.selectedSession)
//                }
//            case .cluster:
//                setPageType(.session, for: self.selectedSession)
//            case .headQuater:
//                setPageType(.session, for: self.selectedSession)
//            case .jointCall:
//                setPageType(.session, for: self.selectedSession)
//            case .listedDoctor:
//                setPageType(.session, for: self.selectedSession)
//            case .chemist:
//                setPageType(.session, for: self.selectedSession)
//            case .stockist:
//                setPageType(.session, for: self.selectedSession)
//            case .unlistedDoctor:
//                setPageType(.session, for: self.selectedSession)
//            }
//           
//        }
//        
//        addSessionView.addTap {
//            let count = self.sessionDetailsArr.sessionDetails?.count
//            if  count ?? 0 > 1 {
//                if #available(iOS 13.0, *) {
//                    (UIApplication.shared.delegate as! AppDelegate).createToastMessage("Maximum plans added", isFromWishList: true)
//                } else {
//                  print("Maximum plan added")
//                }
//            } else {
//                
//                let sessionArr = self.toCheckSessionInfo()
//                
//                if sessionArr.isEmpty {
//                    self.toGenerateNewSession(true)
//                    self.isToalartCell = false
//                } else {
//                    self.toAlertCell()
//                }
//                
//                //isToAddSession: true
//                
//            }
//        }
//        
//        
//    
//         
//        clearview.addTap { [self] in
//            switch self.cellType {
//                
//            case .session:
//                break
//            case .workType:
//                break
//            case .cluster:
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID?.removeAll()
//              
//            case .headQuater:
//              //  sessionDetailsArr.sessionDetails?[selectedSession].selectedHeadQuaterID.removeAll()
//                break
//                
//            case .jointCall:
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID?.removeAll()
//             
//            case .listedDoctor:
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID?.removeAll()
//               
//            case .chemist:
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID?.removeAll()
//             
//            case .edit:
//                break
//            case .stockist:
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID?.removeAll()
//            case .unlistedDoctor:
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID?.removeAll()
//            }
//            self.menuTable.reloadData()
//        }
//        
//        
//        selectAllView.addTap { [self] in
//            self.endEditing(true)
//            
//            self.selectAllIV.image =  self.selectAllIV.image ==  UIImage(named: "checkBoxEmpty") ? UIImage(named: "checkBoxSelected") : UIImage(named: "checkBoxEmpty")
//            switch self.cellType {
//              
//            case .session:
//                break
//            case .workType:
//                break
//            case .cluster:
//                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
//                 
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].cluster?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID?[cluster.code ?? ""] = true
//                     
//                        
//              
//                    })
//                } else {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].cluster?.enumerated().forEach({ (index, cluster) in
//                   
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID?.removeValue(forKey: cluster.code ?? "")
//                    })
//                  
//                    
//          
//                }
//      
//                
//            case .headQuater:
////                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
////
////                } else {
////
////                }
////                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
////
////                    self.sessionDetailsArr.sessionDetails?[selectedSession].headQuates?.enumerated().forEach({ index, cluster in
////                        sessionDetailsArr.sessionDetails?[selectedSession].selectedHeadQuaterID[cluster.id ?? ""] = true
////
////                    })
////                } else {
////                    self.sessionDetailsArr.sessionDetails?[selectedSession].headQuates?.enumerated().forEach({ (index, cluster) in
////                        sessionDetailsArr.sessionDetails?[selectedSession].selectedHeadQuaterID.removeValue(forKey: cluster.id ?? "")
////                    })
////
////                }
//                break
//            case .jointCall:
//                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
//                  
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].jointWork?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID?[cluster.code ?? ""] = true
//                    
//                    })
//                } else {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].jointWork?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID?.removeValue(forKey: cluster.code ?? "")
//                    })
//                   
//                }
//            case .listedDoctor:
//                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
//                   // sessionDetailsArr.sessionDetails?[selectedSession].selectedDoctorsIndices.removeAll()
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].listedDoctors?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID?[cluster.code ?? ""] = true
//                      //  sessionDetailsArr.sessionDetails?[selectedSession].selectedDoctorsIndices.append(index)
//                    })
//                } else {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].listedDoctors?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID?.removeValue(forKey: cluster.code ?? "")
//                    })
//                
//                }
//            case .chemist:
//                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].chemist?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID?[cluster.code ?? ""] = true
//                    })
//                } else {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].chemist?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID?.removeValue(forKey: cluster.code ?? "")
//                    })
//                }
//            case .edit:
//                break
//            case .stockist:
//                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].stockist?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID?[cluster.code ?? ""] = true
//                    })
//                } else {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].stockist?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID?.removeValue(forKey: cluster.code ?? "")
//                    })
//                }
//            case .unlistedDoctor:
//                if  self.selectAllIV.image ==  UIImage(named: "checkBoxSelected") {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].unlistedDoctors?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID?[cluster.code ?? ""] = true
//                    })
//                } else {
//                    self.sessionDetailsArr.sessionDetails?[selectedSession].unlistedDoctors?.enumerated().forEach({ (index, cluster) in
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID?.removeValue(forKey: cluster.code ?? "")
//                    })
//                }
//            }
//            self.menuTable.reloadData()
//        }
//        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleMenuPan(_:)))
//        self.sideMenuHolderView.addGestureRecognizer(panGesture)
//        self.sideMenuHolderView.isUserInteractionEnabled = true
//    }
//    
//    func toAlertCell(_ index: [Int]? = nil) {
//        isToalartCell = true
//        setPageType(.session, andfor: index)
//    }
//    
//    func toSetSelectAllImage(selectedIndexCount : Int) {
//        var isToSelectAll: Bool = false
//        switch self.cellType {
//        case .session:
//            break
//        case .workType:
//            break
//        case .cluster:
//            
//            if isSearched {
//                if selectedIndexCount == sessionDetailsArr.sessionDetails?[selectedSession].cluster?.count ?? 0 {
//                    isToSelectAll = true
//                } else {
//                    isToSelectAll = false
//                }
//            } else {
//                if selectedIndexCount == self.clusterArr?.count ?? 0 {
//                    isToSelectAll = true
//                } else {
//                    isToSelectAll = false
//                }
//            }
//            
// 
//        case .headQuater:
//            if selectedIndexCount == sessionDetailsArr.sessionDetails?[selectedSession].headQuates?.count ?? 0 {
//                isToSelectAll = true
//            } else {
//                isToSelectAll = false
//            }
//        case .jointCall:
//            if selectedIndexCount == sessionDetailsArr.sessionDetails?[selectedSession].jointWork?.count ?? 0 {
//                isToSelectAll = true
//            } else {
//                isToSelectAll = false
//            }
//        case .listedDoctor:
//            if selectedIndexCount == sessionDetailsArr.sessionDetails?[selectedSession].listedDoctors?.count ?? 0 {
//                isToSelectAll = true
//            } else {
//                isToSelectAll = false
//            }
//        case .chemist:
//            if selectedIndexCount == sessionDetailsArr.sessionDetails?[selectedSession].chemist?.count ?? 0 {
//                isToSelectAll = true
//            } else {
//                isToSelectAll = false
//            }
//        case .edit:
//            break
//        case .stockist:
//            if selectedIndexCount == sessionDetailsArr.sessionDetails?[selectedSession].stockist?.count ?? 0 {
//                isToSelectAll = true
//            } else {
//                isToSelectAll = false
//            }
//        case .unlistedDoctor:
//            if selectedIndexCount == sessionDetailsArr.sessionDetails?[selectedSession].unlistedDoctors?.count ?? 0 {
//                isToSelectAll = true
//            } else {
//                isToSelectAll = false
//            }
//        }
//        if isToSelectAll {
//            self.selectAllIV.image =  UIImage(named: "checkBoxSelected")
//        } else {
//            self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//        }
//    }
//
//    //MARK: UDF, gestures  and animations
//    
//    private var animationDuration : Double = 1.0
//    private let aniamteionWaitTime : TimeInterval = 0.15
//    private let animationVelocity : CGFloat = 5.0
//    private let animationDampning : CGFloat = 2.0
//    private let viewOpacity : CGFloat = 0.3
//    
//    func showMenu(){
//       // let isRTL = isRTLLanguage
//        let _ : CGFloat =  -1
//        //isRTL ? 1 :
//        let width = self.frame.width
//        self.sideMenuHolderView.transform =  CGAffineTransform(translationX: width,y: 1)
//        //isRTL ? CGAffineTransform(translationX: 1 * width,y: 0)  :
//        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
//        while animationDuration > 1.6{
//            animationDuration = animationDuration * 0.1
//        }
//        UIView.animate(withDuration: animationDuration,
//                       delay: aniamteionWaitTime,
//                       usingSpringWithDamping: animationDampning,
//                       initialSpringVelocity: animationVelocity,
//                       options: [.curveEaseOut,.allowUserInteraction],
//                       animations: {
//                        self.sideMenuHolderView.transform = .identity
//                        self.backgroundColor = UIColor.black.withAlphaComponent(self.viewOpacity)
//                       }, completion: nil)
//    }
//
//    func hideMenuAndDismiss(){
//       
//        let rtlValue : CGFloat = 1
//      //  isRTL ? 1 :
//        let width = self.frame.width
//        while animationDuration > 1.6{
//            animationDuration = animationDuration * 0.1
//        }
//        UIView.animate(withDuration: animationDuration,
//                       delay: aniamteionWaitTime,
//                       usingSpringWithDamping: animationDampning,
//                       initialSpringVelocity: animationVelocity,
//                       options: [.curveEaseOut,.allowUserInteraction],
//                       animations: {
//                        self.sideMenuHolderView.transform = CGAffineTransform(translationX: width * rtlValue,
//                                                                              y: 0)
//                        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
//                       }) { (val) in
//            
//                           self.menuVC.dismiss(animated: true, completion: nil)
//        }
//        
//        
//    }
//    @objc func handleMenuPan(_ gesture : UIPanGestureRecognizer){
//      
//        let _ : CGFloat =   -1
//        //isRTL ? 1 :
//        let translation = gesture.translation(in: self.sideMenuHolderView)
//        let xMovement = translation.x
//        //        guard abs(xMovement) < self.view.frame.width/2 else{return}
//        var opacity = viewOpacity * (abs(xMovement * 2)/(self.frame.width))
//        opacity = (1 - opacity) - (self.viewOpacity * 2)
//        print("~opcaity : ",opacity)
//        switch gesture.state {
//        case .began,.changed:
//            guard  ( xMovement > 0)  else {return}
//          //  ||  (xMovement < 0)
//           // isRTL && || !isRTL &&
//            
//            self.sideMenuHolderView.transform = CGAffineTransform(translationX: xMovement, y: 0)
//            self.backgroundColor = UIColor.black.withAlphaComponent(opacity)
//        default:
//            let velocity = gesture.velocity(in: self.sideMenuHolderView).x
//            self.animationDuration = Double(velocity)
//            if abs(xMovement) <= self.frame.width * 0.25{//show
//                self.sideMenuHolderView.transform = .identity
//                self.backgroundColor = UIColor.black.withAlphaComponent(self.viewOpacity)
//            }else{//hide
//                self.hideMenuAndDismiss()
//            }
//            
//        }
//    }
//    
//    
//
//}
//extension MenuView : UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch self.cellType {
//        case .edit:
//            return sessionDetailsArr.sessionDetails?.count ?? 0
//            
//        case .session:
//            return sessionDetailsArr.sessionDetails?.count ?? 0
//        
//        case .workType:
//            return sessionDetailsArr.sessionDetails?[selectedSession].workType?.count ?? 0
//           
//        case .cluster:
//            return sessionDetailsArr.sessionDetails?[selectedSession].cluster?.count ?? 0
//         
//        case .headQuater:
//            return sessionDetailsArr.sessionDetails?[selectedSession].headQuates?.count ?? 0
//          
//        case .jointCall:
//            return sessionDetailsArr.sessionDetails?[selectedSession].jointWork?.count ?? 0
//           
//        case .listedDoctor:
//            return sessionDetailsArr.sessionDetails?[selectedSession].listedDoctors?.count ?? 0
//          
//        case .chemist:
//            return sessionDetailsArr.sessionDetails?[selectedSession].chemist?.count ?? 0
//
//        case .stockist:
//            return sessionDetailsArr.sessionDetails?[selectedSession].stockist?.count ?? 0
//        case .unlistedDoctor:
//            return sessionDetailsArr.sessionDetails?[selectedSession].unlistedDoctors?.count ?? 0
//        }
//       
//     
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        switch self.cellType {
//            
//        case .edit:
//            let cell : EditSessionTVC = tableView.dequeueReusableCell(withIdentifier:"EditSessionTVC" ) as! EditSessionTVC
//            cell.selectionStyle = .none
//
//            cell.lblName.text = "Plan \(indexPath.row + 1)"
//           
//            sessionDetailsArr.sessionDetails?[indexPath.row].sessionName = cell.lblName.text ?? ""
//            
//            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex
//            let searchedWorkTypeIndex = sessionDetailsArr.sessionDetails?[indexPath.row].searchedWorkTypeIndex
//            
//            let selectedHQIndex = sessionDetailsArr.sessionDetails?[indexPath.row].selectedHQIndex
//            let searchedHQIndex = sessionDetailsArr.sessionDetails?[indexPath.row].searchedHQIndex
//            
//            let isForFieldWork = sessionDetailsArr.sessionDetails?[indexPath.row].isForFieldWork
//            let modal = sessionDetailsArr.sessionDetails![indexPath.row]
//            if  isForFieldWork ?? false  {
//                
//               
//                // cellStackHeightforFW
//                let cellViewArr : [UIView] = [cell.workTypeView, cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.stockistView, cell.unlistedDocView]
//                
//                cellViewArr.forEach { view in
//                    switch view {
//                        
//                    case cell.jointCallView:
//                        if !(modal.selectedjointWorkID?.isEmpty ?? true) {
//                            view.isHidden = false
//                        } else {
//                            cellEditStackHeightforFW =  cellEditStackHeightforFW - 75
//                            cellEditHeightForFW =  cellEditHeightForFW - 75
//                            view.isHidden = true
//                        }
//                        
//                    case cell.listedDoctorView:
//                        if !(modal.selectedlistedDoctorsID?.isEmpty ?? true)  {
//                            view.isHidden = false
//                        } else {
//                            cellEditStackHeightforFW =  cellEditStackHeightforFW - 75
//                            cellEditHeightForFW =  cellEditHeightForFW - 75
//                            view.isHidden = true
//                        }
//            
//                    case cell.chemistView:
//                        if !(modal.selectedchemistID?.isEmpty ?? true) {
//                            view.isHidden = false
//                        } else {
//                            cellEditStackHeightforFW =  cellEditStackHeightforFW - 75
//                            cellEditHeightForFW =  cellEditHeightForFW - 75
//                            view.isHidden = true
//                        }
//                        
//                    case cell.stockistView:
//                        if !(modal.selectedStockistID?.isEmpty ?? true) {
//                            view.isHidden = false
//                        } else {
//                            cellEditStackHeightforFW =  cellEditStackHeightforFW - 75
//                            cellEditHeightForFW =  cellEditHeightForFW - 75
//                            view.isHidden = true
//                        }
//                        
//                    case cell.unlistedDocView:
//                        if !(modal.selectedUnlistedDoctorsID?.isEmpty ?? true)  {
//                            view.isHidden = false
//                        } else {
//                            cellEditStackHeightforFW =  cellEditStackHeightforFW - 75
//                            cellEditHeightForFW =  cellEditHeightForFW - 75
//                            view.isHidden = true
//                        }
//                        
//                    default:
//                        view.isHidden = false
//                    }
//                }
//                cell.stackHeight.constant =  cellEditStackHeightforFW
//            }  else {
//                cell.stackHeight.constant = cellStackHeightfOthers
//                [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.stockistView, cell.unlistedDocView].forEach { view in
//                    view?.isHidden = true
//                    // cell.workselectionHolder,
//                }
//                
//            }
//            if isSearched {
//                if sessionDetailsArr.sessionDetails?[indexPath.row].searchedWorkTypeIndex != nil {
//                    cell.lblWorkType.text = sessionDetailsArr.sessionDetails?[indexPath.row].workType?[searchedWorkTypeIndex ?? 0].name
//                } else {
//                    cell.lblWorkType.text = "No info available"
//                }
//                
//                if sessionDetailsArr.sessionDetails?[indexPath.row].searchedHQIndex != nil {
//                    cell.lblHeadquaters.text = sessionDetailsArr.sessionDetails?[indexPath.row].headQuates?[searchedHQIndex ?? 0].name
//                } else {
//                    cell.lblHeadquaters.text = "No info available"
//                }
//                
//                
//            } else {
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil {
//                    cell.lblWorkType.text = sessionDetailsArr.sessionDetails?[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
//                } else {
//                    cell.lblWorkType.text = "No info available"
//                }
//                
//                
//                
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedHQIndex != nil {
//                    cell.lblHeadquaters.text = sessionDetailsArr.sessionDetails?[indexPath.row].headQuates?[selectedHQIndex ?? 0].name
//                } else {
//                    cell.lblHeadquaters.text = "No info available"
//                }
//                
//            }
//            
//            var clusterNameArr = [String]()
//            var clusterCodeArr = [String]()
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedClusterID?.isEmpty ?? true) {
//                self.clusterArr?.forEach({ cluster in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedClusterID?.forEach { key, value in
//                        if key == cluster.code {
//                            clusterNameArr.append(cluster.name ?? "")
//                            clusterCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblCluster.text = clusterNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].clusterName =  cell.lblCluster.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].clusterCode = clusterCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblCluster.text = "No info available"
//            }
////            var headQuatersNameArr = [String]()
////            var headQuartersCodeArr = [String]()
////            if !sessionDetailsArr.sessionDetails?[indexPath.row].selectedHeadQuaterID.isEmpty {
////                self.headQuatersArr?.forEach({ headQuaters in
////                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedHeadQuaterID.forEach { key, value in
////                        if key == headQuaters.id {
////                            headQuatersNameArr.append(headQuaters.name ?? "")
////                            headQuartersCodeArr.append(key)
////                        }
////                    }
////                })
////
////                cell.lblHeadquaters.text = headQuatersNameArr.joined(separator:", ")
////                sessionDetailsArr.sessionDetails?[indexPath.row].HQNames =  cell.lblHeadquaters.text ?? ""
////                sessionDetailsArr.sessionDetails?[indexPath.row].HQCodes = headQuartersCodeArr.joined(separator:", ")
////            } else {
////
////                cell.lblHeadquaters.text = "No info available"
////            }
//            
//            
//            
//            var jointWorkNameArr = [String]()
//            var jointWorkCodeArr = [String]()
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedjointWorkID?.isEmpty ?? true) {
//                self.jointWorkArr?.forEach({ work in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedjointWorkID?.forEach { key, value in
//                        if key == work.code {
//                            jointWorkNameArr.append(work.name ?? "")
//                            jointWorkCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblJointCall.text = jointWorkNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].jwName =  cell.lblJointCall.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].jwCode = jointWorkCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblJointCall.text = "No info available"
//            }
//            
//            
//            var listedDoctorsNameArr = [String]()
//            var listedDoctorsCodeArr = [String]()
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedlistedDoctorsID?.isEmpty ?? true)  {
//                self.listedDocArr?.forEach({ doctors in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedlistedDoctorsID?.forEach { key, value in
//                        if key == doctors.code {
//                            listedDoctorsNameArr.append(doctors.name ?? "")
//                            listedDoctorsCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblListedDoctor.text = listedDoctorsNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].drName =  cell.lblListedDoctor.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].drCode = listedDoctorsCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblListedDoctor.text = "No info available"
//            }
//            
//            
//            var chemistNameArr = [String]()
//            var chemistCodeArr = [String]()
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedchemistID?.isEmpty ?? true) {
//                self.chemistArr?.forEach({ chemist in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedchemistID?.forEach { key, value in
//                        if key == chemist.code {
//                            chemistNameArr.append(chemist.name ?? "")
//                            chemistCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblChemist.text = chemistNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].chemName =  cell.lblChemist.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].chemCode = chemistCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblChemist.text = "No info available"
//            }
//            
//            
//            var stockistNameArr = [String]()
//            var stockistCodeArr = [String]()
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedStockistID?.isEmpty ?? true) {
//                self.stockistArr?.forEach({ stockist in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedStockistID?.forEach { key, value in
//                        if key == stockist.code {
//                            stockistNameArr.append(stockist.name ?? "")
//                            stockistCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblstockist.text = stockistNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].stockistName =  cell.lblstockist.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].stockistCode = stockistCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblstockist.text = "No info available"
//            }
//            
//            
//            
//            var unlistedDocNameArr = [String]()
//            var unlistedDocCodeArr = [String]()
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedUnlistedDoctorsID?.isEmpty ?? true) {
//                self.unlisteedDocArr?.forEach({ unlistDoc in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedUnlistedDoctorsID?.forEach { key, value in
//                        if key == unlistDoc.code {
//                            unlistedDocNameArr.append(unlistDoc.name ?? "")
//                            unlistedDocCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblunlistedDoc.text = unlistedDocNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].unListedDrName =  cell.lblunlistedDoc.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].unListedDrCode = unlistedDocCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblunlistedDoc.text = "No info available"
//            }
//            
//            
//           return cell
//            
//
//        case .session:
//            let cell : SessionInfoTVC = tableView.dequeueReusableCell(withIdentifier:"SessionInfoTVC" ) as! SessionInfoTVC
//            cell.selectionStyle = .none
//            if indexPath.row == alartcellIndex {
//                if isToalartCell {
//                    UIView.animate(withDuration: 1, delay: 0, animations: {
//                        cell.overallContentsHolder.backgroundColor =  .red.withAlphaComponent(0.5)
//                    })
//                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        UIView.animate(withDuration: 1, delay: 0, animations: {
//                            cell.overallContentsHolder.backgroundColor = .appSelectionColor
//                            self.isToalartCell = false
//                        })
//                    }
//                }
//            }
//
//
//            
//            cell.delegate = self
//            cell.remarksTV.text = sessionDetailsArr.sessionDetails?[indexPath.row].remarks == "" ? "Remarks" : sessionDetailsArr.sessionDetails?[indexPath.row].remarks
//           // sessionDetailsArr.sessionDetails?[selectedSession].remarks
//            if  cell.remarksTV.text == "Remarks" {
//                cell.remarksTV.textColor =  UIColor.lightGray
//            } else {
//                cell.remarksTV.textColor = UIColor.black
//            }
//            if self.sessionDetailsArr.sessionDetails?.count == 1 {
//                cell.deleteIcon.isHidden = true
//            } else  {
//                cell.deleteIcon.isHidden = false
//            }
//           
//            cell.keybordenabled = false
//            cell.lblName.text = "Plan \(indexPath.row + 1)"
//            cell.selectedIndex = indexPath.row + 1
//            sessionDetailsArr.sessionDetails?[indexPath.row].sessionName = cell.lblName.text ?? ""
//            
//            let selectedWorkTypeIndex = sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex
//            let searchedWorkTypeIndex = sessionDetailsArr.sessionDetails?[indexPath.row].searchedWorkTypeIndex
//            
//            let selectedHQIndex = sessionDetailsArr.sessionDetails?[indexPath.row].selectedHQIndex
//            let searchedHQIndex = sessionDetailsArr.sessionDetails?[indexPath.row].searchedHQIndex
//            
//            let isForFieldWork = sessionDetailsArr.sessionDetails?[indexPath.row].isForFieldWork
//            
//          
//            
//            if  isForFieldWork ?? false  {
//                cell.stackHeight.constant = cellStackHeightforFW
//                
//                let cellViewArr : [UIView] = [cell.workTypeView, cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.stockistView, cell.newCustomersView]
//                
//                cellViewArr.forEach { view in
//                    switch view {
//                        
//                    case cell.jointCallView:
//                        if self.isJointCallneeded {
//                            view.isHidden = false
//                        } else {
//                            view.isHidden = true
//                        }
//                        
//                    case cell.listedDoctorView:
//                        if self.isDocNeeded {
//                            view.isHidden = false
//                        } else {
//                            view.isHidden = true
//                        }
//            
//                    case cell.chemistView:
//                        if self.isChemistNeeded {
//                            view.isHidden = false
//                        } else {
//                            view.isHidden = true
//                        }
//                        
//                    case cell.stockistView:
//                        if self.isSockistNeeded {
//                            view.isHidden = false
//                        } else {
//                            view.isHidden = true
//                        }
//                        
//                    case cell.newCustomersView:
//                        if self.isnewCustomerNeeded {
//                            view.isHidden = false
//                        } else {
//                            view.isHidden = true
//                        }
//                        
//                    default:
//                        view.isHidden = false
//                    }
//                }
//            }  else {
//                cell.stackHeight.constant = cellStackHeightfOthers
//                [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.stockistView, cell.newCustomersView].forEach { view in
//                    view?.isHidden = true
//                    // cell.workselectionHolder,
//                }
//                
//            }
//            if isSearched {
//                if sessionDetailsArr.sessionDetails?[indexPath.row].searchedWorkTypeIndex != nil {
//                    cell.lblWorkType.text = sessionDetailsArr.sessionDetails?[indexPath.row].workType?[searchedWorkTypeIndex ?? 0].name
//                } else {
//                    cell.lblWorkType.text = "Select"
//                }
//                
//                if sessionDetailsArr.sessionDetails?[indexPath.row].searchedHQIndex != nil {
//                    cell.lblHeadquaters.text = sessionDetailsArr.sessionDetails?[indexPath.row].headQuates?[searchedHQIndex ?? 0].name
//                } else {
//                    cell.lblHeadquaters.text = "No info available"
//                }
//            } else {
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil {
//                    cell.lblWorkType.text = sessionDetailsArr.sessionDetails?[indexPath.row].workType?[selectedWorkTypeIndex ?? 0].name
//                } else {
//                    cell.lblWorkType.text = "Select"
//                }
//                
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedHQIndex != nil {
//                    cell.lblHeadquaters.text = sessionDetailsArr.sessionDetails?[indexPath.row].headQuates?[selectedHQIndex ?? 0].name
//                } else {
//                    cell.lblHeadquaters.text = "Select"
//                }
//                
//            }
//            if isSearched {
//                let model = sessionDetailsArr.sessionDetails?[indexPath.row]
//                if model?.searchedWorkTypeIndex == nil {
//                    model?.selectedClusterID =  [String : Bool]()
//                  //  mod?el.selectedHeadQuaterID =  [String : Bool]()
//                    model?.selectedjointWorkID = [String : Bool]()
//                    model?.selectedlistedDoctorsID = [String : Bool]()
//                    model?.selectedchemistID = [String : Bool]()
//                    model?.selectedStockistID = [String : Bool]()
//                    model?.selectedUnlistedDoctorsID = [String : Bool]()
//                }
//            } else {
//                let model = sessionDetailsArr.sessionDetails?[indexPath.row]
//                 if model?.selectedWorkTypeIndex == nil {
//                    model?.selectedClusterID =  [String : Bool]()
//                  //  mod?el.selectedHeadQuaterID =  [String : Bool]()
//                    model?.selectedjointWorkID = [String : Bool]()
//                    model?.selectedlistedDoctorsID = [String : Bool]()
//                    model?.selectedchemistID = [String : Bool]()
//                    model?.selectedStockistID = [String : Bool]()
//                    model?.selectedUnlistedDoctorsID = [String : Bool]()
//                }
//            }
//    
//            
//           
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedClusterID?.isEmpty ?? true) {
//                var clusterNameArr = [String]()
//                var clusterCodeArr = [String]()
//                self.clusterArr?.forEach({ cluster in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedClusterID?.forEach { key, value in
//                        if key == cluster.code {
//                            clusterNameArr.append(cluster.name ?? "")
//                            clusterCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblCluster.text = clusterNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].clusterName =  cell.lblCluster.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].clusterCode = clusterCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblCluster.text = "Select"
//            }
//            
////            if !sessionDetailsArr.sessionDetails?[indexPath.row].selectedHeadQuaterID.isEmpty {
////                var headQuatersNameArr = [String]()
////                var headQuartersCodeArr = [String]()
////                self.headQuatersArr?.forEach({ headQuaters in
////                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedHeadQuaterID.forEach { key, value in
////                        if key == headQuaters.id {
////                            headQuatersNameArr.append(headQuaters.name ?? "")
////                            headQuartersCodeArr.append(key)
////                        }
////                    }
////                })
////
////                cell.lblHeadquaters.text = headQuatersNameArr.joined(separator:", ")
////                sessionDetailsArr.sessionDetails?[indexPath.row].HQNames =  cell.lblHeadquaters.text ?? ""
////                sessionDetailsArr.sessionDetails?[indexPath.row].HQCodes = headQuartersCodeArr.joined(separator:", ")
////            } else {
////
////                cell.lblHeadquaters.text = "Select"
////            }
//            
//            
//            
//          
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedjointWorkID?.isEmpty ?? true) {
//                var jointWorkNameArr = [String]()
//                var jointWorkCodeArr = [String]()
//                self.jointWorkArr?.forEach({ work in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedjointWorkID?.forEach { key, value in
//                        if key == work.code {
//                            jointWorkNameArr.append(work.name ?? "")
//                            jointWorkCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblJointCall.text = jointWorkNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].jwName =  cell.lblJointCall.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].jwCode = jointWorkCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblJointCall.text = "Select"
//            }
//            
//            
//           
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedlistedDoctorsID?.isEmpty ?? true) {
//                var listedDoctorsNameArr = [String]()
//                var listedDoctorsCodeArr = [String]()
//                self.listedDocArr?.forEach({ doctors in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedlistedDoctorsID?.forEach { key, value in
//                        if key == doctors.code {
//                            listedDoctorsNameArr.append(doctors.name ?? "")
//                            listedDoctorsCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblListedDoctor.text = listedDoctorsNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].drName =  cell.lblListedDoctor.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].drCode = listedDoctorsCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblListedDoctor.text = "Select"
//            }
//           
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedchemistID?.isEmpty ?? true) {
//                var chemistNameArr = [String]()
//                var chemistCodeArr = [String]()
//                self.chemistArr?.forEach({ chemist in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedchemistID?.forEach { key, value in
//                        if key == chemist.code {
//                            chemistNameArr.append(chemist.name ?? "")
//                            chemistCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblChemist.text = chemistNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].chemName =  cell.lblChemist.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].chemCode = chemistCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblChemist.text = "Select"
//            }
//            
//            //Set label for Stockists
//            
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedStockistID?.isEmpty ?? true) {
//                var stockistNameArr = [String]()
//                var stockistCodeArr = [String]()
//                self.stockistArr?.forEach({ chemist in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedStockistID?.forEach { key, value in
//                        if key == chemist.code {
//                            stockistNameArr.append(chemist.name ?? "")
//                            stockistCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblStockist.text = stockistNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].stockistName =  cell.lblStockist.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].stockistCode = stockistCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblStockist.text = "Select"
//            }
//            
//            //Set label for new customers
//            
//            if !(sessionDetailsArr.sessionDetails?[indexPath.row].selectedUnlistedDoctorsID?.isEmpty ?? true) {
//                var unlistedDocNameArr = [String]()
//                var unlistedDocCodeArr = [String]()
//                self.unlisteedDocArr?.forEach({ chemist in
//                    sessionDetailsArr.sessionDetails?[indexPath.row].selectedUnlistedDoctorsID?.forEach { key, value in
//                        if key == chemist.code {
//                            unlistedDocNameArr.append(chemist.name ?? "")
//                            unlistedDocCodeArr.append(key)
//                        }
//                    }
//                })
//                cell.lblNewCustomers.text = unlistedDocNameArr.joined(separator:", ")
//                sessionDetailsArr.sessionDetails?[indexPath.row].unListedDrName =  cell.lblNewCustomers.text ?? ""
//                sessionDetailsArr.sessionDetails?[indexPath.row].unListedDrCode = unlistedDocCodeArr.joined(separator:", ")
//            } else {
//                
//                cell.lblNewCustomers.text = "Select"
//            }
//            
//            
//            
//            var isToproceed = false
//            
//
//            
//            cell.clusterView.addTap { [self] in
//               
//                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails?[indexPath.row].selectedClusterID?.count ?? 0)
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  {
//                    isToproceed = true
//                }
//                if isToproceed {
//                    self.cellType = .cluster
//                    self.selectedSession = indexPath.row
//                    self.setPageType(.cluster)
//                } else {
//                    self.toCreateToast("Please select work type")
//                }
//                
//                
//            }
//            cell.workTypeView.addTap {
//                
//               
//                    self.cellType = .workType
//                    self.selectedSession = indexPath.row
//                    self.setPageType(.workType)
//           
//                
//                
//            }
//            
//            cell.headQuatersView.addTap { [self] in
////                [self] in
////                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails?[indexPath.row].selectedHeadQuaterID.count)
////                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  {
////                    isToproceed = true
////                }
////                if isToproceed {
////                    self.cellType = .headQuater
////                    self.selectedSession = indexPath.row
////
////                    self.setPageType(.headQuater)
////                } else {
////                    self.toCreateToast("Please select work type")
////                }
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  {
//                    isToproceed = true
//                }
//                if isToproceed {
//                    self.cellType = .headQuater
//                    self.selectedSession = indexPath.row
//                    self.setPageType(.headQuater)
//                } else {
//                    self.toCreateToast("Please select work type")
//                }
//            }
//            cell.jointCallView.addTap { [self] in
//                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails?[indexPath.row].selectedjointWorkID?.count ?? 0)
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  {
//                    isToproceed = true
//                }
//                if isToproceed {
//                    self.cellType = .jointCall
//                    self.selectedSession = indexPath.row
//                    
//                    self.setPageType(.jointCall)
//                } else {
//                    self.toCreateToast("Please select work type")
//                }
//                
//                
//            }
//            cell.listedDoctorView.addTap { [self] in
//                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails?[indexPath.row].selectedlistedDoctorsID?.count ?? 0)
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  {
//                    isToproceed = true
//                }
//                if isToproceed {
//                    self.cellType = .listedDoctor
//                    self.selectedSession = indexPath.row
//                    
//                    self.setPageType(.listedDoctor)
//                } else {
//                    self.toCreateToast("Please select work type")
//                }
//                
//                
//                
//            }
//            cell.chemistView.addTap { [self] in
//                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails?[indexPath.row].selectedchemistID?.count ?? 0)
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  {
//                    isToproceed = true
//                }
//                if isToproceed {
//                    self.cellType = .chemist
//                    self.selectedSession = indexPath.row
//                    self.setPageType(.chemist)
//                } else {
//                    self.toCreateToast("Please select work type")
//                }
//                
//                
//                
//            }
//            
//            cell.stockistView.addTap { [self] in
//                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails?[indexPath.row].selectedStockistID?.count ?? 0)
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  {
//                    isToproceed = true
//                }
//                if isToproceed {
//                    self.cellType = .stockist
//                    self.selectedSession = indexPath.row
//                    self.setPageType(.stockist)
//                } else {
//                    self.toCreateToast("Please select work type")
//                }
//            }
//            
//            
//            cell.newCustomersView.addTap { [self] in
//                toSetSelectAllImage(selectedIndexCount: sessionDetailsArr.sessionDetails?[indexPath.row].selectedUnlistedDoctorsID?.count ?? 0)
//                if sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  ||  sessionDetailsArr.sessionDetails?[indexPath.row].selectedWorkTypeIndex != nil  {
//                    isToproceed = true
//                }
//                if isToproceed {
//                    self.cellType = .unlistedDoctor
//                    self.selectedSession = indexPath.row
//                    self.setPageType(.unlistedDoctor)
//                } else {
//                    self.toCreateToast("Please select work type")
//                }
//            }
//            
//            //cell.deleteIcon.isHidden = false
//            
//            
//            cell.deleteIcon.addTap {
//                self.selectedSession = indexPath.row
//                self.toRemoveSession(at: indexPath.row)
//                tableView.reloadData()
//            }
//         
//            return cell
//            
//        case .workType:
//            let cell = tableView.dequeueReusableCell(withIdentifier:"WorkTypeCell" ) as! WorkTypeCell
//            cell.workTypeLbl.textColor = .appTextColor
//            cell.workTypeLbl.setFont(font: .medium(size: .SMALL))
//            let item = sessionDetailsArr.sessionDetails?[selectedSession].workType?[indexPath.row]
//            cell.workTypeLbl.text = item?.name ?? ""
//            let cacheIndex =  sessionDetailsArr.sessionDetails?[selectedSession].selectedWorkTypeIndex
//            let searchedCacheIndex = sessionDetailsArr.sessionDetails?[selectedSession].searchedWorkTypeIndex
//            
//            
//            if isSearched {
//                if searchedCacheIndex == nil {
//                    self.selectedWorkTypeName = "Select"
//                    self.selectTitleLbl.text = selectedWorkTypeName
//                } else {
//                    
//                    self.selectedWorkTypeName = self.workTypeArr?[searchedCacheIndex ?? 0].name ?? ""
//                    self.selectTitleLbl.text = selectedWorkTypeName
//                }
//            } else {
//                if cacheIndex == nil {
//                    self.selectedWorkTypeName = "Select"
//                    self.selectTitleLbl.text = selectedWorkTypeName
//                } else {
//                    self.selectedWorkTypeName = sessionDetailsArr.sessionDetails?[selectedSession].workType?[cacheIndex ?? 0].name ?? ""
//                    sessionDetailsArr.sessionDetails?[selectedSession].WTCode = sessionDetailsArr.sessionDetails?[selectedSession].workType?[cacheIndex ?? 0].code ?? ""
//                    
//                    sessionDetailsArr.sessionDetails?[selectedSession].WTName = sessionDetailsArr.sessionDetails?[selectedSession].workType?[cacheIndex ?? 0].name ?? ""
//                    
//                    self.selectTitleLbl.text = selectedWorkTypeName
//                }
//            }
//            
//            
//            
//            if isSearched {
//                if sessionDetailsArr.sessionDetails?[selectedSession].WTName == cell.workTypeLbl.text {
//                    cell.workTypeLbl.textColor = .green
//                }
//                else {
//                    cell.workTypeLbl.textColor = .black
//                }
//            } else {
//                if sessionDetailsArr.sessionDetails?[selectedSession].WTName == cell.workTypeLbl.text {
//                    cell.workTypeLbl.textColor = .green
//                }
//                else {
//                    cell.workTypeLbl.textColor = .black
//                }
//            }
//            
//            
//            
//            cell.addTap { [self] in
//                
//                if self.isSearched {
//                    var isToremove: Bool = false
//                    let cacheIndex = sessionDetailsArr.sessionDetails?[selectedSession].searchedWorkTypeIndex
//                    let cacheCode = sessionDetailsArr.sessionDetails?[selectedSession].WTCode
//                    let cacheName = sessionDetailsArr.sessionDetails?[selectedSession].WTName
//                    self.workTypeArr?.enumerated().forEach({ index, workType in
//                        if workType.code  ==  item?.code {
//                            if sessionDetailsArr.sessionDetails?[selectedSession].searchedWorkTypeIndex == index {
//                                sessionDetailsArr.sessionDetails?[selectedSession].searchedWorkTypeIndex  = index
//                                sessionDetailsArr.sessionDetails?[selectedSession].WTName = workType.name ?? ""
//                                sessionDetailsArr.sessionDetails?[selectedSession].FWFlg =  workType.terrslFlg ?? ""
//                                sessionDetailsArr.sessionDetails?[selectedSession].WTCode =  workType.code ?? ""
//                               // isToremove = true
//                                isToremove = false
//                            } else {
//                                sessionDetailsArr.sessionDetails?[selectedSession].searchedWorkTypeIndex = index
//                                if item?.terrslFlg == "Y" {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].isForFieldWork = true
//                                } else {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].isForFieldWork = false
//                                }
//                                let terrFlg = item?.terrslFlg ?? ""
//                                sessionDetailsArr.sessionDetails?[selectedSession].isToshowTerritory = terrFlg == "N" ? false : true
//                                sessionDetailsArr.sessionDetails?[selectedSession].FWFlg = workType.terrslFlg ?? ""
//                                sessionDetailsArr.sessionDetails?[selectedSession].WTCode = workType.code ?? ""
//                                
//                                sessionDetailsArr.sessionDetails?[selectedSession].WTName = workType.name ?? ""
//                            }
//                        }
//                    })
//              
//                    var isExist = Bool()
//                
//                    if sessionDetailsArr.sessionDetails?.count ?? 0 > 1 {
//                        let asession = sessionDetailsArr.sessionDetails?.enumerated().filter {sessionDetailIndex, sessionDetail in
//                             sessionDetail.WTCode ==  sessionDetailsArr.sessionDetails?[selectedSession].WTCode
//                         }
//                        if asession?.count ?? 0 > 1 {
//                            isExist = true
//                        }
//                        if isExist {
//                            self.endEditing(true)
//                            self.toCreateToast("You have already choosen similar work type for another session")
//                            sessionDetailsArr.sessionDetails?[selectedSession].searchedWorkTypeIndex = cacheIndex
//                            sessionDetailsArr.sessionDetails?[selectedSession].WTCode = cacheCode
//                            sessionDetailsArr.sessionDetails?[selectedSession].WTName = cacheName
//                        } else {
//                            if isToremove {
//                                self.menuTable.reloadData()
//                            } else {
//                                setPageType(.session, for: self.selectedSession)
//                                self.endEditing(true)
//                            }
//                         
//                        }
//                    } else {
//                        if isToremove {
//                            self.menuTable.reloadData()
//                        } else {
//                        
//                            setPageType(.session, for: self.selectedSession)
//                            self.endEditing(true)
//                        }
//                     
//                    }
//           
//                } else {
//                    if sessionDetailsArr.sessionDetails?[selectedSession].selectedWorkTypeIndex == indexPath.row {
////                        sessionDetailsArr.sessionDetails?[selectedSession].selectedWorkTypeIndex  = nil
////                        sessionDetailsArr.sessionDetails?[selectedSession].WTName = ""
////                        sessionDetailsArr.sessionDetails?[selectedSession].FWFlg =  ""
////                        sessionDetailsArr.sessionDetails?[selectedSession].WTCode = ""
//                      //  self.menuTable.reloadData()
//                        toSetData()
//                    } else {
//                        let cacheIndex = sessionDetailsArr.sessionDetails?[selectedSession].selectedWorkTypeIndex
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedWorkTypeIndex = indexPath.row
//                
//                            var isExist = Bool()
//
//                        if sessionDetailsArr.sessionDetails?.count ?? 0 > 1 {
//                               let asession = sessionDetailsArr.sessionDetails?.enumerated().filter {sessionDetailIndex, sessionDetail in
//                                    sessionDetail.selectedWorkTypeIndex ==  sessionDetailsArr.sessionDetails?[selectedSession].selectedWorkTypeIndex
//                                }
//                                
//                            if asession?.count ?? 0 > 1 {
//                                    isExist = true
//                                }
//                                
//                                if isExist {
//                                    self.toCreateToast("You have already choosen similar work type for another session")
//                              
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedWorkTypeIndex = cacheIndex
//                                } else {
//                                    toSetData()
//                                }
//                            } else {
//                                toSetData()
//                            }
//           
//           
//                    }
//                    func toSetData() {
//                        if item?.terrslFlg == "Y" {
//                            sessionDetailsArr.sessionDetails?[selectedSession].isForFieldWork = true
//                        } else {
//                            sessionDetailsArr.sessionDetails?[selectedSession].isForFieldWork = false
//                        }
//                        sessionDetailsArr.sessionDetails?[selectedSession].FWFlg = item?.terrslFlg ?? ""
//                        sessionDetailsArr.sessionDetails?[selectedSession].WTCode = item?.code ?? ""
//                        let terrFlg = item?.terrslFlg ?? ""
//                        sessionDetailsArr.sessionDetails?[selectedSession].isToshowTerritory = terrFlg == "N" ? false : true
//                        sessionDetailsArr.sessionDetails?[selectedSession].WTName = item?.name ?? ""
//                        setPageType(.session, for: self.selectedSession)
//                        self.endEditing(true)
//                    }
//                }
//            }
//            
//            
//            cell.selectionStyle = .none
//            return cell
//            
//            
//            
//            
//        case .cluster, .headQuater, .jointCall, .listedDoctor, .chemist, .stockist, .unlistedDoctor:
//            
//            // MARK: General note
//            /**
//             .headQuater, .jointCall, .listedDoctor, .chemist types follows same type of cell reloads and actions as .cluster
//             - note : do read documentstions of .cluster tyoe below and make changes to types appropriately
//             */
//            // MARK: General note ends
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier:MenuTCell.identifier ) as! MenuTCell
//            var item : AnyObject?
//            switch self.cellType {
//                
//            case .headQuater:
//                item = sessionDetailsArr.sessionDetails?[selectedSession].headQuates?[indexPath.row]
//                cell.lblName?.text = item?.name ?? ""
//                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                let cacheIndex =  sessionDetailsArr.sessionDetails?[selectedSession].selectedHQIndex
//                let searchedCacheIndex = sessionDetailsArr.sessionDetails?[selectedSession].searchedHQIndex
//                
//                
//                if isSearched {
//                    if searchedCacheIndex == nil {
//                        self.selectedWorkTypeName = "Select"
//                        self.selectTitleLbl.text = selectedWorkTypeName
//                    } else {
//                        
//                        self.selectedWorkTypeName = self.headQuatersArr?[searchedCacheIndex ?? 0].name ?? ""
//                        self.selectTitleLbl.text = selectedWorkTypeName
//                    }
//                } else {
//                    if cacheIndex == nil {
//                        self.selectedWorkTypeName = "Select"
//                        self.selectTitleLbl.text = selectedWorkTypeName
//                    } else {
//                        self.selectedWorkTypeName = sessionDetailsArr.sessionDetails?[selectedSession].headQuates?[cacheIndex ?? 0].name ?? ""
//                        sessionDetailsArr.sessionDetails?[selectedSession].HQCodes = sessionDetailsArr.sessionDetails?[selectedSession].headQuates?[cacheIndex ?? 0].id ?? ""
//                        
//                        sessionDetailsArr.sessionDetails?[selectedSession].HQNames = sessionDetailsArr.sessionDetails?[selectedSession].headQuates?[cacheIndex ?? 0].name ?? ""
//                        
//                        self.selectTitleLbl.text = selectedWorkTypeName
//                    }
//                }
//                
//                
//                
//                if isSearched {
//                    if sessionDetailsArr.sessionDetails?[selectedSession].HQNames == cell.lblName.text {
//                        cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//                    }
//                    else {
//                        cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                    }
//                } else {
//                    if sessionDetailsArr.sessionDetails?[selectedSession].HQNames == cell.lblName.text {
//                        cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//                    }
//                    else {
//                        cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                    }
//                }
//                
//                
//                
//                cell.addTap { [self] in
//                    
//                    if self.isSearched {
//                        var isToremove: Bool = false
//                        let cacheIndex = sessionDetailsArr.sessionDetails?[selectedSession].searchedHQIndex
//                        let cacheCode = sessionDetailsArr.sessionDetails?[selectedSession].HQCodes
//                        let cacheName = sessionDetailsArr.sessionDetails?[selectedSession].HQNames
//                        self.headQuatersArr?.enumerated().forEach({ index, HQs in
//                            if HQs.id  ==  item?.id {
//                                if sessionDetailsArr.sessionDetails?[selectedSession].searchedHQIndex == index {
////                                    sessionDetailsArr.sessionDetails?[selectedSession].searchedHQIndex  = nil
////                                    sessionDetailsArr.sessionDetails?[selectedSession].HQNames = ""
////                                    sessionDetailsArr.sessionDetails?[selectedSession].HQCodes = ""
//                                    sessionDetailsArr.sessionDetails?[selectedSession].searchedHQIndex = index
//                                    sessionDetailsArr.sessionDetails?[selectedSession].HQCodes = HQs.id ?? ""
//                                    sessionDetailsArr.sessionDetails?[selectedSession].HQNames = HQs.name ?? ""
//                                    isToremove = false
//                                } else {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].searchedHQIndex = index
//                                    sessionDetailsArr.sessionDetails?[selectedSession].HQCodes = HQs.id ?? ""
//                                    sessionDetailsArr.sessionDetails?[selectedSession].HQNames = HQs.name ?? ""
//                                }
//                            }
//                        })
//                        
//                        if isToremove {
//                            self.menuTable.reloadData()
//                        } else {
//                            setPageType(.session, for: self.selectedSession)
//                            self.endEditing(true)
//                        }
//                        
//                        
//                        
//                    } else {
//                        if sessionDetailsArr.sessionDetails?[selectedSession].selectedHQIndex == indexPath.row {
////                            sessionDetailsArr.sessionDetails?[selectedSession].selectedHQIndex  = nil
////                            sessionDetailsArr.sessionDetails?[selectedSession].HQNames = ""
////                            sessionDetailsArr.sessionDetails?[selectedSession].HQCodes = ""
//                         //   self.menuTable.reloadData()
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedHQIndex = indexPath.row
//                            sessionDetailsArr.sessionDetails?[selectedSession].HQCodes = item?.id ?? ""
//                            sessionDetailsArr.sessionDetails?[selectedSession].HQNames = item?.name ?? ""
//                            setPageType(.session, for: self.selectedSession)
//                            self.endEditing(true)
//                        } else {
//                            let cacheIndex = sessionDetailsArr.sessionDetails?[selectedSession].selectedHQIndex
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedHQIndex = indexPath.row
//                            sessionDetailsArr.sessionDetails?[selectedSession].HQCodes = item?.id ?? ""
//                            sessionDetailsArr.sessionDetails?[selectedSession].HQNames = item?.name ?? ""
//                            setPageType(.session, for: self.selectedSession)
//                            self.endEditing(true)
//                            
//                        }
//                    }
//                }
//                
//                
//                cell.selectionStyle = .none
//                return cell
//                
//
//                
//                
//            case .cluster:
//                
//                let item = sessionDetailsArr.sessionDetails?[selectedSession].cluster?[indexPath.row]
//                let _ = sessionDetailsArr.sessionDetails?[selectedSession].cluster
//                cell.lblName?.text = item?.name ?? ""
//                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                
//                // MARK: - cells load action
//                /**
//                 here  sessionDetailsArr.sessionDetails?[selectedSession].cluster is an array which has cluster,
//                 sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID id dictionary which has selected cluster code and appropriate boolean values captured from cell tap action.
//                 
//                 - note : iterating through cluster Array and selectedClusterID dictionary if code in selectedClusterID dictionary is equal to code in cluster array
//                 - note : And furher if value for code in  selectedClusterID dictionary is true cell is modified accordingly
//                 */
//
//                    self.clusterArr?.forEach({ cluster in
//                        //  dump(cluster.code)
//                        sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID?.forEach { id, isSelected in
//                            if id == cluster.code {
//
//                                if isSelected  {
//                                    if cluster.name ==  cell.lblName?.text {
//                                        cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//                                    }
//                                    
//                                } else {
//                                    cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                                }
//                            } else {
//                            }
//                        }
//                    })
//
//                // MARK: - set count and selected label
//                /**
//                 here  sessionDetailsArr.sessionDetails?[selectedSession].cluster is an array which has cluster,
//                 sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID id dictionary which has selected cluster code and appropriate boolean values captured from cell tap action.
//                 - note : iterating through selectedClusterID dictionary if (code) value in selectedClusterID dictionary is is true count value is increamented
//                 */
//                
//                var count = 0
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID?.forEach({ (code, isSelected) in
//                    if isSelected {
//                        count += 1
//                    }
//                })
//                
//                if count > 0 {
//                    self.selectTitleLbl.text = "Selected"
//                    self.countView.isHidden = false
//                    self.countLbl.text = "\(count)"
//                } else {
//                    self.selectTitleLbl.text = "Select"
//                    self.countView.isHidden = true
//                    
//                }
//                
//                // MARK: - set count and selected ends
//                
//                
//                // MARK: - cells load action ends
//                
//                cell.addTap { [self] in
//                    self.endEditing(true)
//                    _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID
//                    
//                    // MARK: - Append contents to selectedClusterID Dictionary
//                    /**
//                     selectedClusterID dictionary holds code key and Boolean value
//                     - note : on tap action on cell if key code doent exists we are making value to true else value for key is removed
//                     - note : if value is false selectAllIV is set to checkBoxEmpty image since key does not holds all code values as true.
//                     */
//                    
//                    if self.isSearched {
//                        self.clusterArr?.enumerated().forEach({ index, cluster in
//                            if cluster.code  ==  item?.code {
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID![cluster.code ?? ""] == nil {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID![cluster.code ?? ""] = true
//                                } else {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID![cluster.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID![cluster.code ?? ""] == true ? false : true
//                                }
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID![cluster.code ?? ""] == false {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID!.removeValue(forKey: cluster.code ?? "")
//                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                                }
//                                
//                            }
//                            
//                        })
//                      
//                    } else {
//                        if let _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID?[item?.code ?? ""] {
//                            
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID![item?.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID![item?.code ?? ""] == true ? false : true
//                            
//                            if sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID![item?.code ?? ""] == false {
//                                sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID!.removeValue(forKey: item?.code ?? "")
//                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                            }
//                            
//                        } else {
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedClusterID?[item?.code ?? ""] = true
//                        }
//                    }
//                    tableView.reloadData()
//                    
//                }
//                
//
//            case .jointCall:
//                item = sessionDetailsArr.sessionDetails?[selectedSession].jointWork?[indexPath.row]
//                cell.lblName?.text = item?.name ?? ""
//                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                sessionDetailsArr.sessionDetails?[selectedSession].jointWork?.forEach({ work in
//                    //  dump(cluster.code)
//                    sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID?.forEach { id, isSelected in
//                        if id == work.code {
//                            
//                            if isSelected  {
//                                
//                                if work.name ==  cell.lblName?.text {
//                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//                                }
//                                
//                            } else {
//                                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                            }
//                        } else {
//
//                        }
//                    }
//                })
//                var count = 0
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID?.forEach({ (code, isSelected) in
//                    if isSelected {
//                        count += 1
//                    }
//                })
//                
//                if count > 0 {
//                    self.selectTitleLbl.text = "Selected"
//                    self.countView.isHidden = false
//                    self.countLbl.text = "\(count)"
//                } else {
//                    self.selectTitleLbl.text = "Select"
//                    self.countView.isHidden = true
//                    
//                }
//                
//                cell.addTap { [self] in
//                    _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID
//                    
//                    if isSearched {
//                        self.jointWorkArr?.enumerated().forEach({ index, work in
//                            if work.code  ==  item?.code {
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID![work.code ?? ""] == nil {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID![work.code ?? ""] = true
//                                } else {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID![work.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID![work.code ?? ""] == true ? false : true
//                                }
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID![work.code ?? ""] == false {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID!.removeValue(forKey: work.code ?? "")
//                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                                }
//                                
//                            }
//                            
//                        })
//                    } else {
//                        if let _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID?[item?.code ?? ""] {
//                            
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID![item?.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID![item?.code ?? ""] == true ? false : true
//                            
//                            if sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID![item?.code ?? ""] == false {
//                                sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID!.removeValue(forKey: item?.code ?? "")
//                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                            }
//                            
//                        } else {
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedjointWorkID?[item?.code ?? ""] = true
//                        }
//                    }
//                    tableView.reloadData()
//                }
//                
//            case .listedDoctor:
//                item = sessionDetailsArr.sessionDetails?[selectedSession].listedDoctors?[indexPath.row]
//                cell.lblName?.text = item?.name ?? ""
//                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                sessionDetailsArr.sessionDetails?[selectedSession].listedDoctors?.forEach({ doctors in
//                    //  dump(cluster.code)
//                    sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID?.forEach { id, isSelected in
//                        if id == doctors.code {
//                            
//                            if isSelected  {
//                                
//                                if doctors.name ==  cell.lblName?.text {
//                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//                                }
//                                
//                                
//                            } else {
//                                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                            }
//                        } else {
//                        }
//                    }
//                })
//                var count = 0
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID?.forEach({ (code, isSelected) in
//                    if isSelected {
//                        count += 1
//                    }
//                })
//                
//                if count > 0 {
//                    self.selectTitleLbl.text = "Selected"
//                    self.countView.isHidden = false
//                    self.countLbl.text = "\(count)"
//                } else {
//                    self.selectTitleLbl.text = "Select"
//                    self.countView.isHidden = true
//                    
//                }
//                
//                cell.addTap { [self] in
//                    _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID
//                    
//                    if self.isSearched {
//                        self.listedDocArr?.enumerated().forEach({ index, doctors in
//                            if doctors.code  ==  item?.code {
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![doctors.code ?? ""] == nil {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![doctors.code ?? ""] = true
//                                } else {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![doctors.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![doctors.code ?? ""] == true ? false : true
//                                }
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![doctors.code ?? ""] == false {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID!.removeValue(forKey: doctors.code ?? "")
//                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                                }
//                                
//                            }
//                            
//                        })
//                    } else {
//                        if let _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![item?.code ?? ""] {
//                            
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![item?.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID?[item?.code ?? ""] == true ? false : true
//                            
//                            if sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![item?.code ?? ""] == false {
//                                sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID!.removeValue(forKey: item?.code ?? "")
//                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                            }
//                            
//                        } else {
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedlistedDoctorsID![item?.code ?? ""] = true
//                        }
//                    }
//
//                    tableView.reloadData()
//                }
//            case .chemist:
//                item = sessionDetailsArr.sessionDetails?[selectedSession].chemist?[indexPath.row]
//                cell.lblName?.text = item?.name ?? ""
//                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                sessionDetailsArr.sessionDetails?[selectedSession].chemist?.forEach({ chemist in
//                  
//                    sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID?.forEach { id, isSelected in
//                        if id == chemist.code {
//                            
//                            if isSelected  {
//                                
//                                if chemist.name ==  cell.lblName?.text {
//                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//                                }
//                                
//                                
//                            } else {
//                                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                            }
//                        } else {
//                       
//                        }
//                    }
//                })
//                
//                var count = 0
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID?.forEach({ (code, isSelected) in
//                    if isSelected {
//                        count += 1
//                    }
//                })
//                
//                if count > 0 {
//                    self.selectTitleLbl.text = "Selected"
//                    self.countView.isHidden = false
//                    self.countLbl.text = "\(count)"
//                } else {
//                    self.selectTitleLbl.text = "Select"
//                    self.countView.isHidden = true
//                    
//                }
//                
//                cell.addTap { [self] in
//                    _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID
//                    
//                    if self.isSearched {
//                        self.chemistArr?.enumerated().forEach({ index, chemist in
//                            if chemist.code  ==  item?.code {
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![chemist.code ?? ""] == nil {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![chemist.code ?? ""] = true
//                                } else {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![chemist.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![chemist.code ?? ""] == true ? false : true
//                                }
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![chemist.code ?? ""] == false {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID!.removeValue(forKey: chemist.code ?? "")
//                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                                }
//                                
//                            }
//                            
//                        })
//                    } else {
//                        if let _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID?[item?.code ?? ""] {
//                            
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![item?.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![item?.code ?? ""] == true ? false : true
//                            
//                            if sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![item?.code ?? ""] == false {
//                                sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID!.removeValue(forKey: item?.code ?? "")
//                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                            }
//                            
//                        } else {
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedchemistID![item?.code ?? ""] = true
//                        }
//                    }
//                    
//
//                    
//                    tableView.reloadData()
//                }
//                
//                
//            case .stockist:
//                item = sessionDetailsArr.sessionDetails?[selectedSession].stockist?[indexPath.row]
//                cell.lblName?.text = item?.name ?? ""
//                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                sessionDetailsArr.sessionDetails?[selectedSession].stockist?.forEach({ stockist in
//                  
//                    sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID?.forEach { id, isSelected in
//                        if id == stockist.code {
//                            
//                            if isSelected  {
//                                
//                                if stockist.name ==  cell.lblName?.text {
//                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//                                }
//                                
//                                
//                            } else {
//                                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                            }
//                        } else {
//                       
//                        }
//                    }
//                })
//                
//                var count = 0
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID?.forEach({ (code, isSelected) in
//                    if isSelected {
//                        count += 1
//                    }
//                })
//                
//                if count > 0 {
//                    self.selectTitleLbl.text = "Selected"
//                    self.countView.isHidden = false
//                    self.countLbl.text = "\(count)"
//                } else {
//                    self.selectTitleLbl.text = "Select"
//                    self.countView.isHidden = true
//                    
//                }
//                
//                cell.addTap { [self] in
//                    _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID
//                    
//                    if self.isSearched {
//                        self.stockistArr?.enumerated().forEach({ index, chemist in
//                            if chemist.code  ==  item?.code {
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![chemist.code ?? ""] == nil {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![chemist.code ?? ""] = true
//                                } else {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![chemist.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![chemist.code ?? ""] == true ? false : true
//                                }
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![chemist.code ?? ""] == false {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID!.removeValue(forKey: chemist.code ?? "")
//                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                                }
//                                
//                            }
//                            
//                        })
//                    } else {
//                        if let _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![item?.code ?? ""] {
//                            
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![item?.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![item?.code ?? ""] == true ? false : true
//                            
//                            if sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![item?.code ?? ""] == false {
//                                sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID!.removeValue(forKey: item?.code ?? "")
//                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                            }
//                            
//                        } else {
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedStockistID![item?.code ?? ""] = true
//                        }
//                    }
//
//                    tableView.reloadData()
//                }
//            case .unlistedDoctor:
//                item = sessionDetailsArr.sessionDetails?[selectedSession].unlistedDoctors?[indexPath.row]
//                cell.lblName?.text = item?.name ?? ""
//                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                sessionDetailsArr.sessionDetails?[selectedSession].unlistedDoctors?.forEach({ stockist in
//                  
//                    sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID?.forEach { id, isSelected in
//                        if id == stockist.code {
//                            
//                            if isSelected  {
//                                
//                                if stockist.name ==  cell.lblName?.text {
//                                    cell.menuIcon?.image = UIImage(named: "checkBoxSelected")
//                                }
//                                
//                                
//                            } else {
//                                cell.menuIcon?.image = UIImage(named: "checkBoxEmpty")
//                            }
//                        } else {
//                       
//                        }
//                    }
//                })
//                
//                var count = 0
//                sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID?.forEach({ (code, isSelected) in
//                    if isSelected {
//                        count += 1
//                    }
//                })
//                
//                if count > 0 {
//                    self.selectTitleLbl.text = "Selected"
//                    self.countView.isHidden = false
//                    self.countLbl.text = "\(count)"
//                } else {
//                    self.selectTitleLbl.text = "Select"
//                    self.countView.isHidden = true
//                    
//                }
//                
//                cell.addTap { [self] in
//                    _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID
//                    
//                    if self.isSearched {
//                        self.unlisteedDocArr?.enumerated().forEach({ index, chemist in
//                            if chemist.code  ==  item?.code {
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![chemist.code ?? ""] == nil {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![chemist.code ?? ""] = true
//                                } else {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![chemist.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![chemist.code ?? ""] == true ? false : true
//                                }
//                                if sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![chemist.code ?? ""] == false {
//                                    sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID!.removeValue(forKey: chemist.code ?? "")
//                                    self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                                }
//                                
//                            }
//                            
//                        })
//                    } else {
//                        if let _ = sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![item?.code ?? ""] {
//                            
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![item?.code ?? ""] =  sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![item?.code ?? ""] == true ? false : true
//                            
//                            if sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![item?.code ?? ""] == false {
//                                sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID!.removeValue(forKey: item?.code ?? "")
//                                self.selectAllIV.image =  UIImage(named: "checkBoxEmpty")
//                            }
//                            
//                        } else {
//                            sessionDetailsArr.sessionDetails?[selectedSession].selectedUnlistedDoctorsID![item?.code ?? ""] = true
//                        }
//                    }
//
//                    tableView.reloadData()
//                }
//                
//            default:  return UITableViewCell()
//            }
//            cell.selectionStyle = .none
//            return cell
//            
//            
//       
//      
//        }
//        
//        
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch cellType {
//            
//        case .session:
// 
//            if sessionDetailsArr.sessionDetails![indexPath.row].isForFieldWork  {
//                return cellHeightForFW
//            }  else {
//                return cellHeightForOthers
//            }
//        case .workType:
//            return 50
//        case .cluster, .headQuater, .jointCall, .listedDoctor, .chemist, .stockist, .unlistedDoctor:
//            if indexPath.section == 0 {
//                return 50
//            } else {
//                return 50
//            }
//           
//        case .edit:
//            if sessionDetailsArr.sessionDetails![indexPath.row].isForFieldWork  {
//                return cellEditHeightForFW - 100
//            }  else {
//                return cellHeightForOthers - 100
//            }
//        }
//    }
//    
//
//
//}
//
//class MenuTCell: UITableViewCell
//{
//    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var menuIcon: UIImageView!
//    @IBOutlet weak var holderView: UIView!
//    static let identifier = "MenuTCell"
//  
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        lblName.textColor = .appTextColor
//        lblName.setFont(font: .medium(size: .SMALL))
//    }
//    
//}
//
//
//
//
//
//class WorkTypeCell: UITableViewCell {
//    @IBOutlet weak var workTypeLbl: UILabel!
//}
//
//
//
//// Given JSON string
//let jsonString = "{\"tableName\": \"savetp\",\"TPDatas\": {\"worktype_name\": \"Field Work,\",\"worktype_code\": \"3637\",\"cluster_name\": \"CHAKKARAKKAL,KELAKAM,KUTHUPARAMBA,MATTANNUR,PANOOR,\",\"cluster_code\": \"18758,20218,20221,18759,18761,\",\"DayRmk\": \"planner Remarks\",},\"dayno\": \"9\",\"TPDt\": \"2023-11-9 00:00:00\",\"TPMonth\": \"11\",\"TPYear\": \"2023\"}"
//
//
//extension MenuView : UITextFieldDelegate {
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == searchTF {
//            
//        }
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // Handle the text change
//        if let text = textField.text as NSString? {
//            let newText = text.replacingCharacters(in: range, with: string).lowercased()
//            print("New text: \(newText)")
//
//            switch self.cellType {
//                
//            case .workType:
//                var filteredWorkType = [WorkType]()
//                filteredWorkType.removeAll()
//                var isMatched = false
//                sessionDetailsArr.sessionDetails?[self.selectedSession].workType?.forEach({ workType in
//                    if workType.name!.lowercased().contains(newText) {
//                        filteredWorkType.append(workType)
//                        isMatched = true
//                        
//                    }
//                })
//                
//                if newText.isEmpty {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = self.workTypeArr
//                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    isSearched = false
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else if isMatched {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].workType = filteredWorkType
//                    isSearched = true
//                    self.noresultsView.isHidden = true
////                    self.selectAllView.isHidden = false
////                    self.selectAllHeightConst.constant = selectAllHeight
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else {
//                    print("Not matched")
//                    self.noresultsView.isHidden = false
//                    isSearched = false
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = true
//                }
//                
//                
//            case .cluster:
//                var filteredWorkType = [Territory]()
//                filteredWorkType.removeAll()
//                var isMatched = false
//                sessionDetailsArr.sessionDetails?[self.selectedSession].cluster?.forEach({ cluster in
//                    if cluster.name!.lowercased().contains(newText) {
//                        filteredWorkType.append(cluster)
//                        
//                        isMatched = true
//                    }
//                })
//                if newText.isEmpty {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].cluster = self.clusterArr
//                    self.noresultsView.isHidden = true
////                    self.selectAllView.isHidden = false
////                    self.selectAllHeightConst.constant = selectAllHeight
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    isSearched = true
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else {
//                    if isMatched {
//                        self.sessionDetailsArr.sessionDetails?[self.selectedSession].cluster = filteredWorkType
//                        isSearched = true
//                        self.noresultsView.isHidden = true
//                        self.selectAllView.isHidden = true
//                        self.selectAllHeightConst.constant = 0
//                        self.menuTable.isHidden = false
//                        self.menuTable.reloadData()
//                    } else {
//                        print("Not matched")
//                        self.noresultsView.isHidden = false
//                        isSearched = true
//                        self.selectAllView.isHidden = true
//                        self.selectAllHeightConst.constant = 0
//                        self.menuTable.isHidden = true
//                    }
//                }
//  
//            case .headQuater:
//                var filteredWorkType = [Subordinate]()
//                filteredWorkType.removeAll()
//                var isMatched = false
//                sessionDetailsArr.sessionDetails?[self.selectedSession].headQuates?.forEach({ cluster in
//                    if cluster.name!.lowercased().contains(newText) {
//                        filteredWorkType.append(cluster)
//                        
//                        isMatched = true
//                    }
//                })
//                
//                
//                if newText.isEmpty {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].headQuates = self.headQuatersArr
//                    self.noresultsView.isHidden = true
////                    self.selectAllView.isHidden = false
////                    self.selectAllHeightConst.constant = selectAllHeight
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    isSearched = false
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else if isMatched {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].headQuates = filteredWorkType
//                    isSearched = true
//                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else {
//                    print("Not matched")
//                    self.noresultsView.isHidden = false
//                    isSearched = false
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = true
//                }
//            case .jointCall:
//                var filteredWorkType = [JointWork]()
//                filteredWorkType.removeAll()
//                var isMatched = false
//                sessionDetailsArr.sessionDetails?[self.selectedSession].jointWork?.forEach({ cluster in
//                    if cluster.name!.lowercased().contains(newText) {
//                        filteredWorkType.append(cluster)
//                        
//                        isMatched = true
//                    }
//                })
//                
//                if newText.isEmpty {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].jointWork = self.jointWorkArr
//                    self.noresultsView.isHidden = true
////                    self.selectAllView.isHidden = false
////                    self.selectAllHeightConst.constant = selectAllHeight
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    isSearched = false
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else if isMatched {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].jointWork = filteredWorkType
//                    isSearched = true
//                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else {
//                    print("Not matched")
//                    self.noresultsView.isHidden = false
//                    isSearched = false
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = true
//                }
//
//            case .listedDoctor:
//                var filteredWorkType = [DoctorFencing]()
//                filteredWorkType.removeAll()
//                var isMatched = false
//                sessionDetailsArr.sessionDetails?[self.selectedSession].listedDoctors?.forEach({ cluster in
//                    if cluster.name!.lowercased().contains(newText) {
//                        filteredWorkType.append(cluster)
//                        
//                        isMatched = true
//                    }
//                })
//                
//                if newText.isEmpty {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].listedDoctors = self.listedDocArr
//                    self.noresultsView.isHidden = true
////                    self.selectAllView.isHidden = false
////                    self.selectAllHeightConst.constant = selectAllHeight
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    isSearched = false
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else if isMatched {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].listedDoctors = filteredWorkType
//                    isSearched = true
//                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else {
//                    print("Not matched")
//                    self.noresultsView.isHidden = false
//                    isSearched = false
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = true
//                }
//                
//
//            case .chemist:
//                var filteredWorkType = [Chemist]()
//                filteredWorkType.removeAll()
//                var isMatched = false
//                sessionDetailsArr.sessionDetails?[self.selectedSession].chemist?.forEach({ cluster in
//                    if cluster.name!.lowercased().contains(newText) {
//                        filteredWorkType.append(cluster)
//                        isMatched = true
//                    }
//                })
//
//                
//                if newText.isEmpty {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].chemist = self.chemistArr
//                    self.noresultsView.isHidden = true
////                    self.selectAllView.isHidden = false
////                    self.selectAllHeightConst.constant = selectAllHeight
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    isSearched = false
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else if isMatched {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].chemist = filteredWorkType
//                    isSearched = true
//                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else {
//                    print("Not matched")
//                    self.noresultsView.isHidden = false
//                    isSearched = false
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = true
//                }
//                
//            case .stockist:
//                var filteredWorkType = [Stockist]()
//                filteredWorkType.removeAll()
//                var isMatched = false
//                sessionDetailsArr.sessionDetails?[self.selectedSession].stockist?.forEach({ stockist in
//                    if stockist.name!.lowercased().contains(newText) {
//                        filteredWorkType.append(stockist)
//                        isMatched = true
//                    }
//                })
//
//                
//                if newText.isEmpty {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].stockist = self.stockistArr
//                    self.noresultsView.isHidden = true
////                    self.selectAllView.isHidden = false
////                    self.selectAllHeightConst.constant = selectAllHeight
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    isSearched = false
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else if isMatched {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].stockist = filteredWorkType
//                    isSearched = true
//                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else {
//                    print("Not matched")
//                    self.noresultsView.isHidden = false
//                    isSearched = false
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = true
//                }
//                
//                
//            case .unlistedDoctor:
//                var filteredWorkType = [UnListedDoctor]()
//                filteredWorkType.removeAll()
//                var isMatched = false
//                sessionDetailsArr.sessionDetails?[self.selectedSession].unlistedDoctors?.forEach({ newDocs in
//                    if newDocs.name!.lowercased().contains(newText) {
//                        filteredWorkType.append(newDocs)
//                        isMatched = true
//                    }
//                })
//
//                
//                if newText.isEmpty {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].unlistedDoctors = self.unlisteedDocArr
//                    self.noresultsView.isHidden = true
////                    self.selectAllView.isHidden = false
////                    self.selectAllHeightConst.constant = selectAllHeight
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    isSearched = false
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else if isMatched {
//                    self.sessionDetailsArr.sessionDetails?[self.selectedSession].unlistedDoctors = filteredWorkType
//                    isSearched = true
//                    self.noresultsView.isHidden = true
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = false
//                    self.menuTable.reloadData()
//                } else {
//                    print("Not matched")
//                    self.noresultsView.isHidden = false
//                    isSearched = false
//                    self.selectAllView.isHidden = true
//                    self.selectAllHeightConst.constant = 0
//                    self.menuTable.isHidden = true
//                }
//            default:
//                break
//            }
//            // You can update your UI or perform other actions based on the filteredArray
//        }
//
//        return true
//    }
//}
//
//
//extension MenuView: SessionInfoTVCDelegate {
//    func remarksAdded(remarksStr: String) {
//        sessionDetailsArr.sessionDetails?[selectedSession].remarks =  remarksStr
//        dump(sessionDetailsArr.sessionDetails?[selectedSession].remarks)
//        self.menuTable.reloadData()
//    }
//    
//    
//}
//


//func toSetParams(_ tourPlanArr: TourPlanArr) -> [String: Any] {
//    _ = self.menuVC.selectedDate
//    let dateArr = self.sessionDetailsArr.date?.components(separatedBy: " ") //"1 Nov 2023"
//    let anotherDateArr = self.sessionDetailsArr.dayNo?.components(separatedBy: "/") // MM/dd/yyyy - 09/12/2018
//    var param = [String: Any]()
//    param["SFCode"] = tourPlanArr.SFCode
//    param["SFName"] = tourPlanArr.SFName
//    param["Div"] = tourPlanArr.Div
//    param["Mnth"] = anotherDateArr?[0]
//    param["Yr"] = dateArr?[2]//2023
//    param["Day"] =  dateArr?[0]//1
//    param["Tour_Month"] = anotherDateArr?[0]// 11
//    param["Tour_Year"] = dateArr?[2] // 2023
//    param["tpmonth"] = dateArr?[1]// Nov
//    param["tpday"] = self.sessionDetailsArr.day// Wednesday
//    param["dayno"] = anotherDateArr?[0] // 11
//    let tpDtDate = self.sessionDetailsArr.dayNo?.replacingOccurrences(of: "/", with: "-")
//    param["TPDt"] =  tpDtDate//2023-11-01 00:00:00
//   // tourPlanArr.arrOfPlan?.enumerated().forEach { index, allDayPlans in
//
//    tourPlanArr.arrOfPlan?.enumerated().forEach { index, allDayPlans in
//        allDayPlans.sessionDetails?.enumerated().forEach { sessionIndex, session in
//           // var sessionParam = [String: Any]()
//            var index = String()
//            if sessionIndex == 0 {
//                index = ""
//            } else {
//                index = "\(sessionIndex + 1)"
//            }
//
//            var drIndex = String()
//            if sessionIndex == 0 {
//                drIndex = "_"
//            } else if sessionIndex == 1{
//                drIndex = "_two_"
//            } else if sessionIndex == 2 {
//                drIndex = "_three_"
//            }
//            param["FWFlg\(index)"] = session.FWFlg
//            param["HQCodes\(index)"] = session.HQCodes
//            param["HQNames\(index)"] = session.HQNames
//            param["WTCode\(index)"] = session.WTCode
//            param["WTName\(index)"] = session.WTName
//            param["chem\(drIndex)Code"] = session.chemCode
//            param["chem\(drIndex)Name"] = session.chemName
//            param["clusterCode\(index)"] = session.clusterCode
//            param["clusterName\(index)"] = session.clusterName
//            param["Dr\(drIndex)Code"] = session.drCode
//            param["Dr\(drIndex)Name"] = session.drName
//            param["jwCodes\(index)"] = session.jwCode
//            param["jwNames\(index)"] = session.jwName
//            param["DayRemarks\(index)"] = session.remarks
//        }
//    }
//    param["submittedTime"] = "\(Date())"
//    param["Mode"] = "Android-App"
//    param["Entry_mode"] = "Apps"
//    param["Approve_mode"] = ""
//    param["Approved_time"] = ""
//    param["app_version"] = "N 1.6.9"
//
//    let stringJSON = param.toString()
//    print(stringJSON)
//
//    return param
//}



//class SessionAPIResponseModel : Codable {
//    let div: String
//    let SFCode: String
//    let SFName: String
//    let tpData : [TPData]
//
//        enum CodingKeys: String, CodingKey {
//            case div
//            case SFCode
//            case SFName
//            case tpData
//        }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.div =  container.safeDecodeValue(forKey: .div)
//        self.SFCode =  container.safeDecodeValue(forKey: .SFCode)
//        self.SFName =  container.safeDecodeValue(forKey: .SFName)
//        self.tpData = try container.decodeIfPresent([TPData].self, forKey: .tpData) ?? [TPData]()
//    }
//
//    init() {
//        div = ""
//        SFCode = ""
//        SFName = ""
//        tpData = [TPData]()
//    }
//
//}
//
//
//class TPData: Codable {
//    let changeStatus : String
//    let date : String
//    let day : String
//    let dayNo: String
//    let entryMode : String
//    let rejectionReason: String
//    let sessions : [Sessions]
//    let submittedTime : SubmittedTime
//
//    enum CodingKeys: String, CodingKey {
//        case changeStatus
//        case date
//        case day
//        case dayNo
//        case entryMode
//        case rejectionReason
//        case sessions
//        case submittedTime
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.changeStatus = container.safeDecodeValue(forKey: .changeStatus)
//        self.date = container.safeDecodeValue(forKey: .date)
//        self.day = container.safeDecodeValue(forKey: .day)
//        self.dayNo = container.safeDecodeValue(forKey: .dayNo)
//        self.entryMode = container.safeDecodeValue(forKey: .entryMode)
//        self.rejectionReason = container.safeDecodeValue(forKey: .rejectionReason)
//        self.sessions = try container.decodeIfPresent([Sessions].self, forKey: .sessions) ?? [Sessions]()
//        self.submittedTime = try container.decodeIfPresent(SubmittedTime.self, forKey: .submittedTime) ?? SubmittedTime()
//    }
//
//    init() {
//        changeStatus = ""
//        date = ""
//        day = ""
//        dayNo = ""
//        entryMode = ""
//        rejectionReason = ""
//        sessions = [Sessions]()
//        submittedTime = SubmittedTime()
//    }
//
//}
//
//
//class SubmittedTime: Codable {
//    let date : String
//    let timezone : String
//    let timezone_type : String
//
//    enum CodingKeys: String, CodingKey {
//        case date
//        case timezone
//        case timezone_type
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.date = container.safeDecodeValue(forKey: .date)
//        self.timezone = container.safeDecodeValue(forKey: .timezone)
//        self.timezone_type = container.safeDecodeValue(forKey: .timezone_type)
//    }
//
//    init() {
//
//        date = ""
//        timezone = ""
//        timezone_type = ""
//    }
//
//
//}
//
//class Sessions: Codable {
//    let FWFlg : String
//    let HQCodes : String
//    let HQNames : String
//    let WTCode : String
//    let WTName : String
//    let chemCode : String
//    let chemName : String
//    let cipCode : String
//    let cipName : String
//    let clusterCode : String
//    let clusterName : String
//    let drCode : String
//    let drName : String
//    let hospCode : String
//    let hospName : String
//    let jwCode : String
//    let jwName : String
//    let remarks : String
//    let stockistCode : String
//    let stockistName : String
//    let unListedDrCode : String
//    let unListedDrName : String
//
//    enum CodingKeys: String, CodingKey {
//        case FWFlg
//        case HQCodes
//        case HQNames
//        case WTCode
//        case WTName
//        case chemCode
//        case chemName
//        case cipCode
//        case cipName
//        case clusterCode
//        case clusterName
//        case drCode
//        case drName
//        case hospCode
//        case hospName
//        case jwCode
//        case jwName
//        case remarks
//        case stockistCode
//        case stockistName
//        case unListedDrCode
//        case unListedDrName
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.FWFlg = container.safeDecodeValue(forKey: .FWFlg)
//        self.HQCodes = container.safeDecodeValue(forKey: .HQCodes)
//        self.HQNames = container.safeDecodeValue(forKey: .HQNames)
//        self.WTCode = container.safeDecodeValue(forKey: .WTCode)
//        self.WTName = container.safeDecodeValue(forKey: .WTName)
//        self.chemCode = container.safeDecodeValue(forKey: .chemCode)
//        self.chemName = container.safeDecodeValue(forKey: .chemName)
//        self.cipCode = container.safeDecodeValue(forKey: .cipCode)
//        self.cipName = container.safeDecodeValue(forKey: .cipName)
//        self.clusterCode = container.safeDecodeValue(forKey: .clusterCode)
//        self.clusterName = container.safeDecodeValue(forKey: .clusterName)
//        self.drCode = container.safeDecodeValue(forKey: .drCode)
//        self.drName = container.safeDecodeValue(forKey: .drName)
//        self.hospCode = container.safeDecodeValue(forKey: .hospCode)
//        self.hospName = container.safeDecodeValue(forKey: .hospName)
//        self.jwCode = container.safeDecodeValue(forKey: .jwCode)
//        self.jwName = container.safeDecodeValue(forKey: .jwName)
//        self.remarks = container.safeDecodeValue(forKey: .remarks)
//        self.stockistCode = container.safeDecodeValue(forKey: .stockistCode)
//        self.stockistName = container.safeDecodeValue(forKey: .stockistName)
//        self.unListedDrCode = container.safeDecodeValue(forKey: .unListedDrCode)
//        self.unListedDrName = container.safeDecodeValue(forKey: .unListedDrName)
//    }
//
//    init() {
//        FWFlg = ""
//        HQCodes = ""
//        HQNames = ""
//        WTCode = ""
//        WTName = ""
//        chemCode = ""
//        chemName = ""
//        cipCode = ""
//        cipName = ""
//        clusterCode = ""
//        clusterName = ""
//        drCode = ""
//        drName = ""
//        hospCode = ""
//        hospName = ""
//        jwCode = ""
//        jwName = ""
//        remarks = ""
//        stockistCode = ""
//        stockistName = ""
//        unListedDrCode = ""
//        unListedDrName = ""
//    }
//
//}


//func toUploadUndavedData(_ unSavedPlans: [SessionDetailsArr], _ unsentIndices: [Int], isFirstTimeLoad: Bool) {
//    if unSavedPlans.count > 0 {
//        self.toSetParams(unSavedPlans) {
//            responseResult in
//            switch responseResult {
//            case .success(let responseJSON):
//                dump(responseJSON)
//                
//                unsentIndices.forEach { index in
//                    unSavedPlans[index].isDataSentToApi = true
//                }
//                
//                var temptpArray = [TourPlanArr]()
//                
//                AppDefaults.shared.eachDatePlan.tourPlanArr?.forEach {  eachDayPlan in
//                    temptpArray.append(eachDayPlan)
//                }
//                
//                temptpArray.forEach({ tpArr in
//                    tpArr.arrOfPlan =  unSavedPlans
//                })
//            
//                AppDefaults.shared.eachDatePlan.tourPlanArr = temptpArray
//                            let savefinish = NSKeyedArchiver.archiveRootObject(AppDefaults.shared.eachDatePlan, toFile: EachDatePlan.ArchiveURL.path)
//                                 if !savefinish {
//                                     print("Error")
//                                 }
//                if isFirstTimeLoad {
//                    self.fetchDataFromServer()
//                }
//                
//               // self.toLoadData()
//            case .failure(_):
//                self.toCreateToast("The operation couldn’t be completed. Try again later")
//                if isFirstTimeLoad {
//                        self.initialSetups()
//                    self.isHidden = false
//                
//                   
//                }
//              
//            }
//        }
//    } else {
//        self.toCreateToast("Already this month plans are submited for approval.")
//    }
//    
//    
//}

//func unarchiveAndGetData(from zipData: Data) -> HTMLinfo {
//    // Create a temporary directory to extract the files
//    guard let temporaryDirectoryURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("MyAppTemp") else {
//        print("Error creating a temporary directory.")
//        return HTMLinfo()
//    }
//    
//    // Create the directory for extracting the contents
//    let extractionDirectory = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString)
//    
//    // Ensure that the directory exists
//    do {
//        try FileManager.default.createDirectory(at: extractionDirectory, withIntermediateDirectories: true, attributes: nil)
//    } catch {
//        print("Error creating extraction directory: \(error.localizedDescription)")
//        return HTMLinfo()
//    }
//    
//    // Create the path for the temporary zip file
//    let tempZipFilePath = extractionDirectory.appendingPathComponent("temp.zip").path
//    
//    // Write the zip data to a temporary file
//    do {
//        try zipData.write(to: URL(fileURLWithPath: tempZipFilePath), options: .atomic)
//    } catch {
//        print("Error writing zip data to a temporary file: \(error)")
//        return HTMLinfo()
//    }
//    
//    
//    // Ensure that the directory exists
//    do {
//        try FileManager.default.createDirectory(at: extractionDirectory, withIntermediateDirectories: true, attributes: nil)
//    } catch {
//        print("Error creating extraction directory: \(error.localizedDescription)")
//        return HTMLinfo()
//    }
//    
//    // Unarchive the zip data
//    // Unarchive the zip data
//    guard SSZipArchive.unzipFile(atPath: tempZipFilePath, toDestination: extractionDirectory.path) else {
//        print("Error unzipping data")
//        return HTMLinfo()
//    }
//    
//    // Get the list of files in the extraction directory
//        do {
//            let fileURLs = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: extractionDirectory.path), includingPropertiesForKeys: nil, options: [])
//            
//            // Convert URLs to paths without /private prefix
//            let fileURLsFromPaths = fileURLs.map { $0.path }
//            
//            // Convert URLs to strings without /private prefix
//            let fileURLStrings = fileURLs.map { $0.absoluteString }
//            
//            // Read data from each file
//            var aHTMLinfo = HTMLinfo()
//            var dataArray: Data = Data()
//            for fileURL in fileURLsFromPaths {
//                guard FileManager.default.fileExists(atPath: fileURL) else {
//                    print("File does not exist at path: \(fileURL)")
//                    continue
//                }
//                
//                let pathurl =  URL(fileURLWithPath: fileURL)
//                let fileNameWithoutExtension = pathurl.deletingPathExtension().lastPathComponent
//                print("File Name (without extension): \(fileNameWithoutExtension)")
//                let result: (htmlString: String?, htmlFileURL: URL?) = readHTMLFile(inDirectory: fileURL)
//                extractedFileName = fileNameWithoutExtension
//                dataArray = findImageData(inDirectory: pathurl) ?? Data()
//                
//                
//                aHTMLinfo.fileData = dataArray
//                aHTMLinfo.htmlFileURL = extractionDirectory
//                aHTMLinfo.htmlString = result.htmlString
//                
//            }
//            // Remove the temporary files and directory
//            do {
//                try FileManager.default.removeItem(atPath: tempZipFilePath)
//                try FileManager.default.removeItem(atPath: extractionDirectory.path)
//            } catch {
//                print("Error removing temporary files or directory: \(error.localizedDescription)")
//            }
//            return aHTMLinfo
//        } catch {
//            print("Error listing files in extraction directory: \(error.localizedDescription)")
//            return HTMLinfo()
//        }
//    
//}
