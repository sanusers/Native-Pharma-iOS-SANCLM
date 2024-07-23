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
    
    
    func fetchApprovalList(vm: UserStatisticsVM, completion: @escaping([ApprovalsListModel]?) -> ()) {
        let appsetup = AppDefaults.shared.getAppSetUp()
        //{"AppName":"SAN ZEN","Appver":"Test.H.8","Mod":"Android-Edet","sf_emp_id":"4474","sfname":"VENKATA KALYAN R","Device_version":"10","Device_name":"HUAWEI - KOB2-L09","language":"en","sf_type":"2","Designation":"MGR","state_code":"2","subdivision_code":"103,","key":"alpt1612","Configurl":"http:\/\/edetailing.sanffa.info\/","tableName":"getvwdcr","sfcode":"MGR3083","division_code":"70,","Rsf":"MR7723"}
        var param: [String: Any] = [:]
        param["tableName"] = "getvwdcr"
        param["sfname"] = appsetup.sfName
        param["sf_emp_id"] = appsetup.sfEmpId
        param["sfcode"] = appsetup.sfCode
        param["division_code"] = appsetup.divisionCode
        param["Rsf"] = LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)
        param["sf_type"] = appsetup.sfType
        param["Designation"] = appsetup.desig
        param["state_code"] = appsetup.stateCode
        param["subdivision_code"] = appsetup.subDivisionCode
        param["Tp_need"] = appsetup.tpNeed
        param["geotag_need"] = appsetup.geoTagNeed
        param["TPdev_need"] = appsetup.tpNeed
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)
        var toSendData = [String : Any]()
         toSendData["data"] = jsonDatum
        
        vm.getArrovalList(params: toSendData, api: .approvals, paramData: param) { result in
            
            switch result {
                
            case .success(let response):
                dump(response)
                completion(response)
            case .failure(let error):
                dump(error)
                completion(nil)
            }
            
        }
    }

}
