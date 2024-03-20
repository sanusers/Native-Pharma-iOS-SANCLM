//
//  BackgroundTaskManager.swift
//  E-Detailing
//
//  Created by San eforce on 19/03/24.
//

import Foundation
import UIKit

extension BackgroundTaskManager : MediaDownloaderDelegate {
    func mediaDownloader(_ downloader: MediaDownloader, didUpdateProgress progress: Float) {
        print("Downloading...<--")
     //   isDownloading = true
    }
    
    func mediaDownloader(_ downloader: MediaDownloader, didFinishDownloadingData data: Data?) {
        
        guard let items = self.items else {return}
        guard let index = self.index else {return}
        let params = items[index]
           let data = data
           params.slideData = data ?? Data()
           params.isDownloadCompleted = true
           params.isFailed = false
           params.uuid = UUID()
        
            delegate?.didUpdate(rrayOfAllSlideObjects: items, index: index) {
            LocalStorage.shared.setSting(LocalStorage.LocalValue.slideDownloadIndex, text: "\(self.index ?? 0)")
            self.toDownloadMedia(index: (self.index ?? 0) + 1, items: items, delegte: self.delegate!)
        }
    
        
        
        //self.toStartBackgroundTask(index: (self.index ?? 0) + 1, items: items, delegte: self.delegate!)
    }
    
    func mediaDownloader(_ downloader: MediaDownloader, didEncounterError error: Error) {
   
            
        }
    }
    
    

protocol BackgroundTaskManagerDelegate: AnyObject {
    func didUpdate(rrayOfAllSlideObjects: [SlidesModel], index: Int, completion: @escaping () -> ())
}

class BackgroundTaskManager {
    static let shared = BackgroundTaskManager()
    
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    private var isBackgroundTaskRunning = false
    
    var hostVC: UIViewController?
    var index: Int?
    var items: [SlidesModel]?
    var delegate: BackgroundTaskManagerDelegate?
    
    init(hostVC: UIViewController? = UIViewController()) {
        self.hostVC = hostVC
    }
    
    
    func toDownloadMedia(index: Int, items: [SlidesModel], isForsingleRetry: Bool? = false, delegte: BackgroundTaskManagerDelegate) {

        Shared.instance.isSlideDownloading = true
        
        guard index >= 0, index < items.count else {
            
            LocalStorage.shared.setSting(LocalStorage.LocalValue.slideDownloadIndex, text: "")
            Shared.instance.isSlideDownloading = false
            self.stopBackgroundTask()
            return
        }

        
        self.toStartBackgroundTask(index: index, items: items, delegte: delegte)
        }
    
    
    
    
    
    func toStartBackgroundTask(index: Int, items: [SlidesModel], delegte: BackgroundTaskManagerDelegate) {
        self.delegate = delegte
        self.index = index
        self.items = items
        // Begin a background task
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            // End the background task if the expiration handler is called
      
            self.endBackgroundTask()
        }
        isBackgroundTaskRunning = true
        // Perform API calls in the background
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
          
         //   BackgroundTaskManager.shared.stopBackgroundTask()
            
            self.toSendParamsToAPISerially(index: index, items: items, isForsingleRetry: false)

        }
     
   
    }
    
    func stopBackgroundTask() {
        if isBackgroundTaskRunning {
            endBackgroundTask()
        }
    }
    
    private func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
        isBackgroundTaskRunning = false
    }
    
    
    
    func toSendParamsToAPISerially(index: Int, items: [SlidesModel], isForsingleRetry: Bool? = false) {


        let params = items[index]
        let filePath = params.filePath
        let url =  slideURL+filePath
        let type = mimeTypeForPath(path: url)
        params.utType = type
        
        // https://sanffa.info/Edetailing_files/DP/download/CC_VA_2021_.jpg
        
       // self.downloadData(mediaURL : url)
        Pipelines.shared.downloadData(mediaURL: url, delegate: self)
        
    }
}
