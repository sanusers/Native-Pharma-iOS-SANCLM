//
//  PlayHTMLCVC.swift
//  E-Detailing
//
//  Created by San eforce on 31/01/24.
//

import UIKit
import WebKit

    
class PlayHTMLCVC: UICollectionViewCell, WKUIDelegate, WKNavigationDelegate {
        static let  identifier = "PlayHTMLCVC"
        let webView: WKWebView = {
            let webVIew = WKWebView()
            //webVIew = WKWebView(frame: contentView.bounds)
            webVIew.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           // contentView.addSubview(webVIew)
            return webVIew
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupWebView()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupWebView()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            webView.frame = self.bounds
            contentView.addSubview(webView)
        }

        private func setupWebView() {
    
        }

//        func loadURL(_ filepathURL: String) {
////            let fileURL =  URL(fileURLWithPath: filepathURLURL)
////            let baseURL = URL(fileURLWithPath: filepathURLURL).deletingLastPathComponent()
////            webView.loadFileURL(fileURL, allowingReadAccessTo: baseURL)
//
//            //let extractedFolderPath =  filepathURL
//            if   let extractedFolderPath = URL(string: filepathURL) {
//                // Get the contents of the extracted folder
//                if let contents = try? FileManager.default.contentsOfDirectory(at: extractedFolderPath, includingPropertiesForKeys: nil, options: []) {
//                    // Enumerate through the contents
//                    for fileURL in contents {
//                        print("File URL: \(fileURL)")
//                        print("File Name: \(fileURL.lastPathComponent)")
//                        let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
//                        print("File Name (without extension): \(fileNameWithoutExtension)")
//
//                        // Create a valid file URL
//                    }
//                } else {
//                    print("Error getting contents of the extracted folder.")
//                }
//            }
//
//
//
//
//
//
//        }
    
    
    func loadURL(_ filepathURL: String) {
        if let url = URL(string: filepathURL) {
            // Create a base URL for the folder containing the HTML file
            let baseURL = url.deletingLastPathComponent()

            // Assuming webView is an instance of WKWebView
            webView.loadFileURL(url, allowingReadAccessTo: baseURL)
        } else {
            print("Error: Invalid file path.")
        }
    }
    }



