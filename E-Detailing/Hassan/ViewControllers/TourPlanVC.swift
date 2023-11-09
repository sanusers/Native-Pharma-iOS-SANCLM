//
//  TourPlanVC.swift
//  E-Detailing
//
//  Created by San eforce on 09/11/23.
//

import Foundation
import UIKit
class TourPlanVC: BaseViewController {
    
    
    @IBOutlet var tourPlanView: TourPlanView!
    
    
    override func viewDidLoad() {
       

    }
    
    
    class func initWithStory() -> TourPlanVC {
        let tourPlanVC : TourPlanVC = UIStoryboard.Hassan.instantiateViewController()
        return tourPlanVC
    }
    
}


