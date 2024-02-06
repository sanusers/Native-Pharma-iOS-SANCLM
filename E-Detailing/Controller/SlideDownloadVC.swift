//
//  SlideDownloadVC.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 21/06/23.
//

import UIKit
import Alamofire
import MobileCoreServices
import SSZipArchive




extension SlideDownloadVC : SlideDownloaderCellDelegate {
    func didDownloadCompleted(arrayOfAllSlideObjects: [SlidesModel], index: Int, isForSingleSelection: Bool, completion: @escaping (Bool) -> Void) {
        
        
      self.loadingIndex = index + 1
      self.arrayOfAllSlideObjects = arrayOfAllSlideObjects

     
        switch isForSingleSelection {
            
        case true:
            
            let downloadedArr = self.arrayOfAllSlideObjects.filter { $0.isDownloadCompleted }
            self.countLbl.text = "\(downloadedArr.count)/\( self.arrayOfAllSlideObjects .count)"
            let element = arrayOfAllSlideObjects[index]
            CoreDataManager.shared.updateSlidesInCoreData(savedSlides: element) {isUpdated in
                if isUpdated {
                    self.toGroupSlidesBrandWise() {_ in
                        self.tableView.reloadData()
                        self.tableView.isUserInteractionEnabled = true
                        completion(true)
                       
                    }
                }
            }
            
        case false:
            
            let downloadedArr = self.arrayOfAllSlideObjects.filter { $0.isDownloadCompleted }
            self.countLbl.text = "\(downloadedArr.count)/\( self.arrayOfAllSlideObjects .count)"
            let aSlidesModel = arrayOfAllSlideObjects[index]
            CoreDataManager.shared.saveSlidesToCoreData(savedSlides: aSlidesModel) { isInstanceSaved in
                if isInstanceSaved {
                    toGroupSlidesBrandWise() {_ in
                        self.tableView.reloadData()
                        self.tableView.isUserInteractionEnabled = true
                        completion(true)
                       
                    }
                } else {

                }
            }
            
 
            
//            guard index + 1 < arrayOfAllSlideObjects.count else {
//                self.toCreateToast("Download completed")
//                // All items processed, exit the recursion
//
//                //   LocalStorage.shared.saveObjectToUserDefaults(items, forKey: LocalStorage.LocalValue.LoadedSlideData)
//                CoreDataManager.shared.removeAllSlides()
//                arrayOfAllSlideObjects.forEach { aSlidesModel in
//                    CoreDataManager.shared.saveSlidesToCoreData(savedSlides: aSlidesModel) { isInstanceSaved in
//                        if isInstanceSaved {
//
//                        } else {
//
//                        }
//                    }
//                }
//
//
//                toGroupSlidesBrandWise() {_ in
//                    self.tableView.reloadData()
//                    completion(true)
//
//                }
//
//
//                return
//            }
            guard index + 1 < arrayOfAllSlideObjects.count else {
                checkifSyncIsCompleted(self.isFromlaunch)
                return
            }
            
            if isFromlaunch {
                toDownloadMedia(index: index + 1, items: arrayOfAllSlideObjects)
            } else {
                self.tableView.isUserInteractionEnabled = true
            }
          
        }
    }
    

    
    func didDownloadCompleted(arrayOfAllSlideObjects: [SlidesModel], index: Int, completion: @escaping (Bool) -> Void) {


    }
    
    
}

protocol SlideDownloadVCDelegate: AnyObject {
    func didDownloadCompleted()
}

typealias SlidesCallBack = (_ status: Bool) -> Void
 
class SlideDownloadVC : UIViewController {
    
    @IBOutlet var countLbl: UILabel!
    @IBOutlet var slideHolderVIew: UIView!
    @IBOutlet var closeHolderView: UIView!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var titleLbl: UILabel!
    weak var delegate: SlideDownloadVCDelegate?
    class func initWithStory() -> SlideDownloadVC {
        let tourPlanVC : SlideDownloadVC = UIStoryboard.Hassan.instantiateViewController()
        return tourPlanVC
    }
    var groupedBrandsSlideModel:  [GroupedBrandsSlideModel]?
    var arrayOfAllSlideObjects = [SlidesModel]()
    var extractedFileName: String?
    var loadingIndex: Int = 0
    var isSlideDownloadCompleted: Bool = false
    var isFromlaunch: Bool = false
    var isConnected = Bool()
    @IBOutlet weak var tableView: UITableView!
    
    var slidesModel = [SlidesModel]()

    func setupuUI() {
        LocalStorage.shared.setBool(LocalStorage.LocalValue.isSlidesLoaded, value: false)
        self.tableView.register(UINib(nibName: "SlideDownloaderCell", bundle: nil), forCellReuseIdentifier: "SlideDownloaderCell")
        titleLbl.setFont(font: .bold(size: .BODY))
        lblStatus.setFont(font: .bold(size: .BODY))
        slideHolderVIew.layer.cornerRadius = 5
        // slideHolderVIew.elevate(2)
      //  self.tableView.isScrollEnabled = true
     
    }
    
