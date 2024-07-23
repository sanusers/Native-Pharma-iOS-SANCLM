//
//  DCRapprovalinfoVC.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import Foundation
import UIKit
class DCRapprovalinfoVC: BaseViewController {

    

    
    @IBOutlet var dcrApprovalinfoView: DCRapprovalinfoView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> DCRapprovalinfoVC {
        let reportsVC : DCRapprovalinfoVC = UIStoryboard.Hassan.instantiateViewController()
        return reportsVC
    }


}
