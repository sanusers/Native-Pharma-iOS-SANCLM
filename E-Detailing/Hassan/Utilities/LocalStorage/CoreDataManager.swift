//
//  PresentationCoreDataManager.swift
//  E-Detailing
//
//  Created by San eforce on 29/01/24.
//



import Foundation
import CoreData
import UIKit
class CoreDataManager {
    static let shared = CoreDataManager()
    var savedCDpresentations:[SavedCDPresentation]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchPresentations(completion: ([SavedCDPresentation]) -> () )  {
        do {
            savedCDpresentations = try  context.fetch(SavedCDPresentation.fetchRequest())
            completion(savedCDpresentations ?? [SavedCDPresentation]())
            
        } catch {
            print("unable to fetch movies")
        }
       
    }
    // MARK: - functionalities for presentation flow
    
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
                cdGroupedBrandsSlideModel.groupedSlide = convertToSlidesCDModel(groupedBrandsSlideModel.groupedSlide, context: context)

                // Add to set
                cdGroupedBrandsSlideModels.add(cdGroupedBrandsSlideModel)
            }
        }

        return cdGroupedBrandsSlideModels
    }
    
    
    /// function used to convert codable class objet array to NSset. sincc core data saves object of type NSset
    /// - Parameters:
    ///   - slidesModels: object of type [SlidesModel]
    ///   - context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /// - Returns: NSSet
    private func convertToSlidesCDModel(_ slidesModels: [SlidesModel], context: NSManagedObjectContext) -> NSSet {
        let cdSlidesModels = NSMutableSet()

        for slidesModel in slidesModels {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "SlidesCDModel", in: context) {
                let cdSlidesModel = SlidesCDModel(entity: entityDescription, insertInto: context)
                
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
                
                
                
                // Convert other properties...
                
                // Add to set
                cdSlidesModels.add(cdSlidesModel)
            }
        }

        return cdSlidesModels
    }
    
    
    
    /// function fetches core data objet and returns as codable objet
    /// - Returns: object of type [SavedPresentation]
    func retriveSavedPresentations() -> [SavedPresentation] {
        
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
                        if let  groupedSlideModelSet = aGroupedBrandsSlideCDModel.groupedSlide as? Set<SlidesCDModel>  {
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
        
        return savePresentationArr
    }
    // MARK: - functionalities for presentation flow Ends
}

    

/// - Author:  hassan
