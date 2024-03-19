//
//  PreCallVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 08/08/23.
//

import Foundation
import UIKit

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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell: productSectiontitleTVC = tableView.dequeueReusableCell(withIdentifier: "productSectiontitleTVC", for: indexPath) as! productSectiontitleTVC
            cell.selectionStyle = .none
            return cell

        default:
            let cell: ProductsDescriptionTVC = tableView.dequeueReusableCell(withIdentifier: "ProductsDescriptionTVC", for: indexPath) as! ProductsDescriptionTVC
            cell.selectionStyle = .none
            return cell
        }
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
            fetchPrecall()
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
    
    
    
    
    @IBOutlet var categoryLbl: UILabel!
    
    
    @IBOutlet var specialityLbl: UILabel!
    
    @IBOutlet var specialityTit: UILabel!
    
    
    @IBOutlet var territoryTit: UILabel!
    
    
    @IBOutlet var territoryLbl: UILabel!
    
    
    @IBOutlet var pagetitle: UILabel!
    
    var callresponse: [PrecallsModel]?
    @IBOutlet var productsTable: UITableView!
    var userStatisticsVM: UserStatisticsVM?
    
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
        toloadProductsTable()
        //fetchPrecall()
    }
    
    deinit {
        print("ok bye")
    }

    @IBAction func startDetailingAction(_ sender: UIButton) {
        
        
        let productVC = UIStoryboard.productVC
        productVC.dcrCall = self.dcrCall
        self.navigationController?.pushViewController(productVC, animated: true)
        
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
        
        //let setup = AppDefaults.shared.getAppSetUp()
        var param = [String: Any]()
        param["tableName"] = "getcuslvst"
        param["CusCode"] = "1679478"
        //self.dcrCall.code
        param["typ"] = "D"
        param["sfcode"] =  "MR5940"
        //setup.sfCode
        param["division_code"] =  "63"
        //setup.divisionCode
        param["Rsf"] =  "MR5940"
        //LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)
        param["sf_type"] =  "1"
        //setup.sfType
        param["Designation"] = "MR"
        //setup.desig
        param["state_code"] =  "2"
        //setup.stateCode
        param["subdivision_code"] = "86,"
        //setup.subDivisionCode
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: param)
        
        var toSendData = [String: Any]()
        toSendData["data"] = jsonDatum
        
        userStatisticsVM?.getPrecalls(params: toSendData, api: .getTodayCalls, paramData: param) {  result in
            
            switch result {
                
            case .success(let response):
                dump(response)
                self.callresponse = response
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
}


