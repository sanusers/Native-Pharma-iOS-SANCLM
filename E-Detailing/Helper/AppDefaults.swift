//
//  AppDefaults.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 14/06/23.
//

import Foundation

enum keys : String {
    
    case config = "Config"
    case logoImage = "Logo Image"
    case appSetUp = "App Set Up"
    case slide = "Slides"
    case syncTime = "Sync Time"
}

class AppDefaults {
    
    
    static let shared = AppDefaults()
    
    var webUrl : String = ""
    var iosUrl  : String = ""
    var syncUrl : String = ""
    var imgLogo : String = ""
    var slideUrl : String  = ""
    var reportUrl : String = ""
    
    var sfCode : String = ""
    
    let userdefaults = UserDefaults.standard
    
    
    
    func getConfig() -> AppConfig {
        
        guard let config = self.get(key: .config, type: [String : Any]()) else {
           return AppConfig(fromDictionary: [:])
        }
        
        let configData = AppConfig(fromDictionary: config)
        
        if let config = configData.config {
            
            self.webUrl = config.webUrl
            self.iosUrl = config.iosUrl
            self.syncUrl = config.syncUrl
            self.slideUrl = config.slideUrl
            self.imgLogo = config.logoImg
            self.reportUrl = config.reportUrl
        }
        return configData
    }
    
    
    func isConfigAdded () -> Bool {
        guard let _ = self.get(key: .config, type: [String: Any]()) else {
            return false
        }
        return true
    }
    
    func isLoggedIn() -> Bool {
        guard let appsetup = self.get(key: .appSetUp, type: [String : Any]())else{
            return false
        }
        
        return !appsetup.isEmpty
    }
    
    func getLogoImgData() -> [String : Any] {
        guard let data = self.get(key: .logoImage, type: [String : Any]())else{
            return [String : Any]()
        }
        return data
    }
    
    func getAppSetUp() -> AppSetUp {
        guard let setup = self.get(key: .appSetUp, type: [String : Any]()) else {
            return AppSetUp(fromDictionary: [:])
        }
        return AppSetUp(fromDictionary: setup)
    }
    
    
    func getSlides() -> [[String : Any]] {
        guard let slideArray = self.get(key: .slide, type: [[String : Any]]()) else{
            return [[String : Any]]()
        }
        return slideArray
    }
    
    
    func getSyncTime() -> Date {
        if let date = self.get(key: .syncTime, type: Date()) {
            return date
        }
        return Date()
    }
    
    
    func reset () {
        let dictionary = self.userdefaults.dictionaryRepresentation()
        dictionary.keys.forEach{ key in
            self.userdefaults.removeObject(forKey: key)
        }
        self.userdefaults.synchronize()
    }
    
    
    func resetLogin() {
        self.userdefaults.removeObject(forKey: keys.appSetUp.rawValue)
        self.userdefaults.synchronize()
    }
    
    
    func save<T>(key : keys,value : T) {
        self.userdefaults.set(value, forKey: key.rawValue)
        self.userdefaults.synchronize()
    }
    
    
    func get<T>(key: keys, type : T) -> T? {
        if let data = self.userdefaults.value(forKey: key.rawValue) as? T {
            return data
        }
        return nil
    }
    
}
