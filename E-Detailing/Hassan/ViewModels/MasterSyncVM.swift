//
//  MasterSyncVM.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 15/02/24.
//

import Foundation
import Alamofire

enum MasterSyncErrors: String, Error {
case unableConnect = "An issue occured data will be saved to device"
}

class MasterSyncVM {
    
    var isUpdated: [MasterInfo] = []
    var isUpdating: Bool = false
    var isSyncCompleted: Bool = false
    let appsetup = AppDefaults.shared.getAppSetUp()
    var getRSF: String? {
    
        let rsfIDPlan1 = LocalStorage.shared.getString(key: LocalStorage.LocalValue.rsfIDPlan1)
        let rsfIDPlan2 = LocalStorage.shared.getString(key: LocalStorage.LocalValue.rsfIDPlan2)

        if !rsfIDPlan1.isEmpty {
            return rsfIDPlan1
        } else if !rsfIDPlan2.isEmpty {
            return rsfIDPlan2
        } else {
            return "\(appsetup.sfCode!)"
        }
    }
    
    var mapID: String?
    
    func toGetMyDayPlan(type: MasterInfo, completion: @escaping (Result<[MyDayPlanResponseModel],MasterSyncErrors>) -> ()) {
        
 
        let date = Date().toString(format: "yyyy-MM-dd 00:00:00")
        var param = [String: Any]()
        
        
//    http://edetailing.sanffa.info/iOSServer/db_api.php/?axn=table/dcrmasterdata
//    {"tableName":"getmydayplan","sfcode":"MGR0941","division_code":"63,","Rsf":"MGR0941","sf_type":"2","Designation":"MGR","state_code":"13","subdivision_code":"86,","ReqDt":"2024-02-15 15:27:16"}
        
        param["tableName"] = "getmydayplan"
        param["ReqDt"] = date
        param["sfcode"] = "\(appsetup.sfCode!)"
        param["division_code"] = "\(appsetup.divisionCode!)"

       // let rsf = LocalStorage.shared.getString(key: LocalStorage.LocalValue.rsfIDPlan1)
        param["Rsf"] = getRSF
        param["sf_type"] = "\(appsetup.sfType!)"
        param["Designation"] = "\(appsetup.dsName!)"
        param["state_code"] = "\(appsetup.stateCode!)"
        param["subdivision_code"] = "\(appsetup.subDivisionCode!)"
         
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        
        self.getTodayPlans(params: toSendData, api: .masterData, paramData: param, {[weak self] result in
            guard let welf = self else {return}
            switch result {
                
            case .success(let model):
                dump(model)
                welf.toUpdateDataBase(aDayplan: welf.toConvertResponseToDayPlan(model: model))
                
            case .failure(let error):
                print(error)
            }
            
            completion(result)
        })
        
    }
    
    func toUpdateDataBase(aDayplan: DayPlan) {
        CoreDataManager.shared.removeAllDayPlans()
        CoreDataManager.shared.toSaveDayPlan(aDayPlan: aDayplan) { isComleted in
            if isComleted {
               // self.toCreateToast("Saved successfully")

                let dayPlans = CoreDataManager.shared.retriveSavedDayPlans()
            
                dump(dayPlans)
            } else {
                
            }
        }
    }
    
