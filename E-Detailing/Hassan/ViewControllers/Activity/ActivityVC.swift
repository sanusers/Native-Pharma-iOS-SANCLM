//
//  ActivityVC.swift
//  SAN ZEN
//
//  Created by San eforce on 05/08/24.
//

import Foundation
import UIKit

class ActivityVC: BaseViewController {
    
    
    @IBOutlet var activityView: ActivityView!
  //  var reportsVM : ReportsVM?
  //  var appdefaultSetup : AppSetUp? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    class func initWithStory() -> ActivityVC {
        let tourPlanVC : ActivityVC = UIStoryboard.Hassan.instantiateViewController()
      //  tourPlanVC.reportsVM = ReportsVM()
        
        return tourPlanVC
    }
}
