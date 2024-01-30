//
//  CreatedPresentationCVC.swift
//  E-Detailing
//
//  Created by San eforce on 23/01/24.
//

import UIKit
import PDFKit
import AVFoundation

class CreatedPresentationCVC: UICollectionViewCell {

    @IBOutlet var holderView: UIView!
    
    @IBOutlet var optionsHolderView: UIView!
    @IBOutlet var slideDescriptionLbl: UILabel!
    @IBOutlet var slideTitleLbl: UILabel!
    @IBOutlet var presentationIV: UIImageView!
    
    @IBOutlet var bottomContentsHolder: UIView!
    @IBOutlet var optionsIV: UIImageView!
    let pdfView = PDFView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        holderView.backgroundColor = .appWhiteColor
        bottomContentsHolder.backgroundColor = .appTextColor
        holderView.layer.cornerRadius = 5
        bottomContentsHolder.backgroundColor = .appTextColor
        slideTitleLbl.setFont(font: .bold(size: .BODY))
        slideTitleLbl.textColor = .appWhiteColor
        slideDescriptionLbl.setFont(font: .medium(size: .SMALL))
        slideDescriptionLbl.textColor = .appWhiteColor
        optionsIV.transform =  optionsIV.transform.rotated(by: .pi  * 1.5)
        optionsIV.tintColor = .appWhiteColor
    }
    
    func populateCell(model: SavedPresentation) {
        
        
        var slidesModel = [SlidesModel]()
        model.groupedBrandsSlideModel.forEach { aGroupedBrandsSlideModel in
          let aslidesModel = aGroupedBrandsSlideModel.groupedSlide.filter { aSlidesModel in
                aSlidesModel.isSelected
            }
            slidesModel.append(contentsOf: aslidesModel)
        }
        

            slideDescriptionLbl.text = "\(slidesModel.count) Asserts"
        
        
        slideTitleLbl.text = model.name
        let groupedBrandsSlideElement = model.groupedBrandsSlideModel.last
        
        
        
        let slideElement = groupedBrandsSlideElement?.groupedSlide.last
        let imageDatatype = slideElement?.utType ?? ""
        
        
        self.presentationIV.toSetImageFromData(utType: imageDatatype, data: slideElement?.slideData ?? Data())
        
    }


}
