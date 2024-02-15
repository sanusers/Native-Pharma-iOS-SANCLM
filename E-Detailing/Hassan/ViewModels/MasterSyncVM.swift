//
//  MasterSyncVM.swift
//  E-Detailing
//
//  Created by San eforce on 15/02/24.
//

import Foundation
class MasterSyncVM {
    
    public enum MasterSyncErrors: String, Error {
    case unableConnect = "An issue occured data will be saved to device"
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
