//
//  PreCallVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 08/08/23.
//

import Foundation
import UIKit
import CoreData

extension PreCallVC : collectionViewProtocols {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PreviewTypeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewTypeCVC", for: indexPath) as! PreviewTypeCVC
        
        
        cell.selectionView.isHidden =  selectedSegmentsIndex == indexPath.row ? false : true
        cell.titleLbl.textColor =  selectedSegmentsIndex == indexPath.row ? .appTextColor : .appLightTextColor
        cell.titleLbl.text = segmentType[indexPath.row].rawValue
        
        
        
        
        cell.addTap { [weak self] in
            guard let welf = self else {return}
            welf.selectedSegmentsIndex  = indexPath.row
            
            welf.segmentsCollection.reloadData()
            
            
            switch welf.segmentType[welf.selectedSegmentsIndex] {
                
            case .Overview:
                
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
                
            case .Precall :
                
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
                
            }
            
            
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

  
             return CGSize(width:segmentType[indexPath.item].rawValue.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: collectionView.height)
         //   return CGSize(width: collectionView.width / 2, height: collectionView.height)
        
    }
}

extension PreCallVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStrArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell: productSectiontitleTVC = tableView.dequeueReusableCell(withIdentifier: "productSectiontitleTVC", for: indexPath) as! productSectiontitleTVC
            
            cell.selectionStyle = .none
            return cell

        default:
            let cell: ProductsDescriptionTVC = tableView.dequeueReusableCell(withIdentifier: "ProductsDescriptionTVC", for: indexPath) as! ProductsDescriptionTVC
            let model = self.productStrArr[indexPath.row]
            cell.topopulateCell(modelStr: model, isforPreCall: true)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    
}

class PreCallVC : UIViewController {
    
    func cellregistration() {
        productsTable.register(UINib(nibName: "ProductsDescriptionTVC", bundle: nil), forCellReuseIdentifier: "ProductsDescriptionTVC")
        
        productsTable.register(UINib(nibName: "productSectiontitleTVC", bundle: nil), forCellReuseIdentifier: "productSectiontitleTVC")
        
    }
    
    enum SegmentType : String {
        case Overview = "Overview"
        case Precall = "Pre call Analysis"

    }
    func setSegment(_ segmentType: SegmentType, isfromSwipe: Bool? = false) {
        switch segmentType {
            
        case .Overview:
            self.selectedSegmentsIndex = 0
            self.segmentsCollection.reloadData()
            self.overVIewVIew.isHidden = false
            self.preCallVIew.isHidden = true
        case .Precall:
            self.selectedSegmentsIndex = 1
            self.segmentsCollection.reloadData()
            self.overVIewVIew.isHidden = true
            self.preCallVIew.isHidden = false
            if !self.isDatafetched {
                fetchPrecall()
            }
            
        }
    }
    
