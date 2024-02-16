//
//  MasterSyncVM.swift
//  E-Detailing
//
//  Created by San eforce on 15/02/24.
//

import Foundation
import Alamofire

enum MasterSyncErrors: String, Error {
case unableConnect = "An issue occured data will be saved to device"
}

class MasterSyncVM {
    

    
    func fetchMasterData(type : MasterInfo, sfCode: String, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        
            AF.request(type.getUrl,method: .post,parameters: type.getParams).responseData(){ (response) in
                
                switch response.result {
                case .success(_):
//                    do {
//                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
//                        print(apiResponse)
//                        if let responseDic = apiResponse as? JSON {
//                            DBManager.shared.saveMasterData(type: type, Values: [responseDic],id: sfCode)
//                        }
//                        completionHandler(response)
//                    } catch {
//                        print("Unable to serialize")
//                    }
                    
                    do {
                        if  let apiResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [[String: Any]] {
                            print(apiResponse)
                            // Save to Core Data or perform any other actions
                            DBManager.shared.saveMasterData(type: type, Values: apiResponse, id: sfCode)
                        }
                        
                        completionHandler(response)
                    } catch {
                        print("Unable to serialize")
                    }
                    
                case .failure(let error):
                    completionHandler(response)
                print(error)
                }
                
              
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
