//
//  MasterSyncVC + DayPlanEX.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 15/02/24.
//

import Foundation
import CoreData
import UIKit
protocol MasterSyncVCDelegate: AnyObject {
    func isHQModified(hqDidChanged: Bool)
}



extension MasterSyncVC: MenuResponseProtocol {
    func selectedType(_ type: MenuView.CellType, selectedObject: NSManagedObject, selectedObjects: [NSManagedObject]) {
        switch type {
//
//        case .workType:
//            self.fetchedWorkTypeObject = selectedObject as? WorkType
//        case .cluster:
//            self.fetchedClusterObject = selectedObject as? Territory
        case .headQuater:
            
            self.fetchedHQObject = selectedObject as? Subordinate
//            if self.fetchedHQObject == nil {
//                
//            }
            
            let aHQobj = HQModel()
            aHQobj.code = self.fetchedHQObject?.id ?? ""
            aHQobj.mapId = self.fetchedHQObject?.mapId ?? ""
            aHQobj.name = self.fetchedHQObject?.name ?? ""
            aHQobj.reportingToSF = self.fetchedHQObject?.reportingToSF ?? ""
            aHQobj.steps = self.fetchedHQObject?.steps ?? ""
            aHQobj.sfHQ = self.fetchedHQObject?.sfHq ?? ""
            CoreDataManager.shared.removeHQ()
            CoreDataManager.shared.saveToHQCoreData(hqModel: aHQobj) { _ in
                CoreDataManager.shared.toRetriveSavedHQ { HQModelarr in
                    dump(HQModelarr)
                }
            }
            
            LocalStorage.shared.setSting(LocalStorage.LocalValue.selectedRSFID, text: aHQobj.code)
            
         
            //let config = AppDefaults.shared.getAppSetUp()
            Shared.instance.showLoaderInWindow()
            masterVM?.fetchMasterData(type: .clusters, sfCode: aHQobj.code, istoUpdateDCRlist: true, mapID: aHQobj.code) { _ in
                
                self.toCreateToast("Clusters synced successfully")
              //  NotificationCenter.default.post(name: NSNotification.Name("HQmodified"), object: nil)
                self.isDayPlanSynced = true
                self.collectionView.reloadData()
                Shared.instance.removeLoaderInWindow()
                
            }
           
            
            
          //  NotificationCenter.default.post(name: NSNotification.Name("HQmodified"), object: nil)

            self.setHQlbl()
            
        default:
            print("Yet to implement.")
        }
        
       // self.setHQlbl()
    }
    
    func selectedType(_ type: MenuView.CellType, index: Int) {
        print("Yet to implement")
    }
    
    func callPlanAPI() {
        print("")
    }
    func routeToView(_ view : UIViewController) {
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}

extension MasterSyncVC {

    
    

    

}


extension CoreDataManager {
    //SelectedHQ
    
    func fetchSavedHQ(completion: ([SelectedHQ]) -> () )  {
        do {
            let savedHQ = try  context.fetch(SelectedHQ.fetchRequest())
            completion(savedHQ)
            
        } catch {
            print("unable to fetch movies")
        }
        
    }
    
    
    func toRetriveSavedHQ(completion: @escaping ([HQModel]) -> ()) {
        var retrivedHq : [HQModel] = []
        CoreDataManager.shared.fetchSavedHQ(completion: { selectedHQArr in
            selectedHQArr.forEach { selectedHQ in
                let aHQ = HQModel()
                aHQ.code                 = selectedHQ.code ?? ""
                aHQ.name               = selectedHQ.name ?? ""
                aHQ.reportingToSF      = selectedHQ.reportingToSF ?? ""
                aHQ.steps                = selectedHQ.steps ?? ""
                aHQ.sfHQ                = selectedHQ.sfHq ?? ""
                aHQ.mapId               = selectedHQ.mapId ?? ""
                retrivedHq.append(aHQ)
            }
            completion(retrivedHq)
        })
    }
    
