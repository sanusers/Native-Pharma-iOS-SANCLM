//
//   SessionResponseVM.swift
//  E-Detailing
//
//  Created by San eforce on 20/11/23.
//

import Foundation
import Alamofire
class  SessionResponseVM {
    
    enum TPErrors: String, Error {
        case unableConnect = "An issue occured data will be saved to device"
    }
    
    func getTourPlanData(params: JSON, api : APIEnums, _ result : @escaping (Result<GeneralResponseModal,Error>) -> Void) {
        
        ConnectionHandler.shared.getRequest(for: api, params: params)
            .responseDecode(to: GeneralResponseModal.self, { (json) in
                result(.success(json))
                dump(json)
            }).responseFailure({ (error) in
                print(error.description)
                
            })
    }
    
    func uploadTPmultipartFormData(params: JSON, api : APIEnums, paramData: Data, _ result : @escaping (Result<SaveTPresponseModel,TPErrors>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: SaveTPresponseModel.self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(TPErrors.unableConnect))
        })
    }
    
    
//    func getTableSetup(params: JSON, api : APIEnums, _ result : @escaping (Result<TableSetupModel,Error>) -> Void) {
//        let responseHandler = APIResponseHandler()
//        ConnectionHandler.shared.getRequest(for: api, params: params).responseJSON { json in
//            print(json)
//            // Convert the dictionary to JSON data
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//                // Use jsonData as needed
//                print(String(data: jsonData, encoding: .utf8)!)
//
//                let decoder = JSONDecoder()
//                  do {
//                      let decodedObj = try decoder.decode(TableSetupModel.self, from: jsonData)
//                      result(.success(decodedObj))
//                  } catch {
//                      print("Error")
//                      result(.failure(error))
//                  }
//
//
//            } catch {
//                print("Error converting JSON to data: \(error)")
//                result(.failure(error))
//            }
//
//        }
//
//    }

}
