//
//  MainVC + EditCallEX.swift
//  E-Detailing
//
//  Created by San eforce on 08/05/24.
//

import Foundation
import CoreData
extension MainVC {
    func toCallEditAPI(dcrCall: TodayCallsModel) {
        Shared.instance.showLoaderInWindow()
     //   {"headerno":"DP8-681","detno":"DP8-816","sfcode":"MR5940","division_code":"63,","Rsf":"MR5940","sf_type":"1","Designation":"MR","state_code":"2","subdivision_code":"86,","cusname":"A JAIN --- [ Doctor ]","custype":"1","pob":"1"}
        
        let listedDocters = DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
       let filteredDoctores = listedDocters.filter { aDoctorFencing in
            aDoctorFencing.code == dcrCall.custCode
        }
        guard let nonNilDoctors = filteredDoctores.first else {
            
            
        return}
        let aCallVM = CallViewModel(call: nonNilDoctors , type: DCRType.doctor)
        var param = [String: Any]()
        param["headerno"] = dcrCall.transSlNo 
        param["detno"] = dcrCall.aDetSLNo
        param["sfcode"] = appSetups.sfCode
        param["division_code"] = appSetups.divisionCode
        param["Rsf"] = LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)
        param["sf_type"] = appSetups.sfType
        param["Designation"] = appSetups.desig
        param["state_code"] = appSetups.stateCode
        param["subdivision_code"] = appSetups.subDivisionCode
        param["cusname"] = dcrCall.custName
        param["custype"] = dcrCall.custType
        param["pob"] = "1"
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        print(param)
        self.userststisticsVM?.toEditAddedCall(params: toSendData, api: .editCall, paramData: param) {[weak self] result in
            guard let welf = self else {return}
            Shared.instance.removeLoaderInWindow()
            switch result {
                
            case .success(let response):
                dump(response)
                welf.toCreateViewModels(call: aCallVM, model: response)
            case .failure(let failure):
                welf.toCreateToast(failure.localizedDescription)
            }
        }
    }
    
    func toCreateViewModels(call: AnyObject, model: EditCallinfoModel) {
     
        let vc = AddCallinfoVC.initWithStory(viewmodel: self.userststisticsVM ?? UserStatisticsVM())
        
        vc.rcpaDetailsModel =  toCreateRCPAdetailsModel(rcpa: model.rcpaHeadArr)
        
        guard let callvm = call as? CallViewModel else {
          
          return
            
        }
        let updatedCallVM = callvm.toRetriveDCRdata(dcrcall: callvm.call)
        
        vc.dcrCall = updatedCallVM
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
//    func toCreateRCPAdetailsModel(rcpa: [RCPAHead]) -> [RCPAdetailsModal] {
//        var rcpaDetailsModelArr :  [RCPAdetailsModal] = []
//    
//
//        rcpa.forEach { aRCPAHead in
//            let  rcpaDetailsModel = RCPAdetailsModal()
//          let loadedChemists =  DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
//            let selectedChemist = loadedChemists.filter { aChemist in
//                aChemist.code == aRCPAHead.chmCode.replacingOccurrences(of: ",", with: "")
//            }
//          
//            
//            if let aChemistEntity = NSEntityDescription.entity(forEntityName: "Chemist", in: context) {
//                let aChemistCDM = Chemist(entity: aChemistEntity, insertInto: context)
//                
//             let selectedChemist = selectedChemist.first
//         
//                aChemistCDM.chemistContact =  selectedChemist?.chemistContact
//                aChemistCDM.chemistEmail = selectedChemist?.chemistEmail
//                aChemistCDM.chemistFax = selectedChemist?.chemistFax
//                aChemistCDM.chemistMobile = selectedChemist?.chemistMobile
//                aChemistCDM.chemistPhone = selectedChemist?.chemistPhone
//                aChemistCDM.code = selectedChemist?.code
//                aChemistCDM.geoTagCnt = selectedChemist?.geoTagCnt
//                aChemistCDM.lat = selectedChemist?.lat
//                aChemistCDM.long = selectedChemist?.long
//                aChemistCDM.mapId = selectedChemist?.mapId
//                aChemistCDM.maxGeoMap = selectedChemist?.maxGeoMap
//                aChemistCDM.name = selectedChemist?.name
//                aChemistCDM.sfCode = selectedChemist?.sfCode
//                aChemistCDM.townCode = selectedChemist?.townCode
//                aChemistCDM.townName = selectedChemist?.townName
//                
//                
//                rcpaDetailsModel.addedChemist = aChemistCDM
//                
//                
//            }
//            
//           
//            var addedProductWithCompetiors = [ProductWithCompetiors]()
//            var aAddedProductWithCompetior = ProductWithCompetiors()
//            
//            
//            let loadedProducts =  DBManager.shared.getProduct()
//            aAddedProductWithCompetior.addedProduct = loadedProducts.filter({ aProduct in
//                aProduct.code == aRCPAHead.opCode
//            }).first
//            var competitorsInfoArr = [AdditionalCompetitorsInfo]()
//            aRCPAHead.rcpaDet.forEach { aRCPADet in
//                var competitorsInfo = AdditionalCompetitorsInfo()
//                if let aCompetitor = NSEntityDescription.entity(forEntityName: "Competitor", in: context) {
//                    let aCompetitor = Competitor(entity: aCompetitor, insertInto: context)
//                    if let  ourProduct = aAddedProductWithCompetior.addedProduct {
//                        aCompetitor.compName = aRCPADet.compName
//                        aCompetitor.compProductName = aRCPADet.compPName
//                        aCompetitor.compProductSlNo = aRCPADet.compPCode
//                       // aCompetitor.compSlNo = aRCPADet.
//                        aCompetitor.index = Int16()
//                        aCompetitor.ourProductCode = ourProduct.code
//                        aCompetitor.ourProductName = ourProduct.name
//                        competitorsInfo.competitor = aCompetitor
//                    }
//
//                }
//                competitorsInfo.remarks = aRCPADet.cpRemarks
//                competitorsInfo.rate = "\(aRCPADet.cpRate)"
//                competitorsInfo.value = "\(aRCPADet.cpValue)"
//                competitorsInfo.qty = "\(aRCPADet.cpQty)"
//                competitorsInfoArr.append(competitorsInfo)
//            }
//            
//            aAddedProductWithCompetior.competitorsInfo = competitorsInfoArr
//            addedProductWithCompetiors.append(aAddedProductWithCompetior)
//            
//            var aProductDetails =  ProductDetails()
//            aProductDetails.addedProduct = addedProductWithCompetiors
//            aProductDetails.addedQuantity = ["\(aRCPAHead.opQty)"]
//            aProductDetails.addedRate = ["\(aRCPAHead.opRate)"]
//            aProductDetails.addedValue = ["\(aRCPAHead.opValue)"]
//            aProductDetails.addedTotal = ["\(aRCPAHead.opValue)"]
//            
//            
//            rcpaDetailsModel.addedProductDetails = aProductDetails
//            rcpaDetailsModelArr.append(rcpaDetailsModel)
//        }
//        
//        
//
//
//        
//        return rcpaDetailsModelArr
//    }
    
    
    
    func toCreateRCPAdetailsModel(rcpa: [RCPAHead]) -> [RCPAdetailsModal] {
        var chemistModelsMap: [String: RCPAdetailsModal] = [:]
        var rcpaDetailsModelArr : [RCPAdetailsModal] = []
        rcpa.forEach { aRCPAHead in
            // Create or retrieve RCPAdetailsModal for the chemist
            var isExistingElement: Bool = false
            let chemistCode = aRCPAHead.chmCode.replacingOccurrences(of: ",", with: "")
            let rcpaDetailsModel: RCPAdetailsModal
            if let existingModel = chemistModelsMap[chemistCode] {
                rcpaDetailsModel = existingModel
                isExistingElement = true
            } else {
                rcpaDetailsModel = RCPAdetailsModal()
                chemistModelsMap[chemistCode] = rcpaDetailsModel
                isExistingElement = false
            }

            // Populate RCPAdetailsModal with chemist details
            let loadedChemists = DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            if let selectedChemist = loadedChemists.first(where: { $0.code == chemistCode }) {
                if let aChemistEntity = NSEntityDescription.entity(forEntityName: "Chemist", in: context) {
                    let aChemistCDM = Chemist(entity: aChemistEntity, insertInto: context)
                    aChemistCDM.chemistContact = selectedChemist.chemistContact
                    aChemistCDM.chemistEmail = selectedChemist.chemistEmail
                    aChemistCDM.chemistFax = selectedChemist.chemistFax
                    aChemistCDM.chemistMobile = selectedChemist.chemistMobile
                    aChemistCDM.chemistPhone = selectedChemist.chemistPhone
                    aChemistCDM.code = selectedChemist.code
                    aChemistCDM.geoTagCnt = selectedChemist.geoTagCnt
                    aChemistCDM.lat = selectedChemist.lat
                    aChemistCDM.long = selectedChemist.long
                    aChemistCDM.mapId = selectedChemist.mapId
                    aChemistCDM.maxGeoMap = selectedChemist.maxGeoMap
                    aChemistCDM.name = selectedChemist.name
                    aChemistCDM.sfCode = selectedChemist.sfCode
                    aChemistCDM.townCode = selectedChemist.townCode
                    aChemistCDM.townName = selectedChemist.townName
                    rcpaDetailsModel.addedChemist = aChemistCDM
                }
            }

            // Populate RCPAdetailsModal with product details
            var addedProductWithCompetitors = [ProductWithCompetiors]()
            var aAddedProductWithCompetitor = ProductWithCompetiors()
            let loadedProducts = DBManager.shared.getProduct()
            aAddedProductWithCompetitor.addedProduct = loadedProducts.first(where: { $0.code == aRCPAHead.opCode })
            var competitorsInfoArr = [AdditionalCompetitorsInfo]()
            aRCPAHead.rcpaDet.forEach { aRCPADet in
                var competitorsInfo = AdditionalCompetitorsInfo()
                if let aCompetitorEntity = NSEntityDescription.entity(forEntityName: "Competitor", in: context) {
                    let aCompetitor = Competitor(entity: aCompetitorEntity, insertInto: context)
                    if let ourProduct = aAddedProductWithCompetitor.addedProduct {
                        aCompetitor.compName = aRCPADet.compName
                        aCompetitor.compProductName = aRCPADet.compPName
                        aCompetitor.compProductSlNo = aRCPADet.compPCode
                        aCompetitor.index = Int16()
                        aCompetitor.ourProductCode = ourProduct.code
                        aCompetitor.ourProductName = ourProduct.name
                        competitorsInfo.competitor = aCompetitor
                    }
                }
                competitorsInfo.remarks = aRCPADet.cpRemarks
                competitorsInfo.rate = "\(aRCPADet.cpRate)"
                competitorsInfo.value = "\(aRCPADet.cpValue)"
                competitorsInfo.qty = "\(aRCPADet.cpQty)"
                competitorsInfoArr.append(competitorsInfo)
            }
            aAddedProductWithCompetitor.competitorsInfo = competitorsInfoArr
            addedProductWithCompetitors.append(aAddedProductWithCompetitor)
            if isExistingElement {
                var aProductDetails : ProductDetails = rcpaDetailsModel.addedProductDetails ?? ProductDetails()
                aProductDetails.addedProduct?.append(contentsOf: addedProductWithCompetitors)
                aProductDetails.addedQuantity?.append(contentsOf: ["\(aRCPAHead.opQty)"])
                aProductDetails.addedRate?.append(contentsOf: ["\(aRCPAHead.opRate)"])
                aProductDetails.addedTotal?.append(contentsOf: ["\(aRCPAHead.opValue)"])
                rcpaDetailsModel.addedProductDetails = aProductDetails
            }
            else {
                var aProductDetails : ProductDetails = ProductDetails()
                aProductDetails.addedProduct = addedProductWithCompetitors
                aProductDetails.addedQuantity = ["\(aRCPAHead.opQty)"]
                aProductDetails.addedRate = ["\(aRCPAHead.opRate)"]
                aProductDetails.addedTotal =  ["\(aRCPAHead.opValue)"]
                rcpaDetailsModel.addedProductDetails = aProductDetails
            }
            if let index = rcpaDetailsModelArr.firstIndex(where: { $0.addedChemist?.code == chemistCode }) {
                rcpaDetailsModelArr[index] = rcpaDetailsModel
        } else {
                rcpaDetailsModelArr.append(rcpaDetailsModel)
            }
        }
        
        // Return the values of the chemistModelsMap
        return rcpaDetailsModelArr
    }
}
