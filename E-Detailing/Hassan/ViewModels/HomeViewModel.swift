//
//  HomeViewModal.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 07/11/23.
//

import Foundation

class  HomeViewModal: BaseViewModel {
    
    enum HomeError: String, Error {
        
    case unableConnect = "Request time out"
   // case customError(message: String)
    }
    
    func getConfigData(params: JSON, api : APIEnums, _ result : @escaping (Result<[AppConfig],Error>) -> Void) {
        
        ConnectionHandler.shared.getRequest(for: api, params: params)
            .responseDecode(to: [AppConfig].self, { (json) in
                result(.success(json))
                dump(json)
            }).responseFailure({ (error) in
                print(error.description)
                
            })
    }
    
    
//    func doUserLogin(params: JSON, api : APIEnums, _ result : @escaping (Result<AppSetupModel,Error>) -> Void) {
//        
//        ConnectionHandler.shared.getRequest(for: api, params: params)
//            .responseDecode(to: AppSetupModel.self, { (json) in
//                result(.success(json))
//                dump(json)
//            }).responseFailure({ (error) in
//                print(error.description)
//                
//            })
//    }
    
    
    func doUserLogin(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<AppSetUp,HomeError>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: AppSetUp.self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(HomeError.unableConnect))
        })
    }
    
}
