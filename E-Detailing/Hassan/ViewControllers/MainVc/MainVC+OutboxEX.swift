//
//  MainVC+Outbox EX.swift
//  E-Detailing
//
//  Created by San eforce on 06/06/24.
//

import Foundation

extension MainVC {
    func toretryDCRupload(custCode: String, date: String, completion: @escaping (Bool) -> Void) {
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
                            let upDatedValues = value.filter { aDict in
                                aDict["CustCode"] as! String == custCode
                            }
                            specificDateParams = upDatedValues
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
                  
                    welf.toSendParamsToAPISerially(refreshDate: date.toDate(format: "yyyy-MM-dd"), index: 0, items: specificDateParams) { isCompleted in
                    
                        if isCompleted {
                          
                            completion(true)
                        }
                    }
                } else {
               
                    completion(true)
                }
                
            }
            

           // let paramData = LocalStorage.shared.getData(key: .outboxParams)

            
            }
        
        
        
        

        
    }
}