    func toLoadSegments() {
        segmentsCollection.isScrollEnabled = false
        segmentType = [.Overview , .Precall]
        self.segmentsCollection.register(UINib(nibName: "PreviewTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PreviewTypeCVC")
        segmentsCollection.delegate = self
        segmentsCollection.dataSource = self
        segmentsCollection.reloadData()
        self.setSegment(.Overview)
    }
    
    @IBOutlet weak var viewSegmentControl: UIView!
    
    @IBOutlet var segmentsCollection: UICollectionView!
    
    @IBOutlet var overVIewVIew: ShadowView!
    
    @IBOutlet var preCallVIew: UIView!
    @IBOutlet var nameTitleLbl: UILabel!
    
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var dobTit: UILabel!
    
    
    @IBOutlet var dobLbl: UILabel!
    
    
    @IBOutlet var weddingDateTit: UILabel!
    
    
    @IBOutlet var weddingDateLbl: UILabel!
    
    @IBOutlet var mobileTit: UILabel!
    
    
    @IBOutlet var mobileLbl: UILabel!
    
    
    
    @IBOutlet var emailTit: UILabel!
    
    @IBOutlet var emailLbl: UILabel!
    
    
    @IBOutlet var addressTit: UILabel!
    
    @IBOutlet var addressLbl: UILabel!
    
    
    @IBOutlet var qualificationtit: UILabel!
    
    
    @IBOutlet var qualificationLBl: UILabel!
    
    
    
    @IBOutlet var categoryTit: UILabel!
    
    
    @IBOutlet var btnSkip: UIButton!
    
    
    @IBOutlet var btnStartdetailing: UIButton!
    
    
    @IBOutlet var categoryLbl: UILabel!
    
    
    @IBOutlet var specialityLbl: UILabel!
    
    @IBOutlet var specialityTit: UILabel!
    
    
    @IBOutlet var territoryTit: UILabel!
    
    
    @IBOutlet var territoryLbl: UILabel!
    
    
    @IBOutlet var pagetitle: UILabel!
    
    
    @IBOutlet var precallLastVIsitLbl: UILabel!
    
    @IBOutlet var precallFeedbackLbl: UILabel!
    
    @IBOutlet var precallRemarksLbl: UILabel!
    
    @IBOutlet var precallInputsLbl: UILabel!
    
    @IBOutlet var noProductsLbl: UILabel!
    
    var callresponse: [PrecallsModel]?
    @IBOutlet var productsTable: UITableView!
    var isDatafetched: Bool = false
    var userStatisticsVM: UserStatisticsVM?
    var productStrArr : [SampleProduct] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func toloadProductsTable() {
        productsTable.delegate = self
        productsTable.dataSource = self
        productsTable.reloadData()
    }
    
    func toretriveDCRdata() {
        
        var dcrObject : AnyObject?
        
        switch dcrCall.type {
            
        case .doctor:
            if let  tempdcrObject = dcrCall.call as? DoctorFencing {
                dcrObject = tempdcrObject
            }
        case .chemist:
            if let  tempdcrObject = dcrCall.call as? Chemist {
                dcrObject = tempdcrObject
            }
        case .stockist:
            if let  tempdcrObject = dcrCall.call as? Stockist {
                dcrObject = tempdcrObject
            }
        case .unlistedDoctor:
            if let  tempdcrObject = dcrCall.call as? UnListedDoctor {
                dcrObject = tempdcrObject
            }
        case .hospital:
            print("Yet yo implement")
        case .cip:
            print("Yet yo implement")
        }
        
        
        self.dcrCall = dcrCall.toRetriveDCRdata(dcrcall: dcrObject ?? nil)
        
        
        topopulateVIew(dcrCall: self.dcrCall)
        
    }
    
    
    func topopulateVIew(dcrCall : CallViewModel) {
      
        switch  dcrCall.type {
            
           
        case .doctor:
            pagetitle.text = dcrCall.name == "" ? "DCR details" :  dcrCall.name
            nameLbl.text = dcrCall.name == "" ? "-" :  dcrCall.name
            dobLbl.text =  dcrCall.dob == "" ? "-" :  dcrCall.dob
            weddingDateLbl.text =  dcrCall.dow == "" ? "-" :  dcrCall.dob
            mobileLbl.text = dcrCall.mobile == "" ? "-" :  dcrCall.mobile
            emailLbl.text = dcrCall.email == "" ? "-" :  dcrCall.email
            addressLbl.text = dcrCall.address == "" ? "-" :  dcrCall.address
            qualificationLBl.text = dcrCall.qualification == "" ? "-" :  dcrCall.qualification
            categoryLbl.text = dcrCall.category == "" ? "-" :  dcrCall.category
            territoryLbl.text = dcrCall.territory == "" ? "-" :  dcrCall.territory
            
        case .chemist:
            pagetitle.text = dcrCall.name == "" ? "DCR details" :  dcrCall.name
            nameLbl.text = dcrCall.name == "" ? "-" :  dcrCall.name
            dobLbl.text =  dcrCall.dob == "" ? "-" :  dcrCall.dob
            weddingDateLbl.text = dcrCall.dow == "" ? "-" :  dcrCall.dob
            mobileLbl.text = dcrCall.mobile == "" ? "-" :  dcrCall.mobile
            emailLbl.text = dcrCall.email == "" ? "-" :  dcrCall.email
            addressLbl.text = dcrCall.address == "" ? "-" :  dcrCall.address
            qualificationLBl.text = dcrCall.qualification == "" ? "-" :  dcrCall.qualification
            categoryLbl.text = dcrCall.category == "" ? "-" :  dcrCall.category
            territoryLbl.text = dcrCall.territory == "" ? "-" :  dcrCall.territory
        case .stockist:
            pagetitle.text = dcrCall.name == "" ? "DCR details" :  dcrCall.name
            nameLbl.text = dcrCall.name == "" ? "-" :  dcrCall.name
            dobLbl.text =  dcrCall.dob == "" ? "-" :  dcrCall.dob
            weddingDateLbl.text = dcrCall.dow == "" ? "-" :  dcrCall.dob
            mobileLbl.text = dcrCall.mobile == "" ? "-" :  dcrCall.mobile
            emailLbl.text = dcrCall.email == "" ? "-" :  dcrCall.email
            addressLbl.text = dcrCall.address == "" ? "-" :  dcrCall.address
            qualificationLBl.text = dcrCall.qualification == "" ? "-" :  dcrCall.qualification
            categoryLbl.text = dcrCall.category == "" ? "-" :  dcrCall.category
            territoryLbl.text = dcrCall.territory == "" ? "-" :  dcrCall.territory
        case .unlistedDoctor:
            pagetitle.text = dcrCall.name == "" ? "DCR details" :  dcrCall.name
            nameLbl.text = dcrCall.name == "" ? "-" :  dcrCall.name
            dobLbl.text = dcrCall.dob == "" ? "-" :  dcrCall.dob
            weddingDateLbl.text = dcrCall.dow == "" ? "-" :  dcrCall.dob
            mobileLbl.text = dcrCall.mobile == "" ? "-" :  dcrCall.mobile
            emailLbl.text = dcrCall.email == "" ? "-" :  dcrCall.email
            addressLbl.text = dcrCall.address == "" ? "-" :  dcrCall.address
            qualificationLBl.text = dcrCall.qualification == "" ? "-" :  dcrCall.qualification
            categoryLbl.text = dcrCall.category == "" ? "-" :  dcrCall.category
            territoryLbl.text = dcrCall.territory == "" ? "-" :  dcrCall.territory
        case .hospital:
            print("Yet to implement")
        case .cip:
            print("Yet to implement")
        }
    }
    
    
    var segmentType: [SegmentType] = []
    private var segmentControl : UISegmentedControl!
    var selectedSegmentsIndex: Int = 0
    var dcrCall : CallViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //updateSegment()
        toretriveDCRdata()
        toLoadSegments()
        cellregistration()
        noProductsLbl.isHidden = true
       // toloadProductsTable()
        //fetchPrecall()
        setupUI()
    }
    
