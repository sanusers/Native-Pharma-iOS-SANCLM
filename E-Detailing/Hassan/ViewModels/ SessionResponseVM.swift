//
//   SessionResponseVM.swift
//  E-Detailing
//
//  Created by San eforce on 20/11/23.
//

import Foundation
class  SessionResponseVM {
    
    func getTourPlanData(params: JSON, api : APIEnums, _ result : @escaping (Result<SessionAPIResponseModel,Error>) -> Void) {
        
        ConnectionHandler.shared.getRequest(for: api, params: params)
            .responseDecode(to: SessionAPIResponseModel.self, { (json) in
                result(.success(json))
                dump(json)
            }).responseFailure({ (error) in
                print(error.description)
                
            })
    }
    
    func getZstoreData(params: JSON, api : APIEnums, _ result : @escaping (Result<ZstoreDataModel,Error>) -> Void) {
        
        ConnectionHandler.shared.getRequest(for: api, params: params)
            .responseDecode(to: ZstoreDataModel.self, { (json) in
                result(.success(json))
                dump(json)
            }).responseFailure({ (error) in
                print(error.description)
                
            })
    }
    
    
    
}
