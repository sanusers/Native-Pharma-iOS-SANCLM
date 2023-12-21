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
    case tableSetup = "table/setups"
    case saveTP = "savenew/tp"
    case sendToApproval = "save/tp"
    case getAllPlansData = "get/tp"
    case getReports = "get/reports"
}


extension APIEnums{//Return method for API
    var method : HTTPMethod{
        switch self {
        case .actionLogin, .tableSetup, .saveTP, .getAllPlansData, .getReports:
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
