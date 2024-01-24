//
//  CreatePresentationVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import UIKit
class CreatePresentationVC: BaseViewController {
    
    @IBOutlet var createPresentationView: CreatePresentationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func initWithStory() -> CreatePresentationVC {
        let reportsVC : CreatePresentationVC = UIStoryboard.Hassan.instantiateViewController()

        return reportsVC
    }
}