    func initVIew() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkModified(_:)) , name: NSNotification.Name("connectionChanged"), object: nil)
        
        closeHolderView.addTap {
            let existingCDSlides: [SlidesModel] = CoreDataManager.shared.retriveSavedSlides()
            let apiFetchedSlide: [SlidesModel] = self.arrayOfAllSlideObjects
            
            if existingCDSlides.count == apiFetchedSlide.count {
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isSlidesLoaded, value: true)
            } else {
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isSlidesLoaded, value: false)
            }
            
            if !LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isSlidesLoaded) && !self.isFromlaunch {
              //  self.toSetupAlert()
                self.dismiss(animated: false)
                
            } else if self.isFromlaunch {
               // self.toSetupAlert()
                self.toCreateToast("Slides data download initiated please wait..")
            } else {
                self.dismiss(animated: false)
            }

        }
    }
    

    
    func toSetupAlert() {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "E - Detailing", alertDescription: "Slides will be downloaded in background..", okAction: "Ok")
        commonAlert.addAdditionalOkAction(isForSingleOption: true) {
            print("no action")
            self.dismiss(animated: false) {
                self.delegate?.didDownloadCompleted()
            }
        }
    }
    
    @objc func networkModified(_ notification: NSNotification) {
        
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
               if let status = dict["Type"] as? String{
                   DispatchQueue.main.async {
                       if status == "No Connection" {
                        //   self.toSetPageType(.notconnected)
                           self.toCreateToast("Please check your internet connection.")
                           self.isConnected = false
                           LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                           self.toSetupRetryAction(index: self.loadingIndex, items: self.arrayOfAllSlideObjects, isConnected: self.isConnected)
                           
                           
                       } else if  status == "WiFi" || status ==  "Cellular"   {
                           self.isConnected = true
                           LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
                           self.toCreateToast("You are now connected.")
                           //self.toDownloadMedia(index: self.loadingIndex, items: self.arrayOfAllSlideObjects)
                           self.toSetupRetryAction(index: self.loadingIndex, items: self.arrayOfAllSlideObjects, isConnected: self.isConnected)
                       }
                   }
               }
           }
    }
    
    func toSetupRetryAction(index: Int, items : [SlidesModel], isConnected: Bool) {
        guard index >= 0, index < items.count else {

            return
        }

        self.arrayOfAllSlideObjects[index].isFailed = true
        self.tableView.reloadData()
        
//
//        let indexPath = IndexPath(row: index, section: 0) // Assuming single section
//
//        if let cell = tableView.cellForRow(at: indexPath) as? SlideDownloaderCell {
//           // cell.toSendParamsToAPISerially(index: index, items: items)
//            cell.btnRetry.isHidden = false
//            cell.delegate = self
//            scrollToItem(at: index + 1, animated: true)
//            cell.isUserInteractionEnabled = true
//
//            cell.lblDataBytes.text = isSlideDownloadCompleted ? "Download Complete." : isConnected ? "Retry now" : "Unable to connect to network.."
//        } else {
//            //  completion(false) // Couldn't get the cell
//            print("Cant able to retrive cell.")
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupuUI()
        initVIew()
        toLoadPresentationData(type: .slideBrand)
        toLoadPresentationData(type: .slides)
        
        
        // self.slides = DBManager.shared.getSlide()
        // self.tableView.reloadData()
        
        // self.downloadSlideData()
    }
    
    
    @IBAction func CloseAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    func toCheckNetworkStatus() -> Bool {
        if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
          return true
        } else {
          return false
        }
    }
    
    func toSetTableVIewDataSource() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    func toLoadPresentationData(type : MasterInfo) {
        
        let paramData = type == MasterInfo.slides ? LocalStorage.shared.getData(key: LocalStorage.LocalValue.slideResponse) :  LocalStorage.shared.getData(key: LocalStorage.LocalValue.BrandSlideResponse)
        //   var localParamArr = [[String: Any]]()
        //  var encodedSlideModelData: [SlidesModel]?
        
        var localParamArr = [[String:  Any]]()
        do {
            localParamArr  = try JSONSerialization.jsonObject(with: paramData, options: []) as?  [[String:  Any]] ??  [[String:  Any]]()
            dump(localParamArr)
            
            
            
        } catch {
            //  self.toCreateToast("unable to retrive")
        }
        
        if type == MasterInfo.slides {
            arrayOfAllSlideObjects.removeAll()
        } 
        
        if type == MasterInfo.slides {
            for dictionary in localParamArr {
                if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary),
                   let model = try? JSONDecoder().decode(SlidesModel.self , from: jsonData) {
                    model.uuid = UUID()
                    arrayOfAllSlideObjects.append(model)
                    
                    
                } else {
                    print("Failed to decode dictionary into YourModel")
                }
            }
            //  self.toSetTableVIewDataSource()
        } else {
          
            CoreDataManager.shared.removeAllSlideBrands()
            localParamArr.enumerated().forEach { index, dictionary in
                if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary),
                   let model = try? JSONDecoder().decode(BrandSlidesModel.self , from: jsonData) {
                    model.uuid = UUID()
              
                    CoreDataManager.shared.saveBrandSlidesToCoreData(savedBrandSlides: model) { isInstanceSaved in
                        if isInstanceSaved {
                            print("Saved BrandSlidesModel sucessfully to core data")
                            
                        } else {
                            print("Error saving  BrandSlidesModel to core data")
                        }
                    }
                } else {
                    print("Failed to decode dictionary into YourModel")
                }
                
            }
        
        }
        
        
        if type == .slides {
            let isNewSlideExists = toCheckExistenceOfNewSlides()
            if isNewSlideExists {
                toSetTableVIewDataSource()
               // self.countLbl.text = "1/\(arrayOfAllSlideObjects.count)"
                if isFromlaunch {
                    toDownloadMedia(index: 0, items: arrayOfAllSlideObjects)
                   
                } else {
                    self.tableView.isUserInteractionEnabled = true
                }
              
            } else {
               // LocalStorage.shared.setBool(LocalStorage.LocalValue.isSlidesLoaded, value: true)
                self.isSlideDownloadCompleted = true
                toSetTableVIewDataSource()
                self.countLbl.text = ""
            }

        }
        
    }
    
    
    func toCheckExistenceOfNewSlides() -> Bool {
        let existingCDSlides: [SlidesModel] = CoreDataManager.shared.retriveSavedSlides()
        let apiFetchedSlide: [SlidesModel] = self.arrayOfAllSlideObjects

        // Extract slideId values from each array
        let existingSlideIds = Set(existingCDSlides.map { $0.slideId })

        // Filter apiFetchedSlide to get slides with slideIds not present in existingCDSlides
        let nonExistingSlides = apiFetchedSlide.filter { !existingSlideIds.contains($0.slideId) }

        // Now, nonExistingSlides contains the slides that exist in apiFetchedSlide but not in existingCDSlides based on slideId
        self.arrayOfAllSlideObjects.removeAll()
        self.arrayOfAllSlideObjects.append(contentsOf: existingCDSlides)
        self.arrayOfAllSlideObjects.append(contentsOf: nonExistingSlides)
        let downloadedArr = self.arrayOfAllSlideObjects.filter { $0.isDownloadCompleted }
        self.countLbl.text = "\(downloadedArr.count)/\( self.arrayOfAllSlideObjects .count)"
        return !nonExistingSlides.isEmpty
        
    }
    
    func toDownloadMedia(index: Int, items: [SlidesModel], isForsingleRetry: Bool? = false) {
     //   self.tableView.isScrollEnabled = false
        self.tableView.isUserInteractionEnabled = false
        guard index >= 0, index < items.count else {
            
            return
        }
        
        let indexPath = IndexPath(row: index, section: 0) // Assuming single section
        
        if let cell = tableView.cellForRow(at: indexPath) as? SlideDownloaderCell {
            cell.toSendParamsToAPISerially(index: index, items: items, isForsingleRetry: isForsingleRetry)
            cell.delegate = self
            scrollToItem(at: index + 1, animated: true)
        } else {
            //  completion(false) // Couldn't get the cell
            print("Cant able to retrive cell.")
        }
    }
    
    func scrollToItem(at index: Int, animated: Bool) {
        guard index >= 0, index < self.arrayOfAllSlideObjects.count else {
            return // Invalid index
        }
        
        let indexPath = IndexPath(row: index, section: 0) // Assuming single section
        tableView.scrollToRow(at: indexPath, at: .middle, animated: animated)
    }
    
    
    func toGroupSlidesBrandWise(completion: @escaping (Bool) -> Void) {
        let  arrayOfAllSlideObjects =  CoreDataManager.shared.retriveSavedSlides()
        let arrayOfBrandSlideObjects = CoreDataManager.shared.retriveSavedBrandSlides()
        //  CoreDataManager.shared.removeAllGroupedSlides()
        
        CoreDataManager.shared.removeAllGeneralGroupedSlides()
        //   var groupedBrandsSlideModel =  [GroupedBrandsSlideModel]()
        arrayOfBrandSlideObjects.enumerated().forEach {index, brandSlideModel in
            let aBrandData =  arrayOfAllSlideObjects.filter({ aSlideModel in
                aSlideModel.code == brandSlideModel.productBrdCode
            })
            
            let aBrandGroup = GroupedBrandsSlideModel()
            
            aBrandGroup.groupedSlide = aBrandData
            aBrandGroup.priority = brandSlideModel.priority
            // aBrandGroup.updatedDate = brandSlideModel.updatedDate
            aBrandGroup.divisionCode = brandSlideModel.divisionCode
            aBrandGroup.productBrdCode = brandSlideModel.productBrdCode
            aBrandGroup.subdivisionCode = brandSlideModel.subdivisionCode
            //  aBrandGroup.createdDate = brandSlideModel.createdDate
            aBrandGroup.id = brandSlideModel.id
            
            CoreDataManager.shared.toSaveGeneralGroupedSlidesToCoreData(groupedBrandSlide: aBrandGroup) { isSaved in
                if !isSaved {
                    print("Error saving groupedBrandSlide to core data")
                    //self.checkifSyncIsCompleted(self.isFromlaunch)
                } else {
                    print("Saved successfully")
                    self.tounArchiveData { _ in
                        if index == arrayOfBrandSlideObjects.count - 1 {
                            completion(true)
                          //  self.checkifSyncIsCompleted(self.isFromlaunch)
                        }
                    }
                }
            }
            
        }
    }
    
    
    func tounArchiveData(completion: @escaping (Bool) -> Void) {
        var zipContentsSlides = [SlidesModel]()
        var zipgropedBrandModels = [GroupedBrandsSlideModel]()
        groupedBrandsSlideModel = CoreDataManager.shared.retriveGeneralGroupedSlides()

        CoreDataManager.shared.removeAllGeneralGroupedSlides()

        //  CoreDataManager.shared.removeAllGeneralGroupedSlides()
        if  let groupedBrandsSlideModel = groupedBrandsSlideModel {
            var tempGroupedBrandsSlideModel =  [GroupedBrandsSlideModel]()
            groupedBrandsSlideModel.enumerated().forEach { aGroupedBrandsSlideModelIndex, aGroupedBrandsSlideModel in
                // Filter out slides with utType equal to "application/zip"
                zipContentsSlides = aGroupedBrandsSlideModel.groupedSlide.filter { aSlideModel in
                    aSlideModel.utType == "application/zip"
                }

                // Update groupedSlideModel by removing slides with utType equal to "application/zip"
                self.groupedBrandsSlideModel?[aGroupedBrandsSlideModelIndex].groupedSlide = aGroupedBrandsSlideModel.groupedSlide.filter { aSlideModel in
                    aSlideModel.utType != "application/zip"
                }

                // Append to zipgropedBrandModels if there are zipContentsSlides
                if !zipContentsSlides.isEmpty {

                    zipgropedBrandModels.append(aGroupedBrandsSlideModel)
                } else {
                    tempGroupedBrandsSlideModel.append(aGroupedBrandsSlideModel)
                }
            }

            self.groupedBrandsSlideModel = tempGroupedBrandsSlideModel

            var modifiedZipgropedBrandModels = [GroupedBrandsSlideModel]()

            zipgropedBrandModels.forEach { aGroupedBrandsSlideModel in
                let tempGroupedBrandsSlideModel = GroupedBrandsSlideModel()
                //              let zipContentsSlides =  aGroupedBrandsSlideModel.groupedSlide.filter { aGroupedSlide in
                //                  aGroupedSlide.utType == "application/zip"
                //                }
                var aGroupedSlideArr = [SlidesModel]()
                // var dataArr = [Data]()
                var data = UnzippedDataInfo()
                if !zipContentsSlides.isEmpty {
                    zipContentsSlides.enumerated().forEach { aSlidesModelIndex, aSlidesModel in
                        //  dataArr.append(contentsOf: unarchiveAndGetData(from: aSlidesModel.slideData) ?? [Data]())
                        data = unarchiveAndGetData(from: aSlidesModel.slideData)

                       let aGroupedSlide = toExtractSlidesFromUnzippedContent(data: data, aSlidesModel: aSlidesModel)
                        aGroupedSlideArr.append(contentsOf: aGroupedSlide)

                    }
                }
                tempGroupedBrandsSlideModel.createdDate = aGroupedBrandsSlideModel.createdDate
                tempGroupedBrandsSlideModel.groupedSlide = aGroupedSlideArr
                tempGroupedBrandsSlideModel.priority   = aGroupedBrandsSlideModel.priority
                tempGroupedBrandsSlideModel.updatedDate = aGroupedBrandsSlideModel.updatedDate
                tempGroupedBrandsSlideModel.divisionCode = aGroupedBrandsSlideModel.divisionCode
                tempGroupedBrandsSlideModel.productBrdCode = aGroupedBrandsSlideModel.productBrdCode
                tempGroupedBrandsSlideModel.subdivisionCode = aGroupedBrandsSlideModel.subdivisionCode
                tempGroupedBrandsSlideModel.createdDate = aGroupedBrandsSlideModel.createdDate
                tempGroupedBrandsSlideModel.id = aGroupedBrandsSlideModel.id
                modifiedZipgropedBrandModels.append(tempGroupedBrandsSlideModel)
            }

            self.groupedBrandsSlideModel?.append(contentsOf: modifiedZipgropedBrandModels)


            var completedTaskCount = 0
            self.groupedBrandsSlideModel?.enumerated().forEach({ index, aGroupedBrandsSlideModel in
                CoreDataManager.shared.toSaveGeneralGroupedSlidesToCoreData(groupedBrandSlide: aGroupedBrandsSlideModel) { isSaved in
                    completedTaskCount += 1

                    if completedTaskCount == groupedBrandsSlideModel.count {
                        completion(true)
                    }
                }

            })


        }
    }
    
    func toExtractSlidesFromUnzippedContent(data: UnzippedDataInfo, aSlidesModel: SlidesModel) -> [SlidesModel] {
        if !data.videofiles.isEmpty {
            var slidesModelArr = [SlidesModel]()
            data.imagefiles.enumerated().forEach { enumeratedIndex, data in
                let aGroupedSlide = SlidesModel()
                aGroupedSlide.code = (aSlidesModel.code)
                aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                aGroupedSlide.isFailed = aSlidesModel.isFailed
                aGroupedSlide.code =   (aSlidesModel.code)
                aGroupedSlide.camp = (aSlidesModel.camp)
                aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
                //  aGroupedSlide.filePath = extractedfileURL ?? ""
                aGroupedSlide.group = (aSlidesModel.group)
                aGroupedSlide.specialityCode = aSlidesModel.specialityCode
                aGroupedSlide.slideId = (aSlidesModel.slideId)
                aGroupedSlide.fileType = aSlidesModel.fileType
                // aGroupedSlidedel.effFrom = effFrom = DateI
                aGroupedSlide.categoryCode = aSlidesModel.categoryCode
                aGroupedSlide.name = aSlidesModel.name
                aGroupedSlide.fileName = aSlidesModel.filePath
                aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)
                aGroupedSlide.ordNo = (aSlidesModel.ordNo)
                aGroupedSlide.priority = (aSlidesModel.priority)
                aGroupedSlide.slideData = data.fileData ?? Data()
                aGroupedSlide.utType = data.filetype ?? "image/jpeg"
                aGroupedSlide.isSelected = aSlidesModel.isSelected
                aGroupedSlide.isFailed = aSlidesModel.isFailed
                aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                slidesModelArr.append(aGroupedSlide)
            }

            return slidesModelArr
           } else if !data.imagefiles.isEmpty {
               var slidesModelArr = [SlidesModel]()
               data.imagefiles.enumerated().forEach { enumeratedIndex, data in
                   let aGroupedSlide = SlidesModel()
                   aGroupedSlide.code = (aSlidesModel.code)
                   aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                   aGroupedSlide.isFailed = aSlidesModel.isFailed
                   aGroupedSlide.code =   (aSlidesModel.code)
                   aGroupedSlide.camp = (aSlidesModel.camp)
                   aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
                   //  aGroupedSlide.filePath = extractedfileURL ?? ""
                   aGroupedSlide.group = (aSlidesModel.group)
                   aGroupedSlide.specialityCode = aSlidesModel.specialityCode
                   aGroupedSlide.slideId = (aSlidesModel.slideId)
                   aGroupedSlide.fileType = aSlidesModel.fileType
                   // aGroupedSlidedel.effFrom = effFrom = DateI
                   aGroupedSlide.categoryCode = aSlidesModel.categoryCode
                   aGroupedSlide.name = aSlidesModel.name
                   aGroupedSlide.fileName = aSlidesModel.filePath
                   aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)
                   aGroupedSlide.ordNo = (aSlidesModel.ordNo)
                   aGroupedSlide.priority = (aSlidesModel.priority)
                   aGroupedSlide.slideData = data.fileData ?? Data()
                   aGroupedSlide.utType = data.filetype ?? "image/jpeg"
                   aGroupedSlide.isSelected = aSlidesModel.isSelected
                   aGroupedSlide.isFailed = aSlidesModel.isFailed
                   aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                   slidesModelArr.append(aGroupedSlide)
               }
               return slidesModelArr
           } else if !data.htmlfiles.isEmpty {
               var slidesModelArr = [SlidesModel]()
               data.htmlfiles.enumerated().forEach { enumeratedIndex, data in
                   let aGroupedSlide = SlidesModel()
                   aGroupedSlide.code = (aSlidesModel.code)
                   aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                   aGroupedSlide.isFailed = aSlidesModel.isFailed
                   aGroupedSlide.code =   (aSlidesModel.code)
                   aGroupedSlide.camp = (aSlidesModel.camp)
                   aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
                   //  aGroupedSlide.filePath = extractedfileURL ?? ""
                   aGroupedSlide.group = (aSlidesModel.group)
                   aGroupedSlide.specialityCode = aSlidesModel.specialityCode
                   aGroupedSlide.slideId = (aSlidesModel.slideId)
                   aGroupedSlide.fileType = aSlidesModel.fileType
                   // aGroupedSlidedel.effFrom = effFrom = DateI
                   aGroupedSlide.categoryCode = aSlidesModel.categoryCode
                   aGroupedSlide.name = aSlidesModel.name
                   aGroupedSlide.fileName = data.fileName ?? "No name"
                   if let url = data.htmlFileURL {
                       //htmlFileURL
                       aGroupedSlide.filePath = "\(url)"
                       //.absoluteString
                   } else {

                       print("htmlFileURL is nil")
                   }
                   aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)

                   aGroupedSlide.ordNo = (aSlidesModel.ordNo)
                   aGroupedSlide.priority = (aSlidesModel.priority)
                   aGroupedSlide.slideData = data.fileData ?? Data()
                   aGroupedSlide.utType = "text/html"
                   aGroupedSlide.isFailed = aSlidesModel.isFailed
                   aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
                   aGroupedSlide.isSelected = aSlidesModel.isSelected
                   slidesModelArr.append(aGroupedSlide)

               }
               return slidesModelArr
           } else   {
               var slidesModelArr = [SlidesModel]()
               let aGroupedSlide = SlidesModel()
               aGroupedSlide.code = (aSlidesModel.code)
               aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
               aGroupedSlide.isFailed = aSlidesModel.isFailed
               aGroupedSlide.code =   (aSlidesModel.code)
               aGroupedSlide.camp = (aSlidesModel.camp)
               aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
               //  aGroupedSlide.filePath = extractedfileURL ?? ""
               aGroupedSlide.group = (aSlidesModel.group)
               aGroupedSlide.specialityCode = aSlidesModel.specialityCode
               aGroupedSlide.slideId = (aSlidesModel.slideId)
               aGroupedSlide.fileType = aSlidesModel.fileType
               // aGroupedSlidedel.effFrom = effFrom = DateI
               aGroupedSlide.categoryCode = aSlidesModel.categoryCode
               aGroupedSlide.name = aSlidesModel.name
               aGroupedSlide.fileName = aSlidesModel.filePath
               aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)
               aGroupedSlide.ordNo = (aSlidesModel.ordNo)
               aGroupedSlide.priority = (aSlidesModel.priority)
               aGroupedSlide.slideData =  Data()
               aGroupedSlide.utType = ""
               aGroupedSlide.isSelected = aSlidesModel.isSelected
               aGroupedSlide.isFailed = aSlidesModel.isFailed
               aGroupedSlide.isDownloadCompleted = aSlidesModel.isDownloadCompleted
               slidesModelArr.append(aGroupedSlide)
               return slidesModelArr
           }
               
            


    }
    
