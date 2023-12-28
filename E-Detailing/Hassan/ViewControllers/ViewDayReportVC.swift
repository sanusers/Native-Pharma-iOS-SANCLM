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
    var reportsModel : ReportsModel?
    var isToReduceLocationHeight : Bool = false
    var appdefaultSetup : AppSetUp? = nil
    @IBOutlet weak var dayReportView: DayReportView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func initWithStory(model: ReportsModel) -> ViewDayReportVC {
        let tourPlanVC : ViewDayReportVC = UIStoryboard.Hassan.instantiateViewController()
      //  tourPlanVC.homeVM = HomeViewModal()
        tourPlanVC.reportsModel = model
        tourPlanVC.sessionResponseVM = SessionResponseVM()
        return tourPlanVC
    }
    
    func toSetParamsAndGetResponse(_ type: Int) {
       // let appdefaultSetup = AppDefaults.shared.getAppSetUp()
       // let dateFormatter = DateFormatter()

   //     {"tableName":"getvwvstdet","ACd":"SE74-2280","typ":"1","sfcode":"MR0026","division_code":"8,","Rsf":"MR0026","sf_type":"1","Designation":"TBM","state_code":"28","subdivision_code":"62,"}
        
        if type == 0 {
            self.dayReportView.initialSerups()
        }
        
        var param = [String: Any]()
        param["tableName"] = "getvwvstdet"
        param["ACd"] = "SE74-2280"
        param["sfcode"] = "MR2697"
        //appdefaultSetup.sfCode
        if type != 0 {
            param["typ"] = type
        }
       
        param["sf_type"] = "1"
        //appdefaultSetup.sfType
       // param["SFName"] =
        //appdefaultSetup.sfName
        param["division_code"] = "8"
        //appdefaultSetup.divisionCode
        param["Rsf"] = "MR0026"
        //appdefaultSetup.sfCode
        param["Designation"] = "TBM"
        //appdefaultSetup.dsName
        param["state_code"] = "28"
        //appdefaultSetup.stateCode
        param["subdivision_code"] = "62"
        //appdefaultSetup.subDivisionCode
       // param["rptDt"] = "2023-12-8"
        //"2023-12-8"

        
        
        dump(param)
        
        
        
        
        var jsonDatum = Data()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: [])
            jsonDatum = jsonData
            // Convert JSON data to a string
            if let tempjsonString = String(data: jsonData, encoding: .utf8) {
                print(tempjsonString)
                
            }
            
            
        } catch {
            print("Error converting parameter to JSON: \(error)")
        }
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        getReporsAPIResponse(toSendData, paramData: param)
    }
    

    func getReporsAPIResponse(_ param: [String: Any], paramData: JSON){
       
        sessionResponseVM?.getDetailedReportsData(params: param, api: .getReports, paramData: paramData) { result in
            switch result {
            case .success(let response):
                dump(response)
                self.dayReportView.detailedReportsModelArr = response
                self.dayReportView.initialSerups()
               // self.reportsView.setupUI()
                dump(response)
                
            case .failure(let error):
                print(error.localizedDescription)
                self.dayReportView.toCreateToast("Error while fetching response from server.")
                
            }
        }
    }
    
}
