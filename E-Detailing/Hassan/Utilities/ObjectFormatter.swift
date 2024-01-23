//
//  ObjectFormatter.swift
//  E-Detailing
//
//  Created by San eforce on 23/01/24.
//

import Foundation
class ObjectFormatter {
    
    static let shared = ObjectFormatter()
    
    
    func convertData2Obj(data: Data) -> JSON {
        

        
        
        return JSON()
    }
    
    
    
    func convertJson2Data(json: JSON) -> Data {
        
        var jsonDatum = Data()

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            jsonDatum = jsonData
           
            // Convert JSON data to a string
            if let tempjsonString = String(data: jsonData, encoding: .utf8) {
                print(tempjsonString)

            }
            return jsonDatum

        } catch {
            print("Error converting parameter to JSON: \(error)")
        }
        
        return Data()
    }
    
    
    func convertJsonArr2Data(json: [JSON]) -> Data {
        
        var jsonDatum = Data()

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: [json], options: [])
            jsonDatum = jsonData
           
            // Convert JSON data to a string
            if let tempjsonString = String(data: jsonData, encoding: .utf8) {
                print(tempjsonString)

            }
            return jsonDatum

        } catch {
            print("Error converting parameter to JSON: \(error)")
        }
        
        return Data()
    }
    
    
}