//    func tounArchiveData(completion: @escaping (Bool) -> Void) {
//        var zipContentsSlides = [SlidesModel]()
//        var zipgropedBrandModels = [GroupedBrandsSlideModel]()
//        groupedBrandsSlideModel = CoreDataManager.shared.retriveGeneralGroupedSlides()
//
//        CoreDataManager.shared.removeAllGeneralGroupedSlides()
//
//        //  CoreDataManager.shared.removeAllGeneralGroupedSlides()
//        if  let groupedBrandsSlideModel = groupedBrandsSlideModel {
//            var tempGroupedBrandsSlideModel =  [GroupedBrandsSlideModel]()
//            groupedBrandsSlideModel.enumerated().forEach { aGroupedBrandsSlideModelIndex, aGroupedBrandsSlideModel in
//                // Filter out slides with utType equal to "application/zip"
//                zipContentsSlides = aGroupedBrandsSlideModel.groupedSlide.filter { aSlideModel in
//                    aSlideModel.utType == "application/zip"
//                }
//
//                // Update groupedSlideModel by removing slides with utType equal to "application/zip"
//                self.groupedBrandsSlideModel?[aGroupedBrandsSlideModelIndex].groupedSlide = aGroupedBrandsSlideModel.groupedSlide.filter { aSlideModel in
//                    aSlideModel.utType != "application/zip"
//                }
//
//                // Append to zipgropedBrandModels if there are zipContentsSlides
//                if !zipContentsSlides.isEmpty {
//
//                    zipgropedBrandModels.append(aGroupedBrandsSlideModel)
//                } else {
//                    tempGroupedBrandsSlideModel.append(aGroupedBrandsSlideModel)
//                }
//            }
//
//            self.groupedBrandsSlideModel = tempGroupedBrandsSlideModel
//
//            var modifiedZipgropedBrandModels = [GroupedBrandsSlideModel]()
//
//            zipgropedBrandModels.forEach { aGroupedBrandsSlideModel in
//                let tempGroupedBrandsSlideModel = GroupedBrandsSlideModel()
//                //              let zipContentsSlides =  aGroupedBrandsSlideModel.groupedSlide.filter { aGroupedSlide in
//                //                  aGroupedSlide.utType == "application/zip"
//                //                }
//                var aGroupedSlideArr = [SlidesModel]()
//                // var dataArr = [Data]()
//                var data = HTMLinfo()
//                if !zipContentsSlides.isEmpty {
//                    zipContentsSlides.forEach { aSlidesModel in
//                        //  dataArr.append(contentsOf: unarchiveAndGetData(from: aSlidesModel.slideData) ?? [Data]())
//                        data = unarchiveAndGetData(from: aSlidesModel.slideData)
//                        //   dataArr.forEach { aData in
//                        let aGroupedSlide = SlidesModel()
//                        aGroupedSlide.code = (aSlidesModel.code)
//                        aGroupedSlide.isDownloadCompleted = true
//                        aGroupedSlide.code =   (aSlidesModel.code)
//                        aGroupedSlide.camp = (aSlidesModel.camp)
//                        aGroupedSlide.productDetailCode = aSlidesModel.productDetailCode
//                        //  aGroupedSlide.filePath = extractedfileURL ?? ""
//                        aGroupedSlide.group = (aSlidesModel.group)
//                        aGroupedSlide.specialityCode = aSlidesModel.specialityCode
//                        aGroupedSlide.slideId = (aSlidesModel.slideId)
//                        aGroupedSlide.fileType = aSlidesModel.fileType
//                        // aGroupedSlidedel.effFrom = effFrom = DateI
//                        aGroupedSlide.categoryCode = aSlidesModel.categoryCode
//                        aGroupedSlide.name = aSlidesModel.name
//                        aGroupedSlide.fileName = data.fileName ?? "No name"
//                        if let url = data.htmlFileURL {
//                            //htmlFileURL
//                            aGroupedSlide.filePath = "\(url)"
//                            //.absoluteString
//                        } else {
//                            // Handle the case when data.htmlFileURL is nil
//                            print("htmlFileURL is nil")
//                        }
//
//
//                        // self.extractedFileName ?? "Unknown file"
//                        aGroupedSlide.noofSamples = (aSlidesModel.noofSamples)
//                        // aGroupedSlidedel.effTo = effTo = DateI
//                        aGroupedSlide.ordNo = (aSlidesModel.ordNo)
//                        aGroupedSlide.priority = (aSlidesModel.priority)
//                        aGroupedSlide.slideData = data.fileData ?? Data()
//                        // let type = mimeTypeForData(data: data.fileData ?? Data())
//                        aGroupedSlide.utType = "text/html"
//                        //"text/html"
//                        aGroupedSlide.isSelected = aSlidesModel.isSelected
//                        aGroupedSlideArr.append(aGroupedSlide)
//                        //  }
//
//                    }
//                }
//                tempGroupedBrandsSlideModel.createdDate = aGroupedBrandsSlideModel.createdDate
//                tempGroupedBrandsSlideModel.groupedSlide = aGroupedSlideArr
//                tempGroupedBrandsSlideModel.priority   = aGroupedBrandsSlideModel.priority
//                tempGroupedBrandsSlideModel.updatedDate = aGroupedBrandsSlideModel.updatedDate
//                tempGroupedBrandsSlideModel.divisionCode = aGroupedBrandsSlideModel.divisionCode
//                tempGroupedBrandsSlideModel.productBrdCode = aGroupedBrandsSlideModel.productBrdCode
//                tempGroupedBrandsSlideModel.subdivisionCode = aGroupedBrandsSlideModel.subdivisionCode
//                tempGroupedBrandsSlideModel.createdDate = aGroupedBrandsSlideModel.createdDate
//                tempGroupedBrandsSlideModel.id = aGroupedBrandsSlideModel.id
//                modifiedZipgropedBrandModels.append(tempGroupedBrandsSlideModel)
//            }
//
//            self.groupedBrandsSlideModel?.append(contentsOf: modifiedZipgropedBrandModels)
//
//
//            var completedTaskCount = 0
//            self.groupedBrandsSlideModel?.enumerated().forEach({ index, aGroupedBrandsSlideModel in
//                CoreDataManager.shared.toSaveGeneralGroupedSlidesToCoreData(groupedBrandSlide: aGroupedBrandsSlideModel) { isSaved in
//                    completedTaskCount += 1
//
//                    if completedTaskCount == groupedBrandsSlideModel.count {
//                        completion(true)
//                    }
//                }
//
//            })
//
//
//        }
//    }
    
    
    
    
    
    
    func checkifSyncIsCompleted(_ isFromLaunch: Bool){
        let existingCDSlides: [SlidesModel] = CoreDataManager.shared.retriveSavedSlides()
        let apiFetchedSlide: [SlidesModel] = self.arrayOfAllSlideObjects
        
        if existingCDSlides.count == apiFetchedSlide.count {
            LocalStorage.shared.setBool(LocalStorage.LocalValue.isSlidesLoaded, value: true)
        }
        isSlideDownloadCompleted = true
        self.tableView.isScrollEnabled = true
        if isFromLaunch {
            DispatchQueue.main.async {
                self.dismiss(animated: false) {
                    self.delegate?.didDownloadCompleted()
                }
            }
        }
    }
    
    
    struct UnzippedDataInfo {
        var videofiles: [Videoinfo]
        var imagefiles: [Imageinfo]
        var htmlfiles: [HTMLinfo]
        
        init() {
            self.videofiles = [Videoinfo]()
            self.imagefiles = [Imageinfo]()
            self.htmlfiles = [HTMLinfo]()
        }
    }

    struct Videoinfo {

        var fileData:  Data?
        var filetype: String?
        init() {

            self.fileData = Data()
            self.filetype = String()
        }
    }


    struct Imageinfo {

        var fileData:  Data?
        var filetype: String?
        init() {

            self.fileData = Data()
            self.filetype = String()
        }
    }
    
    struct HTMLinfo {
        var htmlString: String?
        var htmlFileURL: URL?
        var fileData:  Data?
        var fileName: String?
        init() {
            self.htmlString = String()
            self.htmlFileURL = URL(string: "")
            self.fileData = Data()
            self.fileName = String()
        }
    }
    
    func unarchiveAndGetData(from zipData: Data) -> UnzippedDataInfo {

        // Create a unique temporary directory URL
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)

        // Ensure the temporary directory exists
        do {
            try FileManager.default.createDirectory(at: temporaryDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating temporary directory: \(error.localizedDescription)")
        }

        // Path to the ZIP file data
        // let zipData: Data // Replace with your actual zip data
        let zipFilePath = temporaryDirectoryURL.appendingPathComponent("temp.zip")

        // Save the zip data to a temporary file
        do {
            try zipData.write(to: zipFilePath)
        } catch {
            print("Error saving zip data to temporary file: \(error.localizedDescription)")
        }

        // Unzip the file
        do {
            // Get the app's Documents directory
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // Append a subdirectory for your extracted content
                let extractedFolderName = "ExtractedContent"
                let extractedFolderPath = documentsDirectory.appendingPathComponent(extractedFolderName)

                // Ensure the directory exists, create it if needed
                do {
                    try FileManager.default.createDirectory(at: extractedFolderPath, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Error creating directory: \(error.localizedDescription)")
                }


                // Unzip the file from the temporary directory to the Documents directory

                SSZipArchive.unzipFile(atPath: zipFilePath.path, toDestination: extractedFolderPath.path)
                print("File unzipped successfully.")
                var unzippedDataInfo = UnzippedDataInfo()
                var aHTMLinfoArr = [HTMLinfo]()
                var dataArray: Data = Data()

                // Get the contents of the extracted folder
                if let contents = try? FileManager.default.contentsOfDirectory(at: extractedFolderPath, includingPropertiesForKeys: nil, options: []) {
                    // Enumerate through the contents
                    for fileURL in contents {
                        var aHTMLinfo = HTMLinfo()
                        print("File URL: \(fileURL)")
                        print("File Name: \(fileURL.lastPathComponent)")
                        let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
                        print("File Name (without extension): \(fileNameWithoutExtension)")

                        // Create a valid file URL
                        let validFileURL = URL(fileURLWithPath: fileURL.path)
                        let result: (htmlString: String?, htmlFileURL: URL?) = readHTMLFile(inDirectory: validFileURL.path)
                        guard result.htmlFileURL != nil, result.htmlString != nil else {

                            let unzippedFolderURL = URL(fileURLWithPath: extractedFolderPath.absoluteString)
                            let unzippedDataInfo = extractUnzippedDataInfo(from: unzippedFolderURL)

                             return unzippedDataInfo
                        }
                        extractedFileName = fileNameWithoutExtension
                        dataArray = findImageData(inDirectory: validFileURL) ?? Data()
                        aHTMLinfo.fileData = dataArray
                        let fileName = "index.html"
                        aHTMLinfo.htmlFileURL = extractedFolderPath.appendingPathComponent(fileNameWithoutExtension).appendingPathComponent(fileName)
                        //validFileURL
                        aHTMLinfo.htmlString = result.htmlString
                        aHTMLinfo.fileName = extractedFileName
                        aHTMLinfoArr.append(aHTMLinfo)
                        unzippedDataInfo.htmlfiles.append(contentsOf: aHTMLinfoArr)
                        return unzippedDataInfo
                    }
                } else {
                    print("Error getting contents of the extracted folder.")
                }

            }

                do {
                    try FileManager.default.removeItem(at: temporaryDirectoryURL)
                } catch {
                    print("Error removing temporary directory: \(error.localizedDescription)")
                }

        }
        return UnzippedDataInfo()
    }
    
    
