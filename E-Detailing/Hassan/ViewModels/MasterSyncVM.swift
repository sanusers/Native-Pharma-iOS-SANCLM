//
//  MasterSyncVM.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 15/02/24.
//

import Foundation
import Alamofire
import SSZipArchive

struct UnzippedDataInfo {
    var videofiles: [Videoinfo]
    var imagefiles: [Imageinfo]
    var htmlfiles: [HTMLinfo]
    
    init() {
        self.videofiles = [Videoinfo]()
        self.imagefiles = [Imageinfo]()
        self.htmlfiles = [HTMLinfo]()
    }
}

struct Videoinfo {

    var fileData:  Data?
    var filetype: String?
    init() {

        self.fileData = Data()
        self.filetype = String()
    }
}


struct Imageinfo {

    var fileData:  Data?
    var filetype: String?
    init() {

        self.fileData = Data()
        self.filetype = String()
    }
}

struct HTMLinfo {
    var htmlString: String?
    var htmlFileURL: URL?
    var fileData:  Data?
    var fileName: String?
    init() {
        self.htmlString = String()
        self.htmlFileURL = URL(string: "")
        self.fileData = Data()
        self.fileName = String()
    }
}

enum MasterSyncErrors: String, Error {
case unableConnect = "An issue occured data will be saved to device"
}

class MasterSyncVM {
    var extractedFileName: String?
    var isUpdated: [MasterInfo] = []
    var isUpdating: Bool = false
    var isSyncCompleted: Bool = false
    let appsetup = AppDefaults.shared.getAppSetUp()
    var getRSF: String? {
    
        let selectedRSF = LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)
        let rsfIDPlan1 = LocalStorage.shared.getString(key: LocalStorage.LocalValue.rsfIDPlan1)
        let rsfIDPlan2 = LocalStorage.shared.getString(key: LocalStorage.LocalValue.rsfIDPlan2)

