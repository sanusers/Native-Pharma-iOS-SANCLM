//
//  MasterSyncVC.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 02/06/23.
//

import Foundation
import UIKit
import Alamofire
import CoreData
extension MasterSyncVC:  SlideDownloadVCDelegate {
    func didDownloadCompleted() {
        
        if isFromLaunch {
            self.toCreateToast("Master sync completed")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.setupRootViewControllers()
                }
            }
        } else {
            self.toCreateToast("Slide downloaded succeessfully.")
        }
        

    }
    
    
    func toCheckSlideExistence() -> Bool {
        
        return false
    }
    
    
}

class MasterSyncVC : UIViewController {
    
    
    
    
    
    static let shared = MasterSyncVC()
    var delegate : MasterSyncVCDelegate?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var tapInfoVIew: ShadowView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet weak var lblHqName: UILabel!
    @IBOutlet weak var lblSyncStatus: UILabel!
    
    @IBOutlet var backBtn: UIButton!
    
    var pageType: PageType = .loaded
    var loadedSlideInfo = [MasterInfo]()
    var extractedFileName: String?
    var isFromLaunch : Bool = false
    var masterVM: MasterSyncVM?
    var masterData = [MasterInfo]()
    
    var dcrList = [MasterCellData]()
    
    var fetchedHQObject: Subordinate?
    
    var animations = [Bool](){
        didSet{
            _ = self.animations.filter{$0 == false}
        }
    }
    
    var arrayOfAllSlideObjects = [SlidesModel]()
    //  var arrayOfBrandSlideObjects = [BrandSlidesModel]()
    
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
            
            self.fetchmasterData(type: MasterInfo.doctorFencing) {_ in}
            self.fetchmasterData(type: MasterInfo.chemists) {_ in}
            self.fetchmasterData(type: MasterInfo.stockists) {_ in}
            self.fetchmasterData(type: MasterInfo.unlistedDoctors) {_ in}
            self.fetchmasterData(type: MasterInfo.clusters) {_ in}
            
        }
    }
    
    var mastersyncVM: MasterSyncVM?
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
    
    var groupedBrandsSlideModel:  [GroupedBrandsSlideModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // addobservers()
        masterVM = MasterSyncVM()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupUI()
        collectionView.register(UINib(nibName: "MasterSyncCell", bundle: nil), forCellWithReuseIdentifier: "MasterSyncCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.updateList()
        
        //        self.fetchmasterData(type: MasterInfo.slides)
        //        self.fetchmasterData(type: MasterInfo.subordinate)
        //        self.fetchmasterData(type: MasterInfo.subordinateMGR)
       // let selectedHQobj = LocalStorage.shared.getData(key: LocalStorage.LocalValue.selectedHQ)
        
        
        
        if !isFromLaunch {
            animations = (0...(masterData.count - 1)).map{_ in false}
        }else {
            self.setLoader(pageType: .loading)
            animations = (0...(masterData.count - 1)).map{_ in true}
            
            
            let dispatchgroup = DispatchGroup()
            for masterType in masterData {
          
                dispatchgroup.enter()

            
                fetchmasterData(type: masterType) { _ in
                
                    dispatchgroup.leave()
                }

            
          
            }
            
            dispatchgroup.notify(queue: .main) {

                print("DCR list sync completed")
             
           
            }
           // _ = masterData.map{self.fetchmasterData(type: $0)}
        }
        
        print(DBManager.shared.getSlide())
        
        
        let syncTime = AppDefaults.shared.getSyncTime()
        let date = syncTime.toString(format: "dd MMM yyyy hh:mm a")
        self.lblSyncStatus.text = "Last Sync: " + date
        
        tapInfoVIew.layer.cornerRadius = 5
    }
    
    
    func setupUI() {
        self.mastersyncVM = MasterSyncVM()
        lblHqName.setFont(font: .bold(size: .BODY))
        lblHqName.textColor = .appLightTextColor
        lblSyncStatus.textColor = .appLightTextColor
        lblSyncStatus.setFont(font: .bold(size:   .BODY))
        titleLbl.setFont(font: .bold(size: .SUBHEADER))
        titleLbl.textColor = .appWhiteColor
        backBtn.setTitle("", for: .normal)
        setHQlbl()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        delegate?.isHQModified(hqDidChanged: self.fetchedHQObject != nil ? true : false)
        self.navigationController?.popViewController(animated: true)
    }
    
    func addobservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(syncTapped), name: Notification.Name("synced"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hqModified) , name: NSNotification.Name("HQmodified"), object: nil)
    }
    
    
    @objc func hqModified() {
        print("Tapped")
        self.fetchmasterData(type: .clusters) {_ in }
    }
    
    @objc func syncTapped() {
        print("Tapped")
        self.setLoader(pageType: .loading)
        self.fetchmasterData(type: .getTP) {_ in}
    }
    
    
