//
//  MainVC + APIs.swift
//  SAN ZEN
//
//  Created by San eforce on 29/06/24.
//

import Foundation
extension MainVC {
    
    func uploadDCRcallsSequentially(dates: [String], index: Int = 0, completion: @escaping() -> ()) {
        // Base case: if the index is equal to the count of dates, we are done
        
        guard index < dates.count else {
            print("All dates have been processed")
            completion()
            return
        }

        // Get the current date to process
        let currentDate = dates[index]
        
        // Call the API for the current date
        self.toretryDCRupload(date: currentDate) {[weak self] success in
            guard let welf = self else {return}
            // Move to the next date
            welf.uploadDCRcallsSequentially(dates: dates, index: index + 1, completion: completion)
        }
    }
    
    func uploadDayPlansSequentially(dates: [String], index: Int = 0, completion: @escaping() -> ()) {
        guard index < dates.count else {
            print("All dates have been processed")
            completion()
            return
        }
        // Get the current date to process
        let currentDate = dates[index]
        
        self.toPostDayplan(byDate: currentDate.toDate(format: "yyyy-MM-dd" )) { [weak self] in
            guard let welf = self else {return}
            // Move to the next date
            welf.uploadDayPlansSequentially(dates: dates, index: index + 1, completion: completion)
                
        }
        
    }
    
    func syncAllCalls() {
        if obj_sections.isEmpty {
            return
        }
        
        let unSyncedDates : [String] = obj_sections.map { aSection in
           return aSection.date
        }

        Shared.instance.showLoaderInWindow()
        
        uploadDCRcallsSequentially(dates: unSyncedDates) {  [weak self] in
            
            guard let welf = self else {return}
          
            welf.toUploadUnsyncedImage() {
                
                welf.uploadDayPlansSequentially(dates: unSyncedDates) {
                    Shared.instance.removeLoaderInWindow()
                    
                }
         
                welf.refreshDashboard(date: Shared.instance.selectedDate) {
                    
                }
            }
            
  
            
        }

    }
    
