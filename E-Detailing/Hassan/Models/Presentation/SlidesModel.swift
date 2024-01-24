//
//  SlidesModel.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import Foundation





class SlidesModel: Codable {
    let code: Int
    let camp: Int
    let productDetailCode: String
    let filePath: String
    let group: Int
    let specialityCode: String
    let slideId: Int
    let fileType: String
    let effFrom: DateInfo
    let categoryCode: String
    let name: String
    let noofSamples: Int
    let effTo: DateInfo
    let ordNo: Int
    let priority: Int
    
    
    enum CodingKeys: String, CodingKey {
        case code              = "Code"
        case camp               = "Camp"
        case productDetailCode = "Product_Detail_Code"
        case filePath           = "FilePath"
        case group               = "Group"
        case specialityCode      = "Speciality_Code"
        case slideId = "SlideId"
        case fileType = "FileTyp"
        case effFrom = "Eff_from"
        case categoryCode = "Category_Code"
        case name = "Name"
        case noofSamples = "NoofSamples"
        case effTo = "EffTo"
        case ordNo = "OrdNo"
        case priority = "Priority"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        self.code               = container.safeDecodeValue(forKey: .code)
        self.camp               = container.safeDecodeValue(forKey: .camp)
        self.productDetailCode  = container.safeDecodeValue(forKey: .productDetailCode)
        self.filePath           = container.safeDecodeValue(forKey: .filePath)
        self.group              = container.safeDecodeValue(forKey: .group)
        self.specialityCode     = container.safeDecodeValue(forKey: .specialityCode)
        self.slideId            = container.safeDecodeValue(forKey: .slideId)
        self.fileType           = container.safeDecodeValue(forKey: .fileType)
        self.effFrom            = try container.decodeIfPresent(DateInfo.self, forKey: .effFrom) ?? DateInfo()
        self.categoryCode       = container.safeDecodeValue(forKey: .categoryCode)
        self.name               = container.safeDecodeValue(forKey: .name)
        self.noofSamples        = container.safeDecodeValue(forKey: .noofSamples)
        self.effTo              =   try container.decodeIfPresent(DateInfo.self, forKey: .effTo) ?? DateInfo()
        self.ordNo              = container.safeDecodeValue(forKey: .ordNo)
        self.priority           = container.safeDecodeValue(forKey: .priority)
        
        
    }
    
    
    
    
    init() {
        
        code = Int()
        camp = Int()
        productDetailCode = String()
        filePath = String()
        group = Int()
        specialityCode = String()
        slideId = Int()
        fileType = String()
        effFrom = DateInfo()
        categoryCode = String()
        name = String()
        noofSamples = Int()
        effTo = DateInfo()
        ordNo = Int()
        priority = Int()
    }
}

class DateInfo: Codable {
    let date: String
    let timezone: String
    let timezoneType: Int
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.timezoneType = try container.decode(Int.self, forKey: .timezoneType)
    }
    
    init() {
       
    date = String()
    timezone = String()
    timezoneType = Int()
        
        
        
    }
    
    
}