//    func setTitleFromData() {
//     let subordinateData = LocalStorage.shared.getData(key: LocalStorage.LocalValue.selectedHQObj)
//        // Convert Data back to Subordinate
//        if let fetchedHQObject = try? NSKeyedUnarchiver.unarchivedObject(ofClass: Subordinate.self, from: subordinateData) {
//            // Use fetchedHQObject as your Subordinate object
//            print(fetchedHQObject)
//        }
//    }
    
    func setHQlbl() {
        // let appsetup = AppDefaults.shared.getAppSetUp()
        
        
        
        guard self.fetchedHQObject != nil else {
            CoreDataManager.shared.toRetriveSavedHQ { hqModelArr in
                let savedEntity = hqModelArr.first
                guard let savedEntity = savedEntity else{
                    
                    self.lblHqName.text = "Select HQ"
                    
                    return
                    
                }
                
                self.lblHqName.text = savedEntity.name == "" ? "Select HQ" : savedEntity.name
                
                let subordinates = DBManager.shared.getSubordinate()
                
                let asubordinate = subordinates.filter{$0.id == savedEntity.code}
                
                if !asubordinate.isEmpty {
                    self.fetchedHQObject = asubordinate.first
                }
            
              
  
 
                
            }
            // Retrieve Data from local storage
               return
            }
        
        self.lblHqName.text =   self.fetchedHQObject?.name
        self.collectionView.reloadData()
       
    }
    
    @IBAction func headquarterAction(_ sender: UIButton) {
      //  let headquarter = DBManager.shared.getSubordinate()

        let vc = SpecifiedMenuVC.initWithStory(self, celltype: .headQuater)
        
        vc.selectedObject = self.fetchedHQObject
        
        self.modalPresentationStyle = .custom
        self.navigationController?.present(vc, animated: false)
//        let selectionVC = UIStoryboard.singleSelectionVC
//        selectionVC.selectionData = headquarter
//        selectionVC.didSelectCompletion{ (index) in
//            self.selectedHeadquarter = headquarter[index]
//        }
//        self.present(selectionVC, animated: true)
    }
    
    
    @IBAction func syncAll(_ sender: UIButton) {
        self.setLoader(pageType: .loading)
        animations = (0...(masterData.count - 1)).map{_ in true}

      //  _ = masterData.map{self.fetchmasterData(type: $0)}
        
        let dispatchgroup = DispatchGroup()
        for masterType in masterData {
      
            dispatchgroup.enter()

        
            fetchmasterData(type: masterType) { _ in
            
                dispatchgroup.leave()
            }

        
      
        }
        
        dispatchgroup.notify(queue: .main) {

            print("DCR list sync completed")
         
       
        }
        
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
        self.masterData.append(MasterInfo.holidays)
        self.masterData.append(MasterInfo.weeklyOff)
        self.masterData.append(MasterInfo.tableSetup)
        self.masterData.append(MasterInfo.getTP)
        self.masterData.append(MasterInfo.homeSetup)
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
    

    
    func fetchmasterData(type : MasterInfo, completion: @escaping (Bool) -> ()) {
       // self.setLoader(pageType: .loading)
        
        switch type {
        case .getTP :
            toPostDataToserver(type : type)
        case .myDayPlan:
            
            toGetMyDayPlan(type: type) { [weak self] (result) in
                
                guard let welf = self else {return}
                
                switch result {
                    
                case .success(let responseModel):
                    
                    let model: [MyDayPlanResponseModel] = responseModel
                   
                    if model.count > 0 {
                        let aDayArr = model.first
                        let appdefaultSetup = AppDefaults.shared.getAppSetUp()
                      LocalStorage.shared.setSting(LocalStorage.LocalValue.rsfID, text: aDayArr?.SFMem ?? appdefaultSetup.sfCode!)
                      let subordinateArr =  DBManager.shared.getSubordinate()
                       let filteredHQ = subordinateArr.filter {  $0.id == aDayArr?.SFMem }
                        if !filteredHQ.isEmpty {
                            let cacheHQ = filteredHQ.first
                            welf.fetchedHQObject = cacheHQ
                            welf.setHQlbl()
                        }
                    } else {
                        
                        CoreDataManager.shared.fetchSavedHQ { selectedHQArr in
                            if !selectedHQArr.isEmpty {
                                let aSelectedHQ = selectedHQArr.first
                                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                                if let aSelectedHQ = aSelectedHQ {
                                    welf.fetchedHQObject =  CoreDataManager.shared.convertHeadQuartersToSubordinate(aSelectedHQ, context: context)
                                }
                                welf.lblHqName.text = aSelectedHQ?.name
                            } else {
                                welf.lblHqName.text =  "Select HQ"
                            }
                            
                        }
                        
                       
                    }
                    completion(true)
                case .failure(let error):
                    welf.toCreateToast(error.rawValue)
                    completion(true)
                }
            }
          
        default:
            mastersyncVM?.fetchMasterData(type: type, sfCode:  self.getSFCode, istoUpdateDCRlist: false) {[weak self] (response) in
                guard let welf = self else {return}
                let date1 = Date().toString(format: "yyyy-MM-dd HH:mm:ss ZZZ")
                
                print("date1 === \(date1)")
                
                switch response.result {
                    
                    case .success(_):
                        do {
                            let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                            print(apiResponse)
                            if let jsonObjectresponse = apiResponse as? [[String : Any]] {
                                DBManager.shared.saveMasterData(type: type, Values: jsonObjectresponse,id: welf.getSFCode)
                                if type == MasterInfo.slides || type == MasterInfo.slideBrand {
                                    welf.loadedSlideInfo.append(type)
                                    switch type {
                                    case MasterInfo.slides:
                                        
                                        var slides = AppDefaults.shared.getSlides()
                                        slides.removeAll()
                                        slides.append(contentsOf: jsonObjectresponse)
                                      
                                        LocalStorage.shared.setData(LocalStorage.LocalValue.slideResponse, data: response.data!)
  
                                    case MasterInfo.slideBrand:
                                        
                                        LocalStorage.shared.setData(LocalStorage.LocalValue.BrandSlideResponse, data: response.data!)
                                    
                                    default:
                                        print("Yet to implement")
                                    }
                                    welf.setLoader(pageType: .navigate)
                                }
                            }
                        }catch {
                            print(error)
                        }
                    AppDefaults.shared.save(key: .syncTime, value: Date())
                    let date = Date().toString(format: "dd MMM yyyy hh:mm a")
                    welf.lblSyncStatus.text = "Last Sync: " + date
                    welf.setLoader(pageType: .navigate, type: type)
                   // welf.setHQlbl()
                    case .failure(let error):
                    
                    welf.setLoader(pageType: .loaded)
                    welf.toCreateToast("\(error.localizedDescription)")
                        print(error)
                        return
                }
                
                if let index = welf.masterData.firstIndex(of: type){
                    welf.animations[index] = false
                    welf.collectionView.reloadData()
                }
              

            }
            
//            print(type.getUrl)
//            print(type.getParams)
//
//            let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss ZZZ")
//
//            print("date === \(date)")
//            AF.request(type.getUrl,method: .post,parameters: type.getParams).responseData(){ (response) in
//
//                let date1 = Date().toString(format: "yyyy-MM-dd HH:mm:ss ZZZ")
//
//                print("date1 === \(date1)")
//
//                switch response.result {
//
//                    case .success(_):
//                        do {
//                            let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
//
//                            let date1 = Date()
//                            print(date1)
//
//                            print("ssususnbjbo")
//                            print(apiResponse)
//                            print("ssusus")
//
//
//                            if let jsonObjectresponse = apiResponse as? [[String : Any]] {
//                                DBManager.shared.saveMasterData(type: type, Values: jsonObjectresponse,id: self.getSFCode)
//
//                                if type == MasterInfo.slides || type == MasterInfo.slideBrand {
//
//                                    self.loadedSlideInfo.append(type)
//                                    switch type {
//                                    case MasterInfo.slides:
//
//                                        var slides = AppDefaults.shared.getSlides()
//                                        slides.removeAll()
//                                        slides.append(contentsOf: jsonObjectresponse)
//                                       // AppDefaults.shared.save(key: .slide, value: slides)
//                                        LocalStorage.shared.setData(LocalStorage.LocalValue.slideResponse, data: response.data!)
//
//                                    //    self.toLoadPresentationData(type: MasterInfo.slides)
//
//
//                                    case MasterInfo.slideBrand:
//
//                                        LocalStorage.shared.setData(LocalStorage.LocalValue.BrandSlideResponse, data: response.data!)
//                                     //   self.toLoadPresentationData(type: MasterInfo.slideBrand)
//                                    default:
//                                        print("Yet to implement")
//                                    }
//
//                                    self.setLoader(pageType: .navigate)
//                                }
//                            }else if let responseDic = apiResponse as? [String : Any] {
//                                DBManager.shared.saveMasterData(type: type, Values: [responseDic],id: self.getSFCode)
//                            }
//                        }catch {
//                            print(error)
//                        }
//                    AppDefaults.shared.save(key: .syncTime, value: Date())
//                    let date = Date().toString(format: "dd MMM yyyy hh:mm a")
//                    self.lblSyncStatus.text = "Last Sync: " + date
//                    self.setLoader(pageType: .navigate, type: type)
//                    case .failure(let error):
//                    self.setLoader(pageType: .loaded)
//                        //ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
//                    self.toCreateToast("\(error.localizedDescription)")
//                        print(error)
//                        return
//                }
//
//                if let index = self.masterData.firstIndex(of: type){
//                    self.animations[index] = false
//                    self.collectionView.reloadData()
//
//                 //   self.collectionView.reloadSections(NSIndexSet(index: index) as IndexSet) //, with: .automatic)
//                }
//
//
//                print("2")
//                print(response)
//                print("2")
//            }
        }
        
   
        
        
        

    }
    
    // checkifSyncIsCompleted()
}


