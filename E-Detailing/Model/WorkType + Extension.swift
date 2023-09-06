//
//  WorkType + Extension.swift
//  E-Detailing
//
//  Created by SANEFORCE on 26/06/23.
//

import Foundation
import CoreData



extension WorkType {
    
    func setValues(fromDictionary dictionary: [String:Any])    {
        if let codeValue = dictionary["Code"] as? String{
            code = codeValue
        }
        if let eTabsValue = dictionary["ETabs"] as? String{
            eTabs = eTabsValue
        }
        if let fwFlgValue = dictionary["FWFlg"] as? String{
            fwFlg = fwFlgValue
        }
        if let nameValue = dictionary["Name"] as? String{
            name = nameValue
        }
        if let sfCodeValue = dictionary["SF_Code"] as? String{
            sfCode = sfCodeValue
        }
        if let tpDCRValue = dictionary["TP_DCR"] as? String{
            tpDCR = tpDCRValue
        }
        if let codeValue = dictionary["Code"] as? String{
            code = codeValue
        }
        if let terrslFlgValue = dictionary["TerrSlFlg"] as? String{
            terrslFlg = terrslFlgValue
        }
    }
    
}

extension Territory {
    
    func setValues(fromDictionary dictionary: [String:Any],id : String)    {
        if let codeValue = dictionary["Code"] as? String{
            code = codeValue
        }
        if let latValue = dictionary["Lat"] as? String{
            lat = latValue
        }
        if let longValue = dictionary["Long"] as? String{
            long = longValue
        }
        if let nameValue = dictionary["Name"] as? String{
            name = nameValue
        }
        if let sfCodeValue = dictionary["SF_Code"] as? String{
            sfCode = sfCodeValue
        }
        mapId = id
    }
}
