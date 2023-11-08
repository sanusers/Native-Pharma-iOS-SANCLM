//
//  APIResponseHandler.swift
//  E-Detailing
//
//  Created by Hassan on 07/11/23.
//

import Foundation

class APIResponseHandler : APIResponseProtocol{
  
    init(){
    }
    var jsonSeq : Closure<[JSON]>?
    var dataSeq : Closure<Data>?
    var errorSeq : Closure<String>?
    
    func responseDecode<T>(to modal: T.Type, _ result: @escaping Closure<T>) -> APIResponseProtocol where T : Decodable {
        
        let decoder = JSONDecoder()
        self.dataSeq =  decoder.decode(modal, result: result)
        return self
    }
    
    func responseJSON(_ result: @escaping Closure<[JSON]>) -> APIResponseProtocol {
        self.jsonSeq = result
        return self
    }
    func responseFailure(_ error: @escaping Closure<String>) {
        self.errorSeq = error
        
      }
      

    

    func handleSuccess(value : [JSON], data : Data){
        //
        if let jsonEscaping = self.jsonSeq{
            jsonEscaping(value as [JSON])
        }
        if let dataEscaping = dataSeq{
            dataEscaping(data)
            
        }
    }
    func handleFailure(value : String){
        self.errorSeq?(value)
     }
   
}
