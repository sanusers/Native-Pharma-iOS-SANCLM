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
        let data =  model.slideData
        let utType = model.utType
        presentationIV.toSetImageFromData(utType: utType, data: data)
     
        
        
    }
    }
