//
//  ConfigModel.swift
//  E-Detailing
//
//  Created by San eforce on 07/11/23.
//

import Foundation

class AppConfig: Codable {
    let key : String
    let config : Config
    
    enum CodingKeys: String, CodingKey {
        case key
        case config
    }
    
    required  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.config = try container.decode(Config.self, forKey: .config)
    }
    
    init() {
        key = ""
        config = Config()
    }
}


class Config : Codable {
    let baseUrl : String
    let iosUrl : String
    let bgImg : String
    let division : String
    let logoImg : String
    let reportUrl : String
    let slideUrl : String
    let webUrl : String
    let appurl : String
    let mailUrl : String
    let syncUrl : String
    
    
    enum CodingKeys: String, CodingKey {
    
        case appurl
        case webUrl = "weburl"
        case baseUrl = "baseurl"
        case iosUrl = "iosurl"
        case slideUrl = "slideurl"
        case reportUrl = "reportUrl"
        case division = "division"
        case bgImg = "bgimg"
        case logoImg = "logoimg"
        case syncUrl = "syncurl"
        case mailUrl = "mailUrl"
    }
    
     init() {
         self.webUrl = ""
        self.iosUrl = ""
        self.bgImg = ""
        self.division = ""
        self.logoImg = ""
        self.reportUrl = ""
        self.slideUrl = ""
         self.baseUrl = ""
         self.appurl = ""
         self.mailUrl = ""
         self.syncUrl = ""
    }
    
    required init(from decoder : Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseUrl = container.safeDecodeValue(forKey: .baseUrl)
        self.webUrl = container.safeDecodeValue(forKey: .webUrl)
        self.iosUrl = container.safeDecodeValue(forKey: .iosUrl)
        self.bgImg = container.safeDecodeValue(forKey: .bgImg)
        self.division = container.safeDecodeValue(forKey: .division)
        self.logoImg = container.safeDecodeValue(forKey: .logoImg)
        self.reportUrl = container.safeDecodeValue(forKey: .reportUrl)
        self.slideUrl = container.safeDecodeValue(forKey: .slideUrl)
        self.appurl = container.safeDecodeValue(forKey: .appurl)
        self.mailUrl = container.safeDecodeValue(forKey: .mailUrl)
        self.syncUrl = container.safeDecodeValue(forKey: .syncUrl)
    }
}

