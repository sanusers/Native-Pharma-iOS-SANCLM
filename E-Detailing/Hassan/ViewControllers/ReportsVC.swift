//
//  ReportsVC.swift
//  E-Detailing
//
//  Created by San eforce on 20/12/23.
//

import UIKit

class ReportsVC: BaseViewController {

    
    @IBOutlet var reportsView: ReportsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> ReportsVC {
        let tourPlanVC : ReportsVC = UIStoryboard.Hassan.instantiateViewController()
      //  tourPlanVC.homeVM = HomeViewModal()
        return tourPlanVC
    }

}