        if !selectedRSF.isEmpty {
            return selectedRSF
        } else if !rsfIDPlan1.isEmpty {
            return rsfIDPlan1
        } else if !rsfIDPlan2.isEmpty {
            return rsfIDPlan2
        } else {
            return "\(appsetup.sfCode!)"
        }
    }
    
    var mapID: String?
    
    func toGetMyDayPlan(type: MasterInfo, isToloadDB: Bool, date: Date = Date(), isFromDCR: Bool? = false, completion: @escaping (Result<[MyDayPlanResponseModel],MasterSyncErrors>) -> ()) {
        
 
        let date = date.toString(format: "yyyy-MM-dd HH:mm:ss")
        var param = [String: Any]()
        
        
//    http://edetailing.sanffa.info/iOSServer/db_api.php/?axn=table/dcrmasterdata
//    {"tableName":"getmydayplan","sfcode":"MGR0941","division_code":"63,","Rsf":"MGR0941","sf_type":"2","Designation":"MGR","state_code":"13","subdivision_code":"86,","ReqDt":"2024-02-15 15:27:16"}
        
        
       // {"tableName":"gettodaydcr","sfcode":"MGR0941","division_code":"63,","Rsf":"MGR0941","sf_type":"2","Designation":"MGR","state_code":"13","subdivision_code":"86,","ReqDt":"2024-02-12 15:27:16"}
        
        param["tableName"] = isFromDCR ?? false ? "gettodaydcr" : "getmydayplan"
        param["ReqDt"] = date
        param["sfcode"] = "\(appsetup.sfCode!)"
        param["division_code"] = "\(appsetup.divisionCode!)"

       // let rsf = LocalStorage.shared.getString(key: LocalStorage.LocalValue.rsfIDPlan1)
        param["Rsf"] =  isFromDCR ?? false ? appsetup.sfCode! : getRSF
        param["sf_type"] = "\(appsetup.sfType!)"
        param["Designation"] = "\(appsetup.dsName!)"
        param["state_code"] = "\(appsetup.stateCode!)"
        param["subdivision_code"] = "\(appsetup.subDivisionCode!)"
         
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        
        self.getTodayPlans(params: toSendData, api: .masterData, paramData: param, {[weak self] result in
          
            guard let welf = self else {return}
            switch result {
                
            case .success(let model):
                dump(model)
                if isToloadDB {
                    welf.toUpdateDataBase(aDayplan: welf.toConvertResponseToDayPlan(model: model)) {_ in
                        
                        completion(result)
                    }
                    
                } else {
                    completion(result)
                }
         
                
            case .failure(let error):
                print(error)
                completion(result)
            }
            
          
        })
        
    }
    
    func toUpdateDataBase(aDayplan: DayPlan, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.removeAllDayPlans()
        CoreDataManager.shared.toSaveDayPlan(aDayPlan: aDayplan) { isComleted in
            
            completion(true)
            
//            if isComleted {
//               // self.toCreateToast("Saved successfully")
//
//                CoreDataManager.shared.retriveSavedDayPlans() { dayplans in
//                    dump(dayplans)
//                }
//            
//              
//            } 
        }
    }
    
    func toConvertResponseToDayPlan(model: [MyDayPlanResponseModel]) -> DayPlan  {
        let aDayPlan = DayPlan()
        let userConfig = AppDefaults.shared.getAppSetUp()
        aDayPlan.tableName = "gettodaytpnew"
        aDayPlan.uuid = UUID()
        aDayPlan.divisionCode = userConfig.divisionCode ?? ""
        aDayPlan.sfType = "\(userConfig.sfType!)"
        aDayPlan.designation = "\(userConfig.desig!)"
        aDayPlan.stateCode = "\(userConfig.stateCode!)"
        aDayPlan.subdivisionCode = userConfig.subDivisionCode ?? ""
     
        model.enumerated().forEach {index, aMyDayPlanResponseModel in
            switch index {
            case 0:
                aDayPlan.tpDt = aMyDayPlanResponseModel.TPDt.date //2024-02-03 00:00:00
                aDayPlan.isRetrived  =  true
                aDayPlan.sfcode = aMyDayPlanResponseModel.SFCode
                aDayPlan.rsf = aMyDayPlanResponseModel.SFMem
                LocalStorage.shared.setSting(LocalStorage.LocalValue.rsfIDPlan1, text: aMyDayPlanResponseModel.SFMem)
                LocalStorage.shared.setSting(LocalStorage.LocalValue.selectedRSFID, text: aMyDayPlanResponseModel.SFMem)
                aDayPlan.wtCode = aMyDayPlanResponseModel.WT
                aDayPlan.wtName = aMyDayPlanResponseModel.WTNm
                aDayPlan.fwFlg = aMyDayPlanResponseModel.FWFlg
                aDayPlan.townCode = aMyDayPlanResponseModel.Pl
                aDayPlan.townName = aMyDayPlanResponseModel.PlNm
            case 1:
                aDayPlan.tpDt = aMyDayPlanResponseModel.TPDt.date //2024-02-03 00:00:00
                aDayPlan.isRetrived2  =  true
                aDayPlan.sfcode = aMyDayPlanResponseModel.SFCode
                aDayPlan.rsf2 = aMyDayPlanResponseModel.SFMem
                LocalStorage.shared.setSting(LocalStorage.LocalValue.rsfIDPlan2, text: aMyDayPlanResponseModel.SFMem)
                LocalStorage.shared.setSting(LocalStorage.LocalValue.selectedRSFID, text: aMyDayPlanResponseModel.SFMem)
                aDayPlan.wtCode2 = aMyDayPlanResponseModel.WT
                aDayPlan.wtName2 = aMyDayPlanResponseModel.WTNm
                aDayPlan.fwFlg2 = aMyDayPlanResponseModel.FWFlg
                aDayPlan.townCode2 = aMyDayPlanResponseModel.Pl
                aDayPlan.townName2 = aMyDayPlanResponseModel.PlNm
                
                
            default:
                print("Yet to implement")
            }
        }
        

      
        return aDayPlan
        
    }
    
    
    
    
    func fetchMasterData(type: MasterInfo, sfCode: String, istoUpdateDCRlist: Bool, mapID: String, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        dump(type.getUrl)
        dump(type.getParams)

        AF.request(type.getUrl, method: .post, parameters: type.getParams).responseData { [weak self] (response) in
            guard let welf = self else { return }

            switch response.result {
            case .success(_):
                guard let apiResponse = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [[String: Any]] else {
                    print("Unable to serialize")
                    completionHandler(response)
                    return
                }

                print(apiResponse)
                // Save to Core Data or perform any other actions
                DBManager.shared.saveMasterData(type: type, Values: apiResponse, id: mapID)

                if istoUpdateDCRlist && !welf.isUpdating {
                    welf.updateDCRLists(mapID: mapID) { _ in
                        completionHandler(response)
                    }
                } else   {
                    completionHandler(response)
                }

            case .failure(let error):
                completionHandler(response)
                print(error)
            }
        }
    }
    

    func updateDCRLists(mapID: String, completion: @escaping (Bool) -> ()) {
        let dispatchgroup = DispatchGroup()
        isUpdating = true
        let dcrEntries : [MasterInfo] = [.doctorFencing, .chemists, .unlistedDoctors, .stockists]
        
        
        //Doctor,Chemist,Stokiest,Unlistered,Cip,Hospital,Cluste
     
        dcrEntries.forEach { aMasterInfo in
            dispatchgroup.enter()
            
            fetchMasterData(type: aMasterInfo, sfCode: getRSF ?? "", istoUpdateDCRlist: true, mapID: mapID) { _ in
                print("Syncing \(aMasterInfo.rawValue)")
               
               dispatchgroup.leave()
                
            }
        }
        
        dispatchgroup.notify(queue: .main) {
            // All async tasks are completed
            self.isUpdating = false
            self.isSyncCompleted = true
            print("DCR list sync completed")
            completion(true)
       
        }
        
    }
    
    func getTodayPlans(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<[MyDayPlanResponseModel],MasterSyncErrors>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: [MyDayPlanResponseModel].self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(MasterSyncErrors.unableConnect))
        })
    }
    
    func getDCRdates(params: JSON, api : APIEnums, paramData: JSON, _ result : @escaping (Result<[DCRdatesModel],MasterSyncErrors>) -> Void) {
        ConnectionHandler.shared.uploadRequest(for: api, params: params, data: paramData)
            .responseDecode(to: [DCRdatesModel].self, { (json) in
            result(.success(json))
            dump(json)
        }).responseFailure({ (error) in
            print(error.description)
            result(.failure(MasterSyncErrors.unableConnect))
        })
    }
    
    
    func tofetchDcrdates(completion: @escaping (Result<([DCRdatesModel]), MasterSyncErrors>) -> ()) {
        let appsetup = AppDefaults.shared.getAppSetUp()
        let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
        

        var param = [String: Any]()
        param["tableName"] = "getdcrdate"
        param["sfcode"] = "\(appsetup.sfCode!)"
        param["division_code"] = "\(appsetup.divisionCode!)"
        param["Rsf"] = "\(appsetup.sfCode!)"
        param["sf_type"] = "\(appsetup.sfType!)"
        param["Designation"] = "\(appsetup.dsName!)"
        param["state_code"] = "\(appsetup.stateCode!)"
        param["subdivision_code"] = "\(appsetup.subDivisionCode!)"
        param["ReqDt"] = date
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)

        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
 
       self.getDCRdates(params: toSendData, api: .home, paramData: param) { result in
            
            switch result {
                
            case .success(let respnse):
                completion(result)
                
                dump(respnse)
          
                
            case .failure(_):
                completion(result)
            }
             
        }
 
    }
    
    
    
    func toGroupSlidesBrandWise(completion: @escaping (Bool) -> Void) {
      //  Shared.instance.showLoaderInWindow()
        let allSlideObjects = CoreDataManager.shared.retriveSavedSlides()
        let brandSlideObjects = CoreDataManager.shared.retriveSavedBrandSlides()

        CoreDataManager.shared.removeAllGeneralGroupedSlides()

        let groupedBrandsSlideModels = brandSlideObjects.compactMap { brandSlideModel -> GroupedBrandsSlideModel? in
            let brandSlides = allSlideObjects.filter { $0.code == brandSlideModel.productBrdCode }

            guard !brandSlides.isEmpty else {
                print("No slides found for iterated Brand code: \(brandSlideModel.productBrdCode)")
                return nil
            }
            
            print("slides found for iterated Brand code: \(brandSlideModel.productBrdCode)")
            let groupedBrandModel = GroupedBrandsSlideModel()
            groupedBrandModel.groupedSlide = brandSlides
            groupedBrandModel.priority = brandSlideModel.priority
            groupedBrandModel.divisionCode = brandSlideModel.divisionCode
            groupedBrandModel.productBrdCode = brandSlideModel.productBrdCode
            groupedBrandModel.subdivisionCode = brandSlideModel.subdivisionCode
            groupedBrandModel.id = brandSlideModel.id
            dump(groupedBrandModel)
            return groupedBrandModel
        }

        let dispatchGroup = DispatchGroup()

        for groupedBrandModel in groupedBrandsSlideModels {
            dispatchGroup.enter()

            tounArchiveData(aGroupedBrandsSlideModel: groupedBrandModel) { isSaved in
                dispatchGroup.leave()


            }
        }

        dispatchGroup.notify(queue: .main) {
            // All async tasks are completed
            completion(true)
        }
    }
    
    
    func tounArchiveData(aGroupedBrandsSlideModel: GroupedBrandsSlideModel, completion: @escaping (Bool) -> Void) {
        var zipContentsSlides = [SlidesModel]()
        var zipgropedBrandModels = [GroupedBrandsSlideModel]()
        var tempGroupedBrandsSlideModel =  [GroupedBrandsSlideModel]()
        
        zipContentsSlides = aGroupedBrandsSlideModel.groupedSlide.filter { aSlideModel in
            aSlideModel.utType == "application/zip" ||  aSlideModel.fileType == "H"
        }
        
        // Update groupedSlideModel by removing slides with utType equal to "application/zip"
        aGroupedBrandsSlideModel.groupedSlide = aGroupedBrandsSlideModel.groupedSlide.filter { aSlideModel in
            !(aSlideModel.utType == "application/zip" && aSlideModel.fileType == "H")
        }
        
      
        
        // Append to zipgropedBrandModels if there are zipContentsSlides
        if !zipContentsSlides.isEmpty {
           
            zipgropedBrandModels.append(aGroupedBrandsSlideModel)
            var modifiedZipgropedBrandModels = [GroupedBrandsSlideModel]()
            zipgropedBrandModels.forEach { aGroupedBrandsSlideModel in
                let tempGroupedBrandsSlideModel = GroupedBrandsSlideModel()

                var aGroupedSlideArr = [SlidesModel]()
            
                var data = UnzippedDataInfo()
             
                    zipContentsSlides.enumerated().forEach { aSlidesModelIndex, aSlidesModel in
                        
                        
                        data = unarchiveAndGetData(from: aSlidesModel.slideData)

                       let aGroupedSlide = toExtractSlidesFromUnzippedContent(data: data, aSlidesModel: aSlidesModel)
                        aGroupedSlideArr.append(contentsOf: aGroupedSlide)
                    }
                    tempGroupedBrandsSlideModel.createdDate = aGroupedBrandsSlideModel.createdDate
                    tempGroupedBrandsSlideModel.groupedSlide = aGroupedSlideArr
                    tempGroupedBrandsSlideModel.priority   = aGroupedBrandsSlideModel.priority
                    tempGroupedBrandsSlideModel.updatedDate = aGroupedBrandsSlideModel.updatedDate
                    tempGroupedBrandsSlideModel.divisionCode = aGroupedBrandsSlideModel.divisionCode
                    tempGroupedBrandsSlideModel.productBrdCode = aGroupedBrandsSlideModel.productBrdCode
                    tempGroupedBrandsSlideModel.subdivisionCode = aGroupedBrandsSlideModel.subdivisionCode
                    tempGroupedBrandsSlideModel.createdDate = aGroupedBrandsSlideModel.createdDate
                    tempGroupedBrandsSlideModel.id = aGroupedBrandsSlideModel.id
                    modifiedZipgropedBrandModels.append(tempGroupedBrandsSlideModel)
            }
            tempGroupedBrandsSlideModel.append(contentsOf: modifiedZipgropedBrandModels)
        } else {
            tempGroupedBrandsSlideModel.append(aGroupedBrandsSlideModel)
        }
        
       // aGroupedBrandsSlideModel = tempGroupedBrandsSlideModel
        
       


      
        saveGroupedSlides(tempGroupedBrandsSlideModel, atIndex: 0) { success in
            if success {
                // All items saved successfully
                completion(true)
            } else {
                // Saving failed for one or more items
                completion(false)
            }
        }
        
      
        
//        tempGroupedBrandsSlideModel.enumerated().forEach { index, aGroupedBrandsSlideModel in
//            CoreDataManager.shared.toSaveGeneralGroupedSlidesToCoreData(groupedBrandSlide: aGroupedBrandsSlideModel) {isSaved in
//                if isSaved {
//                    completion(true)
//                } else {
//                    completion(false)
//                }
//            }
//        }
        

    }
    
    
    func saveGroupedSlides(_ groupedSlides: [GroupedBrandsSlideModel], atIndex index: Int, completion: @escaping (Bool) -> Void) {
        guard index < groupedSlides.count else {
            // All items saved
            completion(true)
            return
        }

        let currentSlide = groupedSlides[index]

        CoreDataManager.shared.toSaveGeneralGroupedSlidesToCoreData(groupedBrandSlide: currentSlide) { isSaved in
            if isSaved {
                // Proceed to save the next item
                self.saveGroupedSlides(groupedSlides, atIndex: index + 1, completion: completion)
            } else {
                // If one fails, stop the process and return false
                completion(false)
            }
        }
    }

    func unarchiveAndGetData(from zipData: Data) -> UnzippedDataInfo {

        // Create a unique temporary directory URL
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)

        // Ensure the temporary directory exists
        do {
            try FileManager.default.createDirectory(at: temporaryDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating temporary directory: \(error.localizedDescription)")
        }

        // Path to the ZIP file data
        // let zipData: Data // Replace with your actual zip data
        let zipFilePath = temporaryDirectoryURL.appendingPathComponent("temp.zip")

        // Save the zip data to a temporary file
        do {
            try zipData.write(to: zipFilePath)
        } catch {
            print("Error saving zip data to temporary file: \(error.localizedDescription)")
        }

        // Unzip the file
        do {
            // Get the app's Documents directory
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // Append a subdirectory for your extracted content
                let extractedFolderName = "ExtractedContent"
                let extractedFolderPath = documentsDirectory.appendingPathComponent(extractedFolderName)

                // Ensure the directory exists, create it if needed
                do {
                    try FileManager.default.createDirectory(at: extractedFolderPath, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Error creating directory: \(error.localizedDescription)")
                }


                // Unzip the file from the temporary directory to the Documents directory

                SSZipArchive.unzipFile(atPath: zipFilePath.path, toDestination: extractedFolderPath.path)
                print("File unzipped successfully.")
                var unzippedDataInfo = UnzippedDataInfo()
                var aHTMLinfoArr = [HTMLinfo]()
                var dataArray: Data = Data()

                // Get the contents of the extracted folder
                if let contents = try? FileManager.default.contentsOfDirectory(at: extractedFolderPath, includingPropertiesForKeys: nil, options: []) {
                    // Enumerate through the contents
                    for fileURL in contents {
                        var aHTMLinfo = HTMLinfo()
                        print("File URL: \(fileURL)")
                        print("File Name: \(fileURL.lastPathComponent)")
                        let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
                        print("File Name (without extension): \(fileNameWithoutExtension)")

                        // Create a valid file URL
                        let validFileURL = URL(fileURLWithPath: fileURL.path)
                        let result: (htmlString: String?, htmlFileURL: URL?) = readHTMLFile(inDirectory: validFileURL.path)
                        guard result.htmlFileURL != nil, result.htmlString != nil else {

                            let unzippedFolderURL = URL(fileURLWithPath: extractedFolderPath.absoluteString)
                            let unzippedDataInfo = extractUnzippedDataInfo(from: unzippedFolderURL)

                             return unzippedDataInfo
                        }
                        extractedFileName = fileNameWithoutExtension
                        dataArray = findImageData(inDirectory: validFileURL) ?? Data()
                        aHTMLinfo.fileData = dataArray
                        let fileName = "index.html"
                        aHTMLinfo.htmlFileURL = extractedFolderPath.appendingPathComponent(fileNameWithoutExtension).appendingPathComponent(fileName)
                        //validFileURL
                        aHTMLinfo.htmlString = result.htmlString
                        aHTMLinfo.fileName = extractedFileName
                        aHTMLinfoArr.append(aHTMLinfo)
                        unzippedDataInfo.htmlfiles.append(contentsOf: aHTMLinfoArr)
                        return unzippedDataInfo
                    }
                } else {
                    print("Error getting contents of the extracted folder.")
                }

            }

                do {
                    try FileManager.default.removeItem(at: temporaryDirectoryURL)
                } catch {
                    print("Error removing temporary directory: \(error.localizedDescription)")
                }

        }
        return UnzippedDataInfo()
    }
    
    func toExtractSlidesFromUnzippedContent(data: UnzippedDataInfo, aSlidesModel: SlidesModel) -> [SlidesModel] {
        if !data.videofiles.isEmpty {
            var slidesModelArr = [SlidesModel]()
            data.imagefiles.enumerated().forEach { enumeratedIndex, data in
                let aGroupedSlide = SlidesModel()
                aGroupedSlide.code = (aSlidesModel.code)
                aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                aGroupedSlide.isFailed = aSlidesModel.isFailed
                aGroupedSlide.code =   (aSlidesModel.code)
                aGroupedSlide.camp = (aSlidesModel.camp)
                aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
                //  aGroupedSlide.filePath = extractedfileURL ?? ""
                aGroupedSlide.group = (aSlidesModel.group)
                aGroupedSlide.specialityCode = aSlidesModel.specialityCode
                aGroupedSlide.slideId = (aSlidesModel.slideId)
                aGroupedSlide.fileType = aSlidesModel.fileType
                // aGroupedSlidedel.effFrom = effFrom = DateI
                aGroupedSlide.categoryCode = aSlidesModel.categoryCode
                aGroupedSlide.name = aSlidesModel.name
                aGroupedSlide.fileName = aSlidesModel.filePath
                aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)
                aGroupedSlide.ordNo = (aSlidesModel.ordNo)
                aGroupedSlide.priority = (aSlidesModel.priority)
                aGroupedSlide.slideData = data.fileData ?? Data()
                aGroupedSlide.utType = data.filetype ?? "image/jpeg"
                aGroupedSlide.isSelected = aSlidesModel.isSelected
                aGroupedSlide.isFailed = aSlidesModel.isFailed
                aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                slidesModelArr.append(aGroupedSlide)
            }

            return slidesModelArr
           } else if !data.imagefiles.isEmpty {
               var slidesModelArr = [SlidesModel]()
               data.imagefiles.enumerated().forEach { enumeratedIndex, data in
                   let aGroupedSlide = SlidesModel()
                   aGroupedSlide.code = (aSlidesModel.code)
                   aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                   aGroupedSlide.isFailed = aSlidesModel.isFailed
                   aGroupedSlide.code =   (aSlidesModel.code)
                   aGroupedSlide.camp = (aSlidesModel.camp)
                   aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
                   //  aGroupedSlide.filePath = extractedfileURL ?? ""
                   aGroupedSlide.group = (aSlidesModel.group)
                   aGroupedSlide.specialityCode = aSlidesModel.specialityCode
                   aGroupedSlide.slideId = (aSlidesModel.slideId)
                   aGroupedSlide.fileType = aSlidesModel.fileType
                   // aGroupedSlidedel.effFrom = effFrom = DateI
                   aGroupedSlide.categoryCode = aSlidesModel.categoryCode
                   aGroupedSlide.name = aSlidesModel.name
                   aGroupedSlide.fileName = aSlidesModel.filePath
                   aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)
                   aGroupedSlide.ordNo = (aSlidesModel.ordNo)
                   aGroupedSlide.priority = (aSlidesModel.priority)
                   aGroupedSlide.slideData = data.fileData ?? Data()
                   aGroupedSlide.utType = data.filetype ?? "image/jpeg"
                   aGroupedSlide.isSelected = aSlidesModel.isSelected
                   aGroupedSlide.isFailed = aSlidesModel.isFailed
                   aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                   slidesModelArr.append(aGroupedSlide)
               }
               return slidesModelArr
           } else if !data.htmlfiles.isEmpty {
               var slidesModelArr = [SlidesModel]()
               data.htmlfiles.enumerated().forEach { enumeratedIndex, data in
                   let aGroupedSlide = SlidesModel()
                   aGroupedSlide.code = (aSlidesModel.code)
                   aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                   aGroupedSlide.isFailed = aSlidesModel.isFailed
                   aGroupedSlide.code =   (aSlidesModel.code)
                   aGroupedSlide.camp = (aSlidesModel.camp)
                   aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
                   //  aGroupedSlide.filePath = extractedfileURL ?? ""
                   aGroupedSlide.group = (aSlidesModel.group)
                   aGroupedSlide.specialityCode = aSlidesModel.specialityCode
                   aGroupedSlide.slideId = (aSlidesModel.slideId)
                   aGroupedSlide.fileType = aSlidesModel.fileType
                   // aGroupedSlidedel.effFrom = effFrom = DateI
                   aGroupedSlide.categoryCode = aSlidesModel.categoryCode
                   aGroupedSlide.name = aSlidesModel.name
                   aGroupedSlide.fileName = data.fileName ?? "No name"
                   if let url = data.htmlFileURL {
                       //htmlFileURL
                       aGroupedSlide.filePath = "\(url)"
                       //.absoluteString
                   } else {

                       print("htmlFileURL is nil")
                   }
                   aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)

                   aGroupedSlide.ordNo = (aSlidesModel.ordNo)
                   aGroupedSlide.priority = (aSlidesModel.priority)
                   aGroupedSlide.slideData = data.fileData ?? Data()
                   aGroupedSlide.utType = "text/html"
                   aGroupedSlide.isFailed = aSlidesModel.isFailed
                   aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                   aGroupedSlide.isSelected = aSlidesModel.isSelected
                   slidesModelArr.append(aGroupedSlide)

               }
               return slidesModelArr
           } else   {
               var slidesModelArr = [SlidesModel]()
               let aGroupedSlide = SlidesModel()
               aGroupedSlide.code = (aSlidesModel.code)
               aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
               aGroupedSlide.isFailed = aSlidesModel.isFailed
               aGroupedSlide.code =   (aSlidesModel.code)
               aGroupedSlide.camp = (aSlidesModel.camp)
               aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
               //  aGroupedSlide.filePath = extractedfileURL ?? ""
               aGroupedSlide.group = (aSlidesModel.group)
               aGroupedSlide.specialityCode = aSlidesModel.specialityCode
               aGroupedSlide.slideId = (aSlidesModel.slideId)
               aGroupedSlide.fileType = aSlidesModel.fileType
               // aGroupedSlidedel.effFrom = effFrom = DateI
               aGroupedSlide.categoryCode = aSlidesModel.categoryCode
               aGroupedSlide.name = aSlidesModel.name
               aGroupedSlide.fileName = aSlidesModel.filePath
               aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)
               aGroupedSlide.ordNo = (aSlidesModel.ordNo)
               aGroupedSlide.priority = (aSlidesModel.priority)
               aGroupedSlide.slideData =  Data()
               aGroupedSlide.utType = ""
               
        
               aGroupedSlide.imageData = Data()
              
               
               aGroupedSlide.isSelected = aSlidesModel.isSelected
               aGroupedSlide.isFailed = aSlidesModel.isFailed
               aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
               slidesModelArr.append(aGroupedSlide)
               return slidesModelArr
           }

    }
    
    func readHTMLFile(inDirectory directoryPath: String) -> (htmlString: String?, htmlFileURL: URL?) {
        do {
            // Get the list of files in the directory
            let fileManager = FileManager.default
            let files = try fileManager.contentsOfDirectory(atPath: directoryPath)
            
            // Find the HTML file in the list of files
            if let htmlFileName = files.first(where: { $0.hasSuffix(".html") }) {
                let htmlFilePath = (directoryPath as NSString).appendingPathComponent(htmlFileName)
                let htmlFileURL = URL(fileURLWithPath: htmlFilePath)
                let htmlString = try String(contentsOfFile: htmlFilePath, encoding: .utf8)
                return (htmlString, htmlFileURL)
            } else {
                print("No HTML file found in the directory.")
                return (nil, nil)
            }
        } catch {
            print("Error reading HTML file: \(error)")
            return (nil, nil)
        }
    }
    
    func extractUnzippedDataInfo(from folderURL: URL) -> UnzippedDataInfo {
        var unzippedDataInfo = UnzippedDataInfo()

        do {
            let contents = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: [])
            
            for fileURL in contents {
                let mimeType = mimeTypeForPath(path: fileURL.path)
                
                if mimeType.hasPrefix("video") {
                    var videoInfo = Videoinfo()
                    videoInfo.fileData = try? Data(contentsOf: fileURL)
                    videoInfo.filetype = mimeType
                    unzippedDataInfo.videofiles.append(videoInfo)
                } else if mimeType.hasPrefix("image") {
                    var imageInfo = Imageinfo()
                    imageInfo.fileData = try? Data(contentsOf: fileURL)
                    imageInfo.filetype = mimeType
                    unzippedDataInfo.imagefiles.append(imageInfo)
                }
            }
        } catch {
            print("Error reading contents of the unzipped folder: \(error)")
        }

        return unzippedDataInfo
    }
    
    func findImageData(inDirectory directoryURL: URL) -> Data? {
        let fileManager = FileManager.default
        
        do {
            let contents = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            
            for itemURL in contents {
                // Check if the file is an image file (you can customize this check based on your file types)
                if isImageFile(itemURL) {
                    if let fileData = try? Data(contentsOf: itemURL) {
                        return fileData
                    }
                }
            }
        } catch {
            print("Error while accessing contents of directory: \(error)")
        }
        
        return nil
    }
    
    
    func isImageFile(_ fileURL: URL) -> Bool {
        let imageFileExtensions = ["jpg", "jpeg", "png", "gif", "bmp"] // Add more extensions as needed

        let fileExtension = fileURL.pathExtension.lowercased()
        return imageFileExtensions.contains(fileExtension)
    }
}
