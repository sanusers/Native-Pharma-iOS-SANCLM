//
//  ViewDayReportVC.swift
//  E-Detailing
//
//  Created by San eforce on 22/12/23.
//

import Foundation
import UIKit
class ViewDayReportVC: BaseViewController {
    var sessionResponseVM : SessionResponseVM?
    
    @IBOutlet weak var dayReportView: DayReportView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func initWithStory() -> ViewDayReportVC {
        let tourPlanVC : ViewDayReportVC = UIStoryboard.Hassan.instantiateViewController()
      //  tourPlanVC.homeVM = HomeViewModal()
        tourPlanVC.sessionResponseVM = SessionResponseVM()
        return tourPlanVC
    }
    
}
