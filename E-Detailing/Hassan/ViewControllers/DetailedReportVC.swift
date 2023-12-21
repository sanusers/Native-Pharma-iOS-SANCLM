//
//  DetailedReportVC.swift
//  E-Detailing
//
//  Created by San eforce on 20/12/23.
//

import UIKit

class DetailedReportVC: BaseViewController {

    
    @IBOutlet var reportsView: DetailedReportView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> DetailedReportVC {
        let tourPlanVC : DetailedReportVC = UIStoryboard.Hassan.instantiateViewController()
      //  tourPlanVC.homeVM = HomeViewModal()
        return tourPlanVC
    }

}