    func removeHQ() {
        let fetchRequest: NSFetchRequest<SelectedHQ> = NSFetchRequest(entityName: "SelectedHQ")

        do {
            let slideBrands = try context.fetch(fetchRequest)
            for brand in slideBrands {
                context.delete(brand)
            }

            try context.save()
        } catch {
            print("Error deleting slide brands: \(error)")
        }
    }
    
    
//    func removeHQ() {
//        //completion: @escaping () -> Void
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SelectedHQ.fetchRequest()
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(batchDeleteRequest)
//            try context.save()
//            // completion()
//        } catch {
//            print("Error deleting slide brands: \(error)")
//            //  completion()
//        }
//    }
    
    
    
    func saveToHQCoreData(hqModel: HQModel  , completion: (Bool) -> ()) {
        let context = self.context
        // Create a new managed object
        if let entityDescription = NSEntityDescription.entity(forEntityName: "SelectedHQ", in: context) {
            let savedCDHq = SelectedHQ(entity: entityDescription, insertInto: context)
            
            // Convert properties
            savedCDHq.code                  = hqModel.code
            savedCDHq.name                 = hqModel.name
            savedCDHq.reportingToSF       = hqModel.reportingToSF
            savedCDHq.steps                 = hqModel.steps
            savedCDHq.sfHq                   = hqModel.sfHQ
            savedCDHq.mapId                  = hqModel.mapId
            // Convert and add groupedBrandsSlideModel
            // Save to Core Data
            do {
                try context.save()
                completion(true)
            } catch {
                print("Failed to save to Core Data: \(error)")
                completion(false)
            }
        }
        
    }
    
    
    
    
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
    
    
    func getSubordinate(hqCode: String) -> Subordinate? {
        let hqArr = DBManager.shared.getSubordinate()
        var aSubordinateobj = NSManagedObject()
        hqArr.forEach { aSubordinate in
            if aSubordinate.id == hqCode {
                aSubordinateobj = aSubordinate
            }
                
        }
        return aSubordinateobj as? Subordinate
    }

    private func convertEachDyPlan(_ eachDayPlan : DayPlan, context: NSManagedObjectContext) -> NSSet {
        

        
        var aDaysessions : [Sessions] = []
        
        let cdDayPlans = NSMutableSet()
        
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
                    
//                    CoreDataManager.shared.removeHQ()
//
//                    CoreDataManager.shared.saveToHQCoreData(hqModel: hqModel) { isSaved in
//                        if isSaved {
//                            CoreDataManager.shared.fetchSavedHQ { selectedHQArr in
//                                let aSavedHQ = selectedHQArr.first
//                                selectedheadQuarters = aSavedHQ
//
//                            }
//                        }
//                    }
                    
                    
                    guard let selectedHqentity = NSEntityDescription.entity(forEntityName: "SelectedHQ", in: context)
               
                    else {
                        fatalError("Entity not found")
                    }

                    let temporaryselectedHqobj = NSManagedObject(entity: selectedHqentity, insertInto: nil)  as! SelectedHQ
           
                    temporaryselectedHqobj.code                  = aheadQuater.id
                    temporaryselectedHqobj.name                 = aheadQuater.name
                    temporaryselectedHqobj.reportingToSF       = aheadQuater.reportingToSF
                    temporaryselectedHqobj.steps                 = aheadQuater.steps
                    temporaryselectedHqobj.sfHq                   = aheadQuater.sfHq
                    temporaryselectedHqobj.mapId                  = aheadQuater.mapId
                    selectedheadQuarters = temporaryselectedHqobj
                    
                    
                 
                }
                
            }
            

            
            let tempSession = Sessions(cluster: selectedterritories ?? [temporaryselectedClusterobj], workType: selectedWorkTypes ?? temporaryselectedWTobj, headQuarters: selectedheadQuarters ?? temporaryselectedHqobj)
          
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
                    
//                    CoreDataManager.shared.removeHQ()
//
//                    CoreDataManager.shared.saveToHQCoreData(hqModel: hqModel) { isSaved in
//                        if isSaved {
//                            CoreDataManager.shared.fetchSavedHQ { selectedHQArr in
//                                let aSavedHQ = selectedHQArr.first
//                                selectedheadQuarters = aSavedHQ
//
//                            }
//                        }
//                    }
                    
                    
                    guard let selectedHqentity = NSEntityDescription.entity(forEntityName: "SelectedHQ", in: context)
               
