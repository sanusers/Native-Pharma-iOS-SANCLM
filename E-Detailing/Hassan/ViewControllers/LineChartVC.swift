//
//  LineChartVC.swift
//  E-Detailing
//
//  Created by San eforce on 30/12/23.
//

import Foundation
import UIKit
class LineChartVC: BaseViewController {
    
    @IBOutlet weak var lineChartView: LineChartHolderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func initWithStory() -> LineChartVC {
        let tourPlanVC : LineChartVC = UIStoryboard.Hassan.instantiateViewController()
        return tourPlanVC
    }
}
