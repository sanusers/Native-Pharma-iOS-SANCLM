//
//  ZstoreDataModel.swift
//  E-Detailing
//
//  Created by San eforce on 28/11/23.
//

import Foundation

// MARK: - ZstoreDataModel
struct ZstoreDataModel: Codable {
    let category: [Category]
    let cardOffers: [CardOffer]
    let products: [ZstoreProduct]

    enum CodingKeys: String, CodingKey {
        case category
        case cardOffers = "card_offers"
        case products
    }
}

// MARK: - CardOffer
struct CardOffer: Codable {
    let id: String
    let percentage: Int
    let cardName, offerDesc, maxDiscount: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, percentage
        case cardName = "card_name"
        case offerDesc = "offer_desc"
        case maxDiscount = "max_discount"
        case imageURL = "image_url"
    }
}

// MARK: - Category
struct Category: Codable {
    let id, name, layout: String
}

// MARK: - Product
struct ZstoreProduct: Codable {
    let id, name: String
    let rating: Double
    let reviewCount: Int
    let price: Double
    let categoryID: String
    let cardOfferIDS: [String]
    let imageURL: String
    let description: String
    let colors: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, rating
        case reviewCount = "review_count"
        case price
        case categoryID = "category_id"
        case cardOfferIDS = "card_offer_ids"
        case imageURL = "image_url"
        case description, colors
    }
}



//func callAPI() {
//    self.sessionResponseVM = SessionResponseVM()
//    let param = [String: Any]()
//
//    sessionResponseVM?.getZstoreData(params: param, api: .zsotoreJSON) { result in
//               switch result {
//               case .success(let response):
//                   print(response)
//
//               case .failure(let error):
//                   print(error.localizedDescription)
//               }
//           }
//}

//import Foundation
//class  SessionResponseVM {
//
//
//
//    func getZstoreData(params: JSON, api : APIEnums, _ result : @escaping (Result<ZstoreDataModel,Error>) -> Void) {
//
//        ConnectionHandler.shared.getRequest(for: api, params: params)
//            .responseDecode(to: ZstoreDataModel.self, { (json) in
//                result(.success(json))
//                dump(json)
//            }).responseFailure({ (error) in
//                print(error.description)
//
//            })
//    }
//
//
//
//}
//var appMainURL : String = "https://raw.githubusercontent.com/"
// var APIUrl : String = "https://raw.githubusercontent.com/"


//enum APIEnums : String{
//
//    case none = ""
//    case actionLogin = "action/login"
//    case tableSetup = "table/setups"
//    //axn=
//    case zsotoreJSON = "princesolomon/zstore/main/data.json"
//}

//MARK: - connection handler

//func getRequest(for api : APIEnums,
//                params : Parameters) -> APIResponseProtocol{
//    // + api.rawValue
//    if api.method == .get {
//        return self.getRequest(forAPI: api == .none ? APIUrl + api.rawValue : appMainURL + api.rawValue,
//                               params: params,
//                               CacheAttribute: api.cacheAttribute ?  .none : api)
//    } else {
//        return self.postRequest(forAPI: api == .none ? APIUrl + api.rawValue : appMainURL + api.rawValue,
//                                params: params, CacheAttribute: api)
//    }
//}
