//
//  PlayHTMLCVC.swift
//  E-Detailing
//
//  Created by San eforce on 31/01/24.
//

import UIKit
import WebKit

    
    class PlayHTMLCVC: UICollectionViewCell {
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

        func loadURL(_ htmlString: String) {
            if let fileURL = URL(string: htmlString) {
                let baseURL = URL(fileURLWithPath: htmlString).deletingLastPathComponent()
                webView.loadFileURL(fileURL, allowingReadAccessTo: baseURL)
            } else {
                print("Invalid file path")
            }
           // webView.loadHTMLString(htmlString, baseURL: nil)
          
        }
    }


