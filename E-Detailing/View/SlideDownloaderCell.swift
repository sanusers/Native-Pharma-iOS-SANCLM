//
//  SlideDownloaderCell.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 21/06/23.
//

import UIKit

protocol SlideDownloaderCellDelegate: AnyObject {
    func didDownloadCompleted(arrayOfAllSlideObjects : [SlidesModel], index: Int, completion: @escaping (Bool) -> Void)
}

extension SlideDownloaderCell: MediaDownloaderDelegate {
    func mediaDownloader(_ downloader: MediaDownloader, didFinishDownloadingData data: Data?) {
        print("Download completed")
        let params = model[index]
         let data = data
            params.slideData = data ?? Data()
            lblDataBytes.text = "Download completed"
            btnRetry.isHidden = true
            delegate?.didDownloadCompleted(arrayOfAllSlideObjects: model, index: index + 1) {_ in}
        
    }
    
    func mediaDownloader(_ downloader: MediaDownloader, didEncounterError error: Error) {
       let error = error
            print("Error downloading media: \(error)")
            btnRetry.isHidden = false
            delegate?.didDownloadCompleted(arrayOfAllSlideObjects: model, index: index + 1) {_ in}
        
    }
    
    func mediaDownloader(_ downloader: MediaDownloader, didUpdateProgress progress: Float) {
        self.progressView.progress = progress
        let progressPercentage = Int(progress * 100)
        lblDataBytes.text = "Downloading: \(progressPercentage)%"
    }
    
 
    
    func mediaDownloader(_ downloader: MediaDownloader, didFinishDownloadingData data: Data) {
        

            //  completion(true)
        
    }
    
    
}

class SlideDownloaderCell : UITableViewCell  {
    
    
    // MARK: URLSessionDownloadDelegate
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDataBytes: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var btnRetry: UIButton!
    weak var delegate: SlideDownloaderCellDelegate?
    var model = [SlidesModel]()
    var index: Int = 0
    // var arrayOfAllSlideObjects = [SlidesModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblName.setFont(font: .medium(size: .BODY))
        lblDataBytes.setFont(font: .medium(size: .SMALL))
       // progressView.setProgress(0, animated: false)
        lblName.textColor = .appTextColor
        lblDataBytes.textColor = .appLightTextColor
        btnRetry.isHidden = true
    }
    //    func animateProgressView() {
    //        let finalProgress: Float = 1.0
    //        UIView.animate(withDuration: 2.0, animations: {
    //            self.progressView.setProgress(finalProgress, animated: true)
    //        }) { (_) in
    //            // Animation completion code, if needed
    //            print("Animation completed!")
    //        }
    //    }
    
    
    func toSendParamsToAPISerially(index: Int, items: [SlidesModel]) {
     
        // self.arrayOfAllSlideObjects = items
        self.model = items
        self.index = index
        self.lblDataBytes.text = "Downloading..."
        btnRetry.isHidden = true
        let params = items[index]
        let filePath = params.filePath
        let url =  slideURL+filePath
        let type = mimeTypeForPath(path: url)
        params.utType = type
        
        // https://sanffa.info/Edetailing_files/DP/download/CC_VA_2021_.jpg
        
        self.downloadData(mediaURL : url)
//        { [weak self]  data ,error  in
//            guard let welf = self else {return}
//            if let error = error {
//                print("Error downloading media: \(error)")
//                welf.btnRetry.isHidden = false
//                return
//            }
//            if let data = data {
//                params.slideData = data
//                welf.lblDataBytes.text = "Download completed"
//                welf.btnRetry.isHidden = true
//                welf.delegate?.didDownloadCompleted(arrayOfAllSlideObjects: items, index: index + 1) {_ in}
//                //  completion(true)
//            }
//
//
//        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressView.setProgress(0, animated: false)
        self.lblDataBytes.text = "Download operation on queue..."
    }
    
    func downloadData(mediaURL: String) {
        //, completion: @escaping (Data?, Error?) -> Void
        guard let url = URL(string: mediaURL) else {
           // completion(nil, NSError(domain: "E-Detailing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }

        let downloader = MediaDownloader()
        downloader.delegate = self
        downloader.downloadMedia(from: url)
    }
}






class listView : UIView {
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



    

protocol MediaDownloaderDelegate: AnyObject {
    func mediaDownloader(_ downloader: MediaDownloader, didUpdateProgress progress: Float)
    func mediaDownloader(_ downloader: MediaDownloader, didFinishDownloadingData data: Data?)
    func mediaDownloader(_ downloader: MediaDownloader, didEncounterError error: Error)
}



extension MediaDownloader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let data = try Data(contentsOf: location)
            delegate?.mediaDownloader(self, didFinishDownloadingData: data)
        } catch {
            print("Error reading downloaded data: \(error.localizedDescription)")
            delegate?.mediaDownloader(self, didEncounterError: error)
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        delegate?.mediaDownloader(self, didUpdateProgress: progress)
    }
}

class MediaDownloader: NSObject {

    weak var delegate: MediaDownloaderDelegate?

    func downloadMedia(from url: URL) {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
}
