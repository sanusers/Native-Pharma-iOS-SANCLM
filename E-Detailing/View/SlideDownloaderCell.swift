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

extension SlideDownloaderCell: URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        // Handle the downloaded file
//        // ...
//
//        // Reset progress view after download completion
//        DispatchQueue.main.async {
//            self.progressView.progress = 0.0
//        }
//    }
//
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        // Update progress view
//        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//        self.lblDataBytes.text = "Downloading \(progress)%"
//        DispatchQueue.main.async {
//            self.progressView.progress = progress
//        }
//    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Did finish downloading")
        // ... rest of the code
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Did write data")
        // ... rest of the code
    }
    
}

class SlideDownloaderCell : UITableViewCell  {
    // MARK: URLSessionDownloadDelegate


    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDataBytes: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var btnRetry: UIButton!
    weak var delegate: SlideDownloaderCellDelegate?
   // var arrayOfAllSlideObjects = [SlidesModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.setFont(font: .medium(size: .BODY))
        lblDataBytes.setFont(font: .medium(size: .SMALL))
        progressView.setProgress(0, animated: false)
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

        self.lblDataBytes.text = "Downloading..."
        btnRetry.isHidden = true
        let params = items[index]
        
        
        let filePath = params.filePath
        let url =  slideURL+filePath
        
        

        
        let type = mimeTypeForPath(path: url)
        params.utType = type
        
        // https://sanffa.info/Edetailing_files/DP/download/CC_VA_2021_.jpg
        
        self.downloadData(mediaURL : url) { [weak self]  data ,error  in
            guard let welf = self else {return}
            if let error = error {
                print("Error downloading media: \(error)")
                welf.btnRetry.isHidden = false
                return
            }
            if let data = data {
                params.slideData = data
                welf.lblDataBytes.text = "Download completed"
                welf.btnRetry.isHidden = true
                welf.delegate?.didDownloadCompleted(arrayOfAllSlideObjects: items, index: index + 1) {_ in}
              //  completion(true)
            }
            
            
        }
        
    }
    
    func downloadData(mediaURL: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: mediaURL) else {
            completion(nil, NSError(domain: "E-Detailing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }

        let downloader = MediaDownloader(delegate: self)
        downloader.downloadMedia(from: url) { (data, error) in
            completion(data, error)
        }
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
