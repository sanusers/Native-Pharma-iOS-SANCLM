//
//  TourPlanVC.swift
//  E-Detailing
//
//  Created by San eforce on 09/11/23.
//

import Foundation
import UIKit
class TourPlanVC: BaseViewController {
    
    var homeVM: HomeViewModal?
   
    @IBOutlet var tourPlanView: TourPlanView!
    
    
    override func viewDidLoad() {
        
       
    }
    
    
    class func initWithStory() -> TourPlanVC {
        let tourPlanVC : TourPlanVC = UIStoryboard.Hassan.instantiateViewController()
        tourPlanVC.homeVM = HomeViewModal()
        return tourPlanVC
    }
    
    
//    func togetTableSetup() {
//        // {"tableName":"gettpsetup","sfcode":"MGR0941","division_code":"63,","Rsf":"MR5990","sf_type":"2","Designation":"MGR","state_code":"13","subdivision_code":"86,"}
//      //  let appsetup = AppDefaults.shared.getAppSetUp()
//        var customSetupParams = [String : Any]()
//        var param = [String: Any]()
//
//        param["tableName"] = "gettpsetup"
//        param["sfcode"] = "MGR0941"
//        param["division_code"] = "63"
//        param["Designation"] = "MGR"
//        param["state_code"] = "13"
//        param["subdivision_code"] = "86,"
//        param["sf_type"] = "2"
//        param["Rsf"] = "MR5990"
//
//        customSetupParams["data"] = param
//        // return ["data" : paramString]
//        homeVM!.togetTourPlanTable(params: customSetupParams, api: .tableSetup) { result in
//            switch result {
//            case .success(let response):
//                print(response)
//                self.tableSetupmodel = response
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//    }
}
    



