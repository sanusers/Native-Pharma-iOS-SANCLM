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
        formatIV.isHidden = true
        formatVIew.layer.cornerRadius = formatVIew.height / 2
    }
    
    func toPopulateCell(_ model: SlidesModel) {
        
            let data =  model.slideData
            let utType = model.utType
            presentationIV.toSetImageFromData(utType: utType, data: data)
      
        
        
        
        
//        if model.utType == "application/pdf" {
//
//            formatIV.image = UIImage(named: "pdf")
//        } else  if model.utType == "image/jpeg" {
//            formatIV.image = UIImage(named: "image")
//
//        } else if model.utType == "video/mp4" {
//
//            formatIV.image = UIImage(named: "video")
//
//        } else if model.utType == "application/zip" {
//
//            print(model.utType)
//            presentationIV.image = UIImage(named: "zip")
//        } else {
//
//            print(model.utType)
//
//        }
        
       // layoutSubviews()
       // setupVIews()
        
    }
    
    

    

    
    

    

}
