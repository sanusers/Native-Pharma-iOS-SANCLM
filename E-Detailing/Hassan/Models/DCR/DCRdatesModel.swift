//
//  DCRdatesMode.swift
//  E-Detailing
//
//  Created by San eforce on 29/02/24.
//

import Foundation

class DCRdatesModel: Codable {
    let sfCode: String
    let dt: Dt
    let flg: Int
    let tbname: String

    enum CodingKeys: String, CodingKey {
        case sfCode = "Sf_Code"
        case dt, flg, tbname
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sfCode = container.safeDecodeValue( forKey: .sfCode)
        self.dt = try container.decode(Dt.self, forKey: .dt)
        self.flg = container.safeDecodeValue(forKey: .flg)
        self.tbname = container.safeDecodeValue(forKey: .tbname)
    }
}

// MARK: - Dt
class Dt: Codable {
    let date: String
    let timezoneType: Int
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case date
        case timezoneType = "timezone_type"
        case timezone
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.timezoneType = try container.decode(Int.self, forKey: .timezoneType)
        self.timezone = try container.decode(String.self, forKey: .timezone)
    }
}
