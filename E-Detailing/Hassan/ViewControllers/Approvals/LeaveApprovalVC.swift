//
//  LeaveApprovalVC.swift
//  SAN ZEN
//
//  Created by San eforce on 24/07/24.
//

import Foundation
import UIKit
class LeaveApprovalVC: BaseViewController {
    
    
    
    
    @IBOutlet var leaveApprovalView: LeaveApprovalView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    class func initWithStory() -> LeaveApprovalVC {
        let reportsVC : LeaveApprovalVC = UIStoryboard.Hassan.instantiateViewController()
        return reportsVC
    }
}
