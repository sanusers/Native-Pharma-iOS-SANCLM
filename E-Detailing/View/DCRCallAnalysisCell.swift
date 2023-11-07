//
//  DCRCallAnalysisCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 24/07/23.
//

import UIKit
import UICircularProgressRing

class DCRCallAnalysisCell : UICollectionViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    
    @IBOutlet weak var viewDoctor: UIView!
    @IBOutlet weak var viewChart: UICircularProgressRing!
    
    
    @IBOutlet weak var imgArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.viewChart.startAngle = -90.0
        self.viewChart.isClockwise = true
        self.viewChart.font = UIFont(name: "Satoshi-Bold", size: 18)!
        self.viewChart.fontColor = .white
        if #available(iOS 13.0, *) {
            self.viewChart.outerRingColor = UIColor.systemGray4
        } else {
            self.viewChart.outerRingColor = UIColor.lightGray
            // Fallback on earlier versions
        }
        
        self.viewChart.innerRingColor = UIColor.white
        self.viewChart.style = .bordered(width: 0.0, color: .black)
        self.viewChart.outerRingWidth = 5.0
        
        self.viewChart.maxValue = CGFloat(truncating: 10.0)
        
        self.viewChart.startProgress(to: CGFloat(truncating: 8.0), duration: 2)
        
    }
    
    
}


