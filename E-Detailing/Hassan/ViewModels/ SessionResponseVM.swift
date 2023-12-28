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
    
    //getAllPlansData
    func getTourPlanData(params: JSON, api : APIEnums, _ result : @escaping (Result<SessionResponseModel,Error>) -> Void) {
        
        ConnectionHandler.shared.getRequest(for: api, params: params)
            .responseDecode(to: SessionResponseModel.self, { (json) in
                result(.success(json))
                dump(json)
            }).responseFailure({ (error) in
                result(.failure(TPErrors.unableConnect))
                print(error.description)
                
            })
    }
    
    
    func getTourPlanData(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<SessionResponseModel,TPErrors>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: SessionResponseModel.self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(TPErrors.unableConnect))
        })
    }
    
    
    
    func uploadTPmultipartFormData(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<SaveTPresponseModel,TPErrors>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: SaveTPresponseModel.self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(TPErrors.unableConnect))
        })
    }
    
    
    func getReportsData(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<[ReportsModel],TPErrors>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: [ReportsModel].self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(TPErrors.unableConnect))
        })
    }

    func getDetailedReportsData(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<[DetailedReportsModel],TPErrors>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: [DetailedReportsModel].self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(TPErrors.unableConnect))
        })
    }
    
}