extension MasterSyncVC : tableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dcrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterSyncTbCell", for: indexPath) as! MasterSyncTbCell
        cell.selectionStyle = .none
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
        self.loadedSlideInfo = []
        self.setLoader(pageType: .loading)
        self.masterData = [MasterInfo.slides,MasterInfo.doctorFencing,MasterInfo.chemists,MasterInfo.stockists,MasterInfo.unlistedDoctors,MasterInfo.worktype,MasterInfo.clusters,MasterInfo.myDayPlan,MasterInfo.subordinate,MasterInfo.subordinateMGR,MasterInfo.jointWork,MasterInfo.products,
                           MasterInfo.inputs,MasterInfo.brands,MasterInfo.competitors,MasterInfo.slideSpeciality,MasterInfo.slideBrand,MasterInfo.speciality,MasterInfo.departments,MasterInfo.category,MasterInfo.qualifications,MasterInfo.doctorClass,MasterInfo.setups,MasterInfo.customSetup, MasterInfo.tableSetup, MasterInfo.weeklyOff, MasterInfo.holidays, MasterInfo.getTP, MasterInfo.homeSetup]
        
        animations = (0...(masterData.count - 1)).map{_ in true}
    
     //   _ = masterData.map{self.fetchmasterData(type: $0)}
        
        let dispatchgroup = DispatchGroup()
        for masterType in masterData {
      
            dispatchgroup.enter()

        
            fetchmasterData(type: masterType) { _ in
            
                dispatchgroup.leave()
            }

        
      
        }
        
        dispatchgroup.notify(queue: .main) {

            print("DCR list sync completed")
         
       
        }
        
        
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
        
        if self.masterData[indexPath.row].rawValue == "Holidays" || self.masterData[indexPath.row].rawValue == "Weekly Off" || self.masterData[indexPath.row].rawValue == "Table Setup" || self.masterData[indexPath.row].rawValue == "Charts" {
            return CGSize(width: width - 10, height: 0)
        }
            let size = CGSize(width: collectionView.width / 3 - 10 , height: collectionView.height / 5.5)
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
        self.setLoader(pageType: .loading)
        animations = (0...(masterData.count - 1)).map{_ in true}
        self.collectionView.reloadData()
      //  _ = masterData.map{self.fetchmasterData(type: $0)}
        let dispatchgroup = DispatchGroup()
        for masterType in masterData {
      
            dispatchgroup.enter()

        
            fetchmasterData(type: masterType) { _ in
            
                dispatchgroup.leave()
            }

        
      
        }
        
        dispatchgroup.notify(queue: .main) {

            print("DCR list sync completed")
         
       
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        animations[indexPath.row] = true
        self.collectionView.reloadData()
        self.fetchmasterData(type: self.masterData[indexPath.row]) {_ in}
    }
}


struct MasterCellData {
    
    var cellType : MasterCellType!
    var isSelected : Bool!
}
