//
//  MainVC + DayPlanEX.swift
//  E-Detailing
//
//  Created by San eforce on 17/02/24.
//

import Foundation
import CoreData

class DayPlanSessions {
    var worktype: WorkType
    var headQuarters: SelectedHQ
    var cluster: [Territory]
    var isSavedSession: Bool

    init() {
        worktype = WorkType()
        headQuarters = SelectedHQ()
        cluster = [Territory]()
        isSavedSession = false
       
    }
}

struct Sessions {
    var cluster : [Territory]?
    var workType: WorkType?
    var headQuarters: SelectedHQ?
    var isRetrived : Bool?
    var  remarks : String?
    var isRejected: Bool?
    var rejectionReason: String?
    var isFirstCell : Bool?
}

extension MainVC {
    
    func callSavePlanAPI() {
        let dayEntities = CoreDataManager.shared.retriveSavedDayPlans()
         
        
         
        let aDayplan = dayEntities.first
         
         do {
             let encoder = JSONEncoder()
             let jsonData = try encoder.encode(aDayplan)
             

             if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                 print("JSON Dictionary: \(jsonObject)")
                 
                 var toSendData = [String: Any]()
                 
                 let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: jsonObject)
                 
                 toSendData["data"] = jsonDatum
                 
                 
                 userststisticsVM?.saveMyDayPlan(params: toSendData, api: .myDayPlan, paramData: jsonObject, { [ weak self ] result in
                     guard let welf = self else {return}
                     switch result {
                         
                     case .success(let response):
                         dump(response)
                         
                         guard var nonNilSession = welf.sessions else {
                             return
                         }
                         nonNilSession.indices.forEach { index in
                             nonNilSession[index].isRetrived = true
                         }
                         
//                         CoreDataManager.shared.removeAllDayPlans()
//                         CoreDataManager.shared.saveSessionAsEachDayPlan(session: nonNilSession) { isSaved in
//                             print("Day session successfully saved to core data")
//                             welf.sessions =  welf.toFetchExistingPlan()
//                             welf.toLoadWorktypeTable()
//
//                         }
                         welf.masterVM?.toGetMyDayPlan(type: .myDayPlan) {_ in
                             welf.toLoadWorktypeTable()
                             welf.configureAddplanBtn(true, isSessionSaved: true)
                             welf.configureSaveplanBtn(false)
                             welf.toCreateToast(response.msg ?? "")
                         }
                     case .failure(let error):
                         welf.toCreateToast(error.localizedDescription)
                     }
                     
                 })
                 
                 
                 
             } else {
                 print("Failed to convert data to JSON dictionary")
             }
             
             
             // jsonData now contains the JSON representation of yourObject
         } catch {
             print("Error encoding object to JSON: \(error)")
         }
    }
    
    func updatePlansToCoreData() {
        
    }
    
    func toFetchExistingPlan(completion: @escaping ([Sessions]) -> ())  {
    
      let todayPlans =  CoreDataManager.shared.retriveSavedDayPlans()
        var aDaysessions : [Sessions] = []
        if !todayPlans.isEmpty {
            if let eachDayPlan = todayPlans.first {
                
                //                CoreDataManager.shared.removeAllDayPlans()
                //                CoreDataManager.shared.toSaveDayPlan(aDayPlan: eachDayPlan) { isComleted in
                //                    if isComleted {
                //                        self.toCreateToast("Saved successfully")
                //                    }
                //                }
                
                let clusterArr = DBManager.shared.getTerritory()
                let headQuatersArr =  DBManager.shared.getSubordinate()
                let workTypeArr = DBManager.shared.getWorkType()
                
                
                guard let selectedHqentity = NSEntityDescription.entity(forEntityName: "SelectedHQ", in: context),
                      let selectedWTentity = NSEntityDescription.entity(forEntityName: "WorkType", in: context),
                      let selectedClusterentity = NSEntityDescription.entity(forEntityName: "Territory", in: context)
                else {
                    fatalError("Entity not found")
                }
                
                let temporaryselectedHqobj = NSManagedObject(entity: selectedHqentity, insertInto: nil)  as! SelectedHQ
                let temporaryselectedWTobj = NSManagedObject(entity: selectedWTentity, insertInto: nil)  as! WorkType
                let temporaryselectedClusterobj = NSManagedObject(entity: selectedClusterentity, insertInto: nil)  as! Territory
                
                
                if eachDayPlan.fwFlg != "" || eachDayPlan.wtCode != "" || eachDayPlan.townCode != "" || eachDayPlan.location != ""  {
                    
                    var selectedterritories: [Territory]?
                    var selectedheadQuarters : SelectedHQ?
                    var selectedWorkTypes: WorkType?
                    let codes = eachDayPlan.townCode
                    let codesArray = codes.components(separatedBy: ", ")
                    
                    let filteredTerritories = clusterArr.filter { aTerritory in
                        // Check if any code in codesArray is contained in aTerritory
                        return codesArray.contains { code in
                            return aTerritory.code?.contains(code) ?? false
                        }
                    }
                    selectedterritories = filteredTerritories
                    
                    
//                    if selectedterritories?.count == 0 {
//
//                        dispatchGroup.enter()
//                        LocalStorage.shared.setSting(LocalStorage.LocalValue.rsfID, text: eachDayPlan.rsf)
//                        masterVM?.fetchMasterData(type: MasterInfo.clusters, sfCode: eachDayPlan.rsf, istoUpdateDCRlist: false) { response in
//                            switch response.result {
//                            case .success(let data):
//                                do {
//                                    let apiResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
//                                    print(apiResponse)
//
//                                    if let jsonObjectresponse = apiResponse as? [[String: Any]] {
//                                        DBManager.shared.saveMasterData(type: .clusters, Values: jsonObjectresponse,id: eachDayPlan.rsf2)
//                                    }
//
//
//                                    let updatedclusterArr = DBManager.shared.getTerritory()
//
//                                    let filteredTerritories = updatedclusterArr.filter { aTerritory in
//                                        // Check if any code in codesArray is contained in aTerritory
//                                        return codesArray.contains { code in
//                                            return aTerritory.code?.contains(code) ?? false
//                                        }
//                                    }
//                                    selectedterritories = filteredTerritories
//
//
//                                } catch {
//                                    print("Error decoding JSON: \(error)")
//                                    // Handle the error here if needed
//                                }
//                            case .failure(let error):
//                                print("API request failed with error: \(error)")
//                                // Handle the error here if needed
//                            }
//
//                        }
//                        self.dispatchGroup.leave()
//                    }
                    
                    workTypeArr.forEach { aWorkType in
                        if aWorkType.code == eachDayPlan.wtCode  {
                            selectedWorkTypes = aWorkType
                        }
                    }
                    
                    headQuatersArr.forEach { aheadQuater in
                        if aheadQuater.id == eachDayPlan.rsf  {
                            
                            let hqModel =   HQModel()
                            hqModel.code = aheadQuater.id ?? ""
                            hqModel.name = aheadQuater.name ?? ""
                            hqModel.reportingToSF = aheadQuater.reportingToSF ?? ""
                            hqModel.steps = aheadQuater.steps ?? ""
                            hqModel.sfHQ = aheadQuater.sfHq ?? ""
                            hqModel.mapId = aheadQuater.mapId ?? ""
                            
                            //                            CoreDataManager.shared.removeHQ()
                            //
                            //                            CoreDataManager.shared.saveToHQCoreData(hqModel: hqModel) { isSaved in
                            //                                if isSaved {
                            //                                    CoreDataManager.shared.fetchSavedHQ { selectedHQArr in
                            //                                        let aSavedHQ = selectedHQArr.first
                            //                                        selectedheadQuarters = aSavedHQ
                            //                                    }
                            //                                }
                            //                            }
                            guard let selectedHqentity = NSEntityDescription.entity(forEntityName: "SelectedHQ", in: context)
                                    
                            else {
                                fatalError("Entity not found")
                            }
                            
                            let temporaryselectedHqobj = NSManagedObject(entity: selectedHqentity, insertInto: nil)  as! SelectedHQ
                            
                            temporaryselectedHqobj.code                  = hqModel.code
                            temporaryselectedHqobj.name                 = hqModel.name
                            temporaryselectedHqobj.reportingToSF       = hqModel.reportingToSF
                            temporaryselectedHqobj.steps                 = hqModel.steps
                            temporaryselectedHqobj.sfHq                   = hqModel.sfHQ
                            temporaryselectedHqobj.mapId                  = hqModel.mapId
                            
                            selectedheadQuarters   = temporaryselectedHqobj
                            
                            
                        }
                        
                    }
                    
                    let resultSet = CoreDataManager.shared.convertClustersToCDM(selectedterritories ?? [temporaryselectedClusterobj], context: context)
                    
                    
                    let convertedTerritories = resultSet.allObjects as? [Territory] ?? []
                    
                    self.cacheTerritory = convertedTerritories
                    
                    
                    
                    let tempSession = Sessions(cluster: selectedterritories ?? [temporaryselectedClusterobj], workType: selectedWorkTypes ?? temporaryselectedWTobj, headQuarters: selectedheadQuarters ?? temporaryselectedHqobj, isRetrived: true)
                    
                    
                    aDaysessions.append(tempSession)
                }
                
                if eachDayPlan.fwFlg2 != "" || eachDayPlan.wtCode2 != "" || eachDayPlan.townCode2 != "" || eachDayPlan.location2 != ""  {
                    
                    var selectedterritories: [Territory]?
                    var selectedheadQuarters : SelectedHQ?
                    var selectedWorkTypes: WorkType?
                    let codes = eachDayPlan.townCode2
                    let codesArray = codes.components(separatedBy: ", ")
                    
                    let filteredTerritories = clusterArr.filter { aTerritory in
                        // Check if any code in codesArray is contained in aTerritory
                        return codesArray.contains { code in
                            return aTerritory.code?.contains(code) ?? false
                        }
                    }
                    selectedterritories = filteredTerritories
                    
//                    if selectedterritories?.count == 0 {
//                        LocalStorage.shared.setSting(LocalStorage.LocalValue.rsfID, text: eachDayPlan.rsf)
//                        dispatchGroup.enter()
//
//                        masterVM?.fetchMasterData(type: MasterInfo.clusters, sfCode: eachDayPlan.rsf, istoUpdateDCRlist: false) { response in
//                            switch response.result {
//                            case .success(let data):
//                                do {
//                                    let apiResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
//                                    print(apiResponse)
//
//                                    if let jsonObjectresponse = apiResponse as? [[String: Any]] {
//                                        DBManager.shared.saveMasterData(type: .clusters, Values: jsonObjectresponse,id: eachDayPlan.rsf2)
//                                    }
//
//                                    let updatedclusterArr = DBManager.shared.getTerritory()
//
//                                    let filteredTerritories = updatedclusterArr.filter { aTerritory in
//                                        // Check if any code in codesArray is contained in aTerritory
//                                        return codesArray.contains { code in
//                                            return aTerritory.code?.contains(code) ?? false
//                                        }
//                                    }
//                                    selectedterritories = filteredTerritories
//
//
//
//                                } catch {
//                                    print("Error decoding JSON: \(error)")
//                                    // Handle the error here if needed
//                                }
//                            case .failure(let error):
//                                print("API request failed with error: \(error)")
//                                // Handle the error here if needed
//                            }
//
//                        }
//
//                        self.dispatchGroup.leave()
//                    }
                
            
                    
                    
                    workTypeArr.forEach { aWorkType in
                        if aWorkType.code == eachDayPlan.wtCode2  {
                            selectedWorkTypes = aWorkType
                        }
                    }
                    
                    headQuatersArr.forEach { aheadQuater in
                        if aheadQuater.id == eachDayPlan.rsf2  {
                            
                         let hqModel =   HQModel()
                            hqModel.code = aheadQuater.id ?? ""
                            hqModel.name = aheadQuater.name ?? ""
                            hqModel.reportingToSF = aheadQuater.reportingToSF ?? ""
                            hqModel.steps = aheadQuater.steps ?? ""
                            hqModel.sfHQ = aheadQuater.sfHq ?? ""
                            hqModel.mapId = aheadQuater.mapId ?? ""
                            
                            
                            guard let selectedHqentity = NSEntityDescription.entity(forEntityName: "SelectedHQ", in: context)
                       
                            else {
                                fatalError("Entity not found")
                            }

                            let temporaryselectedHqobj = NSManagedObject(entity: selectedHqentity, insertInto: nil)  as! SelectedHQ
                   
                            temporaryselectedHqobj.code                  = hqModel.code
                            temporaryselectedHqobj.name                 = hqModel.name
                            temporaryselectedHqobj.reportingToSF       = hqModel.reportingToSF
                            temporaryselectedHqobj.steps                 = hqModel.steps
                            temporaryselectedHqobj.sfHq                   = hqModel.sfHQ
                            temporaryselectedHqobj.mapId                  = hqModel.mapId
                        
                            selectedheadQuarters   = temporaryselectedHqobj
                            
                            
//                            CoreDataManager.shared.removeHQ()
//
//                            CoreDataManager.shared.saveToHQCoreData(hqModel: hqModel) { isSaved in
//                                if isSaved {
//                                    CoreDataManager.shared.fetchSavedHQ { selectedHQArr in
//                                        let aSavedHQ = selectedHQArr.first
//                                        selectedheadQuarters = aSavedHQ
//
//                                    }
//                                }
//                            }
                        }
                        
                    }
                    let tempSession = Sessions(cluster: selectedterritories ?? [temporaryselectedClusterobj], workType: selectedWorkTypes ?? temporaryselectedWTobj, headQuarters: selectedheadQuarters ?? temporaryselectedHqobj, isRetrived: true)
                  //selectedheadQuarters ?? SelectedHQ()
                    aDaysessions.append(tempSession)
                }
            }
        }
        
        
       // dispatchGroup.notify(queue: .main) {
            completion(aDaysessions)
      //  }
            
        
    }

}
