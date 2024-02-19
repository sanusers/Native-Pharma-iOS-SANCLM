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
    

}

extension MainVC {
    func toFetchExistingPlan() -> [Sessions]{
      let todayPlans =  CoreDataManager.shared.retriveSavedDayPlans()
        var aDaysessions : [Sessions] = []
        if !todayPlans.isEmpty {
            if let eachDayPlan = todayPlans.first {
                
                
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
                    let codesArray = codes.components(separatedBy: ",")
                    
                    let filteredTerritories = clusterArr.filter { aTerritory in
                        // Check if any code in codesArray is contained in aTerritory
                        return codesArray.contains { code in
                            return aTerritory.code?.contains(code) ?? false
                        }
                    }
                    selectedterritories = filteredTerritories
                    
                    workTypeArr.forEach { aWorkType in
                        if aWorkType.fwFlg == eachDayPlan.fwFlg  {
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
                            
                            CoreDataManager.shared.removeHQ()
                            
                            CoreDataManager.shared.saveToHQCoreData(hqModel: hqModel) { isSaved in
                                if isSaved {
                                    CoreDataManager.shared.fetchSavedHQ { selectedHQArr in
                                        let aSavedHQ = selectedHQArr.first
                                        selectedheadQuarters = aSavedHQ
                                    }
                                }
                            }
                            
                            
                         
                        }
                        
                    }
                    
                    let tempSession = Sessions(cluster: selectedterritories ?? [temporaryselectedClusterobj], workType: selectedWorkTypes ?? temporaryselectedWTobj, headQuarters: selectedheadQuarters ?? temporaryselectedHqobj, isRetrived: true)
                  
                  
                    aDaysessions.append(tempSession)
                }
                
                if eachDayPlan.fwFlg2 != "" || eachDayPlan.wtCode2 != "" || eachDayPlan.townCode2 != "" || eachDayPlan.location2 != ""  {
                   
                    var selectedterritories: [Territory]?
                    var selectedheadQuarters : SelectedHQ?
                    var selectedWorkTypes: WorkType?
                    let codes = eachDayPlan.townCode
                    let codesArray = codes.components(separatedBy: ",")
                    
                    let filteredTerritories = clusterArr.filter { aTerritory in
                        // Check if any code in codesArray is contained in aTerritory
                        return codesArray.contains { code in
                            return aTerritory.code?.contains(code) ?? false
                        }
                    }
                    selectedterritories = filteredTerritories
                    
                    workTypeArr.forEach { aWorkType in
                        if aWorkType.fwFlg == eachDayPlan.fwFlg  {
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
                            
                            CoreDataManager.shared.removeHQ()
                            
                            CoreDataManager.shared.saveToHQCoreData(hqModel: hqModel) { isSaved in
                                if isSaved {
                                    CoreDataManager.shared.fetchSavedHQ { selectedHQArr in
                                        let aSavedHQ = selectedHQArr.first
                                        selectedheadQuarters = aSavedHQ
                                    }
                                }
                            }
                        }
                        
                    }
                    let tempSession = Sessions(cluster: selectedterritories ?? [temporaryselectedClusterobj], workType: selectedWorkTypes ?? temporaryselectedWTobj, headQuarters: selectedheadQuarters ?? temporaryselectedHqobj, isRetrived: true)
                  //selectedheadQuarters ?? SelectedHQ()
                    aDaysessions.append(tempSession)
                }
            }
        }
        return aDaysessions
    }

}