    func callSavePlanAPI(byDate: Date, completion: @escaping (Bool) -> Void) {
        var dayEntities : [DayPlan] = []
        CoreDataManager.shared.retriveSavedDayPlans(byDate: byDate) { dayplan in
            
            dayEntities = dayplan
            
            let aDayplan = dayEntities.first
             
             do {
                 let encoder = JSONEncoder()
                 let jsonData = try encoder.encode(aDayplan)
                 

                 if var jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                     print("JSON Dictionary: \(jsonObject)")
                     jsonObject["InsMode"] = "0"
                     var toSendData = [String: Any]()
                     
                     let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: jsonObject)
                     
                     toSendData["data"] = jsonDatum
                     
                     
                     self.userststisticsVM?.saveMyDayPlan(params: toSendData, api: .myDayPlan, paramData: jsonObject, { [ weak self ] result in
                         guard let welf = self else {return}
                         switch result {
                             
                         case .success(let response):
                             dump(response)
                             
                             LocalStorage.shared.setBool(LocalStorage.LocalValue.istoUploadDayplans, value: false)
                            

                             welf.masterVM?.toGetMyDayPlan(type: .myDayPlan, isToloadDB: true, date: Shared.instance.selectedDate) {_ in
 
                                 completion(true)
                                 welf.toCreateToast(response.msg ?? "")
                             }
                         case .failure(let error):
                             completion(false)
                             

                             
                             welf.toCreateToast(error.rawValue)
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
         
        
         

    }
    
    func toretryDCRupload(date: String, completion: @escaping (Bool) -> Void) {
        var userAddress: String?
    
        Pipelines.shared.getAddressString(latitude: self.latitude ?? Double(), longitude: self.longitude ?? Double()) { [weak self] address in
            guard let welf = self else{return}
            userAddress = address
            
            
            CoreDataManager.shared.toFetchAllOutboxParams { outboxCDMs in
                guard let aoutboxCDM = outboxCDMs.first else {
                    completion(false)
                    return}
                
                let coreparamDatum = aoutboxCDM.unSyncedParams
                
                guard let paramData = coreparamDatum else {
                    completion(false)
                    return}
                
                
                var localParamArr = [String: [[String: Any]]]()
                do {
                    localParamArr  = try JSONSerialization.jsonObject(with: paramData, options: []) as? [String: [[String: Any]]] ?? [String: [[String: Any]]]()
                    dump(localParamArr)
                } catch {
                    //  self.toCreateToast("unable to retrive")
                    completion(false)
                }
                
                var specificDateParams : [[String: Any]] = [[:]]
                
                
                if date.isEmpty {
                    localParamArr.forEach { key, value in
                        
                        specificDateParams = value
                        
                        
                        for index in 0..<specificDateParams.count {
                            var paramData = specificDateParams[index]
                            
                            // Check if "Entry_location" key exists
                            if let _ = paramData["Entry_location"] as? String {
                                // Update the value of "Entry_location" key
                                paramData["Entry_location"] = "\(welf.latitude ?? Double()):\(welf.longitude ?? Double())"
                            }
                            
                            // Check if "address" key exists
                            if let _ = paramData["address"] as? String {
                                // Update the value of "address" key
                                paramData["address"] = userAddress ?? ""
                            }
                            
                            // Update the dictionary in specificDateParams array
                            specificDateParams[index] = paramData
                        }
                        
                        
                    }
                } else {
                    if localParamArr.isEmpty {
                        completion(true)
                    }
                    localParamArr.forEach { key, value in
                        if key == date {
                            dump(value)
                            specificDateParams = value

                            for index in 0..<specificDateParams.count {
                                var paramData = specificDateParams[index]
                                
                                // Check if "Entry_location" key exists
                                if paramData["Entry_location"] is String {
                                    // Update the value of "Entry_location" key
                                    paramData["Entry_location"] = "\(welf.latitude ?? Double()):\(welf.longitude ?? Double())"
                                }
                                
                                // Check if "address" key exists
                                if paramData["address"] is String {
                                    // Update the value of "address" key
                                    paramData["address"] = userAddress ?? ""
                                }
                                
                                // Update the dictionary in specificDateParams array
                                specificDateParams[index] = paramData
                            }
                            
                        }
                    }
                }
                
                print("specificDateParams has \(specificDateParams.count) values")
                if !localParamArr.isEmpty {
                    Shared.instance.showLoaderInWindow()
                    let refreshDate = date.toDate(format: "yyyy-MM-dd")
                    welf.toSendParamsToAPISerially(refreshDate: refreshDate, index: 0, items: specificDateParams) { isCompleted in
                    
                        if isCompleted {
                            Shared.instance.removeLoaderInWindow()
                            completion(true)
                        }
                    }
                } else {
                    Shared.instance.removeLoaderInWindow()
                    completion(true)
                }
                
            }
            

           // let paramData = LocalStorage.shared.getData(key: .outboxParams)

            
            }
        
        
        
        

        
    }
    
    func toSendParamsToAPISerially(refreshDate: Date, index: Int, items: [JSON], completion: @escaping (Bool) -> Void) {
      guard index < items.count else {
        completion(true) // All items processed, signal completion
        return
      }

      let currentItem = items[index]

      // Attempt to convert JSON to Data
      guard let jsonData = try? JSONSerialization.data(withJSONObject: currentItem, options: []) else {
        completion(false) // Error converting JSON, signal failure
        return
      }

      // Prepare data for API request
      let toSendData = ["data": jsonData]

      // Send API request
        sendAPIrequest(refreshDate: refreshDate, toSendData, paramData: currentItem) { callStatus in
        let nextIndex = index + 1
            self.toSendParamsToAPISerially(refreshDate: refreshDate, index: nextIndex, items: items, completion: completion)
      }
    }
    
    func callDayPLanAPI(date: Date, isFromDCRDates: Bool, completion: @escaping () -> ()) {
       // Shared.instance.showLoaderInWindow()
        if LocalStorage.shared.getBool(key: .isConnectedToNetwork) {
            masterVM?.toGetMyDayPlan(type: .myDayPlan, isToloadDB: true, date: date, isFromDCR: isFromDCRDates) {[weak self] result in
                guard let welf = self else {return}
                switch result {
                case .success(let response):
                        completion()
                case .failure(let error):
                  welf.toCreateToast(error.rawValue)
                    completion()
                }
              
            }
        } else {
            completion()
        }
    }
    
}
