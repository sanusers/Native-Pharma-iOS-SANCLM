//
//  SelectedSlidesTVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import UIKit

class SelectedSlidesTVC: UITableViewCell {

    @IBOutlet var titleLbl: UILabel!
    
    
    @IBOutlet var deleteoptionView: UIView!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var presentationIV: UIImageView!
    @IBOutlet var rearrangeView: UIView!
    @IBOutlet var contentsHolderVIew: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        presentationIV.layer.cornerRadius = 5
        contentsHolderVIew.layer.cornerRadius = 5
        contentsHolderVIew.backgroundColor = .appGreyColor
        //rearrangeView
        titleLbl.setFont(font: .bold(size: .BODY))
        descriptionLbl.setFont(font: .medium(size: .SMALL))
        titleLbl.textColor = .appTextColor
        descriptionLbl.textColor = .appLightTextColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func toPopulateCell(model: SlidesModel) {
        titleLbl.text = model.name
        descriptionLbl.text = model.fileName
        //extractFileName(from: model.slideData)
        //"Yet to be added"
        let data =  model.slideData
        let utType = model.utType
        presentationIV.toSetImageFromData(utType: utType, data: data)
    }

}
