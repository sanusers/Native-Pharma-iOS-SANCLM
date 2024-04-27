//
//  swift
//  E-Detailing
//
//  Created by San eforce on 20/03/24.
//

import Foundation
import UIKit
import CoreData
class AddCallinfoVC: BaseViewController {
    @IBOutlet var addCallinfoView: AddCallinfoView!
    let appsetup = AppDefaults.shared.getAppSetUp()
    var dcrCall : CallViewModel!
    var userStatisticsVM: UserStatisticsVM?
 
    var  latitude: Double?
    var longitude: Double?
    var address: String?
    
    class func initWithStory(viewmodel: UserStatisticsVM) -> AddCallinfoVC {
        let reportsVC : AddCallinfoVC = UIStoryboard.Hassan.instantiateViewController()
        reportsVC.userStatisticsVM = viewmodel
       // reportsVC.pageType = pageType
        return reportsVC
    }
    
    
    func setupParam(dcrCall: CallViewModel) {
        
        
        let persistentContainer = appdelegate.persistentContainer
        let managedObjectContext = persistentContainer.viewContext
        var savedPath : String = ""
        if let persistentStore = managedObjectContext.persistentStoreCoordinator?.persistentStores.first {
            if let storeURL = persistentStore.url {
                print("Core Data SQLite file path: \(storeURL)")
                savedPath = "\(storeURL)"
            }
        }
        var cusType : String = ""

        switch self.dcrCall.type {
            case .doctor:
                cusType = "1"
            case .chemist:
                cusType = "2"
            case .stockist:
                cusType = "3"
            case .hospital:
                cusType = "6"
            case .cip:
                cusType = "5"
            case .unlistedDoctor:
                cusType = "4"
        }
        
      //  var productData = [[String : Any]]()
      //  var inputData = [[String : Any]]()
       // var jointWorkData = [[String : Any]]()
       // var additionalCallData = [[String : Any]]()
       // var rcpaData = [[String : Any]]()
        
        
        let productValue = self.addCallinfoView.productSelectedListViewModel.productData()
        let inputValue = self.addCallinfoView.inputSelectedListViewModel.inputData()
        let jointWorkValue = self.addCallinfoView.jointWorkSelectedListViewModel.getJointWorkData()
        let additionalCallValue = self.addCallinfoView.additionalCallListViewModel.getAdditionalCallData()
        
        let rcpaValue =  self.addCallinfoView.rcpaDetailsModel
        let evenetCaptureValue = self.addCallinfoView.eventCaptureListViewModel
        
       
        
        var addedDCRCallsParam: [String: Any] = [:]
        
        //Joint works
        var addedJointworks = [[String: Any]]()
        addedJointworks.removeAll()

        for jointWork in jointWorkValue{
            
            var aJointwork = [String: Any]()
            aJointwork["Code"] = jointWork.code
            aJointwork["Name"] = jointWork.name
            
            addedJointworks.append(aJointwork)
        }
        
        addedDCRCallsParam["JointWork"] = addedJointworks
        
        
        //Inputs
        var addedInput = [[String: Any]]()
        for input in inputValue{
            var aInput = [String: Any]()
            aInput["Code"] = input.code
            aInput["Name"] = input.name
            aInput["IQty"] = input.inputCount
            addedInput.append(aInput)
        }
        
        
        
        
        addedDCRCallsParam["Inputs"] = addedInput
        //Products Detailed
        // Assuming you have detailedSlides array
        var detailedSlides = Shared.instance.detailedSlides

        // Create a dictionary to group slides by brandCode
        var groupedSlides: [Int: [SlidesModel]] = [:]

        // Group slides by brandCode
        for slide in detailedSlides {
            if let brandCode = slide.brandCode {
                if groupedSlides[brandCode] == nil {
                    groupedSlides[brandCode] = []
                }
                if let slides = slide.groupedSlides {
                    groupedSlides[brandCode]?.append(contentsOf: slides)
                }
            }
        }

        // Iterate through the detailedSlides array and update each DetailedSlide object
        for (index, detailedSlide) in detailedSlides.enumerated() {
            if let groupedSlidesForBrand = groupedSlides[detailedSlide.brandCode ?? Int()] {
                detailedSlides[index].groupedSlides = groupedSlidesForBrand
            }
        }

        // Create a dictionary to group DetailedSlides by brandCode
        var groupedDetailedSlides: [Int: [DetailedSlide]] = [:]

        // Group DetailedSlides by brandCode
        for slide in detailedSlides {
            if let brandCode = slide.brandCode {
                if groupedDetailedSlides[brandCode] == nil {
                    groupedDetailedSlides[brandCode] = []
                }
                groupedDetailedSlides[brandCode]?.append(slide)
            }
        }

        // Convert the groupedSlides dictionary into an array of arrays
        let mappedArray = groupedDetailedSlides.values.map { $0 }

        
        
        
        var addedDetailedProducts = [[String: Any]]()
        addedDetailedProducts.removeAll()
        
        dump(mappedArray)
//        mappedArray.forEach { DetailedSlide in
//
//        }
        
        mappedArray.forEach { detailedSlideArr in
            var groupSlides: [SlidesModel] = []
            detailedSlideArr.forEach { aDetailedSlide in
                if let aSlideModel = aDetailedSlide.slidesModel {
                    groupSlides.append(aSlideModel)
                }
            }
            let optionalDetailedSlide = detailedSlideArr.first
            if let aDetailedSlide = optionalDetailedSlide  {
                var aproduct : [String : Any] = [:]
                // groupedSlides.forEach
                aproduct["Code"] = aDetailedSlide.brandCode
                aproduct["Group"] = "1"
                aproduct["ProdFeedbk"] = ""
                aproduct["Rating"] = ""
                aproduct["Appver"] = "Test.S.1.0"
                aproduct["Mod"] = "iOS-Edet"
                aproduct["Type"] = cusType
                var timesLine = [String: Any]()
                timesLine["sTm"] = aDetailedSlide.startTime ?? ""
                timesLine["eTm"] = detailedSlideArr.last?.endTime ?? ""
                aproduct["Timesline"] = timesLine
                
                aproduct["Slides"] = [[String: Any]]()
                var aslideParamArr = [[String: Any]]()
                groupSlides.enumerated().forEach {index, aSlide in
                    
                    aproduct["Name"] = aSlide.name
                    var aSlideParam: [String :Any] = [:]
                    aSlideParam["Slide"] = aSlide.name
                    aSlideParam["SlidePath"] = savedPath
                    aSlideParam["Scribbles"] = ""
                    aSlideParam["SlideRemarks"] = aDetailedSlide.remarks
                    aSlideParam["SlideType"] =  aSlide.fileType
                    aSlideParam["SlideRating"] = aDetailedSlide.remarksValue
                    aSlideParam["Times"] = [[String: Any]]()
                    var previewTimeArr:  [[String : Any]] = [[:]]
                    previewTimeArr.removeAll()
                    var previewTime : [String: Any] = [:]
                    previewTime.removeAll()
                    previewTime["sTm"] = detailedSlideArr[index].startTime
                    previewTime["eTm"] = detailedSlideArr[index].endTime
                    previewTimeArr.append(previewTime)
                    aSlideParam["Times"] = previewTimeArr
                    aslideParamArr.append(aSlideParam)
                  
                }
                aproduct["Slides"] = aslideParamArr
                addedDetailedProducts.append(aproduct)
            }
        }
        dump(addedDetailedProducts)
        
        
        //Products not Detailed
        var addedProducts = [[String: Any]]()
        addedProducts.removeAll()
      //  let slides : [String : Any] = ["Slide" : "", "SlidePath" : "", "SlideRemarks" : "", "SlideType" : "", "SlideRating" : "", "Times" : "times"]
        
        
        for product in productValue {
            var aproduct : [String : Any] = [:]
            aproduct["Code"] = product.code
            aproduct["Name"] =  product.name
            aproduct["Group"] = "0"
            aproduct["ProdFeedbk"] = ""
            aproduct["Rating"] = ""
            var timesLine = [String: Any]()
            timesLine["sTm"] = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
            timesLine["eTm"] = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
            aproduct["Timesline"] = timesLine
            aproduct["Appver"] = "Test.S.1.0"
            aproduct["Mod"] = "iOS-Edet"
            aproduct["SmpQty"] = product.sampleCount
            aproduct["RcpaQty"] = product.rcpaCount
            aproduct["RxQty"] = product.rxCount
            aproduct["Promoted"] = product.isDetailed ? "0" : "1"
            aproduct["Type"] = cusType
            aproduct["StockistName"] = product.stockistName
            aproduct["StockistCode"] = product.stockistCode
            aproduct["Slides"] = [[String: Any]]()
            addedProducts.append(aproduct)
        }
        
        addedDCRCallsParam["Products"] = addedProducts + addedDetailedProducts
        
        //Additional Customers
        var additionalCustomerParams = [[String: Any]]()
        additionalCustomerParams.removeAll()
        additionalCallValue.enumerated().forEach { index, call in
            var aAdditioanlcall : [String : Any] = [:]
            aAdditioanlcall["Code"] = call.docCode
            aAdditioanlcall["Name"] = call.docName
            aAdditioanlcall["town_code"] = call.docTownCode
            aAdditioanlcall["town_name"] = call.docTownName
          
            //Additional call products
            if let productValue = call.productSelectedListViewModel.fetchAllProductData() {
                var products: [[String: Any]] = [[:]]
                products.removeAll()
                for product in productValue {
                    var aproduct : [String : Any] = [:]
                    aproduct["Code"] = product.product?.code
                    aproduct["Name"] =  product.product?.name
                    aproduct["SmpQty"] = product.sampleCount
                    products.append(aproduct)
                }
                aAdditioanlcall["Products"] = products
            }

            
            //Additional call Inputs
            if  let inputValue = call.inputSelectedListViewModel.fetchAllInputData() {
                var addedInput = [[String: Any]]()
                for input in inputValue{
                    var aInput = [String: Any]()
                    aInput["Code"] = input.input?.code
                    aInput["Name"] = input.input?.name
                    aInput["InpQty"] = input.inputCount
                    addedInput.append(aInput)
                }
                aAdditioanlcall["Inputs"] = addedInput
            }

            additionalCustomerParams.append(aAdditioanlcall)
        }
        
        addedDCRCallsParam["AdCuss"] = additionalCustomerParams
        
        //RCPA Entry
       
        var entryRCPAparam : [[String: Any]] = [[:]]
        entryRCPAparam.removeAll()
        
        
        for rcpa in rcpaValue {
            var aRCPAdetail: [String: Any] = [:]
            aRCPAdetail["Trans_SlNo"] = ""
            aRCPAdetail["ADetSLNo"] = ""
            aRCPAdetail["CustCode"] = rcpa.addedChemist?.code
            aRCPAdetail["CustName"] = rcpa.addedChemist?.name
            aRCPAdetail["vstTime"] = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
            aRCPAdetail["CustType"] = cusType
            aRCPAdetail["Synced"] = "1"
            entryRCPAparam.append(aRCPAdetail)
            
            
 //           let rcpaChemist = ["Name" : rcpa.addedChemist?.name , "Code" : rcpa.addedChemist?.code]

//            rcpa.addedProductDetails?.addedProduct?.forEach{ aAddedProduct in
//              
//                var competitorData = [[String : Any]]()
//                var productCode : String =    aAddedProduct.addedProduct?.code ?? ""
//                var productName : String =  aAddedProduct.addedProduct?.name ?? ""
//                let rcpa : [String : Any] = [ "Chemists" : [rcpaChemist],
//                             "OPCode" : productCode, //rcpa.rcpaChemist.products[i].product.code ?? "",
//                             "OPName" : productName, // rcpa.rcpaChemist.products[i].product.name ?? "",
//                             "OPQty" : sumOfQuantities(corelatedStringArr: rcpa.addedProductDetails?.addedQuantity) ,
//                             "OPRate" : sumOfQuantities(corelatedStringArr: rcpa.addedProductDetails?.addedRate),
//                             "OPValue" : sumOfQuantities(corelatedStringArr: rcpa.addedProductDetails?.addedValue),
//                             "Competitors" : competitorData
//                ]
//
//                rcpaData.append(rcpa)
//
//            }

        }
        addedDCRCallsParam["RCPAEntry"] = entryRCPAparam
        
       
        
        
//Joint works

        var addedJointWorks  : [[String: Any]] = [[:]]
     
       
        let selectedJWs =  self.addCallinfoView.jointWorkSelectedListViewModel.getJointWorkData()
        for aJointWork in selectedJWs {
            var ajointWorkParam: [String: Any] = [:]
            ajointWorkParam["Code"] = aJointWork.code
            ajointWorkParam["Name"] = aJointWork.name
            addedJointWorks.append(ajointWorkParam)
        }
        addedDCRCallsParam["JWWrk"] = addedJointWorks
        
        
//        "EventCapture":[
//        {
//        "EventCapture":"True",
//        "EventImageName":"MR5940_1679482_27042024161708.jpeg",
//        "EventImageTitle":"",
//        "EventImageDescription":"",
//        "Eventfilepath":""
//        },
//        {
//        "EventCapture":"True",
//        "EventImageName":"MR5940_1679482_27042024161656.jpeg",
//        "EventImageTitle":"",
//        "EventImageDescription":"",
//        "Eventfilepath":""
//        }
//        ],
        
        
        addedDCRCallsParam["EventCapture"] = [[String: Any]]()
        var addedDCRCallsParamArr : [[String: Any]] = [[:]]
        addedDCRCallsParamArr.removeAll()
        let aEventDatum = evenetCaptureValue.EventCaptureData()
        aEventDatum.forEach { eventCaptureViewModel in
            var aCapturedEvent : [String: Any] = [:]
            aCapturedEvent["EventCapture"] = "True"
            aCapturedEvent["EventImageName"] = eventCaptureViewModel.image.description
            aCapturedEvent["EventImageTitle"] = eventCaptureViewModel.title
            aCapturedEvent["EventImageDescription"] = eventCaptureViewModel.description
            aCapturedEvent["Eventfilepath"] = savedPath
            addedDCRCallsParamArr.append(aCapturedEvent)
        }
        addedDCRCallsParam["EventCapture"]  = addedDCRCallsParamArr
        
        let divisionCode = appsetup.divisionCode!.replacingOccurrences(of: ",", with: "")
        let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
        
        addedDCRCallsParam["tableName"] = "postDCRdata"
        addedDCRCallsParam["CateCode"] = dcrCall.cateCode
        addedDCRCallsParam["CusType"] = cusType
        addedDCRCallsParam["CustCode"] = dcrCall.code
        addedDCRCallsParam["CustName"] = dcrCall.name
     
        addedDCRCallsParam["sfcode"] = appsetup.sfCode ?? ""
        addedDCRCallsParam["Rsf"] =  LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)
        //appsetup.sfCode ?? ""
        addedDCRCallsParam["sf_type"] = "\(appsetup.sfType ?? 0)"
        addedDCRCallsParam["Designation"] = appsetup.dsName ?? ""
        addedDCRCallsParam["state_code"] = appsetup.stateCode ?? ""
        addedDCRCallsParam["subdivision_code"] = appsetup.subDivisionCode ?? ""
        addedDCRCallsParam["division_code"] = divisionCode
        addedDCRCallsParam["AppUserSF"] = appsetup.sfCode ?? ""
        addedDCRCallsParam["SFName"] = appsetup.sfName ?? ""
        addedDCRCallsParam["SpecCode"] = dcrCall.specialityCode
        addedDCRCallsParam["mappedProds"] = ""
        addedDCRCallsParam["mode"]  = "0"
        addedDCRCallsParam["Appver"] = "iEdet.1.1"
        addedDCRCallsParam["Mod"] = "ios-Edet-New"
        addedDCRCallsParam["WT_code"] = "2748"
        addedDCRCallsParam["WTName"] = "Field Work"
        addedDCRCallsParam["FWFlg"] = "F"
        addedDCRCallsParam["town_code"] = dcrCall.townCode
        addedDCRCallsParam["town_name"] = dcrCall.townName
        addedDCRCallsParam["ModTime"] = date
        addedDCRCallsParam["ReqDt"] = date
        addedDCRCallsParam["vstTime"] = date
        addedDCRCallsParam["Remarks"] =  self.addCallinfoView.overallRemarks ?? ""
        //self.txtRemarks.textColor == .lightGray ? "" : self.txtRemarks.text ?? ""
        addedDCRCallsParam["amc"] = ""
        addedDCRCallsParam["hospital_code"] = ""
        addedDCRCallsParam["hospital_name"] = ""
        addedDCRCallsParam["sample_validation"]  = "0"
        addedDCRCallsParam["input_validation"]  = "0"
        addedDCRCallsParam["sign_path"] = ""
        addedDCRCallsParam["SignImageName"] = ""
        addedDCRCallsParam["DCSUPOB"] =  self.addCallinfoView.pobValue
       // addedDCRCallsParam["checkout"] = dcrCall.dcrCheckinTime
       // addedDCRCallsParam["checkin"] = date
        //self.txtPob.text ?? ""
        if let overallFeedback = self.addCallinfoView.overallFeedback {
            addedDCRCallsParam["Drcallfeedbackcode"] = overallFeedback.id ?? ""
            addedDCRCallsParam["Drcallfeedbackname"] = overallFeedback.name ?? ""
        }
        addedDCRCallsParam["sample_validation"] = "0"
        addedDCRCallsParam["input_validation"] = "0"
       

