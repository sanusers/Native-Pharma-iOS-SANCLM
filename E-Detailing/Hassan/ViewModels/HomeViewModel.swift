//
//  HomeViewModal.swift
//  E-Detailing
//
//  Created by Hassan on 07/11/23.
//

import Foundation

class  HomeViewModal: BaseViewModel {
    
    func getConfigData(params: JSON, api : APIEnums, _ result : @escaping (Result<[AppConfig],Error>) -> Void) {
        
        ConnectionHandler.shared.getRequest(for: api, params: params)
            .responseDecode(to: [AppConfig].self, { (json) in
                result(.success(json))
                dump(json)
            }).responseFailure({ (error) in
                print(error.description)
                
            })
    }
    
    func doUserLogin(params: JSON, api : APIEnums, _ result : @escaping (Result<LoginData,Error>) -> Void) {
        ConnectionHandler.shared.getRequest(for: api, params: params)
            .responseDecode(to: LoginData.self, { (json) in
                result(.success(json))
                dump(json)
            }).responseFailure({ (error) in
                print(error.description)
                
            })
    }
    
}
