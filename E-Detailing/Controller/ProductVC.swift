//
//  ProductVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 09/08/23.
//

import Foundation
import UIKit
import Alamofire


class ProductVC : UIViewController {
    
   
    @IBOutlet weak var txtSearchForProduct: UITextField!
    @IBOutlet weak var txtSearchForInput: UITextField!
    @IBOutlet weak var txtSearchForJointWork: UITextField!
    @IBOutlet weak var txtSearchForAdditionalCall: UITextField!
    @IBOutlet weak var txtSearchForFeedback: UITextField!
    
    
    
    @IBOutlet weak var txtRcpaQty: UITextField!
    @IBOutlet weak var txtRcpaRate: UITextField!
    @IBOutlet weak var txtRcpaTotal: UITextField!
    
    
    
    @IBOutlet weak var lblChemistName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    
    
    @IBOutlet weak var btnAddCompetitor: UIButton!
    @IBOutlet weak var btnRcpaChemist: UIButton!
    @IBOutlet weak var btnRcpaProduct: UIButton!
    
    
    
    @IBOutlet weak var viewSegmentControl: UIView!
    
    
    
    @IBOutlet weak var ProductTableView: UITableView!
    @IBOutlet weak var productRatingTableView: UITableView!
    @IBOutlet weak var productSampleTableView: UITableView!
    
    
    
    @IBOutlet weak var inputListTableView: UITableView!
    @IBOutlet weak var inputSampleTableView: UITableView!
    
    
    @IBOutlet weak var jointWorkListTableView: UITableView!
    @IBOutlet weak var jointWorkSelectedListTableView: UITableView!
    
    
    @IBOutlet weak var additionalCallListTableView: UITableView!
    @IBOutlet weak var additionalCallSelectedTableView: UITableView!
    
    
    @IBOutlet weak var feedbackListTableView: UITableView!
    
    
    @IBOutlet weak var feedbackSelectedListTableView: UITableView!
    
    
    
    @IBOutlet weak var rcpaCompetitorTableView: UITableView!
    
    
    @IBOutlet weak var viewProduct: UIView!
    @IBOutlet weak var viewInput: UIView!
    @IBOutlet weak var viewJointWork: UIView!
    @IBOutlet weak var viewAdditionalCalls: UIView!
    @IBOutlet weak var viewRCPA: UIView!
    @IBOutlet weak var viewFeedback: UIView!
    
    
    @IBOutlet weak var viewRcpaChemist: UIView!
    @IBOutlet weak var viewRcpaProduct: UIView!
    
    
    @IBOutlet weak var viewRcpa: UIView!
    
    
    
    private var productSegmentControl : UISegmentedControl!
    
    var dcrCall : CallViewModel!
    
    var products = [Product]()
    
    var feedback = [Feedback]()
    
    var selectedChemistRcpa : AnyObject!
    
    var selectedProductRcpa : AnyObject!
    
    private var inputSelectedListViewModel = InputSelectedListViewModel()
    private var jointWorkSelectedListViewModel = JointWorksListViewModel()
    private var addittionalCallListViewModel = AdditionalCallsListViewModel()
    
    private var rcpaCallListViewModel = RcpaListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
        
        [txtSearchForProduct,txtSearchForInput,txtSearchForJointWork,txtSearchForAdditionalCall,txtSearchForFeedback].forEach { txtfield in
            txtfield.setIcon(UIImage(imageLiteralResourceName: "searchIcon"))
        }
        
        [viewRcpaChemist,viewRcpaProduct,txtRcpaQty,txtRcpaRate,txtRcpaTotal].forEach { view in
            view.layer.borderColor = AppColors.primaryColorWith_40per_alpha.cgColor
            view.layer.borderWidth = 1.5
            view.layer.cornerRadius = 8
            
        }
        
        
        self.products = DBManager.shared.getProduct()
        self.feedback = DBManager.shared.getFeedback()
        