    func setupUI() {
        
        btnSkip.layer.cornerRadius = 5
        btnSkip.layer.borderWidth = 1
        btnSkip.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.2).cgColor
        btnSkip.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        
        
        btnStartdetailing.layer.cornerRadius = 5
        btnStartdetailing.backgroundColor = .appTextColor

    }
    @IBAction func skipDetailingAction(_ sender: Any) {
        let vc = AddCallinfoVC.initWithStory(viewmodel: self.userStatisticsVM ?? UserStatisticsVM())
        vc.dcrCall = self.dcrCall
        
        CoreDataManager.shared.tofetchaSavedCalls(callID: self.dcrCall.code) { addedDCRcall in
            
       
            
            dump(addedDCRcall)
            
            
            let context = self.context
            let ftchedDCRcall = addedDCRcall?.first
            
            
            
            
            
            //Input
            if let inputEntityDescription  = NSEntityDescription.entity(forEntityName: "InputViewModelCDEntity", in: context) {
                let inputDetailsCDEntity = ftchedDCRcall?.inputViewModel ?? InputViewModelCDEntity(entity: inputEntityDescription, insertInto: context)
                
                let inputSelectedListViewModel = InputSelectedListViewModel()
                inputSelectedListViewModel.uuid = inputDetailsCDEntity.uuid
                
                var inputViewModelArr =  [InputViewModel]()
                if let inputViewModelCDArr = inputDetailsCDEntity.inputViewModelArr {
                    inputViewModelCDArr.forEach { inputDataCDModel in
                        var aProductData = InputData(availableCount: "", inputCount: "")
                        if let ainputDataCDModel = inputDataCDModel as? InputDataCDModel {
                          
                            aProductData.availableCount = ainputDataCDModel.availableCount ?? ""
                            aProductData.inputCount = ainputDataCDModel.inputCount ?? ""
                            aProductData.input = aProductData.input
                            
                          let inputViewModel = InputViewModel(input: aProductData)
                          inputViewModelArr.append(inputViewModel)
                        }
                    }
                }
                inputSelectedListViewModel.inputViewModel = inputViewModelArr
                vc.inputSelectedListViewModel = inputSelectedListViewModel
            }
            
            //Product
            if let producEntityDescription  = NSEntityDescription.entity(forEntityName: "ProductViewModelCDEntity", in: context) {
                let productDetailsCDEntity = ftchedDCRcall?.productViewModel ?? ProductViewModelCDEntity(entity: producEntityDescription, insertInto: context)
                ///ProductSelectedListViewModel
                
                let productSelectedListViewModel = ProductSelectedListViewModel()
                productSelectedListViewModel.uuid = productDetailsCDEntity.uuid
                
                
                var productViewModelArr =  [ProductViewModel]()
                
                if let productViewModelCDArr =  productDetailsCDEntity.productViewModelArr {
                    productViewModelCDArr.forEach { productDetailsCDModel in
                        var aProductData = ProductData(isDetailed: false, sampleCount: "", rxCount: "", rcpaCount: "", availableCount: "", totalCount: "", stockistName: "", stockistCode: "")
                
                        if let aproductDetailsCDModel = productDetailsCDModel as? ProductDataCDModel {
                            
                            aProductData.product = aproductDetailsCDModel.product
                            
                            aProductData.availableCount = aproductDetailsCDModel.availableCount ?? ""
                            aProductData.isDetailed = aproductDetailsCDModel.isDetailed
                            aProductData.rcpaCount = aproductDetailsCDModel.rcpaCount ?? ""
                            aProductData.rxCount = aproductDetailsCDModel.rxCount ?? ""
                            aProductData.sampleCount = aproductDetailsCDModel.sampleCount ?? ""
                            aProductData.stockistCode = aproductDetailsCDModel.stockistCode ?? ""
                            aProductData.stockistName = aproductDetailsCDModel.stockistName ?? ""
                            aProductData.totalCount = aproductDetailsCDModel.totalCount ?? ""
                            
                            let productViewModel = ProductViewModel(product: aProductData)
                            productViewModelArr.append(productViewModel)
                        }
                    }
                }
                productSelectedListViewModel.productViewModel = productViewModelArr
                vc.productSelectedListViewModel = productSelectedListViewModel
            }
            
            
            //RCPA
            if let rcpaEntityDescription = NSEntityDescription.entity(forEntityName: "RCPAdetailsCDEntity", in: context) {
                // dispatchGroup.enter()
                let rcpaDetailsCDEntity = ftchedDCRcall?.rcpaDetailsModel ?? RCPAdetailsCDEntity(entity: rcpaEntityDescription, insertInto: context)
                
                
                ///[RCPAdetailsModal]
                var rcpaDetailsModelArr = [RCPAdetailsModal]()

                if let rcpaDetailsCDModelArr = rcpaDetailsCDEntity.rcpadtailsCDModelArr  {
                    
                    rcpaDetailsCDModelArr.forEach { aRCPAdetailsCDModel in
                        
                        ///RCPAdetailsModal
                        let rcpaDetailsModel =  RCPAdetailsModal()
                        
                        if let aRCPAdetailsCDModel = aRCPAdetailsCDModel as? RCPAdetailsCDModel {
                            let addedChemist = aRCPAdetailsCDModel.addedChemist
                            rcpaDetailsModel.addedChemist = addedChemist
                            
                            ///ProductDetails
                            var aproductDetails = ProductDetails()
                            
                            if let  productDetailsCDModel = aRCPAdetailsCDModel.addedProductDetails {
                          
                                
                                aproductDetails.addedQuantity = productDetailsCDModel.addedQuantity
                                aproductDetails.addedRate =   productDetailsCDModel.addedRate
                                aproductDetails.addedTotal = productDetailsCDModel.addedTotal
                                aproductDetails.addedValue =  productDetailsCDModel.addedValue
                              
                                ///[ProductWithCompetiors]
                                var  addedProductsArr = [ProductWithCompetiors]()
                                
                                if let addedProductArr = productDetailsCDModel.addedProductArr {
                                    addedProductArr.forEach { addedProductWithCompetitor in
                                        
                                        ///ProductWithCompetiors
                                        var addedProduct = ProductWithCompetiors()
                                        
                                        if let addedProductWithCompetitor = addedProductWithCompetitor as? ProductWithCompetiorsCDModel {
        
                                            addedProduct.addedProduct = addedProductWithCompetitor.addedProduct
                                            
                                            ///AdditionalCompetitorsInfo
                                            var additionalCompetitorsInfoArr =  [AdditionalCompetitorsInfo]()
                                            
                                            if let competitorsInfoArr = addedProductWithCompetitor.competitorsInfoArr {
                                                competitorsInfoArr.forEach { additionalCompetitorsInfoCDModel in
                                                    
                                                    if let additionalCompetitorsInfoCDModel = additionalCompetitorsInfoCDModel as? AdditionalCompetitorsInfoCDModel {
                                                        
                                                        ///AdditionalCompetitorsInfo
                                                        
                                                        var additionalCompetitorsInfo = AdditionalCompetitorsInfo()
                                                        
                                                        additionalCompetitorsInfo.competitor =  additionalCompetitorsInfoCDModel.competitor
                                                        additionalCompetitorsInfo.qty =  additionalCompetitorsInfoCDModel.qty
                                                        additionalCompetitorsInfo.rate = additionalCompetitorsInfoCDModel.rate
                                                        additionalCompetitorsInfo.remarks = additionalCompetitorsInfoCDModel.remarks
                                                        additionalCompetitorsInfo.value = additionalCompetitorsInfoCDModel.value
                                                        additionalCompetitorsInfoArr.append(additionalCompetitorsInfo)
                                                    }
                                                }
                                                addedProduct.competitorsInfo = additionalCompetitorsInfoArr
                                            }
                                           
                                        }
                                        addedProductsArr.append(addedProduct)
                                        
                                    }
                                    aproductDetails.addedProduct = addedProductsArr
                                }
                                
                                rcpaDetailsModel.addedProductDetails = aproductDetails
                            }
                        }
                        rcpaDetailsModelArr.append(rcpaDetailsModel)
                    }
                    
                }
                 dump(rcpaDetailsModelArr)
                vc.rcpaDetailsModel = rcpaDetailsModelArr
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
          //  vc.eventCaptureListViewModel = ftchedDCRcall.eve
          //  vc.jointWorkSelectedListViewModel = ftchedDCRcall?.jointWorkViewModel
           // vc.productSelectedListViewModel = ftchedDCRcall?.productViewModel
          //  vc.additionalCallListViewModel = ftchedDCRcall?.additionalCallViewModel
        
            
            
        }
        
   
        
        
    }
    
//    func toRetriveRCPAfromCDentity(rcpaEntity: RCPAdetailsCDEntity) {
//        
//        RCPAdetailsCDEntity.
//        
//        
//    }
    
    @IBAction func startDetailingAction(_ sender: UIButton) {
        
        let vc = PreviewHomeVC.initWithStory(previewType: .detailing, dcrCall: self.dcrCall)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupPrecallsinfo() {
        
    }
    
    func fetchPrecall() {
        //getTodayCalls
        
       // {"tableName":"getcuslvst","typ":"D","CusCode":"1679478","sfcode":"MR5940","division_code":"63,","Rsf":"MR5940","sf_type":"1","Designation":"MR","state_code":"2","subdivision_code":"86,"}
        self.userStatisticsVM = UserStatisticsVM()
        
        let setup = AppDefaults.shared.getAppSetUp()
        var param = [String: Any]()
        param["tableName"] = "getcuslvst"
        param["CusCode"] = self.dcrCall.code

        param["typ"] = "D"
        param["sfcode"] =  setup.sfCode

        param["division_code"] =  setup.divisionCode
 
        param["Rsf"] =   LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)
  
        param["sf_type"] =  setup.sfType

        param["Designation"] = setup.desig
 
        param["state_code"] =  setup.stateCode
  
        param["subdivision_code"] = "\(setup.subDivisionCode!),"

        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        userStatisticsVM?.getPrecalls(params: toSendData, api: .getTodayCalls, paramData: param) {  result in
            
            switch result {
                
            case .success(let response):
                dump(response)
                self.callresponse = response
                self.toPopulateView()
                self.isDatafetched = true
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
    func toPopulateView() {
        
        guard let callresponse = self.callresponse?.first else {return}
        
      let cleanedResponse = callresponse.inputs == "( 0 )," ? "No inputs" : callresponse.inputs
        
        self.precallInputsLbl.text = cleanedResponse
        self.precallRemarksLbl.text = callresponse.remarks.isEmpty ? "No remarks" : callresponse.remarks
        self.precallFeedbackLbl.text = callresponse.feedback.isEmpty ? "No feedback" : callresponse.feedback
      
        let rawDate = callresponse.visitDate.date.toDate(format: "yyyy-MM-dd HH:mm:ss")
        self.precallLastVIsitLbl.text = rawDate.toString(format:  "yyyy-MM-dd HH:mm:ss")
        
        toSetDataSourceForProducts(detailedReportModel: callresponse)
    }
    
    
    func toSetDataSourceForProducts(detailedReportModel: PrecallsModel?) {
        productStrArr.removeAll()
        productStrArr.append(SampleProduct(prodName: "", isPromoted: false, noOfSamples: "", rxQTY: "", rcpa: "", isDemoProductCell: true, remarks: "No remarks found."))
        
       if detailedReportModel?.sampleProduct != "" {
           var prodArr =  detailedReportModel?.sampleProduct.components(separatedBy: ",")
           if prodArr?.last == "" {
               prodArr?.removeLast()
           }
           let filteredComponents = prodArr?.map { anElement -> String in
               var modifiedElement = anElement
               if modifiedElement.first == " " {
                   modifiedElement.removeFirst()
               }
               return modifiedElement
           }
           
           
           filteredComponents?.forEach { prod in
               var prodString : [String] = []
               prodString.append(contentsOf: prod.components(separatedBy: "("))
               prodString = prodString.map({ aprod in
                   aprod.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
               })
               var name: String = ""
               var isPromoted: Bool = false
               var noOfsamples: String = ""
               var rxQty: String = ""
               var rcpa: String  = ""
               prodString.enumerated().forEach {prodindex, prod in
                   
                   // let sampleProduct: SampleProduct
                   switch prodindex {
                   case 0 :
                       name = prod
                   case 1:
                       noOfsamples = prod
                   case 2:
                       rxQty = prod
                   case 3:
                       if let index = prod.firstIndex(of: "^") {
                           let startIndex = prod.index(after: index)
                           let numberString = String(prod[startIndex...])
                           rcpa = numberString
                           print(numberString) // This will print "5"
                       } else {
                           print("'^' not found in the expression.")
                           rcpa = "-"
                       }
                       
                       
                   default:
                       print("default")
                   }
               }
               
               let aProduct = SampleProduct(prodName: name, isPromoted: isPromoted, noOfSamples: noOfsamples, rxQTY: rxQty, rcpa: rcpa, isDemoProductCell: false, remarks: detailedReportModel?.remarks ?? "")
               productStrArr.append(aProduct)
           }
           
           
       } else {
           productStrArr.append(SampleProduct(prodName: "-", isPromoted: false, noOfSamples: "-", rxQTY: "-", rcpa: "-", isDemoProductCell: true, remarks: "No remarks found"))
       }

        
        //productStrArr.append(contentsOf: detailedReportModel?.products.components(separatedBy: ",") ?? [])
  
        
        toloadProductsTable()
         
    }
    
}




extension PreCallVC:  PreviewHomeViewDelegate {
    func didUserDetailedSlide() {
        self.skipDetailingAction(self.btnSkip!)
    }
    
    
}
