//
//  PlayPresentationCVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import UIKit
import PDFKit
import AVFoundation

class PlayPresentationCVC: UICollectionViewCell {
    @IBOutlet var holderIV: UIView!
    @IBOutlet var formatIV: UIImageView!
    @IBOutlet var formatVIew: UIView!
    
    @IBOutlet var presentationIV: UIImageView!
    @IBOutlet var holderViewWidth: NSLayoutConstraint!
    @IBOutlet var holderViewHeight: NSLayoutConstraint!
    let pdfView = PDFView()
//    var isCellSelected {
//        didSet {
//
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderIV.backgroundColor = .clear
    
        formatVIew.layer.cornerRadius = formatVIew.height / 2
    }
    
    func toPopulateCell(_ model: SlidesModel) {
        
            let data =  model.slideData
            let utType = model.utType
            presentationIV.toSetImageFromData(utType: utType, data: data)
        if model.utType == "application/pdf" {
        
            formatIV.image = UIImage(named: "pdf")
        } else  if model.utType == "image/jpeg" {
            formatIV.image = UIImage(named: "image")
   
        } else if model.utType == "video/mp4" {
         
            formatIV.image = UIImage(named: "video")
    
        } else if model.utType == "application/zip" {
          
            print(model.utType)
            presentationIV.image = UIImage(named: "zip")
        } else {
            
            print(model.utType)
            
        }
        
       // layoutSubviews()
       // setupVIews()
        
    }
    
    
    func displayThumbnail(for videoData: Data) {
        guard let videoURL = saveVideoDataToTemporaryFile(data: videoData) else {
            return
        }

        let asset = AVAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)

        do {
            let cgImage = try generator.copyCGImage(at: CMTimeMake(value: 1, timescale: 2), actualTime: nil)
            let thumbnailImage = UIImage(cgImage: cgImage)
            presentationIV.image = thumbnailImage
            presentationIV.contentMode = .scaleAspectFill
        } catch {
            print("Error generating thumbnail: \(error.localizedDescription)")
        }
    }
    
    func saveVideoDataToTemporaryFile(data: Data) -> URL? {
        do {
            let temporaryDirectoryURL = FileManager.default.temporaryDirectory
            let temporaryFileURL = temporaryDirectoryURL.appendingPathComponent("temp_video.mp4")
            try data.write(to: temporaryFileURL)
            return temporaryFileURL
        } catch {
            print("Error saving video data to temporary file: \(error.localizedDescription)")
            return nil
        }
    }
    
    

    
    

    

}
