//
//  LocalStorage.swift
//  E-Detailing
//
//  Created by San eforce on 07/12/23.
//

import Foundation

class LocalStorage {
    static var shared = LocalStorage()
    
    var sentToApprovalModelArr = [SentToApprovalModel]()
    
    enum LocalValue:String {

        case istoEnableApproveBtn
        case TPalldatesAppended
        case TPisForFinalDate
        case isMR
    }
    
    func setSting(_ key:LocalValue,text:String = "" ){
        UserDefaults.standard.set(text, forKey: key.rawValue)
    }
    
    func setDouble(_ key :LocalValue,value:Double = 0.0) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func setBool(_ key :LocalValue,value:Bool = false) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getBool(key:LocalValue)->Bool{
        if UserDefaults.standard.object(forKey: key.rawValue) == nil {
            self.setBool(key)
        }
     let result = UserDefaults.standard.bool(forKey: key.rawValue)
            return result
        
    }
    
    func getString(key:LocalValue)->String{
        if UserDefaults.standard.object(forKey: key.rawValue) == nil {
            self.setSting(key)
        }
        if let result = UserDefaults.standard.string(forKey: key.rawValue) {
            return result
        }
        return  ""
    }
    
    func getDouble(key:LocalValue)->Double {
        if UserDefaults.standard.object(forKey: key.rawValue) == nil {
            self.setDouble(key)
        }
        let result = UserDefaults.standard.double(forKey: key.rawValue)
        return result
    }
}
