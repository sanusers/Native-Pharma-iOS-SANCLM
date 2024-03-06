//
//  DCRdetailViewEditVC.swift
//  E-Detailing
//
//  Created by San eforce on 06/03/24.
//

import Foundation
import UIKit
class DCRdetailViewEditVC: BaseViewController {
 
    @IBOutlet var dcrDetailViewEditView: DCRdetailViewEditView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> DCRdetailViewEditVC {
        let reportsVC : DCRdetailViewEditVC = UIStoryboard.Hassan.instantiateViewController()
  
        return reportsVC
    }
    
}