//    func unarchiveAndGetData(from zipData: Data) -> HTMLinfo {
//
//        // Create a unique temporary directory URL
//        let temporaryDirectoryURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
//
//        // Ensure the temporary directory exists
//        do {
//            try FileManager.default.createDirectory(at: temporaryDirectoryURL, withIntermediateDirectories: true, attributes: nil)
//        } catch {
//            print("Error creating temporary directory: \(error.localizedDescription)")
//        }
//
//        // Path to the ZIP file data
//        // let zipData: Data // Replace with your actual zip data
//        let zipFilePath = temporaryDirectoryURL.appendingPathComponent("temp.zip")
//
//        // Save the zip data to a temporary file
//        do {
//            try zipData.write(to: zipFilePath)
//        } catch {
//            print("Error saving zip data to temporary file: \(error.localizedDescription)")
//        }
//
//        // Unzip the file
//        do {
//            // Get the app's Documents directory
//            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                // Append a subdirectory for your extracted content
//                let extractedFolderName = "ExtractedContent"
//                let extractedFolderPath = documentsDirectory.appendingPathComponent(extractedFolderName)
//
//                // Ensure the directory exists, create it if needed
//                do {
//                    try FileManager.default.createDirectory(at: extractedFolderPath, withIntermediateDirectories: true, attributes: nil)
//                } catch {
//                    print("Error creating directory: \(error.localizedDescription)")
//                }
//
//
//                // Unzip the file from the temporary directory to the Documents directory
//
//                SSZipArchive.unzipFile(atPath: zipFilePath.path, toDestination: extractedFolderPath.path)
//                print("File unzipped successfully.")
//
//                var aHTMLinfo = HTMLinfo()
//                var dataArray: Data = Data()
//
//                // Get the contents of the extracted folder
//                if let contents = try? FileManager.default.contentsOfDirectory(at: extractedFolderPath, includingPropertiesForKeys: nil, options: []) {
//                    // Enumerate through the contents
//                    for fileURL in contents {
//                        print("File URL: \(fileURL)")
//                        print("File Name: \(fileURL.lastPathComponent)")
//                        let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
//                        print("File Name (without extension): \(fileNameWithoutExtension)")
//
//                        // Create a valid file URL
//                        let validFileURL = URL(fileURLWithPath: fileURL.path)
//
//                        let result: (htmlString: String?, htmlFileURL: URL?) = readHTMLFile(inDirectory: validFileURL.path)
//                        guard result.htmlFileURL != nil, result.htmlString != nil else {
//                             return HTMLinfo()
//                        }
//
//                        extractedFileName = fileNameWithoutExtension
//                        dataArray = findImageData(inDirectory: validFileURL) ?? Data()
//                        aHTMLinfo.fileData = dataArray
//                        let fileName = "index.html"
//                        aHTMLinfo.htmlFileURL = extractedFolderPath.appendingPathComponent(fileNameWithoutExtension).appendingPathComponent(fileName)
//                        //validFileURL
//                        aHTMLinfo.htmlString = result.htmlString
//                        aHTMLinfo.fileName = extractedFileName
//
//                        return aHTMLinfo
//                    }
//                } else {
//                    print("Error getting contents of the extracted folder.")
//                }
//
//            }
//
//                do {
//                    try FileManager.default.removeItem(at: temporaryDirectoryURL)
//                } catch {
//                    print("Error removing temporary directory: \(error.localizedDescription)")
//                }
//
//        }
//        return HTMLinfo()
//    }
    func extractUnzippedDataInfo(from folderURL: URL) -> UnzippedDataInfo {
        var unzippedDataInfo = UnzippedDataInfo()

        do {
            let contents = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: [])
            
            for fileURL in contents {
                let mimeType = mimeTypeForPath(path: fileURL.path)
                
                if mimeType.hasPrefix("video") {
                    var videoInfo = Videoinfo()
                    videoInfo.fileData = try? Data(contentsOf: fileURL)
                    videoInfo.filetype = mimeType
                    unzippedDataInfo.videofiles.append(videoInfo)
                } else if mimeType.hasPrefix("image") {
                    var imageInfo = Imageinfo()
                    imageInfo.fileData = try? Data(contentsOf: fileURL)
                    imageInfo.filetype = mimeType
                    unzippedDataInfo.imagefiles.append(imageInfo)
                }
            }
        } catch {
            print("Error reading contents of the unzipped folder: \(error)")
        }

        return unzippedDataInfo
    }
    
    func readHTMLFile(inDirectory directoryPath: String) -> (htmlString: String?, htmlFileURL: URL?) {
        do {
            // Get the list of files in the directory
            let fileManager = FileManager.default
            let files = try fileManager.contentsOfDirectory(atPath: directoryPath)
            
            // Find the HTML file in the list of files
            if let htmlFileName = files.first(where: { $0.hasSuffix(".html") }) {
                let htmlFilePath = (directoryPath as NSString).appendingPathComponent(htmlFileName)
                let htmlFileURL = URL(fileURLWithPath: htmlFilePath)
                let htmlString = try String(contentsOfFile: htmlFilePath, encoding: .utf8)
                return (htmlString, htmlFileURL)
            } else {
                print("No HTML file found in the directory.")
                return (nil, nil)
            }
        } catch {
            print("Error reading HTML file: \(error)")
            return (nil, nil)
        }
    }
    
    
    
    
    
    
    func findImageData(inDirectory directoryURL: URL) -> Data? {
        let fileManager = FileManager.default
        
        do {
            let contents = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            
            for itemURL in contents {
                // Check if the file is an image file (you can customize this check based on your file types)
                if isImageFile(itemURL) {
                    if let fileData = try? Data(contentsOf: itemURL) {
                        return fileData
                    }
                }
            }
        } catch {
            print("Error while accessing contents of directory: \(error)")
        }
        
        return nil
    }
    
    func isImageFile(_ fileURL: URL) -> Bool {
        let imageFileExtensions = ["jpg", "jpeg", "png", "gif", "bmp"] // Add more extensions as needed

        let fileExtension = fileURL.pathExtension.lowercased()
        return imageFileExtensions.contains(fileExtension)
    }

    func isMediaFile(_ fileURL: URL) -> Bool {
        let mediaFileExtensions = ["jpg", "jpeg", "png"] // Add more extensions as needed
        //, "gif", "mp4", "mov", "avi", "html"
        let fileExtension = fileURL.pathExtension.lowercased()
        return mediaFileExtensions.contains(fileExtension)

    }
    
    func downloadData(mediaURL: String, competion: @escaping (Data?, Error?) -> Void) {
//        let downloader = MediaDownloader()
//        let mediaURL = URL(string: mediaURL)!
//        downloader.downloadMedia(from: mediaURL) { (data, error) in
//            competion(data, error)
//        }
    }
}


extension SlideDownloadVC : tableViewProtocols {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAllSlideObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SlideDownloaderCell", for: indexPath) as! SlideDownloaderCell
        let model = arrayOfAllSlideObjects[indexPath.row]
        cell.lblName.text = arrayOfAllSlideObjects[indexPath.row].filePath
        if model.isDownloadCompleted  {
            cell.toSetupDoenloadedCell(true)
            //indexPath.row == 0 ? false : true
        } else if model.isFailed {
            cell.toSetupErrorCell(false)
        } else {
            cell.toSetupDownloadingCell(false)
        }
        cell.btnRetry.addTap { [weak self] in
            guard let welf = self else {return}
            if welf.toCheckNetworkStatus() {
                welf.toDownloadMedia(index: indexPath.row, items: self?.arrayOfAllSlideObjects ?? [SlidesModel](), isForsingleRetry: true)
            }
        }
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height / 5
    }
    
    
}
