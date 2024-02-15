//
//  MasterSyncVC + DayPlanEX.swift
//  E-Detailing
//
//  Created by San eforce on 15/02/24.
//

import Foundation
import CoreData


extension MasterSyncVC {
    func toGetMyDayPlan(type: MasterInfo) {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        let date = Date().toString(format: "yyyy-MM-dd 00:00:00")
        var param = [String: Any]()
        
        
        param["tableName"] = "gettodaytpnew"
        param["ReqDt"] = date
        param["sfcode"] = "\(appsetup.sfCode!)"
        param["division_code"] = "\(appsetup.divisionCode!)"
        param["Rsf"] = "\(appsetup.sfCode!)"
        param["sf_type"] = "\(appsetup.sfType!)"
        param["Designation"] = "\(appsetup.dsName!)"
        param["state_code"] = "\(appsetup.stateCode!)"
        param["subdivision_code"] = "\(appsetup.subDivisionCode!)"
        
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        
        mastersyncVM?.getTodayPlans(params: toSendData, api: .masterData, paramData: param, {[weak self] result in
            guard let welf = self else {return}
            switch result {
                
            case .success(let model):
                dump(model)
                welf.toUpdateDataBase(aDayplan: welf.toConvertResponseToDayPlan(model: model))
            case .failure(let error):
                print(error)
            }
        })
        
    }
    
    
    func toConvertResponseToDayPlan(model: [MyDayPlanResponseModel]) -> DayPlan  {
        let aDayPlan = DayPlan()
        let userConfig = AppDefaults.shared.getAppSetUp()
        let aDayResponseModel = model.first
        aDayPlan.tableName = "gettodaytpnew"
        aDayPlan.sfcode = aDayResponseModel?.SFCode ?? ""
        aDayPlan.divisionCode = userConfig.divisionCode
        aDayPlan.rsf = userConfig.sfCode
        aDayPlan.sfType = "\(userConfig.sfType!)"
        aDayPlan.designation = "\(userConfig.desig!)"
        aDayPlan.stateCode = "\(userConfig.stateCode!)"
        aDayPlan.subdivisionCode = userConfig.subDivisionCode
        aDayPlan.wtCode = aDayResponseModel?.WT ?? ""
        aDayPlan.wtName = aDayResponseModel?.WTNm ?? ""
        aDayPlan.fwFlg = aDayResponseModel?.FWFlg ?? ""
        aDayPlan.townCode = aDayResponseModel?.Pl ?? ""
        aDayPlan.townName = aDayResponseModel?.PlNm ?? ""
        aDayPlan.rsf = aDayResponseModel?.SFMem ?? ""
        aDayPlan.uuid = UUID()
        return aDayPlan
        
    }
    
    func toUpdateDataBase(aDayplan: DayPlan) {
        CoreDataManager.shared.removeAllDayPlans()
        CoreDataManager.shared.toSaveDayPlan(aDayPlan: aDayplan) { isComleted in
            if isComleted {
                self.toCreateToast("Saved successfully")
                let dayPlans = CoreDataManager.shared.retriveSavedDayPlans()
                dump(dayPlans)
            } else {
                
            }
        }
    }
}


extension CoreDataManager {
    
    func fetchEachDayPlan(completion: ([EachDayPlan]) -> () )  {
        do {
            let savedDayPlan = try  context.fetch(EachDayPlan.fetchRequest())
            completion(savedDayPlan)
            
        } catch {
            print("unable to fetch movies")
        }
        
    }
    
    func toCheckDayPlanExistence(_ uuid: UUID, completion: (Bool) -> ()) {
        
        do {
            let request = EachDayPlan.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(uuid)'")
            //LIKE
            request.predicate = pred
            let films = try context.fetch(request)
            if films.isEmpty {
                completion(false)
            } else {
                completion(true)
            }
        } catch {
            print("unable to fetch")
            completion(false)
        }
    }
    

