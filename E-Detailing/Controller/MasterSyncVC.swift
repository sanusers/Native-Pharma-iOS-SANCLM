//
//  MasterSyncVC.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 02/06/23.
//

import Foundation
import UIKit
import Alamofire




class MasterSyncVC : UIViewController {
    
    static let shared = MasterSyncVC()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lblHqName: UILabel!
    @IBOutlet weak var lblSyncStatus: UILabel!
    
    
    var isFromLaunch : Bool = false
    
    var masterData = [MasterInfo]()
    
    var dcrList = [MasterCellData]()
    
    var animations = [Bool](){
        didSet{
            _ = self.animations.filter{$0 == false}
        }
    }
    
    var selectedHeadquarter : Subordinate? {
        didSet{
            guard let selectedHeadquarter = self.selectedHeadquarter else{
                return
            }
            
            AppDefaults.shared.sfCode = selectedHeadquarter.id ?? ""
            self.lblHqName.text = selectedHeadquarter.name
            
            
            if let index = self.masterData.firstIndex(of: MasterInfo.doctorFencing){
                self.animations[index] = true
                self.collectionView.reloadData()
            }
            if let index = self.masterData.firstIndex(of: MasterInfo.chemists){
                self.animations[index] = true
                self.collectionView.reloadData()
            }
            if let index = self.masterData.firstIndex(of: MasterInfo.stockists){
                self.animations[index] = true
                self.collectionView.reloadData()
            }
            if let index = self.masterData.firstIndex(of: MasterInfo.unlistedDoctors){
                self.animations[index] = true
                self.collectionView.reloadData()
            }
            if let index = self.masterData.firstIndex(of: MasterInfo.clusters){
                self.animations[index] = true
                self.collectionView.reloadData()
            }
            
            self.fetchmasterData(type: MasterInfo.doctorFencing)
            self.fetchmasterData(type: MasterInfo.chemists)
            self.fetchmasterData(type: MasterInfo.stockists)
            self.fetchmasterData(type: MasterInfo.unlistedDoctors)
            self.fetchmasterData(type: MasterInfo.clusters)
            
        }
    }
    
    
    var getSFCode: String{
        let login = AppDefaults.shared.getAppSetUp()
        let isManager = AppDefaults.shared.getAppSetUp().sfType == 2
        if isManager{
            if AppDefaults.shared.sfCode != ""{
                return AppDefaults.shared.sfCode
            }
            return login.sfCode!
        }
        return login.sfCode!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        collectionView.register(UINib(nibName: "MasterSyncCell", bundle: nil), forCellWithReuseIdentifier: "MasterSyncCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        self.updateList()
        
//        self.fetchmasterData(type: MasterInfo.slides)
//        self.fetchmasterData(type: MasterInfo.subordinate)
//        self.fetchmasterData(type: MasterInfo.subordinateMGR)
        
        let appsetup = AppDefaults.shared.getAppSetUp()
    
        self.lblHqName.text = appsetup.hqName
        print(appsetup)
        
        if !isFromLaunch {
            animations = (0...(masterData.count - 1)).map{_ in false}
        }else {
            animations = (0...(masterData.count - 1)).map{_ in true}
            _ = masterData.map{self.fetchmasterData(type: $0)}
        }
        
        print(DBManager.shared.getSlide())
        
        
        let syncTime = AppDefaults.shared.getSyncTime()
        let date = syncTime.toString(format: "dd MMM yyyy hh:mm a")
        self.lblSyncStatus.text = "Last Sync: " + date
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func headquarterAction(_ sender: UIButton) {
        let headquarter = DBManager.shared.getSubordinate()

        let selectionVC = UIStoryboard.singleSelectionVC
        selectionVC.selectionData = headquarter
        selectionVC.didSelectCompletion{ (index) in
            self.selectedHeadquarter = headquarter[index]
        }
        self.present(selectionVC, animated: true)
    }
    
    
    @IBAction func syncAll(_ sender: UIButton) {
        
        animations = (0...(masterData.count - 1)).map{_ in true}
     //   self.collectionView.reloadData()
        _ = masterData.map{self.fetchmasterData(type: $0)}
    }
    
    
    func updateList() {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        if isFromLaunch {
            self.dcrList.append(MasterCellData(cellType: MasterCellType.slides,isSelected: false))
        }else{
            self.dcrList.append(MasterCellData(cellType: MasterCellType.slides,isSelected: true))
        }
        
        self.dcrList.append(MasterCellData(cellType: MasterCellType.listedDoctor,isSelected: false))
        
        if appsetup.chmNeed == 0 {
            self.dcrList.append(MasterCellData(cellType: MasterCellType.chemist,isSelected: false))
        }
        if appsetup.stkNeed == 0 {
            self.dcrList.append(MasterCellData(cellType: MasterCellType.stockist,isSelected: false))
        }
        if appsetup.unlNeed == 0 {
            self.dcrList.append(MasterCellData(cellType: MasterCellType.unLstDoctor,isSelected: false))
        }
        if appsetup.cipNeed == 0 {
            self.dcrList.append(MasterCellData(cellType: MasterCellType.cip,isSelected: false))
        }
        if appsetup.hospNeed == 0 {
            self.dcrList.append(MasterCellData(cellType: MasterCellType.hospital,isSelected: false))
        }
        
        self.dcrList.append(MasterCellData(cellType: MasterCellType.Product,isSelected: false))
        self.dcrList.append(MasterCellData(cellType: MasterCellType.input,isSelected: false))
        self.dcrList.append(MasterCellData(cellType: MasterCellType.subordinate,isSelected: false))
        self.dcrList.append(MasterCellData(cellType: MasterCellType.cluster,isSelected: false))
        self.dcrList.append(MasterCellData(cellType: MasterCellType.stockBalance,isSelected: false))
        self.dcrList.append(MasterCellData(cellType: MasterCellType.syncAll,isSelected: false))
    
        self.masterData.append(MasterInfo.doctorFencing)
        self.masterData.append(MasterInfo.chemists)
        self.masterData.append(MasterInfo.stockists)
        self.masterData.append(MasterInfo.unlistedDoctors)
        
        self.masterData.append(MasterInfo.setups)
        self.masterData.append(MasterInfo.customSetup)
        self.masterData.append(MasterInfo.tourPlanStatus)
        self.masterData.append(MasterInfo.leaveType)
        self.masterData.append(MasterInfo.visitControl)
        self.masterData.append(MasterInfo.mapCompDet)
        self.masterData.append(MasterInfo.stockBalance)
        self.masterData.append(MasterInfo.slideBrand)
        self.masterData.append(MasterInfo.slides)
        self.masterData.append(MasterInfo.subordinate)
        self.masterData.append(MasterInfo.subordinateMGR)
        
        self.masterData.append(MasterInfo.speciality)
        self.masterData.append(MasterInfo.departments)
        self.masterData.append(MasterInfo.category)
        self.masterData.append(MasterInfo.qualifications)
        self.masterData.append(MasterInfo.doctorClass)
        
        self.masterData.append(MasterInfo.worktype)
        self.masterData.append(MasterInfo.clusters)
        self.masterData.append(MasterInfo.myDayPlan)
        self.masterData.append(MasterInfo.jointWork)
        self.masterData.append(MasterInfo.products)
        self.masterData.append(MasterInfo.inputs)
        self.masterData.append(MasterInfo.brands)
        self.masterData.append(MasterInfo.competitors)
        self.masterData.append(MasterInfo.slideSpeciality)
        
        
      //  self.tableView.reloadData()
     //   self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isFromLaunch {
            self.masterData = self.dcrList.first!.cellType.groupDetail
            self.collectionView.reloadData()
        }
    }
    
    func fetchmasterData(type : MasterInfo) {
        
        if type == .getTP {
            toPostDataToserver(type : type)

        }
        
        print(type.getUrl)
        print(type.getParams)
        
        let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss ZZZ")
        
        print("date === \(date)")
        AF.request(type.getUrl,method: .post,parameters: type.getParams).responseData(){ (response) in
            
            let date1 = Date().toString(format: "yyyy-MM-dd HH:mm:ss ZZZ")
            
            print("date1 === \(date1)")
            
            switch response.result {
                
                case .success(_):
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        let date1 = Date()
                        print(date1)
                        
                        print("ssususnbjbo")
                        print(apiResponse)
                        print("ssusus")
                        
//                        let status = getStatus(json: apiResponse)
//                        if status.isOk {
//
//                            DBManager.shared.savaMasterData(type: type, Values: apiResponse)
////                            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
////                                appDelegate.window?.rootViewController = UIStoryboard.homeVC
////                            }
//                        }
                        
                        if let response = apiResponse as? [[String : Any]] {
                            DBManager.shared.saveMasterData(type: type, Values: response,id: self.getSFCode)
                            
                            if type == MasterInfo.slides {
                                var slides = AppDefaults.shared.getSlides()
                                slides.removeAll()
                                slides.append(contentsOf: response)
                                AppDefaults.shared.save(key: .slide, value: slides)
                            }
                        }else if let responseDic = apiResponse as? [String : Any] {
                            DBManager.shared.saveMasterData(type: type, Values: [responseDic],id: self.getSFCode)
                        }
                    }catch {
                        print(error)
                    }
                AppDefaults.shared.save(key: .syncTime, value: Date())
                let date = Date().toString(format: "dd MMM yyyy hh:mm a")
                self.lblSyncStatus.text = "Last Sync: " + date
                case .failure(let error):
                    ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                    print(error)
                    return
            }
            
            if let index = self.masterData.firstIndex(of: type){
                self.animations[index] = false
                self.collectionView.reloadData()
                
             //   self.collectionView.reloadSections(NSIndexSet(index: index) as IndexSet) //, with: .automatic)
            }
            self.checkifSyncIsCompleted()
            
            print("2")
            print(response)
            print("2")
        }
    }
    
