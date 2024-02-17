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
    
    func fetchMasterData(type: MasterInfo, sfCode: String, istoUpdateDCRlist: Bool, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        dump(type.getUrl)
        dump(type.getParams)

        AF.request(type.getUrl, method: .post, parameters: type.getParams).responseData { [weak self] (response) in
            guard let welf = self else { return }

            switch response.result {
            case .success(_):
                guard let apiResponse = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [[String: Any]] else {
                    print("Unable to serialize")
                    return
                }

                print(apiResponse)
                // Save to Core Data or perform any other actions
                DBManager.shared.saveMasterData(type: type, Values: apiResponse, id: sfCode)

                if istoUpdateDCRlist && !welf.isUpdating {
                    welf.updateDCRLists() { _ in
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
    
 
    
    
    func updateDCRLists(completion: @escaping (Bool) -> ()) {
        let dispatchgroup = DispatchGroup()
        isUpdating = true
        let dcrEntries : [MasterInfo] = [.doctorFencing, .chemists, .unlistedDoctors, .stockists]
     
        dcrEntries.forEach { aMasterInfo in
            dispatchgroup.enter()
            
            fetchMasterData(type: aMasterInfo, sfCode: LocalStorage.shared.getString(key: LocalStorage.LocalValue.rsfID), istoUpdateDCRlist: true) { _ in
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
