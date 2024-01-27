//
//  BrandsNameTVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import UIKit

class BrandsNameTVC: UITableViewCell {

    @IBOutlet var contentsHolderView: UIView!
    
    @IBOutlet var brandsTitle: UILabel!
    @IBOutlet var countsLbl: UILabel!
    @IBOutlet var countsVXVew: UIVisualEffectView!
    @IBOutlet var accessoryIV: UIImageView!
    @IBOutlet var countsHolderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentsHolderView.backgroundColor = .appWhiteColor
       
        contentsHolderView.layer.cornerRadius = 5
        countsHolderView.layer.cornerRadius = 3
        countsVXVew.backgroundColor = .appGreen
        countsLbl.textColor = .appGreen
        countsLbl.setFont(font: .bold(size: .SMALL))
        brandsTitle.textColor = .appTextColor
        brandsTitle.setFont(font: .bold(size: .BODY))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func toPopulateCell(_ model: GroupedBrandsSlideModel) {
        brandsTitle.text = model.groupedSlide[0].name
        self.countsHolderView.isHidden = model.groupedSlide.isEmpty ? true : false
        self.countsLbl.text = "\(model.groupedSlide.count)"
        
//        if let image = UIImage(data: model.slideData) {
//                    // The downloaded data represents an image
//                    print("Downloaded data is an image.")
//
//                    DispatchQueue.main.async {
//                        self.sampleImage.image = image
//                    }
//
//                } else {
//                    // The downloaded data is not an image
//
//                    print("Downloaded data is of Unknown type")
//
//
//                }
        
    }
    
}