                    else {
                        fatalError("Entity not found")
                    }

                    let temporaryselectedHqobj = NSManagedObject(entity: selectedHqentity, insertInto: nil)  as! SelectedHQ
           
                    temporaryselectedHqobj.code                  = aheadQuater.id
                    temporaryselectedHqobj.name                 = aheadQuater.name
                    temporaryselectedHqobj.reportingToSF       = aheadQuater.reportingToSF
                    temporaryselectedHqobj.steps                 = aheadQuater.steps
                    temporaryselectedHqobj.sfHq                   = aheadQuater.sfHq
                    temporaryselectedHqobj.mapId                  = aheadQuater.mapId
                    selectedheadQuarters = temporaryselectedHqobj
                    
                    
                 
                }
                
            }

            
            let tempSession = Sessions(cluster: selectedterritories ?? [temporaryselectedClusterobj], workType: selectedWorkTypes ?? temporaryselectedWTobj, headQuarters: selectedheadQuarters ?? temporaryselectedHqobj)
          //selectedheadQuarters ?? SelectedHQ()
            aDaysessions.append(tempSession)
        }
        
        
        for aDaysession in aDaysessions {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "EachPlan", in: context) {
                let entitydayPlan = EachPlan(entity: entityDescription, insertInto: context)
                
                entitydayPlan.cluster = convertClustersToCDM(aDaysession.cluster ?? [temporaryselectedClusterobj], context: context)
                entitydayPlan.workType = convertWorkTypeToCDM(aDaysession.workType ?? temporaryselectedWTobj, context: context)
         
                entitydayPlan.headQuarters = convertHeadQuartersToCDM(aDaysession.headQuarters ?? temporaryselectedHqobj, context: context)
                
            
                
                // Add to set
                cdDayPlans.add(entitydayPlan)
                
            }
        }
        
        
        
        return cdDayPlans
    }
    
    private func convertHeadQuartersToCDM(_ headQuarters: SelectedHQ, context: NSManagedObjectContext) -> SelectedHQ {
        
      
            let cdHeadQuarters = SelectedHQ(context: context)
            // Convert properties of Subordinate
            cdHeadQuarters.code = headQuarters.code
            cdHeadQuarters.name = headQuarters.name
            cdHeadQuarters.mapId = headQuarters.mapId
            cdHeadQuarters.reportingToSF = headQuarters.reportingToSF
            cdHeadQuarters.sfHq = headQuarters.sfHq
            cdHeadQuarters.steps = headQuarters.steps
          
          
        
        return cdHeadQuarters
    }
    
    public func convertHeadQuartersToSubordinate(_ headQuarters: SelectedHQ, context: NSManagedObjectContext) ->  Subordinate{
        
      
            let cdHeadQuarters = Subordinate(context: context)
            // Convert properties of Subordinate
            cdHeadQuarters.id = headQuarters.code
            cdHeadQuarters.name = headQuarters.name
            cdHeadQuarters.mapId = headQuarters.mapId
            cdHeadQuarters.reportingToSF = headQuarters.reportingToSF
            cdHeadQuarters.sfHq = headQuarters.sfHq
            cdHeadQuarters.steps = headQuarters.steps
          
          
        
        return cdHeadQuarters
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

    
    public func convertCacheTerritoriesToCDM(_ clusters: [Territory], context: NSManagedObjectContext) -> NSSet {
        let cdTerritortModels = NSMutableSet()
        
        for cluster in clusters {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "CacheTerritories", in: context) {
                let cdTerritoryModel = CacheTerritories(entity: entityDescription, insertInto: context)
                
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
    
    
    public func convertClustersToCDM(_ clusters: [Territory], context: NSManagedObjectContext) -> NSSet {
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
               // aDayPlan.rsf =
                //userConfig.sfCode
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
                            aDayPlan.rsf = eachPlan.headQuarters?.code ?? ""
                            aDayPlan.wtCode = eachPlan.workType?.code ?? ""
                            aDayPlan.wtName = eachPlan.workType?.name ?? ""
                            aDayPlan.location = ""
                            aDayPlan.isRetrived = eachPlan.isRetrived
                            
//                            if let clusterSet = eachPlan.cluster as? Set<Territory> {
//
//
//                               // let territoryCodes = clusterSet.map { $0.code ?? "" }
//
//                                let territoryCodesString = clusterSet.map { $0.code ?? "" }.joined(separator: ", ")
//                                let territoryNamesString = clusterSet.map { $0.name ?? "" }.joined(separator: ", ")
//                                aDayPlan.townCode =  territoryCodesString
//                                aDayPlan.townName = territoryNamesString
//                                print("Territory Codes: \(territoryCodesString)")
//                            }
                         
               
                            
                            guard let clusterEntity = NSEntityDescription.entity(forEntityName: "Territory", in: context),
                                  let clusterSet = eachPlan.cluster as? Set<Territory> else {
                                fatalError("Entity or clusterSet not found")
                            }

                            let territoryCodesString = clusterSet.map { $0.code ?? "" }.joined(separator: ", ")
                            let territoryNamesString = clusterSet.map { $0.name ?? "" }.joined(separator: ", ")
                            aDayPlan.townCode =  territoryCodesString
                            aDayPlan.townName = territoryNamesString
                            print("Territory Codes: \(territoryCodesString)")
                            
                            
                            
                            aDayPlan.fwFlg = eachPlan.workType?.fwFlg ?? ""
                        case 1:
                            aDayPlan.rsf2 = eachPlan.headQuarters?.code ?? ""
                            aDayPlan.wtCode2 = eachPlan.workType?.code ?? ""
                            aDayPlan.wtName2 = eachPlan.workType?.name ?? ""
                            aDayPlan.isRetrived = eachPlan.isRetrived
                            guard let clusterEntity = NSEntityDescription.entity(forEntityName: "Territory", in: context),
                                  let clusterSet = eachPlan.cluster as? Set<Territory> else {
                                fatalError("Entity or clusterSet not found")
                            }

                            let territoryCodesString = clusterSet.map { $0.code ?? "" }.joined(separator: ", ")
                            let territoryNamesString = clusterSet.map { $0.name ?? "" }.joined(separator: ", ")
                            aDayPlan.townCode2 =  territoryCodesString
                            aDayPlan.townName2 = territoryNamesString
                            print("Territory Codes: \(territoryCodesString)")
                            
                            aDayPlan.location2 = ""
                       
                         
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
        let fetchRequest: NSFetchRequest<EachDayPlan> = NSFetchRequest(entityName: "EachDayPlan")

        do {
            let slideBrands = try context.fetch(fetchRequest)
            for brand in slideBrands {
                context.delete(brand)
            }

            try context.save()
        } catch {
            print("Error deleting slide brands: \(error)")
        }
    }
    
    
//    func removeAllDayPlans() {
//        //completion: @escaping () -> Void
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = EachDayPlan.fetchRequest()
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(batchDeleteRequest)
//            try context.save()
//            // completion()
//        } catch {
//            print("Error deleting slide brands: \(error)")
//            //  completion()
//        }
//    }
    
    
    func saveSessionAsEachDayPlan(session: [Sessions], completion: @escaping (Bool) -> ()) {
      
        let context = self.context

        guard let selectedHqentity = NSEntityDescription.entity(forEntityName: "SelectedHQ", in: context),
         let selectedWTentity = NSEntityDescription.entity(forEntityName: "WorkType", in: context),
        let selectedClusterentity = NSEntityDescription.entity(forEntityName: "Territory", in: context)
        else {
            fatalError("Entity not found")
        }

        let temporaryselectedHqobj = NSManagedObject(entity: selectedHqentity, insertInto: nil)  as! SelectedHQ
        let temporaryselectedWTobj = NSManagedObject(entity: selectedWTentity, insertInto: nil)  as! WorkType
        let temporaryselectedClusterobj = NSManagedObject(entity: selectedClusterentity, insertInto: nil)  as! Territory

        guard let eachDayPlanEntity = NSEntityDescription.entity(forEntityName: "EachDayPlan", in: context) else {
            fatalError("Entity not found")
        }

        let eachDayPlan = EachDayPlan(entity: eachDayPlanEntity, insertInto: context)
        eachDayPlan.planDate = Date() // Set the planDate as needed

        // Set other properties based on the session
        eachDayPlan.uuid = UUID()
        eachDayPlan.remarks = session[0].remarks ?? ""
        eachDayPlan.isRejected = session[0].isRejected ?? false
        eachDayPlan.rejectionReason = session[0].rejectionReason
        
        // Convert and add EachPlan objects
        
        
        
  
        
        
        let eachPlanSet = NSMutableSet()
        // Add EachPlan for the first index
      //  let firstEachPlan = EachPlan(context: context)
        
        guard let firstPlanEntity = NSEntityDescription.entity(forEntityName: "EachPlan", in: context) else {
            fatalError("Entity not found")
        }
        let firstEachPlan = EachPlan(entity: firstPlanEntity, insertInto: context)

        
        
        guard let secondPlanEntity = NSEntityDescription.entity(forEntityName: "EachPlan", in: context) else {
            fatalError("Entity not found")
        }
        let secondEachPlan = EachPlan(entity: secondPlanEntity, insertInto: context)

 
      //  CoreDataManager.shared.removeSessionTerrioriesFromCoreData()
        session.enumerated().forEach { index, aSession in
            
            switch index {
            case 0:
                firstEachPlan.isRetrived = session[index].isRetrived ?? false
                // Set properties based on session or adjust as needed
                firstEachPlan.headQuarters =  convertHeadQuartersToCDM(session[index].headQuarters ?? temporaryselectedHqobj, context: self.context)
                firstEachPlan.workType = convertWorkTypeToCDM(session[index].workType ?? temporaryselectedWTobj, context: self.context)
                firstEachPlan.cluster = convertClustersToCDM(session[index].cluster ?? [temporaryselectedClusterobj], context: self.context)
                
                eachPlanSet.add(firstEachPlan)
               
            case 1:
                secondEachPlan.isRetrived = session[index].isRetrived ?? false
                // Set properties based on session or adjust as needed
                secondEachPlan.headQuarters =  convertHeadQuartersToCDM(session[index].headQuarters ?? temporaryselectedHqobj, context: self.context)
                secondEachPlan.workType = convertWorkTypeToCDM(session[index].workType ?? temporaryselectedWTobj, context: self.context)
                secondEachPlan.cluster = convertClustersToCDM(session[index].cluster ?? [temporaryselectedClusterobj], context: self.context)

                eachPlanSet.add(secondEachPlan)
                

            default:
                print("Yet to implement")
            }
        }
        

            eachDayPlan.eachPlan = eachPlanSet
        

        // Save to Core Data
        do {
            try context.save()
            completion(true)
        } catch {
            print("Failed to save EachDayPlan to Core Data: \(error)")
            completion(false)
        }

    }
}
    

