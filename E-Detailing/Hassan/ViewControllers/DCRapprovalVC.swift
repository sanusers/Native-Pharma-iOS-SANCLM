//
//  DCRapprovalVC.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import Foundation
import UIKit
class DCRapprovalVC: BaseViewController {

    

    
    @IBOutlet var dcrApprovalView: DCRapprovalView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> DCRapprovalVC {
        let reportsVC : DCRapprovalVC = UIStoryboard.Hassan.instantiateViewController()
        return reportsVC
    }

}