        updateSegment()
        
        
    }
    
    func registerTableViewCell() {
        
        self.ProductTableView.register(UINib(nibName: "ProductNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameTableViewCell")
        
        self.productRatingTableView.register(UINib(nibName: "ProductRatingTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductRatingTableViewCell")
        
        self.productSampleTableView.register(UINib(nibName: "ProductSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductSampleTableViewCell")
        
        self.inputListTableView.register(UINib(nibName: "ProductNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameTableViewCell")
        
        self.inputSampleTableView.register(UINib(nibName: "InputSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "InputSampleTableViewCell")
        
        self.jointWorkListTableView.register(UINib(nibName: "ProductNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameTableViewCell")
        
        self.jointWorkSelectedListTableView.register(UINib(nibName: "InputSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "InputSampleTableViewCell")
        
        self.additionalCallListTableView.register(UINib(nibName: "ProductNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameTableViewCell")
        
        self.additionalCallSelectedTableView.register(UINib(nibName: "InputSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "InputSampleTableViewCell")
        
        self.feedbackListTableView.register(UINib(nibName: "ProductNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameTableViewCell")
        
        self.rcpaCompetitorTableView.register(UINib(nibName: "RcpaTableViewCell", bundle: nil), forCellReuseIdentifier: "RcpaTableViewCell")
        
        
        
    }
    
    
    deinit {
        print("ok bye")
    }
    
    private func updateSegment() {
        
        let segments = ["Products", "Inputs" , "Joint Work" , "Additional Calls" , "RCPA" ,"Feedback"]
        
        self.productSegmentControl = UISegmentedControl(items: segments)
        
        self.productSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.productSegmentControl.selectedSegmentIndex = 0
        self.productSegmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        
        self.viewSegmentControl.addSubview(self.productSegmentControl)
        
        let font = UIFont(name: "Satoshi-Bold", size: 18)!
        self.productSegmentControl.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
        self.productSegmentControl.highlightSelectedSegment1()
         
        
        self.productSegmentControl.topAnchor.constraint(equalTo: self.viewSegmentControl.topAnchor).isActive = true
        self.productSegmentControl.leadingAnchor.constraint(equalTo: self.viewSegmentControl.leadingAnchor, constant: 20).isActive = true
        self.productSegmentControl.heightAnchor.constraint(equalTo: self.viewSegmentControl.heightAnchor, multiplier: 0.7).isActive = true
        
        let lblUnderLine = UILabel()
        lblUnderLine.backgroundColor = AppColors.primaryColorWith_25per_alpha
        lblUnderLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewSegmentControl.addSubview(lblUnderLine)
        
        lblUnderLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        lblUnderLine.topAnchor.constraint(equalTo: self.productSegmentControl.bottomAnchor, constant: 0).isActive = true
        lblUnderLine.leadingAnchor.constraint(equalTo: self.viewSegmentControl.leadingAnchor, constant: 20).isActive = true
        lblUnderLine.trailingAnchor.constraint(equalTo: self.viewSegmentControl.trailingAnchor, constant: -20).isActive = true
        
    }
    
    @objc func segmentControlAction (_ sender : UISegmentedControl){
        
        self.productSegmentControl.underlinePosition()
        
        
        switch self.productSegmentControl.selectedSegmentIndex {
            case 0:
                self.viewProduct.isHidden = false
                [viewInput,viewJointWork,viewAdditionalCalls,viewRCPA,viewFeedback].forEach({$0.isHidden = true})
            
//                self.ProductTableView.reloadData()
//                self.productSampleTableView.reloadData()
//                self.productRatingTableView.reloadData()
            case 1 :
                self.viewInput.isHidden = false
                [viewProduct,viewJointWork,viewAdditionalCalls,viewRCPA,viewFeedback].forEach({$0.isHidden = true})
                
//                self.inputListTableView.reloadData()
//                self.inputSampleTableView.reloadData()
            
            case 2 :
                self.viewJointWork.isHidden = false
                [viewProduct,viewInput,viewAdditionalCalls,viewRCPA,viewFeedback].forEach({$0.isHidden = true})
                
//                self.jointWorkListTableView.reloadData()
//                self.jointWorkSelectedListTableView.reloadData()
            case 3 :
                self.viewAdditionalCalls.isHidden = false
                [viewProduct,viewInput,viewJointWork,viewRCPA,viewFeedback].forEach({$0.isHidden = true})
                    
//                self.additionalCallListTableView.reloadData()
//                self.additionalCallSelectedTableView.reloadData()
            case 4 :
                self.viewRCPA.isHidden = false
                [viewProduct,viewInput,viewJointWork,viewAdditionalCalls,viewFeedback].forEach({$0.isHidden = true})
            case 5:
                self.viewFeedback.isHidden = false
                [viewProduct,viewInput,viewJointWork,viewRCPA,viewAdditionalCalls].forEach({$0.isHidden = true})
            
                self.feedbackListTableView.reloadData()
            default:
                break
        }
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func closeRcpaAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1.5) {
            self.viewRcpa.isHidden = true
        }
        
    }
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let urlStr = AppDefaults.shared.webUrl + AppDefaults.shared.iosUrl + "save/dcr"
        
        
        let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
        
        
        let timesLine = ["sTm" : "" , "eTm" : ""]
        
        let slides : [String : Any] = ["Slide" : "", "SlidePath" : "", "SlideRemarks" : "", "SlideType" : "", "SlideRating" : "", "Times" : "times"]
        
        let times = ["eTm" : "", "sTm" : ""]
        
        let product : [String : Any] = ["Code" : "" , "Name" : "", "Group" : "", "ProdFeedbk" : "", "Rating" : "", "Timesline" : "timesLine", "Appver" : "", "Mod" : "", "SmpQty" : "", "RxQty" : "" , "prdfeed" : "", "Type" : "", "StockistName" : "", "StockistCode" : "", "Slides" : "slides"]
        
        
        
        var productData = [[String : Any]]()
        var inputData = [[String : Any]]()
        var jointWorkData = [[String : Any]]()
        var additionalCallData = [[String : Any]]()
        
        
        let inputValue = self.inputSelectedListViewModel.inputData()
        let jointWorkValue = self.jointWorkSelectedListViewModel.getJointWorkData()
        let additionalCallValue = self.addittionalCallListViewModel.getAdditionalCallData()
        
        
        
        for input in inputValue{
            
            let input = ["Code" : input.code , "Name" : input.name, "IQty" : input.inputCount]
            inputData.append(input)
        }
        
        for jointWork in jointWorkValue{
            let jointWork = ["Code" : jointWork.code , "Name" : jointWork.name]
            jointWorkData.append(jointWork)
        }
        
        for call in additionalCallValue {
            let adcuss = ["Code" : call.code, "Name" : call.name,"town_code" : call.townCode ,"town_name" : call.townName]
            additionalCallData.append(adcuss)
        }
        
        let divisionCode = appsetup.divisionCode!.replacingOccurrences(of: ",", with: "")
        
        var cusType : String = "" 
        
        switch dcrCall.type {
            
        case .doctor:
            cusType = "1"
        case .chemist:
            cusType = "2"
        case .stockist:
            cusType = "3"
        case .unlistedDoctor:
            cusType = "4"
        case .hospital:
            cusType = "5"
        case .cip:
            cusType = "6"
        }
        
        
        let params : [String : Any] = ["JointWork" : jointWorkData,
                      "Inputs": inputData,
                      "Products" : productData,
                      "AdCuss" : additionalCallData,
                      "CateCode" : dcrCall.cateCode,
                      "CusType" : cusType,
                      "CustCode" : dcrCall.code,
                      "CustName" : dcrCall.name,
                      "Entry_location" : "0.0:0.0",
                      "address" : "Address not Found",
                      "sfcode" : appsetup.sfCode ?? "",
                      "Rsf" : appsetup.sfCode ?? "",
                      "sf_type" : "\(appsetup.sfType ?? 0)" ,
                      "Designation" : appsetup.dsName ?? "",
                      "state_code" : appsetup.stateCode ?? "",
                      "subdivision_code" : appsetup.subDivisionCode ?? "",
                      "division_code" : divisionCode,
                      "AppUserSF" : appsetup.sfCode ?? "",
                      "SFName" : appsetup.sfName ?? "",
                      "SpecCode" : dcrCall.specialityCode ,
                      "mappedProds" : "",
                      "mode" : "0",
                      "Appver" : "iEdet.1.1",
                      "Mod" : "ios-Edet-New",
                      "WT_code" : "2748",
                      "WTName" : "Field Work",
                      "FWFlg" : "F",
                       "town_code" : dcrCall.townCode,
                       "town_name" : dcrCall.townName,
                      "ModTime" : date,
                      "ReqDt" : date,
                      "vstTime" : date,
                      "Remarks" : "",
                      "amc"  : "",
                      "sign_path" : "",
                      "SignImageName" : "",
                      "filepath" : "",
                      "EventCapture" : "",
                      "EventImageName" : "",
                      "DCSUPOB" : "",
                      "Drcallfeedbackcode" : "",
                      "sample_validation" : "0",
                      "input_validation" : "0"
        ]
        
        print(urlStr)
        print(params.toString())
        
        let param = ["data" : params.toString()]
        
        print(param)
        
        AF.request(urlStr,method: .post,parameters: param).responseData(){ (response) in
            
            switch response.result {
                
                case .success(_):
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        let date1 = Date()
                        
                        print(date1)
        
                        print("ssususnbjbo")
                        print(apiResponse)
                        print("ssusus")
                        
//                        let status = self.getStatus(json: apiResponse)
//
//                        if status.isOk {
//
//                            AppDefaults.shared.save(key: .appSetUp, value: status.info)
//
//                            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                                appDelegate.setupRootViewControllers()
//                            }
//                        }
                        
                    }catch {
                        print(error)
                    }
                case .failure(let error):
                
                    ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                    print(error)
                    return
            }
            
            print("2")
            print(response)
            print("2")
        }
        
        
       
//        {"JointWork":[{"Code":"MR1932","Name":"SATHISH MR 2"}],"Inputs":[{"Code":"170","Name":"PERFUME","IQty":"1"}],
//        "Products":[{"Code":"1068","Name":"DOLO","Group":"1","ProdFeedbk":"okay","Rating":"3.0","Timesline":{"sTm":"2023-06-28 11:49:36","eTm":"2023-06-28 11:49:37"},
//        "Appver":"V2.0.7","Mod":"Android-Edet","SmpQty":"","RxQty":"","prdfeed":"","Type":"D","StockistName":"StockistName","StockistCode":"StockistCode",
//        "Slides":[{"Slide":"CC_VA_2021_20.jpg","SlidePath":"\/data\/user\/0\/saneforce.sanclm\/cache\/images\/CC_VA_2021_20.jpg","SlideRemarks":"","SlideType":"I",
//        "SlideRating":"3.0","Times":[{"eTm":"2023-06-28 11:49:37","sTm":"2023-06-28 11:49:36"}]}]},{"Code":"1067","Name":"AMOXY","Group":"1","ProdFeedbk":"fine","Rating":"4.0",
//        "Timesline":{"sTm":"2023-06-28 11:49:37","eTm":"2023-06-28 11:49:39"},"Appver":"V2.0.7","Mod":"Android-Edet","SmpQty":"","RxQty":"","prdfeed":"","Type":"D",
//        "StockistName":"StockistName","StockistCode":"StockistCode","Slides":[{"Slide":"Pelvic_acetabula.pdf",
//        "SlidePath":"\/storage\/emulated\/0\/Documents\/ProductsMGR057120230628114730\/Pelvic_acetabula.pdf","SlideRemarks":"","SlideType":"P",
//        "SlideRating":"3.0","Times":[{"eTm":"2023-06-28 11:49:39","sTm":"2023-06-28 11:49:37"}]}]},{"Code":"767","Name":"Paracetamal sale","Group":"0",
//        "ProdFeedbk":"","Rating":"","Timesline":{"sTm":"2023-06-28 00:00:00","eTm":"2023-06-28 00:00:00"},"Appver":"V2.0.7","Mod":"Android-Edet","SmpQty":"00","RxQty":"5",
//        "prdfeed":"","Type":"D","StockistName":"StockistName","StockistCode":"StockistCode","Slides":[]},{"Code":"768","Name":"Alegra sample","Group":"0","ProdFeedbk":"","Rating":"",
//        "Timesline":{"sTm":"2023-06-28 00:00:00","eTm":"2023-06-28 00:00:00"},"Appver":"V2.0.7","Mod":"Android-Edet","SmpQty":"52","RxQty":"00","prdfeed":"",
//        "Type":"C","StockistName":"StockistName","StockistCode":"StockistCode","Slides":[]}],"AdCuss":[{"Code":"616454","Name":"D MOHADE","town_code":"57717","town_name":"VISHAG"},
//        {"Code":"616515","Name":"R S MUTHAL","town_code":"57716","town_name":"CHITTOOR"}],"CateCode":"3","CusType":"1","CustCode":"616519",
//        "CustName":"A KHARDE","Entry_location":"13.0300254:80.2414182",
//        "address":"No 4, Pasumpon Muthuramalinga Thevar Rd, Nandanam Extension, Nandanam, Chennai, Tamil Nadu 600035, India",
//        "sfcode":"MR0026","Rsf":"MR0026","sf_type":"1","Designation":"TBM","state_code":"28","subdivision_code":"62,","division_code":"1,","AppUserSF":"MR1932","SFName":"GOKUL ASM","SpecCode":"2",
//        "mappedProds":"","mode":"0","Appver":"V2.0.7","Mod":"Android-Edet","WT_code":"6","WTName":"Field Work","FWFlg":"F","town_code":"57716","town_name":"CHITTOOR","ModTime":"2023-06-28 11:51:40",
//        "ReqDt":"2023-06-28 11:51:40","vstTime":"2023-06-28 11:51:40","Remarks":"check data","amc":"","sign_path":"\/storage\/emulated\/0\/Documents\/Pictures\/paint_1687933287809.png",
//        "filepath":"\/storage\/emulated\/0\/Android\/data\/saneforce.sanclm\/cache\/pickImageResult1687933264580.jpeg","EventCapture":"true",
//        "DCSUPOB":"25","Drcallfeedbackcode":"","sample_validation":"0","input_validation":"0"}
        
        
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func addRcpaAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1.5) {
            
            self.viewRcpa.isHidden = false
        }
        
    }
    
    
    
    @IBAction func chemistRcpaAction(_ sender: UIButton) {
        
        let chemists = DBManager.shared.getChemist()
        
        var data = [SelectionData]()
        
        data = chemists.map{SelectionData(name: $0.name ?? "",id: $0.code ?? "")}
        
        let selectionVC = UIStoryboard.singleSelectionVC
        selectionVC.selectionData = chemists
        selectionVC.didSelectCompletion { selectedIndex in
            self.lblChemistName.text = chemists[selectedIndex].name
            
            self.selectedChemistRcpa = chemists[selectedIndex]
        }
        self.present(selectionVC, animated: true)
        
        
    }
    
    
    @IBAction func productRcpaAction(_ sender: UIButton) {
        
        let products = DBManager.shared.getProduct()
        
        var data = [SelectionData]()
        
        data = products.map{SelectionData(name: $0.name ?? "",id: $0.code ?? "")}
        
        let selectionVC = UIStoryboard.singleSelectionVC
        selectionVC.selectionData = products
        selectionVC.didSelectCompletion { selectedIndex in
            self.lblProductName.text = products[selectedIndex].name
            
            self.selectedProductRcpa = products[selectedIndex]
            
            print(products[selectedIndex])
        }
        self.present(selectionVC, animated: true)
        
    }
    
    
    @IBAction func rcpaAddCompetitorAction(_ sender: UIButton) {
        
        self.rcpaCallListViewModel.addRcpaCompetitor(RcpaViewModel(rcpaHeaderData: RcpaHeaderData(chemist: self.selectedChemistRcpa, product: self.selectedProductRcpa, quantity: self.txtRcpaQty.text ?? "", total: self.txtRcpaTotal.text ?? "", rate: self.txtRcpaRate.text ?? "")))
        
        self.rcpaCompetitorTableView.reloadData()
        
    }
    
    
    
    public func getStatus(json:Any?, isShowToast:Bool = true) -> (isOk:Bool, info:[String:Any]) {
        guard let info:[String:Any] = json as? [String:Any] else {
            return (false, [:])
        }
        var status = false
        if let statusBool = info["success"] as? Bool {
            status = statusBool
        }
        if status {
            if let errormsg = info["msg"] as? String{
                if isShowToast {
                   // let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    ConfigVC().showToast(controller: self, message: errormsg, seconds: 2)
                    
                   // appdelegate.window?.rootViewController?.showToast(with: errormsg)
                }
            }else if let errormsg = info["Msg"] as? String{
                if isShowToast {
                   // let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    ConfigVC().showToast(controller: self, message: errormsg, seconds: 2)
                   // appdelegate.window?.rootViewController?.showToast(with: errormsg)
                }
            }
            return (true, info)
        }
        else {
            
            if let errormsg = info["msg"] as? String{
                if isShowToast {
//                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                    appdelegate.window?.rootViewController?.showToast(with: errormsg)
                    
                    ConfigVC().showToast(controller: self, message: errormsg, seconds: 2)
                    //showAlert(title: "", message: errormsg, style: .alert, buttons: ["OK"], controller: nil, completion: nil)
                }
            }else if let errormsg = info["Msg"] as? String{
                if isShowToast {
//                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                    appdelegate.window?.rootViewController?.showToast(with: errormsg)
                    
                    ConfigVC().showToast(controller: self, message: errormsg, seconds: 2)
                    //showAlert(title: "", message: errormsg, style: .alert, buttons: ["OK"], controller: nil, completion: nil)
                }
            }
            return (false, info)
        }
    }
    
}


extension ProductVC : tableViewProtocols {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
            case self.ProductTableView :
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameTableViewCell", for: indexPath) as! ProductNameTableViewCell
                cell.lblName.text = self.products[indexPath.row].name
                return cell
            case self.productRatingTableView :
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductRatingTableViewCell", for: indexPath) as! ProductRatingTableViewCell
                return cell
            case self.productSampleTableView :
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSampleTableViewCell", for: indexPath) as! ProductSampleTableViewCell
                return cell
            case self.inputListTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameTableViewCell", for: indexPath) as! ProductNameTableViewCell
                cell.input = self.inputSelectedListViewModel.fetchInputData(indexPath.row)
                return cell
            case self.inputSampleTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InputSampleTableViewCell", for: indexPath) as! InputSampleTableViewCell
                cell.inputSample = self.inputSelectedListViewModel.fetchDataAtIndex(indexPath.row)
                cell.btnDelete.addTarget(self, action: #selector(deleteInput(_:)), for: .touchUpInside)
                cell.txtSampleQty.addTarget(self, action: #selector(updateInputSampleQty(_ :)), for: .editingChanged)
                return cell
            case self.jointWorkListTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameTableViewCell", for: indexPath) as! ProductNameTableViewCell
                cell.jointWork = self.jointWorkSelectedListViewModel.fetchJointWorkData(indexPath.row)
                return cell
            case self.jointWorkSelectedListTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InputSampleTableViewCell", for: indexPath) as! InputSampleTableViewCell
                cell.jointWorkSample = self.jointWorkSelectedListViewModel.fetchDataAtIndex(indexPath.row)
                cell.btnDelete.addTarget(self, action: #selector(deleteJointWork(_:)), for: .touchUpInside)
                cell.txtSampleQty.isHidden = true
                return cell
            case self.additionalCallListTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameTableViewCell", for: indexPath) as! ProductNameTableViewCell
                cell.additionalCall = self.addittionalCallListViewModel.fetchAdditionalCallData(indexPath.row)
                return cell
            case self.additionalCallSelectedTableView :
                let cell = tableView.dequeueReusableCell(withIdentifier: "InputSampleTableViewCell", for: indexPath) as! InputSampleTableViewCell
                cell.additionalCallSample = self.addittionalCallListViewModel.fetchDataAtIndex(indexPath.row)
                cell.btnDelete.addTarget(self, action: #selector(deleteAdditionalCall(_:)), for: .touchUpInside)
                cell.txtSampleQty.isHidden = true
                return cell
            case self.feedbackListTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameTableViewCell", for: indexPath) as! ProductNameTableViewCell
                cell.lblName.text = self.feedback[indexPath.row].name
                return cell
            case self.rcpaCompetitorTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RcpaTableViewCell", for: indexPath) as! RcpaTableViewCell
            cell.btnCompetitorCompany.addTarget(self, action: #selector(rcpaCompetitorCompany(_:)), for: .touchUpInside)
            cell.btnCompetitorBrand.addTarget(self, action: #selector(rcpaCompetitorBrand(_:)), for: .touchUpInside)
                return cell
            default :
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameTableViewCell", for: indexPath) as! ProductNameTableViewCell
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
            case self.ProductTableView :
            return self.products.count
            case self.productRatingTableView :
                return 10
            case self.productSampleTableView :
                return 10
            case self.inputListTableView:
                return self.inputSelectedListViewModel.numberOfInputs()
            case self.inputSampleTableView:
                return self.inputSelectedListViewModel.numberOfRows(section)
            case self.jointWorkListTableView:
                return self.jointWorkSelectedListViewModel.numbersOfJointWorks()
            case self.jointWorkSelectedListTableView:
                return self.jointWorkSelectedListViewModel.numberofSelectedRows()
            case self.additionalCallListTableView:
                return self.addittionalCallListViewModel.numberofAdditionalCalls()
            case self.additionalCallSelectedTableView:
                return self.addittionalCallListViewModel.numberOfSelectedRows()
            case self.feedbackListTableView:
                return self.feedback.count
            case self.rcpaCompetitorTableView:
                return self.rcpaCallListViewModel.numberOfCompetitorRows()
            default :
               return 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
            case self.ProductTableView :
                break
            case self.productRatingTableView :
                break
            case self.productSampleTableView :
                break
            case self.inputListTableView:
            
                let inputValue =  self.inputSelectedListViewModel.fetchInputData(indexPath.row)
            
                if inputValue.isSelected {
                    if let cell = tableView.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                        cell.btnSelected.isSelected = false
                    }
                    self.inputSelectedListViewModel.removebyId(inputValue.Object.code ?? "")
                    self.inputSampleTableView.reloadData()
                }else {
                    if let cell = tableView.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                        cell.btnSelected.isSelected = true
                    }
                    self.inputSelectedListViewModel.addInputViewModel(InputViewModel(input: InputData(input: inputValue.Object as! Input, inputCount: "1")))
                    self.inputSampleTableView.reloadData()
                }
            case self.jointWorkListTableView :
                let jointWorkValue = self.jointWorkSelectedListViewModel.fetchJointWorkData(indexPath.row)
            
                if jointWorkValue.isSelected {
                    if let cell = tableView.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                        cell.btnSelected.isSelected = false
                    }
                    self.jointWorkSelectedListViewModel.removeById(id: jointWorkValue.Object.code ?? "")
                    self.jointWorkSelectedListTableView.reloadData()
                }else {
                    if let cell = tableView.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                        cell.btnSelected.isSelected = true
                    }
                    self.jointWorkSelectedListViewModel.addJointWorkViewModel(JointWorkViewModel(jointWork: jointWorkValue.Object as! JointWork))
                    self.jointWorkSelectedListTableView.reloadData()
                }
            
            case self.additionalCallListTableView:
            let additionalCallValue = self.addittionalCallListViewModel.fetchAdditionalCallData(indexPath.row)
                if additionalCallValue.isSelected {
                    if let cell = tableView.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                        cell.btnSelected.isSelected = false
                    }
                    self.addittionalCallListViewModel.removeById(id: additionalCallValue.Object.code ?? "")
                    self.additionalCallSelectedTableView.reloadData()
                }else {
                    if let cell = tableView.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                        cell.btnSelected.isSelected = true
                    }
                    self.addittionalCallListViewModel.addAdditionalCallViewModel(AdditionalCallViewModel(additionalCall: additionalCallValue.Object as! DoctorFencing))
                    self.additionalCallSelectedTableView.reloadData()
                }
            default :
               break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView{
            case self.inputSampleTableView:
                return 70
            case self.rcpaCompetitorTableView:
                return UITableView.automaticDimension
            default:
                return 70
        }
    }
    
    
    @objc func rcpaCompetitorCompany(_ sender : UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.rcpaCompetitorTableView)
        guard let indexPath = self.inputSampleTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        
    }
    
    @objc func rcpaCompetitorBrand(_ sender : UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.rcpaCompetitorTableView)
        guard let indexPath = self.inputSampleTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        
    }
    
    @objc func deleteInput(_ sender : UIButton){
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.inputSampleTableView)
        guard let indexPath = self.inputSampleTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        self.inputSelectedListViewModel.removeAtIndex(indexPath.row)
        self.inputSampleTableView.reloadData()
        self.inputListTableView.reloadData()
    }
    
    @objc func deleteJointWork (_ sender : UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.jointWorkSelectedListTableView)
        guard let indexPath = self.jointWorkSelectedListTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        self.jointWorkSelectedListViewModel.removeAtindex(indexPath.row)
        self.jointWorkSelectedListTableView.reloadData()
        self.jointWorkListTableView.reloadData()
    }
    
    @objc func deleteAdditionalCall (_ sender : UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.additionalCallSelectedTableView)
        guard let indexPath = self.additionalCallSelectedTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        self.addittionalCallListViewModel.removeAtindex(indexPath.row)
        self.additionalCallSelectedTableView.reloadData()
        self.additionalCallListTableView.reloadData()
        
    }
    
    @objc func updateInputSampleQty (_ sender : UITextField) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.inputSampleTableView)
        guard let indexPath = self.inputSampleTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        self.inputSelectedListViewModel.setInputCodeAtIndex(indexPath.row, samQty: sender.text ?? "")
        
        print(sender.text!)
    }
    
    
}


extension ProductVC : UITextFieldDelegate {
    
}