    private func convertEachDyPlan(_ eachDayPlan : DayPlan, context: NSManagedObjectContext) -> NSSet {
        
        struct Sessions {
            var cluster : [Territory]
            var headQuarters: Subordinate
            var workType: WorkType
            
            init() {
                self.cluster = [Territory]()
                self.headQuarters = Subordinate()
                self.workType = WorkType()
            }
        }
        
        var aDaysessions : [Sessions] = []
        
        let cdDayPlans = NSMutableSet()
        
        let clusterArr = DBManager.shared.getTerritory()
        let headQuatersArr =  DBManager.shared.getSubordinate()
        let workTypeArr = DBManager.shared.getWorkType()
        if eachDayPlan.fwFlg != "" || eachDayPlan.wtCode != "" || eachDayPlan.townCode != "" || eachDayPlan.location != ""  {
            var aDaySession = Sessions()
            
            
            let codes = eachDayPlan.townCode
            let codesArray = codes.components(separatedBy: ",")
            
            let filteredTerritories = clusterArr.filter { aTerritory in
                // Check if any code in codesArray is contained in aTerritory
                return codesArray.contains { code in
                    return aTerritory.code?.contains(code) ?? false
                }
            }
            aDaySession.cluster = filteredTerritories
            
            workTypeArr.forEach { aWorkType in
                if aWorkType.fwFlg == eachDayPlan.fwFlg  {
                    aDaySession.workType = aWorkType
                }
            }
            
            headQuatersArr.forEach { aheadQuater in
                if aheadQuater.id == eachDayPlan.rsf  {
                    aDaySession.headQuarters = aheadQuater
                }
            }
            aDaysessions.append(aDaySession)
        }
        
        if eachDayPlan.fwFlg2 != "" || eachDayPlan.wtCode2 != "" || eachDayPlan.townCode2 != "" || eachDayPlan.location2 != ""  {
            var aDaySession = Sessions()
            //            clusterArr.forEach { aTerritory in
            //                if aTerritory.code == eachDayPlan.townCode {
            //                    aDaySession.cluster = aTerritory
            //                }
            //            }
            
            let codes = eachDayPlan.townCode
            let codesArray = codes.components(separatedBy: ",")
            
            let filteredTerritories = clusterArr.filter { aTerritory in
                // Check if any code in codesArray is contained in aTerritory
                return codesArray.contains { code in
                    return aTerritory.code?.contains(code) ?? false
                }
            }
            aDaySession.cluster = filteredTerritories
            
            
            workTypeArr.forEach { aWorkType in
                if aWorkType.fwFlg == eachDayPlan.fwFlg  {
                    aDaySession.workType = aWorkType
                }
            }
            
            headQuatersArr.forEach { aheadQuater in
                if aheadQuater.id == eachDayPlan.rsf  {
                    aDaySession.headQuarters = aheadQuater
                }
            }
            aDaysessions.append(aDaySession)
        }
        
        
        for aDaysession in aDaysessions {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "EachPlan", in: context) {
                let entitydayPlan = EachPlan(entity: entityDescription, insertInto: context)
                
                entitydayPlan.cluster = convertClustersToCDM(aDaysession.cluster, context: context)
                entitydayPlan.workType = convertWorkTypeToCDM(aDaysession.workType, context: context)
                entitydayPlan.headQuarters = convertHeadQuartersToCDM(aDaysession.headQuarters, context: context)
                
                // Add to set
                cdDayPlans.add(entitydayPlan)
                
            }
        }
        
        
        
