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
    
        if model.utType == "application/pdf" {
            pdfView.contentMode = .scaleAspectFit
            formatIV.image = UIImage(named: "pdf")
             let pdfData = model.slideData
                if let pdfDocument = PDFDocument(data: pdfData) {
                    pdfView.document = pdfDocument

                     let pdfPage = pdfDocument.page(at: 0)
                        // Convert the PDF page to an image
                    if let pdfImage = pdfPage?.thumbnail(of: CGSize(width: pdfPage?.bounds(for: .mediaBox).width ?? 0, height: pdfPage?.bounds(for: .mediaBox).height ?? 0), for: .mediaBox) {
                            // Display the image in the UIImageView
                        presentationIV.image = pdfImage
                        }
                    
                } else {
                    print("Failed to create PDF document from data.")
                }
        
        } else  if model.utType == "image/jpeg" {
            formatIV.image = UIImage(named: "image")   
            presentationIV.contentMode = .scaleAspectFill
            if let image = UIImage(data: model.slideData) {
                // The downloaded data represents an image
                presentationIV.image = image
                print("Downloaded data is an image.")
            } else {
                // The downloaded data is not an image
                print("Downloaded data is of an unknown type.")
            }
        } else if model.utType == "video/mp4" {
            print(model.utType)
            formatIV.image = UIImage(named: "video")
            displayThumbnail(for: model.slideData)
            
            
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