    func toConvertResponseToDayPlan(model: [MyDayPlanResponseModel]) -> DayPlan  {
        let aDayPlan = DayPlan()
        let userConfig = AppDefaults.shared.getAppSetUp()
        aDayPlan.tableName = "gettodaytpnew"
        aDayPlan.uuid = UUID()
        aDayPlan.divisionCode = userConfig.divisionCode
        aDayPlan.sfType = "\(userConfig.sfType!)"
        aDayPlan.designation = "\(userConfig.desig!)"
        aDayPlan.stateCode = "\(userConfig.stateCode!)"
        aDayPlan.subdivisionCode = userConfig.subDivisionCode
        model.enumerated().forEach {index, aMyDayPlanResponseModel in
            switch index {
            case 0:
                aDayPlan.sfcode = aMyDayPlanResponseModel.SFCode
                aDayPlan.rsf = aMyDayPlanResponseModel.SFMem
                LocalStorage.shared.setSting(LocalStorage.LocalValue.rsfIDPlan1, text: aMyDayPlanResponseModel.SFMem)
                LocalStorage.shared.setSting(LocalStorage.LocalValue.selectedRSFID, text: aMyDayPlanResponseModel.SFMem)
                aDayPlan.wtCode = aMyDayPlanResponseModel.WT
                aDayPlan.wtName = aMyDayPlanResponseModel.WTNm
                aDayPlan.fwFlg = aMyDayPlanResponseModel.FWFlg
                aDayPlan.townCode = aMyDayPlanResponseModel.Pl
                aDayPlan.townName = aMyDayPlanResponseModel.PlNm
            case 1:
                aDayPlan.sfcode = aMyDayPlanResponseModel.SFCode
                aDayPlan.rsf2 = aMyDayPlanResponseModel.SFMem
                LocalStorage.shared.setSting(LocalStorage.LocalValue.rsfIDPlan2, text: aMyDayPlanResponseModel.SFMem)
                LocalStorage.shared.setSting(LocalStorage.LocalValue.selectedRSFID, text: aMyDayPlanResponseModel.SFMem)
                aDayPlan.wtCode2 = aMyDayPlanResponseModel.WT
                aDayPlan.wtName2 = aMyDayPlanResponseModel.WTNm
                aDayPlan.fwFlg2 = aMyDayPlanResponseModel.FWFlg
                aDayPlan.townCode2 = aMyDayPlanResponseModel.Pl
                aDayPlan.townName2 = aMyDayPlanResponseModel.PlNm
                
                
            default:
                print("Yet to implement")
            }
        }
        

      
        return aDayPlan
        
    }
    
    
    func fetchMasterData(type: MasterInfo, sfCode: String, istoUpdateDCRlist: Bool, mapID: String, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        dump(type.getUrl)
        dump(type.getParams)

        AF.request(type.getUrl, method: .post, parameters: type.getParams).responseData { [weak self] (response) in
            guard let welf = self else { return }

            switch response.result {
            case .success(_):
                guard let apiResponse = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [[String: Any]] else {
                    print("Unable to serialize")
                    completionHandler(response)
                    return
                }

                print(apiResponse)
                // Save to Core Data or perform any other actions
                DBManager.shared.saveMasterData(type: type, Values: apiResponse, id: mapID)

                if istoUpdateDCRlist && !welf.isUpdating {
                    welf.updateDCRLists(mapID: mapID) { _ in
                        completionHandler(response)
                    }
                } else   {
                    completionHandler(response)
                }

            case .failure(let error):
                completionHandler(response)
                print(error)
            }
        }
    }
    
//    func fetchMasterData(type : MasterInfo, sfCode: String, istoUpdateDCRlist : Bool, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
//        dump(type.getUrl)
//        dump(type.getParams)
//            AF.request(type.getUrl,method: .post,parameters: type.getParams).responseData(){[weak self] (response) in
//                guard let welf = self else {return}
//                switch response.result {
//                case .success(_):
//                    do {
//                        if  let apiResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [[String: Any]] {
//                            print(apiResponse)
//                            // Save to Core Data or perform any other actions
//                            DBManager.shared.saveMasterData(type: type, Values: apiResponse, id: sfCode)
//                        }
//
//
//                    } catch {
//                        print("Unable to serialize")
//                    }
//                    if istoUpdateDCRlist {
//
//
//
//                        if !welf.isUpdating {
//                            welf.updateDCRLists() { _ in
//
//                                    completionHandler(response)
//
//                            }
//                        }
//                    } else {
//                        completionHandler(response)
//                    }
//                case .failure(let error):
//                    completionHandler(response)
//                print(error)
//                }
//
//
//            }
//    }
    
 
    
    
    func updateDCRLists(mapID: String, completion: @escaping (Bool) -> ()) {
        let dispatchgroup = DispatchGroup()
        isUpdating = true
        let dcrEntries : [MasterInfo] = [.doctorFencing, .chemists, .unlistedDoctors, .stockists]
        
        
        //Doctor,Chemist,Stokiest,Unlistered,Cip,Hospital,Cluste
     
        dcrEntries.forEach { aMasterInfo in
            dispatchgroup.enter()
            
            fetchMasterData(type: aMasterInfo, sfCode: getRSF ?? "", istoUpdateDCRlist: true, mapID: mapID) { _ in
                print("Syncing \(aMasterInfo.rawValue)")
               
               dispatchgroup.leave()
                
            }
        }
        
        dispatchgroup.notify(queue: .main) {
            // All async tasks are completed
            self.isUpdating = false
            self.isSyncCompleted = true
            print("DCR list sync completed")
            completion(true)
       
        }
        
    }
    
    func getTodayPlans(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<[MyDayPlanResponseModel],MasterSyncErrors>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: [MyDayPlanResponseModel].self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(MasterSyncErrors.unableConnect))
        })
    }
    
    
}