    func checkifSyncIsCompleted(){
        if !isFromLaunch{
            return
        }
        let filterStatus = self.animations.filter{$0 == true}
        if filterStatus.isEmpty{
            
            ConfigVC().showToast(controller: self, message: "Master Sync Completed", seconds: 2)
            
            let slideVC = UIStoryboard.slideDownloadVC
            self.present(slideVC, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.setupRootViewControllers()
                }
            }
        }
    }
}


extension MasterSyncVC : tableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dcrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterSyncTbCell", for: indexPath) as! MasterSyncTbCell
        cell.lblName.text = self.dcrList[indexPath.row].cellType.name
        cell.btnSyncAll.isHidden = MasterCellType.syncAll.rawValue == self.dcrList[indexPath.row].cellType.rawValue ? false : true
        cell.btnSyncAll.addTarget(self, action: #selector(syncAllAction(_:)), for: .touchUpInside)
        if self.dcrList[indexPath.row].isSelected == true {
            cell.btnArrow.isSelected = true
        }else {
            cell.btnArrow.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        for i in 0..<self.dcrList.count {
            self.dcrList[i].isSelected = false
        }
        self.tableView.reloadData()
        if let cell = tableView.cellForRow(at: indexPath) as? MasterSyncTbCell {
            cell.btnArrow.isSelected = true
        }
        
        self.masterData = self.dcrList[indexPath.row].cellType.groupDetail
        self.collectionView.reloadData()
    }
    
    @objc func syncAllAction (_ sender : UIButton) {
        
        self.masterData = [MasterInfo.slides,MasterInfo.doctorFencing,MasterInfo.chemists,MasterInfo.stockists,MasterInfo.unlistedDoctors,MasterInfo.worktype,MasterInfo.clusters,MasterInfo.myDayPlan,MasterInfo.subordinate,MasterInfo.subordinateMGR,MasterInfo.jointWork,MasterInfo.products,
                           MasterInfo.inputs,MasterInfo.brands,MasterInfo.competitors,MasterInfo.slideSpeciality,MasterInfo.slideBrand,MasterInfo.speciality,MasterInfo.departments,MasterInfo.category,MasterInfo.qualifications,MasterInfo.doctorClass,MasterInfo.setups,MasterInfo.customSetup, MasterInfo.tableSetup, MasterInfo.weeklyOff, MasterInfo.holidays, MasterInfo.getTP]
        
        animations = (0...(masterData.count - 1)).map{_ in true}
      //  self.collectionView.reloadData()
        _ = masterData.map{self.fetchmasterData(type: $0)}
        
    }
    
}

