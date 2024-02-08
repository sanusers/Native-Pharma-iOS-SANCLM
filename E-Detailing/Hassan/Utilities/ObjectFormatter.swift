//
//  ObjectFormatter.swift
//  E-Detailing
//
//  Created by San eforce on 23/01/24.
//

import Foundation
import UIKit
import PDFKit
import AVFoundation



class ObjectFormatter {
    
    static let shared = ObjectFormatter()
    
    
    func convertData2Obj(data: Data) -> JSON {
        

        
        
        return JSON()
    }
    
    
    
    func convertJson2Data(json: JSON) -> Data {
        
        var jsonDatum = Data()

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            jsonDatum = jsonData
           
            // Convert JSON data to a string
            if let tempjsonString = String(data: jsonData, encoding: .utf8) {
                print(tempjsonString)

            }
            return jsonDatum

        } catch {
            print("Error converting parameter to JSON: \(error)")
        }
        
        return Data()
    }
    
    
    func convertJsonArr2Data(json: [JSON]) -> Data {
        
        var jsonDatum = Data()

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: [json], options: [])
            jsonDatum = jsonData
           
            // Convert JSON data to a string
            if let tempjsonString = String(data: jsonData, encoding: .utf8) {
                print(tempjsonString)

            }
            return jsonDatum

        } catch {
            print("Error converting parameter to JSON: \(error)")
        }
        
        return Data()
    }
    
    func loadImageInBackground(utType: String?, data: Data?, presentationIV: UIImageView, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let welf = self else {return}
            autoreleasepool {
                var displayImage: UIImage?
                
                if let utType = utType, let data = data {
                    switch utType {
                    case "image/jpeg", "image/png", "image/jpg", "image/bmp", "text/html", "image/gif":
                        if let thumbnailImage = UIImage(data: data)?.resize(to: CGSize(width: presentationIV.width, height: presentationIV.height)) {
                            // Load a thumbnail (adjust the size as needed)
                            displayImage = thumbnailImage
                        } else {
                            // Failed to create a thumbnail
                            displayImage = nil
                        }
                    case "video/mp4":
                        displayImage = welf.displayThumbnail(for: data)
                        
                    case "application/pdf":
                        var pdfView : PDFView?
                        let pdfData = data
                        DispatchQueue.main.async {
                            if let pdfDocument = PDFDocument(data: pdfData) {
                                pdfView = PDFView()
                                pdfView?.document = pdfDocument
                                let pdfPage = pdfDocument.page(at: 0)
                                // Convert the PDF page to an image
                                if let pdfImage = pdfPage?.thumbnail(of: CGSize(width: pdfPage?.bounds(for: .mediaBox).width ?? 0, height: pdfPage?.bounds(for: .mediaBox).height ?? 0), for: .mediaBox) {
                                    // Display the image in the UIImageView
                                    
                                    if let thumbnailImage = pdfImage.resize(to: CGSize(width: presentationIV.width, height: presentationIV.height)) {
                                        // Load a thumbnail (adjust the size as needed)
                                        displayImage = thumbnailImage
                                        
                                        pdfView = nil
                                        displayImage = pdfImage
                                        
                                    }
                                }
                              
                            } else {
                                print("Failed to create PDF document from data.")
                            }
                        }

                    default:
                        displayImage = nil
                    }
                } else {
                    displayImage = nil
                }

                DispatchQueue.main.async {
                    completion(displayImage)
                }
            }
        }
    }
    
    
    func displayThumbnail(for videoData: Data) -> UIImage {
        guard let videoURL = saveVideoDataToTemporaryFile(data: videoData) else {
            return UIImage()
        }
        
        let asset = AVAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)
        
        do {
            let cgImage = try generator.copyCGImage(at: CMTimeMake(value: 1, timescale: 2), actualTime: nil)
            let thumbnailImage = UIImage(cgImage: cgImage)
            deleteTemporaryFile(at: videoURL)
           return thumbnailImage
          //  self.contentMode = .scaleAspectFill
      
        } catch {
            print("Error generating thumbnail: \(error.localizedDescription)")
        }
        return UIImage()
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
    
    func deleteTemporaryFile(at url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
            print("Temporary file deleted successfully.")
        } catch {
            print("Error deleting temporary file: \(error.localizedDescription)")
        }
    }

}