      //  Pipelines.shared.getAddressString(latitude: <#T##Double#>, longitude: <#T##Double#>, completion: <#T##(String?) -> Void#>)
       // let param = ["data" : params.toString()]

        Pipelines.shared.requestAuth() {[weak self] coordinates in
            guard let welf = self else {return}
            guard coordinates != nil else {
                welf.showAlert()
                return
            }
            
            welf.latitude = coordinates?.latitude
            welf.longitude = coordinates?.longitude
            
            addedDCRCallsParam["Entry_location"] = "\(welf.latitude ?? Double()):\(welf.longitude ?? Double())"
   
            
            Shared.instance.showLoaderInWindow()
            if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
                Pipelines.shared.getAddressString(latitude:   welf.latitude ?? Double(), longitude:   welf.longitude ?? Double()) {[weak self] address in
                    guard let welf = self else {return}
                    guard let fetchedAddress = address else {
                        
                        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: addedDCRCallsParam)
                        var toSendData = [String : Any]()
                        toSendData["data"] = jsonDatum
                        welf.postDCRData(toSendData: toSendData, addedDCRCallsParam: addedDCRCallsParam, cusType: cusType)
                        
                        return}
                
                    welf.address = fetchedAddress
                    addedDCRCallsParam["address"] =  fetchedAddress
                    let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: addedDCRCallsParam)
                    var toSendData = [String : Any]()
                    toSendData["data"] = jsonDatum
                    welf.postDCRData(toSendData: toSendData, addedDCRCallsParam: addedDCRCallsParam, cusType: cusType)
                }
            } else {
                welf.address = ""
                addedDCRCallsParam["address"] =  ""
                let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: addedDCRCallsParam)
                var toSendData = [String : Any]()
                toSendData["data"] = jsonDatum
                welf.postDCRData(toSendData: toSendData, addedDCRCallsParam: addedDCRCallsParam, cusType: cusType)
            }

            
        }

     
    }
    
    func postDCRData(toSendData: JSON, addedDCRCallsParam: JSON, cusType: String) {
        callDCRScaeapi(toSendData: toSendData, params: addedDCRCallsParam, cusType: cusType) {[weak self] isPosted in
            guard let welf = self else {return}
            Shared.instance.removeLoaderInWindow()
            Shared.instance.detailedSlides = []
            if !isPosted {
                welf.saveCallsToDB(issussess: isPosted, appsetup: welf.appsetup, cusType: cusType, param: addedDCRCallsParam)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("callsAdded"), object: nil)
            }

            welf.popToBack(MainVC.initWithStory(isfromLaunch: false, ViewModel: UserStatisticsVM()))
        }
    }
    
    func showAlertToEnableLocation() {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "E - Detailing", alertDescription: "Please enable location services in Settings.", okAction: "Cancel",cancelAction: "Ok")
        commonAlert.addAdditionalOkAction(isForSingleOption: false) {
            print("no action")
            // self.toDeletePresentation()
            
        }
        commonAlert.addAdditionalCancelAction {
            print("yes action")
            self.redirectToSettings()
            
        }
    }
    
    func redirectToSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    
    func showAlert() {
        showAlertToEnableLocation()
    }
    
    
        private func popToBack<T>(_ VC : T) {
            let mainVC = navigationController?.viewControllers.first{$0 is T}
    
            if let vc = mainVC {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    
    func callDCRScaeapi(toSendData: JSON, params: JSON, cusType: String, completion: @escaping (Bool) -> () ) {
        if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
           // Shared.instance.showLoaderInWindow()
            postDCTdata(toSendData, paramData: params) { result in
                switch result {
                case .success(let model):
                   
                      
                        completion(model.isSuccess ?? false )
                
             
                case .failure(let error):
                  
                    self.toCreateToast("\(error)")
                    print(error)
                    completion(false)
            
                }
              
            }
        } else {
           completion(false)
        }
        
        func postDCTdata(_ param: [String: Any], paramData: JSON, _ completion : @escaping (Result<DCRCallesponseModel, UserStatisticsError>) -> Void)  {
           
            userStatisticsVM?.saveDCRdata(params: param, api: .saveDCR, paramData: paramData) { result in
                completion(result)
            }
        }
    }
    
    func saveCallsToDB(issussess: Bool, appsetup: AppSetUp, cusType : String, param: [String: Any]) {
                var dbparam = [String: Any]()
                dbparam["CustCode"] = dcrCall.code
                dbparam["CustType"] = cusType
                dbparam["FW_Indicator"] = "F"
                dbparam["Dcr_dt"] = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
                dbparam["month_name"] = Date().toString(format: "MMMM")
                dbparam["Mnth"] = Date().toString(format: "MM")
                dbparam["Yr"] =  Date().toString(format: "YYYY")
                dbparam["CustName"] = dcrCall.name
                dbparam["town_code"] = dcrCall.townCode
                dbparam["town_name"] = dcrCall.territory
                dbparam["Dcr_flag"] = ""
                dbparam["SF_Code"] = appsetup.sfCode
                dbparam["Trans_SlNo"] = ""
                dbparam["AMSLNo"] = ""
                dbparam["isDataSentToAPI"] = issussess == true ?  "1" : "0"
                dbparam["successMessage"] = issussess ? "call Aldready Exists" : "Waiting to sync"
                 dbparam["checkinTime"] = dcrCall.dcrCheckinTime
                 dbparam["checkOutTime"] = dcrCall.dcrCheckOutTime
                var dbparamArr = [[String: Any]]()
                dbparamArr.append(dbparam)
                let masterData = DBManager.shared.getMasterData()
                var HomeDataSetupArray = [UnsyncedHomeData]()
                for (index,homeData) in dbparamArr.enumerated() {
        
             
                        let contextNew = DBManager.shared.managedContext()
                        let HomeDataEntity = NSEntityDescription.entity(forEntityName: "UnsyncedHomeData", in: contextNew)
                        let HomeDataSetupItem = UnsyncedHomeData(entity: HomeDataEntity!, insertInto: contextNew)
                    
                     if  self.dcrCall.type == .chemist {
                         HomeDataSetupItem.custType = "2"
                       }
                       if  self.dcrCall.type == .stockist {
                           HomeDataSetupItem.custType = "3"
                         }
                       if  self.dcrCall.type == .doctor {
                           HomeDataSetupItem.custType = "1"
                         }
                       if  self.dcrCall.type == .hospital {
                           HomeDataSetupItem.custType = "6"
                         }
                       if  self.dcrCall.type == .unlistedDoctor {
                           HomeDataSetupItem.custType = "4"
                         }
                       if  self.dcrCall.type == .cip
                       {
                           HomeDataSetupItem.custType = "5"
                         }
                        HomeDataSetupItem.setValues(fromDictionary: homeData)
                        HomeDataSetupItem.index = Int16(index)
                        HomeDataSetupArray.append(HomeDataSetupItem)
              
                }
        
                HomeDataSetupArray.forEach{ (type) in
                    masterData.addToUnsyncedHomeData(type)
                }
                DBManager.shared.saveContext()
        
        if !issussess {
            saveParamoutboxParamtoDefaults(param: param)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("callsAdded"), object: nil)
    

    }
    
    func saveParamoutboxParamtoDefaults(param: JSON) {
        
        var callsByDay: [String: [[String: Any]]] = [:]
        
        let paramdate = param["vstTime"]
        var dayString = String()
        
        // Create a DateFormatter to parse the vstTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: paramdate as! String) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
             dayString = dateFormatter.string(from: date)
            
            // Check if the day key exists in the dictionary
            if callsByDay[dayString] == nil {
                callsByDay[dayString] = [param]
            } else {
                callsByDay[dayString]?.append(param)
            }
        }
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: callsByDay)
        
        
        let paramData = LocalStorage.shared.getData(key: LocalStorage.LocalValue.outboxParams)
        if paramData.isEmpty {
            LocalStorage.shared.setData(LocalStorage.LocalValue.outboxParams, data: jsonDatum)
            return
        }
        var localParamArr = [String: [[String: Any]]]()
 
        do {
            localParamArr  = try JSONSerialization.jsonObject(with: paramData, options: []) as? [String: [[String: Any]]] ?? [String: [[String: Any]]]()
            dump(localParamArr)
        } catch {
            self.toCreateToast("unable to retrive")
        }
        
        
        var matchFound = Bool()
        for (_, calls) in localParamArr {
            for call in calls {
                // if let vstTime = call["vstTime"] as? String,
                if  let custCode = call["CustCode"] as? String,
                    //   vstTime == param["vstTime"] as? String,
                    custCode == param["CustCode"] as? String {
                    // Match found, do something with the matching call
                    matchFound = true
                    print("Match found for CustCode: \(custCode)")
                    // vstTime: \(vstTime),
                    
                }
            }
        }
        
        if !matchFound {
            // Check if the day key exists in the dictionary
            if localParamArr[dayString] == nil {
                localParamArr[dayString] = [param]
            } else {
                localParamArr[dayString]?.append(param)
            }
            let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: localParamArr)
            
            LocalStorage.shared.setData(LocalStorage.LocalValue.outboxParams, data: jsonDatum)
        }
    }
    
    func sumOfQuantities(corelatedStringArr: [String]?) -> Int {
        guard let quantities = corelatedStringArr else {
            return 0 // Return 0 if the array is nil or empty
        }
        
        var sum = 0
        for quantityString in quantities {
            if let quantity = Int(quantityString) {
                sum += quantity
            } else {
                // Handle invalid string that cannot be converted to integer
                print("Invalid quantity string: \(quantityString)")
            }
        }
        return sum
    }
    

    
}


