//
//  APIenums.swift
//  E-Detailing
//
//  Created by Hassan on 07/11/23.
//


import Foundation
import Alamofire

enum APIEnums : String{
    
    case none = ""
    case actionLogin = "action/login"
    
}


extension APIEnums{//Return method for API
    var method : HTTPMethod{
        switch self {
        case .actionLogin:
            return .post
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
