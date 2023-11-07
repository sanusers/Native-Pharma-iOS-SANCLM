//
//  APIresponseProtocol.swift
//  E-Detailing
//
//  Created by San eforce on 07/11/23.
//

import Foundation

//MARK:- protocol APIResponseProtocol
protocol APIResponseProtocol{
    func responseDecode<T: Decodable>(to modal : T.Type,
                              _ result : @escaping Closure<T>) -> APIResponseProtocol
    func responseJSON(_ result : @escaping Closure<[JSON]>) -> APIResponseProtocol
    func responseFailure(_ error :@escaping Closure<String>)
}


typealias Closure<T> = (T)->()

extension JSONDecoder{
    func decode<T : Decodable>(_ model : T.Type,
                               result : @escaping Closure<T>) ->Closure<Data>{
        return { data in
            do{
                let value = try self.decode(model.self, from: data)
                result(value)
                
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
