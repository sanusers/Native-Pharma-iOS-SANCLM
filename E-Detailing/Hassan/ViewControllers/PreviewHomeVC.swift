//
//  PreviewHomeVC.swift
//  E-Detailing
//
//  Created by San eforce on 07/02/24.
//

import Foundation
import UIKit
class PreviewHomeVC: BaseViewController {
    @IBOutlet var previewHomeView: PreviewHomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    class func initWithStory() -> PreviewHomeVC {
        let reportsVC : PreviewHomeVC = UIStoryboard.Hassan.instantiateViewController()

        return reportsVC
    }
}
