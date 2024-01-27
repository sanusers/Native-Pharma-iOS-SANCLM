//
//  SlidesModel.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import Foundation




    
    
    
    class GroupedBrandsSlideModel: Codable {
        var groupedSlide : [SlidesModel]
        var priority: Int
        var updatedDate: DateInfo
        var divisionCode: Int
        var productBrdCode: Int
        var subdivisionCode: Int
        var createdDate: DateInfo
        var id: Int
        
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.groupedSlide = try container.decode([SlidesModel].self, forKey: .groupedSlide)
            self.priority = try container.decode(Int.self, forKey: .priority)
            self.updatedDate = try container.decode(DateInfo.self, forKey: .updatedDate)
            self.divisionCode = try container.decode(Int.self, forKey: .divisionCode)
            self.productBrdCode = try container.decode(Int.self, forKey: .productBrdCode)
            self.subdivisionCode = try container.decode(Int.self, forKey: .subdivisionCode)
            self.createdDate = try container.decode(DateInfo.self, forKey: .createdDate)
            self.id = try container.decode(Int.self, forKey: .id)
        }
        
        
        init() {
            self.groupedSlide = [SlidesModel]()
            self.priority = Int()
            self.updatedDate = DateInfo()
            self.divisionCode = Int()
            self.productBrdCode = Int()
            self.subdivisionCode = Int()
            self.createdDate = DateInfo()
            self.id = Int()
        }
        
    }
    
    
    class  BrandSlidesModel: Codable {
        let priority: Int
        let updatedDate: DateInfo
        let divisionCode: Int
        let productBrdCode: Int
        let subdivisionCode: Int
        let createdDate: DateInfo
        let id: Int
        
        private enum CodingKeys: String, CodingKey {
            case priority = "Priority"
            case updatedDate = "Updated_Date"
            case divisionCode = "Division_Code"
            case productBrdCode = "Product_Brd_Code"
            case subdivisionCode = "Subdivision_Code"
            case createdDate = "Created_Date"
            case id = "ID"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.priority = container.safeDecodeValue(forKey: .priority)
            self.updatedDate =  try container.decodeIfPresent(DateInfo.self, forKey: .updatedDate) ?? DateInfo()
            self.divisionCode = container.safeDecodeValue(forKey: .divisionCode)
            self.productBrdCode = container.safeDecodeValue(forKey: .productBrdCode)
            self.subdivisionCode = container.safeDecodeValue(forKey: .subdivisionCode)
            self.createdDate =  try container.decodeIfPresent(DateInfo.self, forKey: .createdDate) ?? DateInfo()
            self.id = try container.decode(Int.self, forKey: .id)
        }
        
        
        init() {
            
            priority = Int()
            updatedDate = DateInfo()
            divisionCode = Int()
            productBrdCode = Int()
            subdivisionCode = Int()
            createdDate = DateInfo()
            id = Int()
            
            
            
            
        }
    }
    
    
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
        var slideData: Data
        var utType : String
        var isSelected : Bool
        
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
            self.slideData = Data()
            self.utType = String()
            self.isSelected = Bool()
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
            slideData = Data()
            utType = String()
            isSelected = Bool()
        }
    }
    
    class DateInfo: Codable {
        let date: String
        let timezone: String
        let timezoneType: Int
        
        enum CodingKeys: String, CodingKey {
            case date
            case timezone
            case  timezoneType = "timezone_type"
        }
        
        required init(from decoder: Decoder) throws {
            let container   = try decoder.container(keyedBy: CodingKeys.self)
            self.date = container.safeDecodeValue(forKey: .date)
            self.timezone = container.safeDecodeValue(forKey: .timezone)
            self.timezoneType = container.safeDecodeValue(forKey: .timezoneType)
        }
        
        init() {
            
            date = String()
            timezone = String()
            timezoneType = Int()
            
            
            
        }
        
        
    }






class SavedPresentation: Codable {
    var groupedBrandsSlideModel : [GroupedBrandsSlideModel]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.groupedBrandsSlideModel = try container.decode([GroupedBrandsSlideModel].self, forKey: .groupedBrandsSlideModel)
    }
    
    init() {
        self.groupedBrandsSlideModel = [GroupedBrandsSlideModel]()
    }
}
