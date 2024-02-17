//
//  Appdelegate+Ex.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 31/01/24.
//

import Foundation
import MobileCoreServices
import SSZipArchive



extension MasterSyncVC {
    
    enum PageType {
        case loading
        case loaded
        case navigate
    }
    
    func setLoader(pageType: PageType, type: MasterInfo? = nil) {
        switch pageType {
        case .loading:
            Shared.instance.showLoaderInWindow()
        case .loaded:
            Shared.instance.removeLoaderInWindow()
        case .navigate:
            Shared.instance.removeLoaderInWindow()
            if isFromLaunch {
                if type == .homeSetup || (type == .slides || type == .slideBrand) && self.loadedSlideInfo.count >= 2 {
                    if self.loadedSlideInfo.count >= 2 {
                        moveToDownloadSlide()
                    }
                }
            
            } else {
                let isNewSlideExists =  self.toCheckExistenceOfNewSlides()
                if isNewSlideExists {
                    moveToDownloadSlide()
                }
            }

            
        
        }
    }
    
    func toCheckExistenceOfNewSlides() -> Bool {
        let paramData = LocalStorage.shared.getData(key: LocalStorage.LocalValue.slideResponse)
        var localParamArr = [[String:  Any]]()
        do {
            localParamArr  = try JSONSerialization.jsonObject(with: paramData, options: []) as?  [[String:  Any]] ??  [[String:  Any]]()
            dump(localParamArr)
        } catch {
            //  self.toCreateToast("unable to retrive")
        }
        arrayOfAllSlideObjects.removeAll()
        for dictionary in localParamArr {
            if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary),
               let model = try? JSONDecoder().decode(SlidesModel.self , from: jsonData) {
                model.uuid = UUID()
                arrayOfAllSlideObjects.append(model)
                
                
            } else {
                print("Failed to decode dictionary into YourModel")
            }
        }
        let existingCDSlides: [SlidesModel] = CoreDataManager.shared.retriveSavedSlides()
        let apiFetchedSlide: [SlidesModel] = self.arrayOfAllSlideObjects
        // Extract slideId values from each array
        let existingSlideIds = Set(existingCDSlides.map { $0.slideId })

        // Filter apiFetchedSlide to get slides with slideIds not present in existingCDSlides
        let nonExistingSlides = apiFetchedSlide.filter { !existingSlideIds.contains($0.slideId) }

        // Now, nonExistingSlides contains the slides that exist in apiFetchedSlide but not in existingCDSlides based on slideId

        return !nonExistingSlides.isEmpty
        
    }
    
    func moveToDownloadSlide() {
        let vc = SlideDownloadVC.initWithStory()
        vc.isFromlaunch = isFromLaunch
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
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