extension MasterSyncVC : collectionViewProtocols{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.collectionView.frame.width / 3
        let size = CGSize(width: width - 10, height: 80)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.masterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MasterSyncCell", for: indexPath) as! MasterSyncCell
        cell.lblName.text = self.masterData[indexPath.row].rawValue
        
        let status = self.animations[indexPath.row]
        if status {
            cell.activityIndicator.isHidden = false
            cell.activityIndicator.startAnimating()
        }else{
            cell.activityIndicator.isHidden = true
            cell.activityIndicator.stopAnimating()
        }
        cell.btnSync.addTarget(self, action: #selector(groupSyncAll(_:)), for: .touchUpInside)
        
        
        switch MasterInfo(rawValue: self.masterData[indexPath.row].rawValue){
            
        case .doctorFencing:
            cell.lblCount.text = String(DBManager.shared.getDoctor().count)
        case .chemists:
            cell.lblCount.text = String(DBManager.shared.getChemist().count)
        case .stockists:
            cell.lblCount.text = String(DBManager.shared.getStockist().count)
        case .unlistedDoctors:
            cell.lblCount.text = String(DBManager.shared.getUnListedDoctor().count)
        case .clusters:
            cell.lblCount.text = String(DBManager.shared.getTerritory().count)
        case .worktype:
            cell.lblCount.text = String(DBManager.shared.getWorkType().count)
        case .subordinate:
            cell.lblCount.text = String(DBManager.shared.getSubordinate().count)
        case .subordinateMGR:
            cell.lblCount.text = String(DBManager.shared.getSubordinateMGR().count)
        case .myDayPlan:
            cell.lblCount.text = String(DBManager.shared.getMyDayPlan().count)
        case .jointWork:
            cell.lblCount.text = String(DBManager.shared.getJointWork().count)
        case .products:
            cell.lblCount.text = String(DBManager.shared.getProduct().count)
        case .inputs:
            cell.lblCount.text = String(DBManager.shared.getInput().count)
        case .brands:
            cell.lblCount.text = String(DBManager.shared.getBrands().count)
        case .speciality:
            cell.lblCount.text = String(DBManager.shared.getSpeciality().count)
        case .doctorClass:
            cell.lblCount.text = String(DBManager.shared.getDoctorClass().count)
        case .category:
            cell.lblCount.text = String(DBManager.shared.getCategory().count)
        case .competitors:
            cell.lblCount.text = String(DBManager.shared.getCompetitor().count)
        case .slideBrand:
            cell.lblCount.text = String(DBManager.shared.getSlideBrand().count)
        case .slideSpeciality:
            cell.lblCount.text = String(DBManager.shared.getSlideSpeciality().count)
        case .slides:
            cell.lblCount.text = String(DBManager.shared.getSlide().count)
        case .qualifications:
            cell.lblCount.text = String(DBManager.shared.getQualification().count)
        case .visitControl:
            cell.lblCount.text = String(DBManager.shared.getVisitControl().count)
        case .leaveType:
            cell.lblCount.text = String(DBManager.shared.getLeaveType().count)
        case .mapCompDet:
            cell.lblCount.text = String(DBManager.shared.getMapCompDet().count)
        case .docFeedback:
            cell.lblCount.text = String(DBManager.shared.getFeedback().count)
        case .holidays:
            cell.lblCount.text = String(DBManager.shared.getHolidays().count)
        case .weeklyOff:
            cell.lblCount.text = String(DBManager.shared.getWeeklyOff().count)
        case .tableSetup:
            cell.lblCount.text = String(DBManager.shared.getTableSetUp().count)
        case .getTP:
            cell.lblCount.text = !DBManager.shared.getTP().tourPlanArr.isEmpty ? "\(DBManager.shared.getTP().tourPlanArr[0].arrOfPlan.count)" : "0"
        default:
            cell.lblCount.text = "0"
        }
        
        if MasterInfo.syncAll.rawValue == self.masterData[indexPath.row].rawValue {
            cell.isHidden = false
            cell.btnSync.isHidden = false
            cell.btnSync.setTitle("Sync \(self.masterData.first?.rawValue ?? "")", for: .normal)
        }else if MasterInfo.empty.rawValue == self.masterData[indexPath.row].rawValue {
            cell.isHidden = true
        }else{
            cell.isHidden = false
            cell.btnSync.isHidden = true
        }
        return cell
    }
    
