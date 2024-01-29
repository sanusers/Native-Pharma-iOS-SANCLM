//
//  SelectPresentationCVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import UIKit
import PDFKit
import AVFoundation


class SelectPresentationCVC: UICollectionViewCell {
    
    
    enum CellType {
        case pdf
        case image
        case video
        case zip
    }
    
    @IBOutlet var selectedVxVIew: UIVisualEffectView!
    @IBOutlet var selectionImage: UIImageView!
    @IBOutlet var selectionView: UIView!
    @IBOutlet var presentationIV: UIImageView!
    @IBOutlet var contentsHolderView: UIView!
    let pdfView = PDFView()
    //var player = AVPlayer()
    var type : CellType = .image
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentsHolderView.layer.cornerRadius = 5
        contentsHolderView.layer.borderColor = UIColor.appLightTextColor.cgColor
        contentsHolderView.layer.borderWidth = 1
        selectionView.layer.cornerRadius = selectionView.height / 2
        selectionView.backgroundColor = .appWhiteColor
        selectionImage.tintColor = .appGreen
        selectionImage.image = UIImage(systemName: "checkmark.circle.fill")
        
        
    }
    
    
    
    
    func setupVIews() {
        
    }
    
    
    
    func toPopulateCell(_ model: SlidesModel) {
        
        if model.utType == "application/pdf" {
            self.type = .pdf
            
            
            pdfView.contentMode = .scaleAspectFill
            
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
            self.type = .image
            
            
            presentationIV.contentMode = .scaleAspectFit
            if let image = UIImage(data: model.slideData) {
                // The downloaded data represents an image
                presentationIV.image = image
                print("Downloaded data is an image.")
            } else {
                // The downloaded data is not an image
                print("Downloaded data is of an unknown type.")
            }
        } else if model.utType == "video/mp4" {
            self.type = .video
            print(model.utType)
            displayThumbnail(for: model.slideData)
        } else if model.utType == "application/zip" {
            self.type = .zip
            print(model.utType)
            presentationIV.image = UIImage(named: "zip")
        } else {
            
            print(model.utType)
            
        }
        
        
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
