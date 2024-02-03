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

extension UIImageView {
    
    func toSetImageFromData(utType: String, data: Data)  {
        let pdfView = PDFView()
        self.contentMode = .scaleAspectFill
        switch utType {
        case "application/pdf":

            let pdfData = data
            if let pdfDocument = PDFDocument(data: pdfData) {
                pdfView.document = pdfDocument
                
                let pdfPage = pdfDocument.page(at: 0)
                // Convert the PDF page to an image
                if let pdfImage = pdfPage?.thumbnail(of: CGSize(width: pdfPage?.bounds(for: .mediaBox).width ?? 0, height: pdfPage?.bounds(for: .mediaBox).height ?? 0), for: .mediaBox) {
                    // Display the image in the UIImageView
                    self.image = pdfImage
                }
                
            } else {
                print("Failed to create PDF document from data.")
            }
        case "image/jpeg", "image/png", "image/jpg", "image/bmp", "text/html", "image/gif":
           
            if let image = UIImage(data: data) {
                // The downloaded data represents an image
                self.image = image
                print("Downloaded data is an image.")
            } else {
                // The downloaded data is not an image
                print("Downloaded data is of an unknown type.")
            }
        case "video/mp4":
           
            displayThumbnail(for: data)
  
            
        case  "application/zip":
              
                
                self.image = UIImage(named: "zip")
           
                
 
        default:
            print("Unknown type")
            self.image = UIImage(named: "ic_close")

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
            self.image = thumbnailImage
          //  self.contentMode = .scaleAspectFill
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
    
    
}
