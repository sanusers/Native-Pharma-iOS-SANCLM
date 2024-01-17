//
//  ReportsVC.swift
//  E-Detailing
//
//  Created by San eforce on 20/12/23.
//

import UIKit

class ReportsVC: BaseViewController {

    
    enum PageType {
        case reports
        case approvals
    }
    
    @IBOutlet var reportsView: ReportsView!
    var pageType: PageType = .reports
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory(pageType: PageType) -> ReportsVC {
        let reportsVC : ReportsVC = UIStoryboard.Hassan.instantiateViewController()
      //  tourPlanVC.homeVM = HomeViewModal()
        reportsVC.pageType = pageType
        return reportsVC
    }

}
