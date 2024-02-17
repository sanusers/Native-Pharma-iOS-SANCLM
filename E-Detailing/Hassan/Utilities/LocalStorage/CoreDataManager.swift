//
//  PresentationCoreDataManager.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 29/01/24.
//



import Foundation
import CoreData
import UIKit




class CoreDataManager {
    static let shared = CoreDataManager()
    // var savedSlideBrand: [SlideBrand]?
    // var savedSlides : [SlidesCDModel]?
   //  var savedGroupedSlides : [GroupedBrandsSlideCDModel]?
    // var savedCDpresentations:[SavedCDPresentation]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - functionalities for presentation flow
    
    /// function to fetch all saved presentation
    /// - Parameter completion: array of type SavedCDPresentation
    func fetchPresentations(completion: ([SavedCDPresentation]) -> () )  {
        do {
           let savedCDpresentations = try  context.fetch(SavedCDPresentation.fetchRequest())
            completion(savedCDpresentations )
            
        } catch {
            print("unable to fetch movies")
        }
       
    }
    
    

    
    
    /// function checks for existing object from core data SavedCDPresentation
    /// - Parameters:
    ///   - id: UUID
    ///   - completion: boolean
    func toCheckExistance(_ id: UUID, completion: (Bool) -> ()) {
        
        do {
            let request = SavedCDPresentation.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(id)'")
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
    
    
    
    
    /// function to remove a presentation
    /// - Parameters:
    ///   - id: UUID
    ///   - completion: completion descriptionboolen
    func toRemovePresentation(_ id: UUID, completion: (Bool) -> ()) {
   

        do {
            let request = SavedCDPresentation.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(id)'")
            request.predicate = pred
           let presentations = try context.fetch(request)
            if presentations.isEmpty {
                completion(false)
            } else {
                let presentationToRemove = presentations[0]
                self.context.delete(presentationToRemove)
                do {
                     try self.context.save()
                    completion(true)
                } catch {
                    completion(false)
                }
                completion(true)
            }
        } catch {
            print("unable to fetch")
            completion(false)
        }

    }
    
    
    ///  function to edit a existing presentation
    /// - Parameters:
    ///   - savedPresentation: SavedPresentation object
    ///   - id: UUID
    ///   - completion: boolean
    func toEditSavedPresentation(savedPresentation: SavedPresentation,_ id: UUID, completion: (Bool) -> ()) {
        do {
            let request = SavedCDPresentation.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(id)'")
            //LIKE
            request.predicate = pred
           let presentations = try context.fetch(request)
            if let existingEntity = presentations.first {
                // Convert properties
                existingEntity.uuid = savedPresentation.uuid
                existingEntity.name = savedPresentation.name

                // Convert and add groupedBrandsSlideModel
                
                existingEntity.groupedBrandsSlideModel = convertToCDGroupedBrandsSlideModel(savedPresentation.groupedBrandsSlideModel, context: context)

                // Save to Core Data
                 try self.context.save()
                 completion(true)
             } else {
                 completion(false)
             }
        } catch {
            print("unable to fetch")
            completion(false)
        }
    }
    
    

    

    /// to save object of type SavedPresentation to core data
    /// - Parameters:
    ///   - savedPresentation: SavedPresentation
    ///   - completion: boolean
    func saveToCoreData(savedPresentation: SavedPresentation  , completion: (Bool) -> ()) {
        toCheckExistance(savedPresentation.uuid) { isExists in
            if !isExists {
                let context = self.context
                // Create a new managed object
                if let entityDescription = NSEntityDescription.entity(forEntityName: "SavedCDPresentation", in: context) {
                    let savedCDPresentation = SavedCDPresentation(entity: entityDescription, insertInto: context)

                    // Convert properties
                    savedCDPresentation.uuid = savedPresentation.uuid
                    savedCDPresentation.name = savedPresentation.name

                    // Convert and add groupedBrandsSlideModel
                    savedCDPresentation.groupedBrandsSlideModel = convertToCDGroupedBrandsSlideModel(savedPresentation.groupedBrandsSlideModel, context: context)

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
    
    
    /// function used to convert codable class objet array to NSset. sincc core data saves object of type NSset
    /// - Parameters:
    ///   - groupedBrandsSlideModels: object of type [GroupedBrandsSlideModel]
    ///   - context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /// - Returns: NSSet
    private func convertToCDGroupedBrandsSlideModel(_ groupedBrandsSlideModels: [GroupedBrandsSlideModel], context: NSManagedObjectContext) -> NSSet {
        let cdGroupedBrandsSlideModels = NSMutableSet()

        for groupedBrandsSlideModel in groupedBrandsSlideModels {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "GroupedBrandsSlideCDModel", in: context) {
                let cdGroupedBrandsSlideModel = GroupedBrandsSlideCDModel(entity: entityDescription, insertInto: context)

                // Convert properties of GroupedBrandsSlideModel
                cdGroupedBrandsSlideModel.priority = Int16(groupedBrandsSlideModel.priority)
                //cdGroupedBrandsSlideModel.updatedDate = groupedBrandsSlideModel.updatedDate
                // Convert other properties...

                // Convert and add groupedSlide
                let tempSlide =  groupedBrandsSlideModel.groupedSlide.sorted { $0.index < $1.index }
                cdGroupedBrandsSlideModel.groupedSlide = convertToSavedSlidesCDModel(tempSlide, context: context)

                // Add to set
                cdGroupedBrandsSlideModels.add(cdGroupedBrandsSlideModel)
            }
        }

        return cdGroupedBrandsSlideModels
    }
    
    
    private func convertToSavedSlidesCDModel(_ slidesModels: [SlidesModel], context: NSManagedObjectContext) -> NSSet {
        let cdSlidesModels = NSMutableSet()

        for slidesModel in slidesModels {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "SavedSlidesCDModel", in: context) {
                let cdSlidesModel = SavedSlidesCDModel(entity: entityDescription, insertInto: context)
                if slidesModel.utType == "video/mp4" || slidesModel.utType == "application/pdf" || slidesModel.utType == "text/html" {
                    print(slidesModel.index)
                }
                // Convert properties of SlidesModel
                cdSlidesModel.code = Int16(slidesModel.code)
                cdSlidesModel.filePath = slidesModel.filePath
                cdSlidesModel.code =   Int16(slidesModel.code)
                cdSlidesModel.camp = Int16(slidesModel.camp)
                cdSlidesModel.productDetailCode = slidesModel.productDetailCode
                cdSlidesModel.filePath = slidesModel.filePath
                cdSlidesModel.group = Int16(slidesModel.group)
                cdSlidesModel.specialityCode = slidesModel.specialityCode
                cdSlidesModel.slideId = Int16(slidesModel.slideId)
                cdSlidesModel.fileType = slidesModel.fileType
                // cdSlidesModel.effFrom = effFrom = DateI
                cdSlidesModel.categoryCode = slidesModel.categoryCode
                cdSlidesModel.name = slidesModel.name
                cdSlidesModel.noofSamples = Int16(slidesModel.noofSamples)
                // cdSlidesModel.effTo = effTo = DateI
                cdSlidesModel.ordNo = Int16(slidesModel.ordNo)
                cdSlidesModel.priority = Int16(slidesModel.priority)
                cdSlidesModel.slideData = slidesModel.slideData
                cdSlidesModel.utType = slidesModel.utType
                cdSlidesModel.isSelected = slidesModel.isSelected
                cdSlidesModel.fileName = slidesModel.fileName
                cdSlidesModel.isFailed = slidesModel.isFailed
                cdSlidesModel.isDownloadCompleted = slidesModel.isDownloadCompleted
                cdSlidesModel.index = Int16(slidesModel.index)
                // Convert other properties...
                
                // Add to set
                cdSlidesModels.add(cdSlidesModel)
            }
        }

        return cdSlidesModels
    }
    
    
    
    
    /// function used to convert codable class objet array to NSset. sincc core data saves object of type NSset
    /// - Parameters:
    ///   - slidesModels: object of type [SlidesModel]
    ///   - context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /// - Returns: NSSet
    private func convertToSlidesCDModel(_ slidesModels: [SlidesModel], context: NSManagedObjectContext) -> NSSet {
        let cdSlidesModels = NSMutableSet()

        for slidesModel in slidesModels {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "GroupedSlidesCDModel", in: context) {
                let cdSlidesModel = SlidesCDModel(entity: entityDescription, insertInto: context)
                
                // Convert properties of SlidesModel
                cdSlidesModel.code = Int16(slidesModel.code)
                cdSlidesModel.filePath = slidesModel.filePath
                cdSlidesModel.code =   Int16(slidesModel.code)
                cdSlidesModel.camp = Int16(slidesModel.camp)
                cdSlidesModel.productDetailCode = slidesModel.productDetailCode
                cdSlidesModel.group = Int16(slidesModel.group)
                cdSlidesModel.specialityCode = slidesModel.specialityCode
                cdSlidesModel.slideId = Int16(slidesModel.slideId)
                cdSlidesModel.fileType = slidesModel.fileType
                // cdSlidesModel.effFrom = effFrom = DateI
                cdSlidesModel.categoryCode = slidesModel.categoryCode
                cdSlidesModel.name = slidesModel.name
                cdSlidesModel.noofSamples = Int16(slidesModel.noofSamples)
                // cdSlidesModel.effTo = effTo = DateI
                cdSlidesModel.ordNo = Int16(slidesModel.ordNo)
                cdSlidesModel.priority = Int16(slidesModel.priority)
                cdSlidesModel.slideData = slidesModel.slideData
                cdSlidesModel.utType = slidesModel.utType
                cdSlidesModel.isSelected = slidesModel.isSelected
                cdSlidesModel.fileName = slidesModel.fileName
                cdSlidesModel.isFailed = slidesModel.isFailed
                cdSlidesModel.isDownloadCompleted = slidesModel.isDownloadCompleted
                // Convert other properties...
                
                // Add to set
                cdSlidesModels.add(cdSlidesModel)
              
            }
        }

        return cdSlidesModels
    }
    
    
    
    /// function fetches core data objet and returns as codable objet
    /// - Returns: object of type [SavedPresentation]
    func retriveSavedPresentations(completion: @escaping ([SavedPresentation]) -> ())  {
        //-> [SavedPresentation]
        var savePresentationArr = [SavedPresentation]()
        
        CoreDataManager.shared.fetchPresentations { savedCDPresentationArr in
            savedCDPresentationArr.forEach { aSavedCDPresentation in
                let aSavedPresentation = SavedPresentation()
                aSavedPresentation.uuid = aSavedCDPresentation.uuid ?? UUID()
                aSavedPresentation.name = aSavedCDPresentation.name ?? ""
                var groupedBrandsSlideModelArr = [GroupedBrandsSlideModel]()
                
                if let groupedBrandsSlideModelSet = aSavedCDPresentation.groupedBrandsSlideModel as? Set<GroupedBrandsSlideCDModel> {
                       let groupedBrandsSlideModelArray = Array(groupedBrandsSlideModelSet)
                    groupedBrandsSlideModelArray.forEach { aGroupedBrandsSlideCDModel in
                      
                        let groupedBrandsSlideModel = GroupedBrandsSlideModel()
                        groupedBrandsSlideModel.id = Int(aGroupedBrandsSlideCDModel.id)
                        groupedBrandsSlideModel.subdivisionCode = Int(aGroupedBrandsSlideCDModel.subdivisionCode)
                        groupedBrandsSlideModel.productBrdCode = Int(aGroupedBrandsSlideCDModel.productBrdCode)
                        groupedBrandsSlideModel.divisionCode = Int(aGroupedBrandsSlideCDModel.divisionCode)
                        
                        var groupedSlideArr = [SlidesModel]()
                        if let  groupedSlideModelSet = aGroupedBrandsSlideCDModel.groupedSlide as? Set<SavedSlidesCDModel>  {
                            let groupedBrandsSlideModelArray = Array(groupedSlideModelSet)
                            groupedBrandsSlideModelArray.forEach { slidesCDModel in
                                let agroupedSlide = SlidesModel()
                                agroupedSlide.code = Int(slidesCDModel.code)
                                agroupedSlide.camp = Int(slidesCDModel.camp)
                                agroupedSlide.productDetailCode = slidesCDModel.productDetailCode ?? ""
                                agroupedSlide.filePath = slidesCDModel.filePath ?? ""
                                agroupedSlide.group = Int(slidesCDModel.group)
                                agroupedSlide.specialityCode = slidesCDModel.specialityCode ?? ""
                                agroupedSlide.slideId = Int(slidesCDModel.slideId)
                                agroupedSlide.fileType = slidesCDModel.fileType ?? ""
                                agroupedSlide.categoryCode = slidesCDModel.categoryCode ?? ""
                                agroupedSlide.name = slidesCDModel.name ?? ""
                                agroupedSlide.noofSamples = Int(slidesCDModel.noofSamples)
                                agroupedSlide.ordNo = Int(slidesCDModel.ordNo)
                                agroupedSlide.priority = Int(slidesCDModel.priority)
                                agroupedSlide.slideData = slidesCDModel.slideData ?? Data()
                                agroupedSlide.utType = slidesCDModel.utType ?? ""
                                agroupedSlide.isSelected = slidesCDModel.isSelected
                                agroupedSlide.isFailed = slidesCDModel.isFailed
                                agroupedSlide.isDownloadCompleted = slidesCDModel.isDownloadCompleted
                                agroupedSlide.index = Int(slidesCDModel.index)
                                groupedSlideArr.append(agroupedSlide)
                            }
                            
                            groupedBrandsSlideModel.groupedSlide = groupedSlideArr
                            
                        }
                        groupedBrandsSlideModelArr.append(groupedBrandsSlideModel)
                    }
                   }
                aSavedPresentation.groupedBrandsSlideModel = groupedBrandsSlideModelArr
                savePresentationArr.append(aSavedPresentation)
            }
        }
        completion (savePresentationArr)
        //return savePresentationArr
    }
    // MARK: - functionalities for presentation flow Ends
}




extension CoreDataManager {
    

    func fetchGroupedSlides(completion: ([GroupedBrandsSlideCDModel]) -> () )  {
        do {
           let savedGroupedSlides = try  context.fetch(GroupedBrandsSlideCDModel.fetchRequest())
            completion(savedGroupedSlides )
            
        } catch {
            print("unable to fetch movies")
        }
       
    }
    
    
    

    
    
    func retriveGroupedSlides() -> [GroupedBrandsSlideModel] {
        
        var savePresentationArr = [GroupedBrandsSlideModel]()
        
        CoreDataManager.shared.fetchGroupedSlides { groupedBrandsArr in
            groupedBrandsArr.forEach { agroupedBrands in
                let aGroupedBrandsSlideModel = GroupedBrandsSlideModel()
                aGroupedBrandsSlideModel.uuid = agroupedBrands.uuid ?? UUID()
                aGroupedBrandsSlideModel.id = Int(agroupedBrands.id)
                aGroupedBrandsSlideModel.divisionCode = Int(agroupedBrands.divisionCode)
                aGroupedBrandsSlideModel.priority = Int(agroupedBrands.priority)
                aGroupedBrandsSlideModel.productBrdCode = Int(agroupedBrands.productBrdCode)
                aGroupedBrandsSlideModel.subdivisionCode = Int(agroupedBrands.subdivisionCode)

                var groupedSlideArr = [SlidesModel]()
                if let  groupedSlideModelSet = agroupedBrands.groupedSlide as? Set<SlidesCDModel>  {
                    let groupedBrandsSlideModelArray = Array(groupedSlideModelSet)
                    groupedBrandsSlideModelArray.forEach { slidesCDModel in
                        let agroupedSlide = SlidesModel()
                        agroupedSlide.code = Int(slidesCDModel.code)
                        agroupedSlide.camp = Int(slidesCDModel.camp)
                        agroupedSlide.productDetailCode = slidesCDModel.productDetailCode ?? ""
                        agroupedSlide.filePath = slidesCDModel.filePath ?? ""
                        agroupedSlide.group = Int(slidesCDModel.group)
                        agroupedSlide.specialityCode = slidesCDModel.specialityCode ?? ""
                        agroupedSlide.slideId = Int(slidesCDModel.slideId)
                        agroupedSlide.fileType = slidesCDModel.fileType ?? ""
                        agroupedSlide.categoryCode = slidesCDModel.categoryCode ?? ""
                        agroupedSlide.name = slidesCDModel.name ?? ""
                        agroupedSlide.noofSamples = Int(slidesCDModel.noofSamples)
                        agroupedSlide.ordNo = Int(slidesCDModel.ordNo)
                        agroupedSlide.priority = Int(slidesCDModel.priority)
                        agroupedSlide.slideData = slidesCDModel.slideData ?? Data()
                        agroupedSlide.utType = slidesCDModel.utType ?? ""
                        agroupedSlide.isSelected = slidesCDModel.isSelected
                        agroupedSlide.fileName = slidesCDModel.fileName ?? ""
                        agroupedSlide.isFailed = slidesCDModel.isFailed
                        agroupedSlide.isDownloadCompleted = slidesCDModel.isDownloadCompleted
                        groupedSlideArr.append(agroupedSlide)
                    }
                    
                    aGroupedBrandsSlideModel.groupedSlide = groupedSlideArr
                    
                }
                
                savePresentationArr.append(aGroupedBrandsSlideModel)
            }
        }
        
        return savePresentationArr
    }
    
    
    func toCheckGeneralGroupedSlidesExistance(_ productBrdCode: Int, completion: (Bool) -> ()) {
        
        do {
            let request = GeneralSlideGroupsCDModel.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "productBrdCode == '\(productBrdCode)'")
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
    
    func toCheckGroupedSlidesExistance(_ id: UUID, completion: (Bool) -> ()) {
        
        do {
            let request = GroupedBrandsSlideCDModel.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(id)'")
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
    
    
    
    

    
    
    func removeAllGroupedSlides() {
        //completion: @escaping () -> Void
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = GroupedBrandsSlideCDModel.fetchRequest()
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
    
    

    
    
    
    func toSaveGroupedSlidesToCoreData(groupedBrandSlide: GroupedBrandsSlideModel  , completion: @escaping (Bool) -> ()) {
        toCheckGroupedSlidesExistance(groupedBrandSlide.uuid) { isExists in
            if !isExists {
                let context = self.context
                // Create a new managed object
                if let entityDescription = NSEntityDescription.entity(forEntityName: "GroupedBrandsSlideCDModel", in: context) {
                    let GroupedBrandsSlides = GroupedBrandsSlideCDModel(entity: entityDescription, insertInto: context)

                    // Convert properties
                    GroupedBrandsSlides.uuid = groupedBrandSlide.uuid
                    GroupedBrandsSlides.divisionCode = Int16(groupedBrandSlide.divisionCode)
                    GroupedBrandsSlides.priority = Int16(groupedBrandSlide.priority)
                    GroupedBrandsSlides.productBrdCode = Int16(groupedBrandSlide.productBrdCode)
                    GroupedBrandsSlides.subdivisionCode = Int16(groupedBrandSlide.subdivisionCode)

                    // Convert and add groupedBrandsSlideModel
                    GroupedBrandsSlides.groupedSlide = convertToSlidesCDModel(groupedBrandSlide.groupedSlide, context: context)

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
}


extension CoreDataManager {
    // MARK: - functionalities for slides flow
    func toCheckSlideExistance(_ id: UUID, completion: (Bool) -> ()) {
        
        do {
            let request = SlidesCDModel.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(id)'")
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

    
    func toCheckBrandExistance(_ productBrdCode: Int, completion: (Bool) -> ()) {
        
        do {
            let request = SlideBrand.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "productBrandCode == '\(productBrdCode)'")
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

    
    func fetchBarndSlides(completion: ([SlideBrand]) -> () )  {
        do {
           let savedSlideBrand = try  context.fetch(SlideBrand.fetchRequest())
            completion(savedSlideBrand)
            
        } catch {
            print("unable to fetch movies")
        }
       
    }
    
    func removeAllSlideBrands() {
        //completion: @escaping () -> Void
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SlideBrand.fetchRequest()
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
    
    
    func removeAllSavedSlides() {
        //completion: @escaping () -> Void
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SavedSlidesCDModel.fetchRequest()
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
    
    
    func removeAllSlides() {
        //completion: @escaping () -> Void
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SlidesCDModel.fetchRequest()
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
    
    
    
    
    func fetchSlides(completion: ([SlidesCDModel]) -> () )  {
        do {
           let savedSlides = try  context.fetch(SlidesCDModel.fetchRequest())
            completion(savedSlides)
            
        } catch {
            print("unable to fetch movies")
        }
       
    }
    
    func updateSlidesInCoreData(savedSlides: SlidesModel, completion: @escaping (Bool) -> ()) {
        let context = self.context

        // Fetch the existing SlidesCDModel using the uuid
        let fetchRequest: NSFetchRequest<SlidesCDModel> = SlidesCDModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", savedSlides.uuid as CVarArg)

        do {
            if let savedCDSlide = try context.fetch(fetchRequest).first {
                // Update properties
                savedCDSlide.code              =         Int16(savedSlides.code)
                savedCDSlide.camp              =         Int16(savedSlides.camp)
                savedCDSlide.productDetailCode =         savedSlides.productDetailCode
                savedCDSlide.filePath          =         savedSlides.filePath
                savedCDSlide.group             =         Int16(savedSlides.group)
                savedCDSlide.specialityCode    =         savedSlides.specialityCode
                savedCDSlide.slideId           =         Int16(savedSlides.slideId)
                savedCDSlide.fileType          =         savedSlides.fileType
               // savedCDSlide.effFrom           =         savedSlides.effFrom
                savedCDSlide.categoryCode      =         savedSlides.categoryCode
                savedCDSlide.name              =         savedSlides.name
                savedCDSlide.noofSamples       =         Int16(savedSlides.noofSamples)
               // savedCDSlide.effTo             =         savedSlides.effTo
                savedCDSlide.ordNo             =         Int16(savedSlides.ordNo)
                savedCDSlide.priority          =         Int16(savedSlides.priority)
                savedCDSlide.slideData         =         savedSlides.slideData
                savedCDSlide.utType            =         savedSlides.utType
                savedCDSlide.isSelected        =         savedSlides.isSelected
                savedCDSlide.uuid              =         savedSlides.uuid
                savedCDSlide.fileName = savedSlides.fileName
                savedCDSlide.isDownloadCompleted = savedSlides.isDownloadCompleted
                savedCDSlide.isFailed = savedSlides.isFailed
                // Update other properties...

                // Save the context
                do {
                    try context.save()
                    completion(true)
                } catch {
                    print("Failed to save updated object to Core Data: \(error)")
                    completion(false)
                }
            } else {
                // Handle case when the object with the specified uuid is not found
                print("SlidesCDModel with uuid \(savedSlides.uuid) not found.")
                saveSlidesToCoreData(savedSlides: savedSlides) { completed in
                    completion(completed)
                }
                
            }
        } catch {
            print("Error fetching SlidesCDModel: \(error)")
            completion(false)
        }
    }

    
    func saveSlidesToCoreData(savedSlides: SlidesModel  , completion: (Bool) -> ()) {
        toCheckSlideExistance(savedSlides.uuid) { isExists in
            if !isExists {
                let context = self.context
                
                if let entityDescription = NSEntityDescription.entity(forEntityName: "SlidesCDModel", in: context) {
                    let savedCDSlide = SlidesCDModel(entity: entityDescription, insertInto: context)

                    // Convert properties
         
                    savedCDSlide.code              =         Int16(savedSlides.code)
                    savedCDSlide.camp              =         Int16(savedSlides.camp)
                    savedCDSlide.productDetailCode =         savedSlides.productDetailCode
                    savedCDSlide.filePath          =         savedSlides.filePath
                    savedCDSlide.group             =         Int16(savedSlides.group)
                    savedCDSlide.specialityCode    =         savedSlides.specialityCode
                    savedCDSlide.slideId           =         Int16(savedSlides.slideId)
                    savedCDSlide.fileType          =         savedSlides.fileType
                   // savedCDSlide.effFrom           =         savedSlides.effFrom
                    savedCDSlide.categoryCode      =         savedSlides.categoryCode
                    savedCDSlide.name              =         savedSlides.name
                    savedCDSlide.noofSamples       =         Int16(savedSlides.noofSamples)
                   // savedCDSlide.effTo             =         savedSlides.effTo
                    savedCDSlide.ordNo             =         Int16(savedSlides.ordNo)
                    savedCDSlide.priority          =         Int16(savedSlides.priority)
                    savedCDSlide.slideData         =         savedSlides.slideData
                    savedCDSlide.utType            =         savedSlides.utType
                    savedCDSlide.isSelected        =         savedSlides.isSelected
                    savedCDSlide.uuid              =         savedSlides.uuid
                    savedCDSlide.fileName = savedSlides.fileName
                    savedCDSlide.isDownloadCompleted = savedSlides.isDownloadCompleted
                    savedCDSlide.isFailed = savedSlides.isFailed

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
                
            }
        }
    }
    
    
    
    func saveBrandSlidesToCoreData(savedBrandSlides: BrandSlidesModel  , completion: (Bool) -> ()) {
        toCheckBrandExistance(savedBrandSlides.productBrdCode) { isExists in
            if !isExists {
                let context = self.context
                
                if let entityDescription = NSEntityDescription.entity(forEntityName: "SlideBrand", in: context) {
                    let savedCDSlideBrands = SlideBrand(entity: entityDescription, insertInto: context)

                    // Convert properties
                    savedCDSlideBrands.uuid = savedBrandSlides.uuid
                    savedCDSlideBrands.priority = String(savedBrandSlides.priority)
                    savedCDSlideBrands.divisionCode = String(savedBrandSlides.divisionCode)
                    savedCDSlideBrands.id =  String(savedBrandSlides.id)
                    savedCDSlideBrands.productBrandCode = String(savedBrandSlides.productBrdCode)
                    savedCDSlideBrands.subDivisionCode = String(savedBrandSlides.subdivisionCode)
                

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
                
            }
        }
    }
    
    

    
    func retriveSavedSlides() -> [SlidesModel] {
        
        var saveSlidesArr = [SlidesModel]()
        
        CoreDataManager.shared.fetchSlides { savedCDSlides in
            
            savedCDSlides.forEach { aSavedCDPresentation in
                let asaveSlide = SlidesModel()
                asaveSlide.code              =     Int(aSavedCDPresentation.code)
                asaveSlide.camp              =     Int(aSavedCDPresentation.camp)
                asaveSlide.productDetailCode =     aSavedCDPresentation.productDetailCode ?? ""
                asaveSlide.filePath          =     aSavedCDPresentation.filePath ?? ""
                asaveSlide.group             =     Int(aSavedCDPresentation.group)
                asaveSlide.specialityCode    =     aSavedCDPresentation.specialityCode ?? ""
                asaveSlide.slideId           =     Int(aSavedCDPresentation.slideId)
                asaveSlide.fileType          =     aSavedCDPresentation.fileType ?? ""
               // asaveSliderr.effFrom           =   aSavedCDPresentationides.effFrom
                asaveSlide.categoryCode      =     aSavedCDPresentation.categoryCode ?? ""
                asaveSlide.name              =     aSavedCDPresentation.name ?? ""
                asaveSlide.noofSamples       =     Int(aSavedCDPresentation.noofSamples)
               //asaveSliderr.effTo             =   aSavedCDPresentationides.effTo
                asaveSlide.ordNo             =     Int(aSavedCDPresentation.ordNo)
                asaveSlide.priority          =     Int(aSavedCDPresentation.priority)
                asaveSlide.slideData         =     aSavedCDPresentation.slideData ?? Data()
                asaveSlide.utType            =     aSavedCDPresentation.utType ?? ""
                asaveSlide.isSelected        =     aSavedCDPresentation.isSelected
                asaveSlide.uuid              =     aSavedCDPresentation.uuid ?? UUID()
                asaveSlide.isFailed = aSavedCDPresentation.isFailed
                asaveSlide.isDownloadCompleted = aSavedCDPresentation.isDownloadCompleted
                saveSlidesArr.append(asaveSlide)
                
            }

        }
        
       return saveSlidesArr
    }
    
    
    func retriveSavedBrandSlides() -> [BrandSlidesModel] {
        
        var saveSlidesArr = [BrandSlidesModel]()
        
        CoreDataManager.shared.fetchBarndSlides{ SlideBrands in
            SlideBrands.forEach { aSlideBrand in
                let asaveSlide = BrandSlidesModel()
                asaveSlide.uuid = aSlideBrand.uuid ?? UUID()
                asaveSlide.priority = Int(aSlideBrand.priority ?? "0") ?? 0
                asaveSlide.divisionCode = Int(aSlideBrand.divisionCode ?? "0") ?? 0
                asaveSlide.id =   Int(aSlideBrand.id ?? "0") ?? 0
                asaveSlide.productBrdCode =  Int(aSlideBrand.productBrandCode ?? "0") ?? 0
                asaveSlide.subdivisionCode = Int(aSlideBrand.subDivisionCode ?? "0") ?? 0
                saveSlidesArr.append(asaveSlide)
            }
 
        }
        
       return saveSlidesArr
    }
    // MARK: - functionalities for slides flow Ends
}

extension CoreDataManager {
    func toSaveGeneralGroupedSlidesToCoreData(groupedBrandSlide: GroupedBrandsSlideModel  , completion: @escaping (Bool) -> ()) {
        toCheckGeneralGroupedSlidesExistance(groupedBrandSlide.productBrdCode) { isExists in
            if !isExists {
                let context = self.context
                // Create a new managed object
                if let entityDescription = NSEntityDescription.entity(forEntityName: "GeneralSlideGroupsCDModel", in: context) {
                    let GroupedBrandsSlides = GeneralSlideGroupsCDModel(entity: entityDescription, insertInto: context)
                    
                    // Convert properties
                    GroupedBrandsSlides.uuid = groupedBrandSlide.uuid
                    GroupedBrandsSlides.divisionCode = Int16(groupedBrandSlide.divisionCode)
                    GroupedBrandsSlides.priority = Int16(groupedBrandSlide.priority)
                    GroupedBrandsSlides.productBrdCode = Int16(groupedBrandSlide.productBrdCode)
                    GroupedBrandsSlides.subdivisionCode = Int16(groupedBrandSlide.subdivisionCode)
                    
                    // Convert and add groupedBrandsSlideModel
                    GroupedBrandsSlides.groupedSlide = convertToSlidesCDModel(groupedBrandSlide.groupedSlide, context: context)
                    
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
    func removeAllGeneralGroupedSlides() {
        //completion: @escaping () -> Void
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = GeneralSlideGroupsCDModel.fetchRequest()
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

    func toCheckGeneralGroupedSlidesExistance(_ id: UUID, completion: (Bool) -> ()) {
        
        do {
            let request = GeneralSlideGroupsCDModel.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(id)'")
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
    
    
    func retriveSavedGeneralGroupedSlides() -> [GroupedBrandsSlideModel] {
        
        var savePresentationArr = [GroupedBrandsSlideModel]()
        
        CoreDataManager.shared.fetchGeneralGroupedSlides { groupedBrandsArr in
            groupedBrandsArr.forEach { agroupedBrands in
                let aGroupedBrandsSlideModel = GroupedBrandsSlideModel()
                aGroupedBrandsSlideModel.uuid = agroupedBrands.uuid ?? UUID()
                aGroupedBrandsSlideModel.id = Int(agroupedBrands.id)
                aGroupedBrandsSlideModel.divisionCode = Int(agroupedBrands.divisionCode)
                aGroupedBrandsSlideModel.priority = Int(agroupedBrands.priority)
                aGroupedBrandsSlideModel.productBrdCode = Int(agroupedBrands.productBrdCode)
                aGroupedBrandsSlideModel.subdivisionCode = Int(agroupedBrands.subdivisionCode)

                var groupedSlideArr = [SlidesModel]()
                if let  groupedSlideModelSet = agroupedBrands.groupedSlide as? Set<SavedSlidesCDModel>  {
                    let groupedBrandsSlideModelArray = Array(groupedSlideModelSet)
                    groupedBrandsSlideModelArray.forEach { slidesCDModel in
                        let agroupedSlide = SlidesModel()
                        agroupedSlide.code = Int(slidesCDModel.code)
                        agroupedSlide.camp = Int(slidesCDModel.camp)
                        agroupedSlide.productDetailCode = slidesCDModel.productDetailCode ?? ""
                        agroupedSlide.filePath = slidesCDModel.filePath ?? ""
                        agroupedSlide.group = Int(slidesCDModel.group)
                        agroupedSlide.specialityCode = slidesCDModel.specialityCode ?? ""
                        agroupedSlide.slideId = Int(slidesCDModel.slideId)
                        agroupedSlide.fileType = slidesCDModel.fileType ?? ""
                        agroupedSlide.categoryCode = slidesCDModel.categoryCode ?? ""
                        agroupedSlide.name = slidesCDModel.name ?? ""
                        agroupedSlide.noofSamples = Int(slidesCDModel.noofSamples)
                        agroupedSlide.ordNo = Int(slidesCDModel.ordNo)
                        agroupedSlide.priority = Int(slidesCDModel.priority)
                        agroupedSlide.slideData = slidesCDModel.slideData ?? Data()
                        agroupedSlide.utType = slidesCDModel.utType ?? ""
                        agroupedSlide.isSelected = slidesCDModel.isSelected
                        agroupedSlide.fileName = slidesCDModel.fileName ?? ""
                        agroupedSlide.isFailed = slidesCDModel.isFailed
                        agroupedSlide.isDownloadCompleted = slidesCDModel.isDownloadCompleted
                        groupedSlideArr.append(agroupedSlide)
                    }
                    
                    aGroupedBrandsSlideModel.groupedSlide = groupedSlideArr
                    
                }
                
                savePresentationArr.append(aGroupedBrandsSlideModel)
            }
        }
        
        return savePresentationArr
    }
    
    
    
    
    
    func retriveGeneralGroupedSlides() -> [GroupedBrandsSlideModel] {
        
        var savePresentationArr = [GroupedBrandsSlideModel]()
        
        CoreDataManager.shared.fetchGeneralGroupedSlides { groupedBrandsArr in
            groupedBrandsArr.forEach { agroupedBrands in
                let aGroupedBrandsSlideModel = GroupedBrandsSlideModel()
                aGroupedBrandsSlideModel.uuid = agroupedBrands.uuid ?? UUID()
                aGroupedBrandsSlideModel.id = Int(agroupedBrands.id)
                aGroupedBrandsSlideModel.divisionCode = Int(agroupedBrands.divisionCode)
                aGroupedBrandsSlideModel.priority = Int(agroupedBrands.priority)
                aGroupedBrandsSlideModel.productBrdCode = Int(agroupedBrands.productBrdCode)
                aGroupedBrandsSlideModel.subdivisionCode = Int(agroupedBrands.subdivisionCode)

                var groupedSlideArr = [SlidesModel]()
                if let  groupedSlideModelSet = agroupedBrands.groupedSlide as? Set<GroupedSlidesCDModel>  {
                    let groupedBrandsSlideModelArray = Array(groupedSlideModelSet)
                    groupedBrandsSlideModelArray.forEach { slidesCDModel in
                        let agroupedSlide = SlidesModel()
                        agroupedSlide.code = Int(slidesCDModel.code)
                        agroupedSlide.camp = Int(slidesCDModel.camp)
                        agroupedSlide.productDetailCode = slidesCDModel.productDetailCode ?? ""
                        agroupedSlide.filePath = slidesCDModel.filePath ?? ""
                        agroupedSlide.group = Int(slidesCDModel.group)
                        agroupedSlide.specialityCode = slidesCDModel.specialityCode ?? ""
                        agroupedSlide.slideId = Int(slidesCDModel.slideId)
                        agroupedSlide.fileType = slidesCDModel.fileType ?? ""
                        agroupedSlide.categoryCode = slidesCDModel.categoryCode ?? ""
                        agroupedSlide.name = slidesCDModel.name ?? ""
                        agroupedSlide.noofSamples = Int(slidesCDModel.noofSamples)
                        agroupedSlide.ordNo = Int(slidesCDModel.ordNo)
                        agroupedSlide.priority = Int(slidesCDModel.priority)
                        agroupedSlide.slideData = slidesCDModel.slideData ?? Data()
                        agroupedSlide.utType = slidesCDModel.utType ?? ""
                        agroupedSlide.isSelected = slidesCDModel.isSelected
                        agroupedSlide.fileName = slidesCDModel.fileName ?? ""
                        agroupedSlide.isFailed = slidesCDModel.isFailed
                        agroupedSlide.isDownloadCompleted = slidesCDModel.isDownloadCompleted
                        groupedSlideArr.append(agroupedSlide)
                    }
                    
                    aGroupedBrandsSlideModel.groupedSlide = groupedSlideArr
                    
                }
                
                savePresentationArr.append(aGroupedBrandsSlideModel)
            }
        }
        
        return savePresentationArr
    }
    
    func fetchGeneralGroupedSlides(completion: ([GeneralSlideGroupsCDModel]) -> () )  {
        do {
           let savedGroupedSlides = try  context.fetch(GeneralSlideGroupsCDModel.fetchRequest())
            completion(savedGroupedSlides )
            
        } catch {
            print("unable to fetch movies")
        }
       
    }
}

    

/// - Author:  hassan
