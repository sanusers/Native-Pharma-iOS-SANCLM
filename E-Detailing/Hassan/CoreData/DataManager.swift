//
//  DataManager.swift
//  E-Detailing
//
//  Created by San eforce on 29/11/23.
//

import Foundation
import UIKit
import CoreData


enum CDMError: String, Error {
    case UnabletoFetch = "Unable to retrive data from DB"
    case UnabletoSave = "Unable to save data to DB"
    case others = "Falied to save"
}

open class DataManager: NSObject {

    public static let sharedInstance = DataManager()

    private override init() {}
    var plans:[SessionDetailArrCDM]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var EachDatePlanEntity: NSEntityDescription = {
         let managedContext = getContext()
         return NSEntityDescription.entity(forEntityName: "SessionDetailArrCDM", in: managedContext!)!
     }()
    // Helper func for getting the current context.
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }

    func retrieveEachDatePlan() -> NSManagedObject? {
        guard let managedContext = getContext() else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionDetailArrCDM")

        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if result.count > 0 {
                
                // Assuming there will only ever be one User in the app.
                return result[0]
            } else {
                return nil
     

            }
        } catch let error as NSError {
            print("Retrieving user failed. \(error): \(error.userInfo)")
           return nil
        }

    }
    
    
    

    func savePlan(_ plan: SessionDetailsArr) {
        
        
//        guard let appDelegate =
//                UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        // 1
//        let managedContext =
//        appDelegate.persistentContainer.viewContext
//
//        // 2
//        let entity =
//        NSEntityDescription.entity(forEntityName: "TourPlanArrCDM",
//                                   in: managedContext)!
//
//        let allplanDetailsObj = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//
//        // 3
//       // person.setValue(name, forKeyPath: "name")
//
//        var tempPlans  = [SessionDetailsArr]()
//        if let pastPlans = allplanDetailsObj.value(forKey: "arrOfPlan") as? [SessionDetailsArr] {
//            tempPlans += pastPlans
//        }
//        plan.forEach { sessionDet in
//            tempPlans.append(sessionDet)
//        }
//
//        allplanDetailsObj.setValue(tempPlans, forKey: "arrOfPlan")
//
//        do {
//          try managedContext.save()
//         // people.append(person)
//        } catch let error as NSError {
//          print("Could not save. \(error), \(error.userInfo)")
//        }
//
//
        
        
        
      //  print(NSStringFromClass(type(of: plan)))
        guard let managedContext = getContext() else { return }
        guard let plans = retrieveEachDatePlan() else { return }

        var tempPlans  = [SessionDetailsArr]()
        if let pastPlans = plans.value(forKey: "sessionDetailArr") as? [SessionDetailsArr] {
            tempPlans += pastPlans
        }
      //  plan.forEach { sessionDet in
            tempPlans.append(plan)
       // }

        plans.setValue(tempPlans, forKey: "sessionDetailArr")

        do {
            print("Saving session...")
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save session data! \(error): \(error.userInfo)")
        }
        //        guard let managedContext = getContext() else { return }
        //        let planArr = TourPlanArrCDM(context: managedContext)
        //        if  planArr.arrOfPlan == nil {
        //            planArr.arrOfPlan =  [SessionDetailsArr]()
        //        }
        //        plan.forEach { sessionDet in
        //            planArr.arrOfPlan?.append(sessionDet)
        //        }
        //
        //        do {
        //            try managedContext.save()
        //            //completion(true)
        //        } catch {
        //           print("unable to save")
        //
        //        }
    }

    func removeAllPlans() {

              //  guard let managedContext = getContext() else { return }
//                guard let plans = retrieveEachDatePlan() else { return }
//
//               if let _ = plans.value(forKey: "tourplanArr") as? [TourPlanArr] {
//                   plans.setValue(nil, forKey: "tourplanArr")
//               }

    }


    func retrivePlan(completion: @escaping (Result<[SessionDetailsArr], CDMError>) -> ()) {
        
        
//
//        guard let appDelegate =
//           UIApplication.shared.delegate as? AppDelegate else {
//            completion(.failure(.others))
//         }
//
//         let managedContext =
//           appDelegate.persistentContainer.viewContext
//
//         //2
//         let fetchRequest =
//           NSFetchRequest<NSManagedObject>(entityName: "Person")
//
//         //3
//         do {
//           people = try managedContext.fetch(fetchRequest)
//         } catch let error as NSError {
//           print("Could not fetch. \(error), \(error.userInfo)")
//         }
//
        

        if getContext() != nil {
            if let plans = retrieveEachDatePlan() {
                if let pastBooks = plans.value(forKey: "sessionDetailArr") as? [SessionDetailsArr] {
                    completion(.success(pastBooks))
                } else {
                    completion(.failure(.UnabletoFetch))
                }
            }
        }


//        do {
//            plans = try  context.fetch(TourPlanArrCDM.fetchRequest())
//           // completion(movies ?? [Film]())
//            plans?.forEach({ cdm in
//                dump(cdm.arrOfPlan)
//            })
//        } catch {
//            print("unable to fetch movies")
//
//        }
//        return plans ?? [TourPlanArrCDM]()
    }

}
extension DataManager {
    /// Creates a new user with fresh starting data.
    func createUser() {
        guard let managedContext = getContext() else { return }
        let user = NSManagedObject(entity: EachDatePlanEntity, insertInto: managedContext)
      //  let newuser = EachDatePlanCDM(context: managedContext)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save new user! \(error): \(error.userInfo)")
        }
    }
    
//    func deleteAllRecords() {
//        guard let managedContext = getContext() else { return }
//
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionDetailArrCDM")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//        }catch {
//
//        }
//    }
}
