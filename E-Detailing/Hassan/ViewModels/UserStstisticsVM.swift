//
//  UserStstisticsVM.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 15/02/24.
//

import Foundation

public enum UserStatisticsError: String, Error {
case unableConnect = "An issue occured data will be saved to device"
}

class UserStatisticsVM {
    
    func getTodayCallsData(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<[TodayCallsModel],UserStatisticsError>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: [TodayCallsModel].self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(UserStatisticsError.unableConnect))
        })
    }
    
    
    
    func saveDCRdata(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<DCRCallesponseModel,UserStatisticsError>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: DCRCallesponseModel.self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(UserStatisticsError.unableConnect))
        })
    }
}
