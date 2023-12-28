//
//  DetailedReportVC.swift
//  E-Detailing
//
//  Created by San eforce on 20/12/23.
//

import UIKit

class DetailedReportVC: BaseViewController {

    
    @IBOutlet var reportsView: DetailedReportView!
    var sessionResponseVM : SessionResponseVM?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> DetailedReportVC {
        let tourPlanVC : DetailedReportVC = UIStoryboard.Hassan.instantiateViewController()
      //  tourPlanVC.homeVM = HomeViewModal()
        tourPlanVC.sessionResponseVM = SessionResponseVM()
        return tourPlanVC
    }
    

    func toSetParamsAndGetResponse() {
       // let appdefaultSetup = AppDefaults.shared.getAppSetUp()
       // let dateFormatter = DateFormatter()

        var param = [String: Any]()
        param["tableName"] = "getdayrpt"
        param["sfcode"] = "MR2697"
        //appdefaultSetup.sfCode
        param["sf_type"] = "1"
        //appdefaultSetup.sfType
       // param["SFName"] =
        //appdefaultSetup.sfName
        param["divisionCode"] = "64"
        //appdefaultSetup.divisionCode
        param["Rsf"] = "MR2697"
        //appdefaultSetup.sfCode
        param["Designation"] = "MR"
        //appdefaultSetup.dsName
        param["state_code"] = "13"
        //appdefaultSetup.stateCode
        param["subdivision_code"] = "93"
        //appdefaultSetup.subDivisionCode
        param["rptDt"] = "2023-12-8"
        //"2023-12-8"
       // {"tableName":"getdayrpt","sfcode":"MR2697","sf_type":"1","divisionCode":"64,","Rsf":"MR2697","Designation":"MR","state_code":"13","subdivision_code":"93,","rptDt":"2023-12-8"}
        
        
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
       
        sessionResponseVM?.getReportsData(params: param, api: .getReports, paramData: paramData) { result in
            switch result {
            case .success(let response):
                print(response)
                self.reportsView.reportsModel = response
                self.reportsView.setupUI()
                dump(response)
                
            case .failure(let error):
                print(error.localizedDescription)
                self.reportsView.toCreateToast("Error while fetching response from server.")
                
            }
        }
    }
    
}