    @objc func groupSyncAll(_ sender : UIButton){
        
        animations = (0...(masterData.count - 1)).map{_ in true}
        self.collectionView.reloadData()
        _ = masterData.map{self.fetchmasterData(type: $0)}
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        animations[indexPath.row] = true
        self.collectionView.reloadData()
        self.fetchmasterData(type: self.masterData[indexPath.row])
    }
}


struct MasterCellData {
    
    var cellType : MasterCellType!
    var isSelected : Bool!
}


extension MasterSyncVC {
    
    func getAllPlansData(_ param: [String: Any], paramData: Data, completion: @escaping (Result<SessionResponseModel,Error>) -> Void){
        let sessionResponseVM = SessionResponseVM()
        sessionResponseVM.getTourPlanData(params: param, api: .getAllPlansData, paramData: paramData) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
                dump(response)
                
            case .failure(let error):
                print(error.localizedDescription)
                
                completion(.failure(error))
            }
        }
    }
    
    
        func toPostDataToserver(type : MasterInfo) {
    
            
            
            AppDefaults.shared.eachDatePlan = NSKeyedUnarchiver.unarchiveObject(withFile: EachDatePlan.ArchiveURL.path) as? EachDatePlan ?? EachDatePlan()
    
            var  arrOfPlan = [SessionDetailsArr]()
            var tpArray =  [TourPlanArr]()
    
            AppDefaults.shared.eachDatePlan.tourPlanArr?.enumerated().forEach { index, eachDayPlan in
                tpArray.append(eachDayPlan)
            }
            tpArray.forEach({ tpArr in
                arrOfPlan = tpArr.arrOfPlan
            })
            
            
            let nonWeekoff = arrOfPlan.filter({ toFilterSessionsArr in
                toFilterSessionsArr.isForWeekoff == false
            })
            
            
            var unSavedPlans = [SessionDetailsArr]()
            
            if nonWeekoff.isEmpty {
                unSavedPlans = arrOfPlan.filter({ toFilterSessionsArr in
                       toFilterSessionsArr.isDataSentToApi == false &&  toFilterSessionsArr.isForWeekoff == false
                   })
            } else {
                unSavedPlans = arrOfPlan.filter({ toFilterSessionsArr in
                       toFilterSessionsArr.isDataSentToApi == false
                   })
            }
    
        
    
            var unsentIndices = [Int]()
    
            dump(unSavedPlans)
            if !(unSavedPlans.isEmpty ) {
                unsentIndices = unSavedPlans.indices.filter { unSavedPlans[$0].isDataSentToApi == false &&  !unSavedPlans[$0].isForWeekoff }
            }
    
    
            dump(unsentIndices)
    
            if unSavedPlans.count > 0 {
                self.toSendUnsavedObjects(unSavedPlans: unSavedPlans, unsentIndices: unsentIndices, isFromFirstLoad: true)
            } else {

                let toSendData = type.getParams

                 self.getAllPlansData(toSendData, paramData: Data()) { result in
                     switch result{
                     case .success(let respnse):
                         dump(respnse)
                         DBManager.shared.saveTPtoMasterData(modal: respnse) { isCompleted in
                             if isCompleted {
                                 let date = Date().toString(format: "dd MMM yyyy hh:mm a")
                                 self.lblSyncStatus.text = "Last Sync: " + date
                             }
                         }
                     case .failure( let error):
                      dump(error)

                      //  self.toCreateToast("Failed connecting to server!")
                     }
                 }
            }
    
        }
    
    func toSetParams(_ arrOfPlan: [SessionDetailsArr], completion: @escaping (Result<SaveTPresponseModel, Error>) -> ())  {
        let appdefaultSetup = AppDefaults.shared.getAppSetUp()

        
        
        var param = [String: Any]()
        param["SFCode"] = appdefaultSetup.sfCode
        param["SFName"] = appdefaultSetup.sfName
        param["Div"] = appdefaultSetup.divisionCode


        // tourPlanArr.arrOfPlan?.enumerated().forEach { index, allDayPlans in
        
        var sessions = [JSON]()
        
        arrOfPlan.enumerated().forEach { index, allDayPlans in
            allDayPlans.sessionDetails?.enumerated().forEach { sessionIndex, session in
                _ = [String: Any]()
                var index = String()
                if sessionIndex == 0 {
                    index = ""
                } else {
                    index = "\(sessionIndex + 1)"
                }
                
                var drIndex = String()
                if sessionIndex == 0 {
                    drIndex = "_"
                } else if sessionIndex == 1{
                    drIndex = "_two_"
                } else if sessionIndex == 2 {
                    drIndex = "_three_"
                }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMMM yyyy"
                let date =  dateFormatter.string(from:  allDayPlans.rawDate)
                let dateArr = date.components(separatedBy: " ") //"1 Nov 2023"
                dateFormatter.dateFormat = "EEEE"
                let day = dateFormatter.string(from: allDayPlans.rawDate)
                param["Yr"] = dateArr[2]//2023
               // param["Day"] =  dateArr[0]//1
               // param["Tour_Year"] = dateArr[2] // 2023
               // param["tpmonth"] = dateArr[1]// Nov
                param["tpday"] = day// Wednesday
                
                
                dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
                let dayNo = dateFormatter.string(from: allDayPlans.rawDate)
                let anotherDateArr = dayNo.components(separatedBy: "/") // MM/dd/yyyy - 09/12/2018
                param["dayno"] = anotherDateArr[1] // 11
              //  param["Tour_Month"] = anotherDateArr[0]// 11
                param["Mnth"] = anotherDateArr[0]
                
                let tpDtDate = dayNo.replacingOccurrences(of: "/", with: "-")
                param["TPDt"] =  tpDtDate//2023-11-01 00:00:00
                param["FWFlg\(index)"] = session.FWFlg
                param["HQCodes\(index)"] = session.HQCodes
                param["HQNames\(index)"] = session.HQNames
                param["WTCode\(index)"] = session.WTCode
                param["WTName\(index)"] = session.WTName
                param["chem\(drIndex)code"] = session.chemCode
                param["chem\(drIndex)name"] = session.chemName
                param["ClusterCode\(index)"] = session.clusterCode
                param["ClusterName\(index)"] = session.clusterName
                param["Dr\(drIndex)Code"] = session.drCode
                param["Dr\(drIndex)Name"] = session.drName
                param["jwCodes\(index)"] = session.jwCode
                param["jwNames\(index)"] = session.jwName
                
                if sessionIndex == 0 {
                    param["Stockist\(drIndex)Name"] = session.stockistName
                    param["Stockist\(drIndex)Code"] = session.stockistCode
                } else  {
                    param["Stockist\(drIndex)code"] = session.stockistCode
                    param["StockistName\(index)"] = session.stockistName
                }
              
                param["DayRemarks\(index)"] = session.remarks
            }
            param["submittedTime"] = "\(Date())"
            param["Mode"] = "Android-App"
            param["Entry_mode"] = "Apps"
            param["Approve_mode"] = ""
            param["Approved_time"] = ""
            param["app_version"] = "N 1.6.9"
            sessions.append(param)
        }
        dump(sessions)
        
        
        
        
        var jsonDatum = Data()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: sessions, options: [])
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
        let sessionResponseVM = SessionResponseVM()
        sessionResponseVM.uploadTPmultipartFormData(params: toSendData, api: .saveTP, paramData: jsonDatum) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
                dump(response)
                
            case .failure(let error):
                print(error.localizedDescription)
                
                completion(.failure(error))
            }
        }
    }
    
    func toSendUnsavedObjects(unSavedPlans : [SessionDetailsArr], unsentIndices: [Int], isFromFirstLoad : Bool) {
        if unSavedPlans.count > 0 {
            self.toSetParams(unSavedPlans ) {
                responseResult in
                switch responseResult {
                case .success(let responseJSON):
                    dump(responseJSON)
                    
//                    unsentIndices.forEach { index in
//                        unSavedPlans[index].isDataSentToApi = true
//                    }
                    
                    var temptpArray = [TourPlanArr]()
                    
                    AppDefaults.shared.eachDatePlan.tourPlanArr?.forEach {  eachDayPlan in
                        temptpArray.append(eachDayPlan)
                    }
                    
                    var temparrOfplan = [SessionDetailsArr]()
                    
                    temptpArray.forEach({ tpArr in
                        temparrOfplan = tpArr.arrOfPlan
                        //unSavedPlans//self.arrOfPlan
                    })
                    
                   var apiSentPlans = temparrOfplan.filter { ASessionDetailsArr in
                       ASessionDetailsArr.isDataSentToApi == true
                    }
                    
                    apiSentPlans.append(contentsOf: unSavedPlans)
                    
                    temparrOfplan = apiSentPlans
                    
                    temparrOfplan.forEach { plans in
                        plans.isDataSentToApi = true
                    }
                    
                    temptpArray.forEach({ tpArr in
                        tpArr.arrOfPlan = temparrOfplan
                        //unSavedPlans//self.arrOfPlan
                    })
                    
                    
                
                    AppDefaults.shared.eachDatePlan.tourPlanArr = temptpArray
                                let savefinish = NSKeyedArchiver.archiveRootObject(AppDefaults.shared.eachDatePlan, toFile: EachDatePlan.ArchiveURL.path)
                                     if !savefinish {
                                         print("Error")
                                     }
                    
                
                    
                   // self.toLoadData()
                 //  if isFromFirstLoad {
                  //     self.fetchDataFromServer()
                //   } else {
                       
                 //  }
                    LocalStorage.shared.setBool(LocalStorage.LocalValue.TPalldatesAppended, value: true)
                    self.toPostDataToserver(type: .getTP)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
          //  self.initialSetups()
          //  self.toCreateToast("Already this month plans are submited for approval.")
        }

    }
    

}
