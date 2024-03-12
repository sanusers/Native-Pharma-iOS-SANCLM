//
//  MasterSyncCell.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 03/06/23.
//

import UIKit


class MasterSyncCell : UICollectionViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet var loaderImage: UIImageView!
    
    
    @IBOutlet weak var btnSync: UIButton!
    
    @IBOutlet var loaderView: UIView!
    
    
    
    
    var isRotationEnabled = true
    
    
    func loadGIF() {
        // Replace "your_gif_name" with the name of your GIF file (without extension)
        Shared.instance.showLoader(in: loaderView, loaderType: .mastersync)
    }
    
    func rotateImage() {
        guard isRotationEnabled else {
     
            return
        }

        // Reset the transform to the identity transform
   
    
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
            // Rotate by 30 degrees
            self.loaderImage.transform = self.loaderImage.transform.rotated(by: .pi / 6.0)
        }, completion: { _ in
            // Recursive call for infinite rotation
            self.rotateImage()
        })
    }

    // Call this function to stop the rotation
    func stopRotation() {
        
        loaderImage.transform = .identity
        loaderImage.image = nil
        isRotationEnabled = false
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loaderImage.image = nil
        lblName.setFont(font: .bold(size: .BODY))
        lblName.textColor = .appTextColor
        
        lblCount.setFont(font: .bold(size: .BODY))
        lblCount.textColor = .appLightTextColor
        btnSync.backgroundColor = .appTextColor
    }
    
}
