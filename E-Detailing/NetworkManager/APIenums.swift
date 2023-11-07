//
//  APIenums.swift
//  E-Detailing
//
//  Created by San eforce on 07/11/23.
//


import Foundation
import Alamofire

enum APIEnums : String{
    
    case none
    case loginAction = "action/login"
    
}


extension APIEnums{//Return method for API
    var method : HTTPMethod{
        switch self {
        default:
            return .get
        }
    }

    var cacheAttribute: Bool{
        switch self {
        default:
            return false
        }
    }
}
