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
        
        // Create an AVPlayerItem with the video URL or data
              // let videoURL = URL(string: "your_video_url.mp4")!
              // let playerItem = AVPlayerItem(url: videoURL)

               // Create an AVPlayer
              // let player = AVPlayer(playerItem: playerItem)

               // Create an AVPlayerLayer to display the video
              // let playerLayer = AVPlayerLayer(player: player)
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentsHolderView.frame = CGRect(x: 5, y: 5, width: contentView.width - 10, height: contentView.height - 10)
//        selectedVxVIew.frame = contentsHolderView.bounds
//        selectionView.frame = CGRect(x: contentsHolderView.width / 2 - 45, y: contentsHolderView.height / 2 - 45, width: 45, height: 45)
//        contentsHolderView.addSubview(selectedVxVIew)
//        contentsHolderView.addSubview(selectionView)
//        selectionImage.frame = selectionView.bounds
//    }
    
    
    func setupVIews() {
//        switch type {
//        case .pdf:
//           // player.removeFromSuperview()
//            presentationIV.removeFromSuperview()
//            pdfView.frame = contentsHolderView.bounds
//            contentsHolderView.addSubview(pdfView)
//            pdfView.addSubview(selectedVxVIew)
//            pdfView.addSubview(selectionView)
//        case .image:
//            //player.removeFromSuperview()
//            pdfView.removeFromSuperview()
//            presentationIV.frame = contentsHolderView.bounds
//            contentsHolderView.addSubview(presentationIV)
//            presentationIV.addSubview(selectedVxVIew)
//            presentationIV.addSubview(selectionView)
//        case .video:
//            print("Yet to implement")
//            presentationIV.removeFromSuperview()
//            pdfView.removeFromSuperview()
//            player.accessibilityFrame = contentsHolderView.bounds
//
//
//
//        case .zip:
//            print("Yet to implement")
//
//        }
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
            presentationIV.image = UIImage(named: "video")
            // Create an AVPlayerLayer to display the video
//            let asset = AVAsset(url: URL(dataRepresentation: model.slideData, relativeTo: nil)!)
//
//
//            let playerItem = AVPlayerItem(asset: asset)
//            let player = AVPlayer(playerItem: playerItem)
//            let playerLayer = AVPlayerLayer(player: player)
//            player.play()


        } else if model.utType == "application/zip" {
            self.type = .zip
            print(model.utType)
            presentationIV.image = UIImage(named: "zip")
        } else {
            
            print(model.utType)
            
        }
        
       // layoutSubviews()
       // setupVIews()
        
    }
    
//    func unzip(data: Data, to destinationURL: URL) throws {
//        // Create a temporary directory to extract the contents
//        let temporaryDirectory = FileManager.default.temporaryDirectory
//        let temporaryURL = temporaryDirectory.appendingPathComponent(UUID().uuidString)
//
//        do {
//            // Create a temporary directory
//            try FileManager.default.createDirectory(at: temporaryURL, withIntermediateDirectories: true, attributes: nil)
//
//            // Write the zip data to a temporary file
//            let temporaryFileURL = temporaryURL.appendingPathComponent("archive.zip")
//            try data.write(to: temporaryFileURL)
//
//            // Unzip the contents
//            try FileManager.default.unzipItem(at: temporaryFileURL, to: destinationURL)
//        } catch {
//            // Handle errors
//            throw error
//        }
//
//        // Remove the temporary directory
//        try? FileManager.default.removeItem(at: temporaryURL)
//    }

    // Example usage:
//    do {
//        let zipData = try Data(contentsOf: URL(fileURLWithPath: "/path/to/your/file.zip"))
//        let destinationURL = URL(fileURLWithPath: "/path/to/your/destination")
//        try unzipData(data: zipData, to: destinationURL)
//    } catch {
//        print("Error: \(error)")
//    }

}
