//
//  Appdelegate+Ex.swift
//  E-Detailing
//
//  Created by San eforce on 31/01/24.
//

import Foundation
import MobileCoreServices
import SSZipArchive


extension MasterSyncVC {
    func toLoadPresentationData(type : MasterInfo) {
        
        let paramData = type == MasterInfo.slides ? LocalStorage.shared.getData(key: LocalStorage.LocalValue.slideResponse) :  LocalStorage.shared.getData(key: LocalStorage.LocalValue.BrandSlideResponse)
        //   var localParamArr = [[String: Any]]()
        //  var encodedSlideModelData: [SlidesModel]?
        
        var localParamArr = [[String:  Any]]()
        do {
            localParamArr  = try JSONSerialization.jsonObject(with: paramData, options: []) as?  [[String:  Any]] ??  [[String:  Any]]()
            dump(localParamArr)
        } catch {
            self.toCreateToast("unable to retrive")
        }
        
        if type == MasterInfo.slides {
            arrayOfAllSlideObjects.removeAll()
        }
        
        if type == MasterInfo.slides {
            for dictionary in localParamArr {
                if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary),
                   let model = try? JSONDecoder().decode(SlidesModel.self , from: jsonData) {
                    model.uuid = UUID()
                    arrayOfAllSlideObjects.append(model)
                    
                    
                } else {
                    print("Failed to decode dictionary into YourModel")
                }
            }
        } else {
            CoreDataManager.shared.removeAllSlideBrands()
            for dictionary in localParamArr {
                if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary),
                   let model = try? JSONDecoder().decode(BrandSlidesModel.self , from: jsonData) {
                    model.uuid = UUID()
                    // arrayOfBrandSlideObjects.append(model)
                    
                    CoreDataManager.shared.saveBrandSlidesToCoreData(savedBrandSlides: model) { isInstanceSaved in
                        if isInstanceSaved {
                            print("Saved BrandSlidesModel sucessfully to core data")
                        } else {
                            print("Error saving  BrandSlidesModel to core data")
                        }
                    }
                } else {
                    print("Failed to decode dictionary into YourModel")
                }
            }
        }
        
        
        if type == .slides {
            toSendParamsToAPISerially(index: 0, items:  arrayOfAllSlideObjects) { _ in
                
            }
        }
        //        else {
        //            LocalStorage.shared.saveObjectToUserDefaults(arrayOfBrandSlideObjects, forKey: LocalStorage.LocalValue.LoadedBrandSlideData)
        //        }
        
        
        
    }
    
    func toSendParamsToAPISerially(index: Int, items: [SlidesModel], completion: @escaping (Bool) -> Void) {
      
        self.arrayOfAllSlideObjects = items
        guard index < items.count else {
            self.toCreateToast("Download completed")
            // All items processed, exit the recursion
            
            //   LocalStorage.shared.saveObjectToUserDefaults(items, forKey: LocalStorage.LocalValue.LoadedSlideData)
            CoreDataManager.shared.removeAllSlides()
            items.forEach { aSlidesModel in
                CoreDataManager.shared.saveSlidesToCoreData(savedSlides: aSlidesModel) { isInstanceSaved in
                    if isInstanceSaved {
                        
                    } else {
                        
                    }
                }
            }
            
            
          
            //            DispatchQueue.main.async {
            //                self.toCreateToast("Download completed")
            //            }
            //            completion(true)
            toGroupSlidesBrandWise()
            completion(true)
            return
        }
        
        let params = items[index]
        
        
        let filePath = params.filePath
        let url =  slideURL+filePath
        
        
        
        if index == 4 {
            print("Reached")
            
        }
        
        let type = mimeTypeForPath(path: url)
        params.utType = type
        
        // https://sanffa.info/Edetailing_files/DP/download/CC_VA_2021_.jpg
        
        self.downloadData(mediaURL : url) {  data ,error  in
            if let error = error {
                print("Error downloading media: \(error)")
                return
            }
            if let data = data {
                params.slideData = data
                
                completion(true)
            }
            
            let nextIndex = index + 1
            self.toSendParamsToAPISerially(index: nextIndex, items: items) {_ in
                
            }
            
        }
        
    }
    
    
    func toGroupSlidesBrandWise() {
        let  arrayOfAllSlideObjects =  CoreDataManager.shared.retriveSavedSlides()
        let arrayOfBrandSlideObjects = CoreDataManager.shared.retriveSavedBrandSlides()
        CoreDataManager.shared.removeAllGroupedSlides()
        //   var groupedBrandsSlideModel =  [GroupedBrandsSlideModel]()
        arrayOfBrandSlideObjects.enumerated().forEach {index, brandSlideModel in
            let aBrandData =  arrayOfAllSlideObjects.filter({ aSlideModel in
                aSlideModel.code == brandSlideModel.productBrdCode
            })
            
            let aBrandGroup = GroupedBrandsSlideModel()
            
            aBrandGroup.groupedSlide = aBrandData
            aBrandGroup.priority = brandSlideModel.priority
            // aBrandGroup.updatedDate = brandSlideModel.updatedDate
            aBrandGroup.divisionCode = brandSlideModel.divisionCode
            aBrandGroup.productBrdCode = brandSlideModel.productBrdCode
            aBrandGroup.subdivisionCode = brandSlideModel.subdivisionCode
            //  aBrandGroup.createdDate = brandSlideModel.createdDate
            aBrandGroup.id = brandSlideModel.id
          
            CoreDataManager.shared.toSaveGroupedSlidesToCoreData(groupedBrandSlide: aBrandGroup) { isSaved in
                if !isSaved {
                    print("Error saving groupedBrandSlide to core data")
                    checkifSyncIsCompleted()
                } else {
                    print("Saved successfully")
                    tounArchiveData { _ in
                        if index == arrayOfBrandSlideObjects.count - 1 {
                            checkifSyncIsCompleted()
                        }
                    }
                }
            }
            
        }
        
        func tounArchiveData(completion: @escaping (Bool) -> Void) {
            var zipContentsSlides = [SlidesModel]()
            var zipgropedBrandModels = [GroupedBrandsSlideModel]()
            groupedBrandsSlideModel = CoreDataManager.shared.retriveGroupedSlides()
            CoreDataManager.shared.removeAllGroupedSlides()
            if  let groupedBrandsSlideModel = groupedBrandsSlideModel {
                var tempGroupedBrandsSlideModel =  [GroupedBrandsSlideModel]()
                groupedBrandsSlideModel.enumerated().forEach { aGroupedBrandsSlideModelIndex, aGroupedBrandsSlideModel in
                    // Filter out slides with utType equal to "application/zip"
                    zipContentsSlides = aGroupedBrandsSlideModel.groupedSlide.filter { aSlideModel in
                        aSlideModel.utType == "application/zip"
                    }
                    
                    // Update groupedSlideModel by removing slides with utType equal to "application/zip"
                    self.groupedBrandsSlideModel?[aGroupedBrandsSlideModelIndex].groupedSlide = aGroupedBrandsSlideModel.groupedSlide.filter { aSlideModel in
                        aSlideModel.utType != "application/zip"
                    }
                    
                    // Append to zipgropedBrandModels if there are zipContentsSlides
                    if !zipContentsSlides.isEmpty {
                        
                        zipgropedBrandModels.append(aGroupedBrandsSlideModel)
                    } else {
                        tempGroupedBrandsSlideModel.append(aGroupedBrandsSlideModel)
                    }
                }
                
                self.groupedBrandsSlideModel = tempGroupedBrandsSlideModel
                
                var modifiedZipgropedBrandModels = [GroupedBrandsSlideModel]()
                
                zipgropedBrandModels.forEach { aGroupedBrandsSlideModel in
                    let tempGroupedBrandsSlideModel = GroupedBrandsSlideModel()
                    //              let zipContentsSlides =  aGroupedBrandsSlideModel.groupedSlide.filter { aGroupedSlide in
                    //                  aGroupedSlide.utType == "application/zip"
                    //                }
                    var aGroupedSlideArr = [SlidesModel]()
                   // var dataArr = [Data]()
                    var data = HTMLinfo()
                    if !zipContentsSlides.isEmpty {
                        zipContentsSlides.forEach { aSlidesModel in
                          //  dataArr.append(contentsOf: unarchiveAndGetData(from: aSlidesModel.slideData) ?? [Data]())
                            data = unarchiveAndGetData(from: aSlidesModel.slideData)
                         //   dataArr.forEach { aData in
                                let aGroupedSlide = SlidesModel()
                                aGroupedSlide.code = (aSlidesModel.code)
                               
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
                            
                            if let url = data.htmlFileURL {
                                aGroupedSlide.filePath = url.absoluteString
                            } else {
                                // Handle the case when data.htmlFileURL is nil
                                print("htmlFileURL is nil")
                            }
                            
                           
                           // self.extractedFileName ?? "Unknown file"
                                aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)
                                // aGroupedSlidedel.effTo = effTo = DateI
                                aGroupedSlide.ordNo = (aSlidesModel.ordNo)
                                aGroupedSlide.priority = (aSlidesModel.priority)
                               aGroupedSlide.slideData = data.fileData ?? Data()
                                let type = mimeTypeForData(data: data.fileData ?? Data())
                                aGroupedSlide.utType = "text/html"
                            //"text/html"
                                aGroupedSlide.isSelected = aSlidesModel.isSelected
                                aGroupedSlideArr.append(aGroupedSlide)
                          //  }
                            
                        }
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
                
                self.groupedBrandsSlideModel?.append(contentsOf: modifiedZipgropedBrandModels)
                
               
                var completedTaskCount = 0
                self.groupedBrandsSlideModel?.enumerated().forEach({ index, aGroupedBrandsSlideModel in
                    CoreDataManager.shared.toSaveGroupedSlidesToCoreData(groupedBrandSlide: aGroupedBrandsSlideModel) { isSaved in
                        completedTaskCount += 1

                            if completedTaskCount == groupedBrandsSlideModel.count {
                                completion(true)
                            }
                    }
                  
                })
                
               
            }
            
            
            
        }
        
        
        
        
        
        
        func checkifSyncIsCompleted(){
            if !isFromLaunch{
                setLoader(pageType: .loaded)
                return
            }
//            let filterStatus = self.animations.filter{$0 == true}
//            if filterStatus.isEmpty{
//
//                ConfigVC().showToast(controller: self, message: "Master Sync Completed", seconds: 2)
//
//                let slideVC = UIStoryboard.slideDownloadVC
//                self.present(slideVC, animated: true)
//
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
//                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                        appDelegate.setupRootViewControllers()
//                    }
//                }
//            }
            
            setLoader(pageType: .navigate)
        }
        
        
        
        
        struct HTMLinfo {
        var htmlString: String?
        var htmlFileURL: URL?
        var fileData:  Data?
            
            init() {
                self.htmlString = String()
                self.htmlFileURL = URL(string: "")
                self.fileData = Data()
            }
        }
        
        func unarchiveAndGetData(from zipData: Data) -> HTMLinfo {
            // Create a temporary directory to extract the files
            let temporaryDirectory = NSTemporaryDirectory()
            let tempZipFilePath = (temporaryDirectory as NSString).appendingPathComponent("temp.zip")
            
            // Write the zip data to a temporary file
            do {
                try zipData.write(to: URL(fileURLWithPath: tempZipFilePath))
            } catch {
                print("Error writing zip data to a temporary file: \(error.localizedDescription)")
                return HTMLinfo()
            }
            
            // Create the directory for extracting the contents
            let extractionDirectory = (temporaryDirectory as NSString).appendingPathComponent(UUID().uuidString)
            
            // Unarchive the zip data
            guard SSZipArchive.unzipFile(atPath: tempZipFilePath, toDestination: extractionDirectory) else {
                print("Error unzipping data")
                return HTMLinfo()
            }
            
            // Get the list of files in the extraction directory
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: extractionDirectory), includingPropertiesForKeys: nil, options: [])
                
                // Read data from each file
                var aHTMLinfo = HTMLinfo()
                var dataArray: Data = Data()
                for fileURL in fileURLs {
                    guard FileManager.default.fileExists(atPath: fileURL.path) else {
                        print("File does not exist at path: \(fileURL.path)")
                        continue
                    }
                    
                   
                        let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
                        print("File Name (without extension): \(fileNameWithoutExtension)")
                         let result: (htmlString: String?, htmlFileURL: URL?) = readHTMLFile(inDirectory: fileURL.path)
                         extractedFileName = fileNameWithoutExtension
                         dataArray = findImageData(inDirectory: fileURL) ?? Data()
                    
                    
                    aHTMLinfo.fileData = dataArray
                    aHTMLinfo.htmlFileURL = result.htmlFileURL
                    aHTMLinfo.htmlString = result.htmlString
                   
                }
                // Remove the temporary files and directory
                do {
                    try FileManager.default.removeItem(atPath: tempZipFilePath)
                    try FileManager.default.removeItem(atPath: extractionDirectory)
                } catch {
                    print("Error removing temporary files or directory: \(error.localizedDescription)")
                }
                return aHTMLinfo
            } catch {
                print("Error listing files in extraction directory: \(error.localizedDescription)")
                return HTMLinfo()
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
    
    func isMediaFile(_ fileURL: URL) -> Bool {
        let mediaFileExtensions = ["jpg", "jpeg", "png"] // Add more extensions as needed
        //, "gif", "mp4", "mov", "avi", "html"
        let fileExtension = fileURL.pathExtension.lowercased()
        return mediaFileExtensions.contains(fileExtension)
        
    }
    
    func downloadData(mediaURL: String, competion: @escaping (Data?, Error?) -> Void) {
        let downloader = MediaDownloader()
        let mediaURL = URL(string: mediaURL)!
        downloader.downloadMedia(from: mediaURL) { (data, error) in
            competion(data, error)
        }
    }
}