        return cdDayPlans
    }
    
    private func convertHeadQuartersToCDM(_ headQuarters: Subordinate, context: NSManagedObjectContext) -> Subordinate {
        var subordinate = Subordinate()
        if let entityHQ = NSEntityDescription.entity(forEntityName: "Subordinate", in: context) {
            let cdHeadQuarters = Subordinate(entity: entityHQ, insertInto: context)
           //  Convert properties of Subordinate
            cdHeadQuarters.id = headQuarters.id
            cdHeadQuarters.name = headQuarters.name
            cdHeadQuarters.mapId = headQuarters.mapId
            cdHeadQuarters.reportingToSF = headQuarters.reportingToSF
            cdHeadQuarters.sfHq = headQuarters.sfHq
            cdHeadQuarters.steps = headQuarters.steps
            subordinate = cdHeadQuarters
            return subordinate
        }
        return subordinate
    }
    
    private func convertWorkTypeToCDM(_ workType: WorkType, context: NSManagedObjectContext) -> WorkType {
        let cdWorkType = WorkType(context: context)

        // Convert properties of WorkType
        cdWorkType.code = workType.code
        cdWorkType.eTabs = workType.eTabs
        cdWorkType.fwFlg = workType.fwFlg
        cdWorkType.index = workType.index
        cdWorkType.name = workType.name
        cdWorkType.sfCode = workType.sfCode
        cdWorkType.terrslFlg = workType.terrslFlg
        cdWorkType.tpDCR = workType.tpDCR
        // Convert other properties...

        return cdWorkType
    }

    
    private func convertClustersToCDM(_ clusters: [Territory], context: NSManagedObjectContext) -> NSSet {
        let cdTerritortModels = NSMutableSet()
        
        for cluster in clusters {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "Territory", in: context) {
                let cdTerritoryModel = Territory(entity: entityDescription, insertInto: context)
                
                // Convert properties of SlidesModel
                cdTerritoryModel.code = cluster.code
                cdTerritoryModel.index = cluster.index
                cdTerritoryModel.lat = cluster.lat
                cdTerritoryModel.long = cluster.long
                cdTerritoryModel.mapId = cluster.mapId
                cdTerritoryModel.name = cluster.name
                cdTerritoryModel.sfCode = cluster.sfCode
                // Convert other properties...
                
                // Add to set
                cdTerritortModels.add(cdTerritoryModel)
                
            }
        }
        
        return cdTerritortModels
    }
    
    
    
    func toSaveDayPlan(aDayPlan: DayPlan  , completion: @escaping (Bool) -> ()) {
        toCheckDayPlanExistence(aDayPlan.uuid) { isExists in
            if !isExists {
                let context = self.context
                // Create a new managed object
                if let entityDescription = NSEntityDescription.entity(forEntityName: "EachDayPlan", in: context) {
                    let entityDayPlan = EachDayPlan(entity: entityDescription, insertInto: context)
                    
                    // Convert properties
                    entityDayPlan.uuid = aDayPlan.uuid
                    entityDayPlan.planDate = aDayPlan.tpDt.toDate()
                    
                    entityDayPlan.eachPlan = convertEachDyPlan(aDayPlan , context: context)
                    
                    // Save to Core Data
                    do {
                        try context.save()
                        completion(true)
                    } catch {
                        print("Failed to save to Core Data: \(error)")
                        completion(false)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    
    func retriveSavedDayPlans() -> [DayPlan] {
        let userConfig = AppDefaults.shared.getAppSetUp()
        var retrivedPlansArr = [DayPlan]()
        
        CoreDataManager.shared.fetchEachDayPlan { eachDayPlanArr in
            eachDayPlanArr.forEach { eachDayPlan in
                let aDayPlan = DayPlan()
                //  aDayPlan.uuid = eachDayPlan.uuid ?? UUID()
                aDayPlan.tpDt = eachDayPlan.planDate?.toString(format: "yyyy-MM-dd HH:mm:ss.SSS") ?? ""
                aDayPlan.tableName = "dayplan"
                aDayPlan.sfcode = userConfig.sfCode
                aDayPlan.divisionCode = userConfig.divisionCode
                aDayPlan.rsf = userConfig.sfCode
                aDayPlan.sfType = "\(userConfig.sfType!)"
                aDayPlan.designation = userConfig.desig
                aDayPlan.stateCode =  "\(userConfig.stateCode!)"
                aDayPlan.subdivisionCode = userConfig.subDivisionCode
                
                aDayPlan.remarks = eachDayPlan.remarks ?? ""
                aDayPlan.isRejected = eachDayPlan.isRejected
                aDayPlan.rejectionReason = eachDayPlan.rejectionReason ?? String()
                
                aDayPlan.insMode = ""
                aDayPlan.appver = ""
                aDayPlan.mod = ""
                
                aDayPlan.tpVwFlg = ""
                aDayPlan.tpCluster = ""
                aDayPlan.tpWorkType = ""
                
                
                if let  eachDayPlansSet = eachDayPlan.eachPlan as? Set<EachPlan>  {
                    let eachDayPlansArray = Array(eachDayPlansSet)
                    eachDayPlansArray.enumerated().forEach { index, eachPlan in
                        // let agroupedSlide = SlidesModel()
                        switch index {
                        case 0 :
                            aDayPlan.wtCode = eachPlan.workType?.code ?? ""
                            aDayPlan.wtName = eachPlan.workType?.name ?? ""
                            aDayPlan.location = ""
                            //eachPlan.cluster?.name ?? ""
                            aDayPlan.townCode = ""
                            //eachPlan.cluster?
                            aDayPlan.townName = ""
                            //eachPlan.workType
                            aDayPlan.fwFlg = eachPlan.workType?.fwFlg ?? ""
                        case 1:
                            aDayPlan.wtCode2 = eachPlan.workType?.code ?? ""
                            aDayPlan.wtName2 = eachPlan.workType?.name ?? ""
                            aDayPlan.location2 = ""
                            aDayPlan.townCode2 = ""
                            aDayPlan.townName2 = ""
                            aDayPlan.fwFlg2 = eachPlan.workType?.fwFlg ?? ""
                        default:
                            print("Yet to implement")
                        }
                        
                    }
                }
                
                retrivedPlansArr.append(aDayPlan)
            }
        }
        return retrivedPlansArr
    }
    
    
    func removeAllDayPlans() {
        //completion: @escaping () -> Void
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = EachDayPlan.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            // completion()
        } catch {
            print("Error deleting slide brands: \(error)")
            //  completion()
        }
    }
    
}