func mimeTypeForData(data: Data) -> String {
    var buffer = [UInt8](repeating: 0, count: 1)
    data.copyBytes(to: &buffer, count: 1)

    let uti: CFString

    switch buffer[0] {
    case 0xFF:
        uti = kUTTypeJPEG
    case 0x89:
        uti = kUTTypePNG
    case 0x47:
        uti = kUTTypeGIF
    case 0x49, 0x4D:
        uti = kUTTypeTIFF
    case 0x52 where data.count >= 12:
        let identifier = String(data: data.subdata(in: 0..<12), encoding: .ascii)
        if identifier == "RIFFWAVEfmt " {
            uti = kUTTypeWaveformAudio
        } else {
            uti = kUTTypeAudio
        }
    case 0x00 where data.count >= 12:
        let identifier = String(data: data.subdata(in: 8..<12), encoding: .ascii)
        if identifier == "ftypmp42" {
            uti = kUTTypeMPEG4
        } else {
            uti = kUTTypeVideo
        }
    case 0x3C where data.count >= 4:
        let identifier = String(data: data.subdata(in: 0..<4), encoding: .ascii)
        if identifier == "<!DO" {
            uti = kUTTypeHTML
        } else {
            uti = kUTTypeData
        }
    default:
        uti = kUTTypeData
    }

    if let mimeType = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
        return mimeType as String
    } else {
        return "application/octet-stream"
    }
}



func mimeTypeForPath(path: String) -> String {
    let url = NSURL(fileURLWithPath: path)
    let pathExtension = url.pathExtension

    if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
        if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
            return mimetype as String
        }
    }
    return "application/octet-stream"
}
