//
//  AddCallinfoView.swift
//  E-Detailing
//
//  Created by San eforce on 20/03/24.
//

import Foundation
import UIKit
import CoreData
extension AddCallinfoView: MenuResponseProtocol {
    func passProductsAndInputs(product: ProductSelectedListViewModel, additioncall: AdditionalCallsListViewModel, index: Int) {
        self.productSelectedListViewModel = product
        self.additionalCallListViewModel = additioncall
        self.additionalCallListViewModel.updateInCallSection(index, isView: false)
        self.loadedContentsTable.reloadData()
    }
    
    func routeToView(_ view: UIViewController) {
        print("Yet to implement")
    }
    
    func callPlanAPI() {
        print("Yet to implement")
    }
    
    func selectedType(_ type: MenuView.CellType, selectedObject: NSManagedObject, selectedObjects: [NSManagedObject]) {

        switch type {
        case .product:
            if let selectedObject = selectedObject as? Product {
                self.lblSelectedProductName.text = selectedObject.name ?? ""
                self.productObj = selectedObject
                self.selectedProductRcpa = selectedObject
                
                let rateInt: Int = Int(selectedObject.dRate ?? "1") ?? 0
                self.rateInt = rateInt
                let qtyInt: Int = Int(self.productQty) ?? 0
                rateLbl.text = "\(rateInt)"
                valuelbl.text = "\(rateInt * qtyInt)"
                
            }
        case .chemist:
            if let selectedObject = selectedObject as? Chemist {
                self.lblSeclectedDCRName.text = selectedObject.name ?? ""
                self.chemistObj = selectedObject
                selectedChemistRcpa = selectedObject
            }
            
        case .competitors:
            if let competitors = selectedObjects as? [Competitor] {
                guard competitors.contains(where: { aCompetitor in
                    aCompetitor.ourProductCode != nil
                }) else {return}
                var competitorInfoArr = [AdditionalCompetitorsInfo]()
                for competitor in competitors {
                    let competitorInfo = AdditionalCompetitorsInfo(competitor: competitor, qty: "", remarks: "", rate: "", value: "")
                    competitorInfoArr.append(competitorInfo)
                }
                
                self.rcpaDetailsModel[selectedAddcompetitorSection].addedProductDetails?.addedProduct?[selectedAddcompetitorProductRow].competitorsInfo = competitorInfoArr
                self.loadedContentsTable.reloadData()
                
            }
        default:
            print("---><---")
        }
    }
 
}



extension AddCallinfoView {
    

    
///RCPA


    @IBAction func rcpaAddCompetitorAction(_ sender: UIButton) {
        guard let selectedChemist = selectedChemistRcpa as? Chemist,
              let selectedProduct = selectedProductRcpa as? Product,
              let productQuantity = productQtyTF.text, !productQuantity.isEmpty else {
            handleIncompleteSelection()
            return
        }
        
        let rcpaDetails = createRCPADetails()
        
        if let existingIndex = findExistingRCPADetailsIndex(for: selectedChemist) {
            updateExistingRCPADetails(existingIndex, selectedChemist, selectedProduct, rcpaDetails.addedProductDetails ?? ProductDetails())
        } else {
            addNewRCPADetails(selectedChemist, selectedProduct, rcpaDetails, rcpaDetails.addedProductDetails ?? ProductDetails())
        }
        
        toloadContentsTable()
        removeAddedRCPAInfo()
    }
    
    func handleIncompleteSelection() {
        if selectedChemistRcpa == nil {
            toCreateToast("Please select Chemist...")
        } else if selectedProductRcpa == nil {
            toCreateToast("Please select Product...")
        } else {
            toCreateToast("Please enter Quantity...")
        }
    }

    func createRCPADetails() -> RCPAdetailsModal {
        let rcpaDetailsModal = RCPAdetailsModal()
        var productDetails = ProductDetails()
        productDetails.addedQuantity = [self.productQty]
       
        productDetails.addedRate = [self.rateLbl.text ?? "0"]
        productDetails.addedValue = [self.valuelbl.text ?? "0"]
        productDetails.addedTotal = [self.valuelbl.text ?? "0"]
        rcpaDetailsModal.addedProductDetails = productDetails
        return rcpaDetailsModal
    }

    func findExistingRCPADetailsIndex(for chemist: Chemist) -> Int? {
        return rcpaDetailsModel.firstIndex { $0.addedChemist?.code == chemist.code }
    }

    func updateExistingRCPADetails(_ index: Int, _ chemist: Chemist, _ product: Product, _ addedProductDetails: ProductDetails) {
        let existingRCPADetails = rcpaDetailsModel[index]
        let addedQuantity = addedProductDetails.addedQuantity ?? [String]()
        let addedRate = addedProductDetails.addedRate ?? [String]()
        let addedValue = addedProductDetails.addedValue ??  [String]()
        let addedTotal = addedProductDetails.addedTotal ??  [String]()
        
        var tempaddedProductDetails = addedProductDetails
        
        tempaddedProductDetails.addedRate = existingRCPADetails.addedProductDetails?.addedRate
        tempaddedProductDetails.addedValue = existingRCPADetails.addedProductDetails?.addedValue
        tempaddedProductDetails.addedQuantity = existingRCPADetails.addedProductDetails?.addedQuantity
        tempaddedProductDetails.addedProduct =  existingRCPADetails.addedProductDetails?.addedProduct
        
        var isAppended: Bool = false
        
        existingRCPADetails.addedProductDetails?.addedProduct?.enumerated().forEach{index, addedProduct in
            
            if addedProduct.addedProduct?.code == product.code {
                // Update existing product if found
                tempaddedProductDetails.addedQuantity?[index] = existingRCPADetails.addedProductDetails?.addedQuantity?[index] ?? ""
                tempaddedProductDetails.addedRate?[index] = existingRCPADetails.addedProductDetails?.addedRate?[index] ?? ""
                tempaddedProductDetails.addedValue?[index] = existingRCPADetails.addedProductDetails?.addedValue?[index] ?? ""
                tempaddedProductDetails.addedProduct?[index] = addedProduct
                //[index] = addedProduct
            } else {
                tempaddedProductDetails.addedQuantity?.append(contentsOf: addedQuantity)
                tempaddedProductDetails.addedValue?.append(contentsOf: addedValue)
                tempaddedProductDetails.addedRate?.append(contentsOf: addedRate)
                tempaddedProductDetails.addedTotal?.append(contentsOf: addedTotal)
                let aProductWithCompetiors = ProductWithCompetiors(addedProduct: product, competitorsInfo: nil)
                if !isAppended {
                    tempaddedProductDetails.addedProduct?.append(aProductWithCompetiors)
                }
                isAppended = true
            }
        }
        

        existingRCPADetails.addedProductDetails = tempaddedProductDetails
        
        rcpaDetailsModel[index] = existingRCPADetails
    }

    func addNewRCPADetails(_ chemist: Chemist, _ product: Product, _ details: RCPAdetailsModal, _ addedProductDetails: ProductDetails) {
        details.addedChemist = chemist
        var tempaddedProductDetails = addedProductDetails
        // Unwrap addedProductDetails and append the product
        let aProductWithCompetiors =  ProductWithCompetiors(addedProduct: product, competitorsInfo: nil)
        if tempaddedProductDetails.addedProduct == nil {
        
            tempaddedProductDetails.addedProduct = [aProductWithCompetiors]
        } else {
            tempaddedProductDetails.addedProduct?.append(aProductWithCompetiors)
        }
       
        details.addedProductDetails = tempaddedProductDetails
        // Set other details

        // Append the modified details to rcpaDetailsModel
        rcpaDetailsModel.append(details)
    }
    
    
    func removeAddedRCPAInfo() {
        self.selectedChemistRcpa = nil
        self.selectedProductRcpa = nil
        productObj = nil
        chemistObj = nil
        lblSeclectedDCRName.text = "Select Chemist Name"
        lblSelectedProductName.text = "Select Product Name"
        self.productQtyTF.text = ""
        self.productQtyTF.placeholder = "Enter Qty"
        self.rateLbl.text = ""
        self.valuelbl.text = ""
        self.productQty = "1"
        self.loadedContentsTable.isHidden = false
        self.viewnoRCPA.isHidden = true
    }
    
    
    
    @IBAction func rcpaSaveAction(_ sender: UIButton) {
        
//        if self.rcpaCallListViewModel.numberOfCompetitorRows(forSection: selectedAddcompetitorSection) == 0 {
//            print("Add Competitor")
//            return
//        }
        yetToloadContentsTable.isHidden = false
        self.yetToloadContentsTable.reloadData()
    }

    ///Additional calls
    @objc func additionalCallDownArrowAction(_ sender : UIButton) {
        //additionalCallSelectedTableView
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.loadedContentsTable)
        guard let indexPath = self.loadedContentsTable.indexPathForRow(at: buttonPosition) else {
            return
        }
        
        let isView = self.additionalCallListViewModel.fetchDataAtIndex(indexPath.row).isView
        
        self.additionalCallListViewModel.updateInCallSection(indexPath.row, isView: !isView)
        
        print(isView)
        
        self.loadedContentsTable.reloadData()
        
    }
    
    @objc func editAdditionalCallSampleInput(_ sender : UIButton) {
        //additionalCallSelectedTableView
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.loadedContentsTable)
        guard self.loadedContentsTable.indexPathForRow(at: buttonPosition) != nil else {
            return
        }
        
        self.selectedDoctorIndex = sender.tag
        
        let vc = AddproductsMenuVC.initWithStory(self, productSelectedListViewModel: self.productSelectedListViewModel, additionalCallListViewModel: self.additionalCallListViewModel, selectedDoctorIndex: selectedDoctorIndex)
        vc.modalPresentationStyle = .custom
        self.addCallinfoVC.navigationController?.present(vc, animated: false)
    }
    
    @objc func deleteAdditionalCall (_ sender : UIButton) {
        //additionalCallSelectedTableView
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.loadedContentsTable)
        guard let indexPath = self.loadedContentsTable.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        self.additionalCallListViewModel.removeAtindex(indexPath.row)
        self.loadedContentsTable.reloadData()
        self.yetToloadContentsTable.reloadData()
    }
    
    @objc func addProductInputAction(_ sender: UIButton) {
       
        //additionalCallSampleInputTableView
        print("sender Tag == \(sender.tag)")
        self.selectedDoctorIndex = sender.tag
        //MARK: - Show menu
        
        let vc = AddproductsMenuVC.initWithStory(self, productSelectedListViewModel: self.productSelectedListViewModel, additionalCallListViewModel: self.additionalCallListViewModel, selectedDoctorIndex: self.selectedDoctorIndex)
        vc.modalPresentationStyle = .custom
    
        self.addCallinfoVC.navigationController?.present(vc, animated: false)
        
      //  self.additionalCallSampleInputTableView.reloadData()
//        UIView.animate(withDuration: 1.5) {
//            self.viewAdditionalCallSampleInput.isHidden = false
//        }
    }
    @objc func additionalCallSelectionAction(_ sender : UIButton){
        //additionalCallSelectedTableView
    
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.yetToloadContentsTable)
        guard let indexPath = self.yetToloadContentsTable.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        let additionalCallValue = self.additionalCallListViewModel.fetchAdditionalCallData(indexPath.row, searchText: self.searchText)
        if additionalCallValue.isSelected {
            if let cell = self.yetToloadContentsTable.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                cell.btnSelected.isSelected = false
                cell.lblName.textColor =    cell.btnSelected.isSelected ? .appTextColor : .appLightTextColor
            }
            self.additionalCallListViewModel.removeById(id: additionalCallValue.Object.code ?? "")
            self.loadedContentsTable.reloadData()
        }else {
            if let cell = self.yetToloadContentsTable.cellForRow(at: indexPath) as? ProductNameTableViewCell{
                cell.btnSelected.isSelected = true
                cell.lblName.textColor =    cell.btnSelected.isSelected ? .appTextColor : .appLightTextColor
            }
            

            self.additionalCallListViewModel.addAdditionalCallViewModel(AdditionalCallViewModel(additionalCall: additionalCallValue.Object as! DoctorFencing, isView: false))
            self.loadedContentsTable.reloadData()
        }
    }
    
    ///inputs
    @objc func inputSelectionAction(_ sender : UIButton){
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.yetToloadContentsTable)
        guard let indexPath = self.yetToloadContentsTable.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        let inputValue =  self.inputSelectedListViewModel.fetchInputData(indexPath.row, searchText: self.searchText)
        if inputValue.isSelected {
            if let cell = self.yetToloadContentsTable.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                cell.btnSelected.isSelected = false
                
                cell.lblName.textColor =    cell.btnSelected.isSelected ? .appTextColor : .appLightTextColor
                
            }
            self.inputSelectedListViewModel.removebyId(inputValue.Object.code ?? "")
            toloadContentsTable()
        }else {
            if let cell = self.yetToloadContentsTable.cellForRow(at: indexPath) as? ProductNameTableViewCell {
                cell.btnSelected.isSelected = true
                
                cell.lblName.textColor =    cell.btnSelected.isSelected ? .appTextColor : .appLightTextColor
            }
            self.inputSelectedListViewModel.addInputViewModel(InputViewModel(input: InputData(input: inputValue.Object as? Input, availableCount: "", inputCount: "1")))
            toloadContentsTable()
        }
    }
    
    
    @objc func deleteInput(_ sender : UIButton){
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.loadedContentsTable)
        guard let indexPath = self.loadedContentsTable.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        self.inputSelectedListViewModel.removeAtIndex(indexPath.row)
        self.loadedContentsTable.reloadData()
        self.yetToloadContentsTable.reloadData()
    }
    
    @objc func updateInputSampleQty(_ sender : UITextField){
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.loadedContentsTable)
        guard let indexPath = self.loadedContentsTable.indexPathForRow(at: buttonPosition) else{
            return
        }
        self.inputSelectedListViewModel.setInputCodeAtIndex(indexPath.row, samQty: sender.text ?? "")
    }
    
    
    ///products
    @objc func productDetailedSelection(_ sender : UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.loadedContentsTable)
        guard let indexPath = self.loadedContentsTable.indexPathForRow(at: buttonPosition) else{
            return
        }
      
        let isDetailed = self.productSelectedListViewModel.fetchDataAtIndex(indexPath.row).isDetailed
        
        self.productSelectedListViewModel.setIsDetailedProductAtIndex(indexPath.row, isDetailed: !isDetailed)
        
        self.toloadContentsTable()
    }
    
    @objc func updateProductSampleQty(_ sender : UITextField){
        
        let product = self.productSelectedListViewModel.fetchDataAtIndex(sender.tag)
        
        print(product.name)
        print(product.sampleCount)
        print(product.availableCount)
        print(product.totalCount)
        print(product.code)
        
        if product.totalCount == "0" {
            
        }
        
        self.productSelectedListViewModel.setSampleCountAtIndex(sender.tag, qty: sender.text ?? "")
    }
    
    @objc func deleteProduct(_ sender: UIButton) {
        
        self.productSelectedListViewModel.removeAtIndex(sender.tag)
        self.toloadYettables()
        self.toloadContentsTable()
    }
    
    
    @objc func updateProductRcpaQty(_ sender : UITextField){
        self.productSelectedListViewModel.setRcpaCountAtIndex(sender.tag, qty: sender.text ?? "")
    }
    
    @objc func updateProductRxQty(_ sender : UITextField){
        self.productSelectedListViewModel.setRxCountAtIndex(sender.tag, qty: sender.text ?? "")
    }
    
    @objc func productSelectionAction(_ sender : UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.yetToloadContentsTable)
        guard let indexPath = self.yetToloadContentsTable.indexPathForRow(at: buttonPosition) else{
            return
        }
     
        let productValue = self.productSelectedListViewModel.fetchProductData(indexPath.row, searchText: self.searchText,type: addCallinfoVC.dcrCall.type,selectedDoctorCode: addCallinfoVC.dcrCall.code)
        if productValue.isSelected {
            if let cell = self.yetToloadContentsTable.cellForRow(at: indexPath) as? ProductNameWithSampleTableViewCell {
                cell.btnSelected.isSelected = false
                cell.lblName.textColor =    cell.btnSelected.isSelected ? .appTextColor : .appLightTextColor
             
            }
            self.productSelectedListViewModel.removeById(productValue.Object.code ?? "")
            self.toloadContentsTable()
        }else {
            if let cell = self.yetToloadContentsTable.cellForRow(at: indexPath) as? ProductNameWithSampleTableViewCell{
                cell.btnSelected.isSelected = true
                cell.lblName.textColor =    cell.btnSelected.isSelected ? .appTextColor : .appLightTextColor
            }
           
            self.productSelectedListViewModel.addProductViewModel(ProductViewModel(product: ProductData(product: productValue.Object as? Product, isDetailed: false, sampleCount: "", rxCount: "", rcpaCount: "", availableCount: "", totalCount: "", stockistName: "", stockistCode: "")))
            self.toloadContentsTable()
        }
    }
}


extension AddCallinfoView : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case productQtyTF:
            // Construct the new text after replacement
            let currentText = textField.text ?? "1"
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            // Update the text immediately
            self.productQty = updatedText
            self.productQtyAction(textField)
            
            // Return false to prevent the text from changing again
            return true
            
        case yetTosearchTF:
            self.didTapSearchTF(textField)
            return true
        default:
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            let maxLength = 6
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return string == numberFiltered && newString.length <= maxLength
        }

    }
    
    
    
}


extension AddCallinfoView: tableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.segmentType[selectedSegmentsIndex] {
            
//        case .detailed:
//            <#code#>
        case .products:
            switch tableView {
            case yetToloadContentsTable:
                return self.productSelectedListViewModel.numberOfProducts(searchText: self.searchText)
            case loadedContentsTable:
                return  self.productSelectedListViewModel.numberOfRows()
            default:
                return Int()
            }
            
          
        case .inputs:
            switch tableView {
            case yetToloadContentsTable:
                return self.inputSelectedListViewModel.numberOfInputs(searchText: self.searchText)
            case loadedContentsTable:
                return self.inputSelectedListViewModel.numberOfRows()
            default:
                return Int()
            }
        case .additionalCalls:
            switch tableView {
            case yetToloadContentsTable:
                return self.additionalCallListViewModel.numberofAdditionalCalls(searchText: self.searchText)
            case loadedContentsTable:
                return self.additionalCallListViewModel.numberOfSelectedRows()
            default:
                return Int()
            }
        case .rcppa:
            
            switch tableView {
            case yetToloadContentsTable:
                return Int()
            case loadedContentsTable:
   
                let arcpaModelsection = self.rcpaDetailsModel[section]
                return arcpaModelsection.addedProductDetails?.addedProduct?.count ?? 0
            default:
                return Int()
            }
            
//        case self.rcpaCompetitorTableView:
//            return self.rcpaCallListViewModel.numberOfCompetitorRows()
        
//        case .jointWork:
//            <#code#>
            
        default:
            return Int()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.segmentType[selectedSegmentsIndex] {
       
        case .products:
            
            switch tableView {
            case yetToloadContentsTable:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameWithSampleTableViewCell", for: indexPath) as! ProductNameWithSampleTableViewCell

                
                cell.product =  self.productSelectedListViewModel.fetchProductData(indexPath.row, searchText: self.searchText, type: addCallinfoVC.dcrCall.type,selectedDoctorCode: addCallinfoVC.dcrCall.code)
                cell.selectionStyle = .none
                cell.btnSelected.isUserInteractionEnabled = false
                cell.addTap {
                    self.productSelectionAction(cell.btnSelected)
                }
                return cell
                
                
            case loadedContentsTable:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSampleTableViewCell", for: indexPath) as! ProductSampleTableViewCell
                cell.selectionStyle = .none
                let model = self.productSelectedListViewModel.fetchDataAtIndex(indexPath.row)
                cell.productSample = model
                
                
//                let saleArr = productArray.filter { $0.productMode?.lowercased() == "sale" }
//                let SaleSampleArr =  productArray.filter { $0.productMode?.lowercased() == "sale/sample" }
//                let sampleArr = productArray.filter { $0.productMode?.lowercased() == "sample" }
                
                /*  SL -> sale -> disable samples SM -> Sample -> Disable RX SM/SL -> Enable both*/
                
                if model.product.product?.productMode?.lowercased() == "sale" {
                    cell.txtRxQty.addTarget(self, action: #selector(updateProductRxQty(_:)), for: .editingChanged)
                    cell.txtRcpaQty.addTarget(self, action: #selector(updateProductRcpaQty(_:)), for: .editingChanged)
                    cell.txtSampleQty.isUserInteractionEnabled = false
                    cell.txtRxQty.isUserInteractionEnabled = true
                } else if  model.product.product?.productMode?.lowercased() == "sale/sample" {
                    cell.txtRxQty.addTarget(self, action: #selector(updateProductRxQty(_:)), for: .editingChanged)
                    cell.txtSampleQty.addTarget(self, action: #selector(updateProductSampleQty(_:)), for: .editingChanged)
                    cell.txtRcpaQty.addTarget(self, action: #selector(updateProductRcpaQty(_:)), for: .editingChanged)
                    
                } else if model.product.product?.productMode?.lowercased() == "sample" {
                    cell.txtSampleQty.addTarget(self, action: #selector(updateProductSampleQty(_:)), for: .editingChanged)
                    cell.txtRcpaQty.addTarget(self, action: #selector(updateProductRcpaQty(_:)), for: .editingChanged)
                    cell.txtRxQty.isUserInteractionEnabled = false
                    cell.txtSampleQty.isUserInteractionEnabled = true
                }
                cell.btnDelete.addTarget(self, action: #selector(deleteProduct(_:)), for: .touchUpInside)
                cell.btnDelete.tag = indexPath.row
                cell.txtRxQty.tag = indexPath.row
                cell.txtRcpaQty.tag = indexPath.row
                cell.txtSampleQty.tag = indexPath.row
      
                cell.txtSampleQty.addTarget(self, action: #selector(updateProductSampleQty(_:)), for: .editingChanged)
                cell.btnDeviation.addTarget(self, action: #selector(productDetailedSelection(_:)), for: .touchUpInside)
             
                cell.txtSampleQty.delegate = self
                cell.txtRxQty.delegate = self
                cell.txtRcpaQty.delegate = self
                if appsetup.sampleValidation != 1 {
                  //  cell.viewStock.isHidden = true
                }
                return cell
            default:
                return UITableViewCell()
            }
            

        case .inputs:
            switch tableView {
            case yetToloadContentsTable:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameTableViewCell", for: indexPath) as! ProductNameTableViewCell
                cell.selectionStyle = .none
                cell.input = self.inputSelectedListViewModel.fetchInputData(indexPath.row, searchText: self.searchText)
                cell.btnSelected.isUserInteractionEnabled = false
                cell.addTap {
                    self.inputSelectionAction(cell.btnSelected)
                }
                return cell
                
                
            case loadedContentsTable:
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "InputSampleTableViewCell", for: indexPath) as! InputSampleTableViewCell
                cell.selectionStyle = .none
                cell.inputSample = self.inputSelectedListViewModel.fetchDataAtIndex(indexPath.row)
                cell.btnDelete.addTarget(self, action: #selector(deleteInput(_:)), for: .touchUpInside)
                cell.txtSampleQty.addTarget(self, action: #selector(updateInputSampleQty(_ :)), for: .editingChanged)
                cell.txtSampleQty.delegate = self
                if appsetup.inputValidation != 1 {
                   // cell.viewSampleQty.isHidden = true
                }
                
                return cell
            default:
                return UITableViewCell()
            }
        case .additionalCalls:
            switch tableView {
            case yetToloadContentsTable:

                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductNameTableViewCell", for: indexPath) as! ProductNameTableViewCell
                cell.selectionStyle = .none
                cell.additionalCall = self.additionalCallListViewModel.fetchAdditionalCallData(indexPath.row, searchText: self.searchText)
                //cell.btnSelected.addTarget(self, action: #selector(additionalCallSelectionAction(_:)), for: .touchUpInside)

                cell.btnSelected.isUserInteractionEnabled = false
                cell.addTap {
                    let doctorArr =  DBManager.shared.getHomeData().filter { aHomeData in
                        aHomeData.custType == "1"
                    }
                    
                    if let addedDcrCall =   cell.additionalCall.Object as? DoctorFencing {
                        if let doctorCall = self.addCallinfoVC.dcrCall.call   as? DoctorFencing  {
                            if addedDcrCall.code == doctorCall.code {
                                self.toCreateToast("OOPS! Addition call is same as selected call")
                                return
                            }
                        }
                    }
                    
                    if let addedDcrCall =   cell.additionalCall.Object as? DoctorFencing {
                        
                        if let unsyncedArr = DBManager.shared.geUnsyncedtHomeData() {
                            let filteredArray = unsyncedArr.filter { aHomeData in
                                  if aHomeData.custCode == addedDcrCall.code {
                                      let dcrDate = aHomeData.dcr_dt?.toDate(format: "yyyy-MM-dd")
                                      let dcrDateString = dcrDate?.toString(format: "yyyy-MM-dd")
                                      let currentDateStr = Date().toString(format: "yyyy-MM-dd")
                                      if dcrDateString == currentDateStr {
                                          return true
                                      }
                                  }
                                  return false
                              }
                            if !filteredArray.isEmpty  {
                                self.toCreateToast("Doctor aldready visited today")
                                return
                            }
                        }
                        
                        
                      let filteredArray = doctorArr.filter { aHomeData in
                            if aHomeData.custCode == addedDcrCall.code {
                                let dcrDate = aHomeData.dcr_dt?.toDate(format: "yyyy-MM-dd")
                                let dcrDateString = dcrDate?.toString(format: "yyyy-MM-dd")
                                let currentDateStr = Date().toString(format: "yyyy-MM-dd")
                                if dcrDateString == currentDateStr {
                                    return true
                                }
                            }
                            return false
                        }
                        if !filteredArray.isEmpty  {
                            self.toCreateToast("Doctor aldready visited today")
                            return
                        } else {
                            self.additionalCallSelectionAction(cell.btnSelected)
                        }
                    }
                    
                    
                 
                }
                return cell
                
                
            case loadedContentsTable:
               //additionalCallSelectedTableView
                let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalCallSampleInputTableViewCell", for: indexPath) as! AdditionalCallSampleInputTableViewCell
                cell.selectionStyle = .none
                cell.additionalCall = self.additionalCallListViewModel.fetchDataAtIndex(indexPath.row)
                cell.btnAddProductInput.addTarget(self, action: #selector(addProductInputAction(_:)), for: .touchUpInside)
                cell.btnDelete.addTarget(self, action: #selector(deleteAdditionalCall(_:)), for: .touchUpInside)
                cell.btnEdit.addTarget(self, action: #selector(editAdditionalCallSampleInput(_:)), for: .touchUpInside)
                cell.btnDownArrow.addTarget(self, action: #selector(additionalCallDownArrowAction(_:)), for: .touchUpInside)
                cell.btnEdit.tag = indexPath.row
                cell.btnAddProductInput.tag = indexPath.row
                if self.additionalCallListViewModel.numberOfProductsInSection(indexPath.row) != 0 || self.additionalCallListViewModel.numberOfInputsInSection(indexPath.row) != 0 {
                    cell.viewProductInputButton.isHidden = true
                }else {
                    cell.viewProductInputButton.isHidden = false
                }
                cell.btnDelete.tag = indexPath.row
                return cell
   
              
            default:
                return UITableViewCell()
            }
        case .rcppa:
            switch tableView {
            case yetToloadContentsTable:
                return UITableViewCell()
            case loadedContentsTable:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RcpaAddedListTableViewCell", for: indexPath) as! RcpaAddedListTableViewCell
            
                cell.rcpaProduct = self.rcpaDetailsModel[indexPath.section]
                let productsInfo = self.rcpaDetailsModel[indexPath.section].addedProductDetails
                cell.lblName.text = productsInfo?.addedProduct?[indexPath.row].addedProduct?.name ?? ""
                //[indexPath.row].name
     
                cell.section = indexPath.section
                cell.index = indexPath.row
                cell.lblQty.text = productsInfo?.addedQuantity?[indexPath.row] ?? ""
                
                cell.lblRate.text = productsInfo?.addedRate?[indexPath.row] ?? ""
                cell.lblValue.text = productsInfo?.addedValue?[indexPath.row] ?? ""
                cell.lblTotal.text = summonedTotal(rate:  cell.lblRate.text ?? "", quantity: cell.lblQty.text ?? "")
                
               
                cell.competitorRate = cell.lblRate.text ?? ""
                cell.competirorValue = cell.lblValue.text ?? ""
                
                cell.selectionStyle = .none
          
                cell.btnDelete.isUserInteractionEnabled = true
                
                cell.btnDelete.addTap {

                    self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct?.remove(at: indexPath.row)
                    self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedRate?.remove(at: indexPath.row)
                    self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedQuantity?.remove(at: indexPath.row)
                    self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedValue?.remove(at: indexPath.row)
                    self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedTotal?.remove(at: indexPath.row)
                    self.loadedContentsTable.reloadData()
                }
                

                var selectedComp = [Competitor]()
                self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct?[indexPath.row].competitorsInfo?.forEach({ aAdditionalCompetitorsInfo in
                    selectedComp.append(aAdditionalCompetitorsInfo.competitor ?? Competitor())
                })
                
              //self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct?[indexPath.row].competitor ?? [Competitor]()
                //competitor ?? [Competitor]()
                cell.competitorsInfo = self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct?[indexPath.row].competitorsInfo
                cell.setupAddedCompetitors(count: selectedComp.count, competitors: selectedComp)
                cell.delegate = self
                cell.btnAddCompetitor.isUserInteractionEnabled = false
                cell.viewAddcompetitor.addTap {
                self.selectedAddcompetitorProductRow =  indexPath.row
                self.selectedAddcompetitorSection = indexPath.section
                self.navigatetoSpecifiedMenu(rcpaSection: indexPath.section)
                }
                
                return cell
            default:
                return UITableViewCell()
            }
//        case .jointWork:
//            <#code#>
            
        default:
            return UITableViewCell()
        }
    }
    
    func summonedTotal(rate: String, quantity: String) -> String {
    let rateInt: Int = Int(rate) ?? 0
        let intQuantity: Int = Int(quantity) ?? 0
        
        return "\(rateInt * intQuantity)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.segmentType[selectedSegmentsIndex] {
            
        case .detailed:
            return 60
        case .products:
            return 60
        case .inputs:
            return 60
        case .additionalCalls:
            switch tableView {
            case yetToloadContentsTable:
                return 60
            case loadedContentsTable:
                return UITableView.automaticDimension
            default:
                return 60
            }
        case .rcppa:
      
            guard let addedProduct = self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct else {
                return 50 + 5 + 5 + 60
            }
            guard addedProduct.count >= indexPath.row else {return 50 + 5 + 5 + 60}
            

            guard self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct?[indexPath.row].competitorsInfo != nil  else { return 50 + 5 + 5 + 60 }
            
          //  guard (self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct?[indexPath.row].competitor) != nil else { return 50 + 5 + 5 + 60 }
            
            var selectedComp = [Competitor]()
            self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct?[indexPath.row].competitorsInfo?.forEach({ aAdditionalCompetitorsInfo in
                selectedComp.append(aAdditionalCompetitorsInfo.competitor ?? Competitor())
            })
            
            if selectedComp.count == 0 {
                return 50 + 5 + 5 + 60
            } else {
                return 50 + 5 + 5 + calculateSectionHeight(forSection: indexPath.section, index: indexPath.row)
            }
            
        case .jointWork:
            return 60
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.segmentType[selectedSegmentsIndex] {
        case .rcppa:
            return   self.rcpaDetailsModel.count
            //rcpaAddedListViewModel.numberofSections()
        default:
            return 1
        }
    }
   
    @objc func navigatetoSpecifiedMenu(rcpaSection section: Int) {
       
        self.selectedAddcompetitorSection = section
        let vc  = SpecifiedMenuVC.initWithStory(self, celltype: .competitors)
        if let addedProduct = self.rcpaDetailsModel[selectedAddcompetitorSection].addedProductDetails?.addedProduct {
            vc.selectedObject = addedProduct[selectedAddcompetitorRow].addedProduct
        }
       // vc.selectedObject =    self.rcpaDetailsModel[selectedAddcompetitorSection].addedProductDetails?.addedProduct?[selectedAddcompetitorRow].addedProduct
        

        vc.menuDelegate = self
        self.addCallinfoVC.modalPresentationStyle = .custom
        self.addCallinfoVC.navigationController?.present(vc, animated: false)
    }

    func calculateSectionHeight(forSection section: Int, index: Int) -> CGFloat {
        //self.rcpaDetailsModel[indexPath.section].addedProductDetails?.addedProduct?[indexPath.row].competitor?
        
        var selectedComp = [Competitor]()
        self.rcpaDetailsModel[section].addedProductDetails?.addedProduct?[index].competitorsInfo?.forEach({ aAdditionalCompetitorsInfo in
            selectedComp.append(aAdditionalCompetitorsInfo.competitor ?? Competitor())
        })
        
        let competitorCount = selectedComp.count //self.rcpaDetailsModel[section].addedProductDetails?.addedProduct?[index].competitor?.count ?? 0
        let sectionHeight = CGFloat(50 + (competitorCount * 50) + 10) + 50
        return sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch self.segmentType[selectedSegmentsIndex] {
       
        case .products:
            
            switch tableView {
            case yetToloadContentsTable:
                return UIView()
            case loadedContentsTable:
                // Dequeue the header view
                guard let headerView = loadedContentsTable.dequeueReusableHeaderFooterView(withIdentifier: "ProductsInfoHeader") as? ProductsInfoHeader else {
         
                    return UIView()
                }



                return headerView
            default:
                return UIView()
            }

        case .inputs:
            switch tableView {
            case yetToloadContentsTable:
                return UIView()
            case loadedContentsTable:
                // Dequeue the header view
                guard let headerView = loadedContentsTable.dequeueReusableHeaderFooterView(withIdentifier: "ProductInputsHeader") as? ProductInputsHeader else {
         
                    return UIView()
                }



                return headerView
            default:
                return UIView()
            }
        case .additionalCalls:
            switch tableView {
            case yetToloadContentsTable:
                return UIView()
            case loadedContentsTable:
                // Dequeue the header view
                guard let headerView = loadedContentsTable.dequeueReusableHeaderFooterView(withIdentifier: "AdditionalCallsHeader") as? AdditionalCallsHeader else {
         
                    return UIView()
                }



                return headerView
            default:
                return UIView()
            }
            
            
            
        case .rcppa:
            
            switch tableView {
            case yetToloadContentsTable:
                return UIView()
            case loadedContentsTable:
                // Dequeue the header view
                guard let headerView = loadedContentsTable.dequeueReusableHeaderFooterView(withIdentifier: "RCPASectionheader") as? RCPASectionheader else {
         
                    return UIView()
                }

                headerView.holderStack.layer.cornerRadius = 5
                headerView.holderStack.backgroundColor = .appLightTextColor.withAlphaComponent(0.1)
                let chemist =  self.rcpaDetailsModel[section].addedChemist
                let productsInfo =  self.rcpaDetailsModel[section].addedProductDetails
                headerView.titleLbl.text = chemist?.name ?? ""
                var summonedTotal: Int = 0
    
                productsInfo?.addedTotal?.forEach({ aProductTotal in
                    let intTotal = Int(aProductTotal) ?? 0
                    summonedTotal += intTotal
                })
                
                headerView.summonedTotal.text = "\(summonedTotal).00"
                headerView.deleteView.addTap {
                    self.rcpaDetailsModel.remove(at: section)
                    self.loadedContentsTable.reloadData()
                }
               // deleteSection
                return headerView
            default:
                return UIView()
            }
//        case .jointWork:
//            <#code#>
            
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch self.segmentType[selectedSegmentsIndex] {
       
        case .products:
            
            switch tableView {
            case yetToloadContentsTable:
                return CGFloat()
            case loadedContentsTable:
                return 50
                
            default:
                return CGFloat()
            }

        case .inputs:
            switch tableView {
            case yetToloadContentsTable:
                return CGFloat()
            case loadedContentsTable:
                return 50
                
            default:
                return CGFloat()
            }

        case .additionalCalls:
            switch tableView {
            case yetToloadContentsTable:
                return CGFloat()
            case loadedContentsTable:
                return 50
                
            default:
                return CGFloat()
            }
        case .rcppa:
            return 80
//        case .jointWork:
//            <#code#>
            
        default:
            return CGFloat()
        }
    }
    
}

extension AddCallinfoView : collectionViewProtocols {
    
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

            case .detailed:
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
            case .products:
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
            case .inputs:
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
            case .additionalCalls:
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
            case .rcppa:
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
            case .jointWork:
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

class AddCallinfoView : BaseView {
    
    func setupSearchTF() {
        self.searchText = ""
        self.yetTosearchTF.text = ""
        self.yetTosearchTF.placeholder = "Search"
    }
    
    func setSegment(_ segmentType: SegmentType, isfromSwipe: Bool? = false) {
      
        switch segmentType {
            
          
        case .detailed:
            setupSearchTF()
            didClose()
            jfwExceptionView.isHidden = true
            viewnoRCPA.isHidden = true
            rcpaEntryView.isHidden = true
            yetToloadContentsTable.isHidden = true
            yettoaddSectionView.backgroundColor = .clear
            loadedContentsTable.isHidden = true
            //toloadYettables()
            //toloadContentsTable()
            detailedInfoAction()
        case .products:
            setupSearchTF()
            didClose()
            detailedSlideInfoView?.removeFromSuperview()
           
            jfwExceptionView.isHidden = false
            viewnoRCPA.isHidden = true
            rcpaEntryView.isHidden = true
            yetToloadContentsTable.isHidden = false
            yettoaddSectionView.backgroundColor = .clear
            loadedContentsTable.isHidden = false
            self.detailedSlideInfoView?.removeFromSuperview()
            toloadYettables()
            toloadContentsTable()
        case .inputs:
            setupSearchTF()
            didClose()
            detailedSlideInfoView?.removeFromSuperview()
            
            jfwExceptionView.isHidden = false
            rcpaEntryView.isHidden = true
            yetToloadContentsTable.isHidden = false
            yettoaddSectionView.backgroundColor = .clear
            viewnoRCPA.isHidden = true
            loadedContentsTable.isHidden = false
            toloadYettables()
            toloadContentsTable()
        case .additionalCalls:
            setupSearchTF()
            didClose()
            detailedSlideInfoView?.removeFromSuperview()
            jfwExceptionView.isHidden = false
            rcpaEntryView.isHidden = true
            yetToloadContentsTable.isHidden = false
            yettoaddSectionView.backgroundColor = .clear
            viewnoRCPA.isHidden = true
            loadedContentsTable.isHidden = false
            toloadYettables()
            toloadContentsTable()
        case .rcppa:
            setupSearchTF()
            didClose()
            detailedSlideInfoView?.removeFromSuperview()
            detailedSlideInfoView?.alpha = 0
            jfwExceptionView.isHidden = false
            rcpaEntryView.isHidden = false
            yetToloadContentsTable.isHidden = true
            yettoaddSectionView.backgroundColor = .appWhiteColor
            
            if rcpaDetailsModel.count == 0 {
                viewnoRCPA.isHidden = false
                loadedContentsTable.isHidden = true
            } else {
                viewnoRCPA.isHidden = true
                loadedContentsTable.isHidden = false
                toloadContentsTable()
            }
            
            
            //toloadYettables()
            //toloadContentsTable()
        case .jointWork:
            setupSearchTF()
            detailedSlideInfoView?.removeFromSuperview()
            jfwExceptionView.isHidden = true
            jfwAction()
        }

    }
    
     var productSelectedListViewModel = ProductSelectedListViewModel()
     var additionalCallListViewModel = AdditionalCallsListViewModel()
   enum  SegmentType : String {
        case detailed = "Detailed"
        case products = "Products"
       case inputs = "Inputs"
       case additionalCalls = "Additional Calls"
       case rcppa = "RCPA"
       case jointWork = "JFW / Others"

    }

    @IBAction func didTapSearchTF(_ sender: UITextField) {
        self.searchText = sender.text ?? ""
        self.yetToloadContentsTable.reloadData()
    }
    
    
    @IBOutlet var yetTosearchTF: UITextField!
    
    
    @IBOutlet var bottomButtonsHolder: UIView!
    
    @IBOutlet var jfwExceptionView: UIView!
    
    @IBOutlet var segmentCollectionHolder: UIView!

    @IBOutlet var lblSeclectedDCRName: UILabel!
    
    
    @IBOutlet var lblSelectedProductName: UILabel!
    
    @IBOutlet var productQtyTF: UITextField!
    

    @IBOutlet var rateLbl: UILabel!
    
    @IBOutlet var valuelbl: UILabel!
    
    
    @IBOutlet var dcrNameCurvedView: UIView!
    
    @IBOutlet var productnameCurvedView: UIView!
    
    @IBOutlet var productQtyCurvedView: UIView!
    
    @IBOutlet var rateCurvedView: UIView!
    
    @IBOutlet var valueCurvedVIew: UIView!
    
    @IBOutlet var btnAddRCPA: UIButton!
    
    @IBOutlet var rcpaEntryView: UIView!
    @IBOutlet var contentsSectionVIew: UIView!
    
    @IBOutlet var yettoaddSectionView: UIView!
    
    @IBOutlet var navigationVIew: UIView!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var searchView: UIView!
    
    @IBOutlet var detailsTable: UITableView!
    
    @IBOutlet var segmentsCollection: UICollectionView!
    
    @IBOutlet var yetToloadContentsTable: UITableView!
    
    @IBOutlet var loadedContentsTable: UITableView!
    
    @IBOutlet var clearView: UIView!
    
    @IBOutlet var yettoaddTableHolder: UIView!
    
    @IBOutlet var saveView: UIView!
    
    @IBOutlet var viewnoRCPA: UIView!
    
    
    @IBOutlet var backGroundVXview: UIView!
    
    @IBOutlet var backgroundView: UIView!
    
    var selectedSegment: SegmentType = .detailed
    var selectedDoctorIndex = 0
    var searchText: String = ""
    var selectedSegmentsIndex: Int = 0
    var addCallinfoVC : AddCallinfoVC!
    let appsetup = AppDefaults.shared.getAppSetUp()
    var segmentType: [SegmentType] = []
    var inputSelectedListViewModel = InputSelectedListViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     var rcpaDetailsModel :  [RCPAdetailsModal] = []
     var eventCaptureListViewModel = EventCaptureListViewModel()
     var jointWorkSelectedListViewModel = JointWorksListViewModel()
     var tpDeviateReasonView:  TPdeviateReasonView?
     var jfwView : JfwView?
    var detailedSlideInfoView: DetailedSlideInfoView?
    var pobValue: String?
    var overallFeedback: Feedback?
    var overallRemarks: String?
 
    var productObj: NSManagedObject?
    var chemistObj: NSManagedObject?
    var selectedChemistRcpa : AnyObject?
    var productQty: String = "1"
    var rateInt: Int = 0
    var selectedProductIndex: Int = 0
    var selectedProductRcpa : AnyObject?
    var selectedAddcompetitorSection: Int = 0
    var selectedAddcompetitorProductRow: Int = 0
    var selectedAddcompetitorRow: Int = 0
    var customerCheckoutView: CustomerCheckoutView?
    var selectedCompetitor: Competitor?
    var additionalCompetitorsInfo: AdditionalCompetitorsInfo?
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.addCallinfoVC = baseVC as? AddCallinfoVC
        NotificationCenter.default.addObserver(self, selector: #selector(networkModified(_:)) , name: NSNotification.Name("connectionChanged"), object: nil)
       setupUI()
       toLoadSegments()
        cellregistration()
        toloadYettables()
        initVIews()
       // toloadContentsTable()
    }
    
    
    
    
    override func didLayoutSubviews(baseVC: BaseViewController) {
        super.didLayoutSubviews(baseVC: baseVC)
        
        let changePasswordViewwidth = self.bounds.width
        let changePasswordViewheight = self.bounds.height / 1.4
        
        let changePasswordViewcenterX = self.bounds.midX - (changePasswordViewwidth / 2)
       // let changePasswordViewcenterY = self.bounds.midY - (changePasswordViewheight / 2)
        
        self.jfwView?.frame = CGRect(x: changePasswordViewcenterX, y: segmentCollectionHolder.bottom + 5, width: changePasswordViewwidth, height: changePasswordViewheight)
        
        self.detailedSlideInfoView?.frame = CGRect(x: changePasswordViewcenterX, y: segmentCollectionHolder.bottom + 5, width: changePasswordViewwidth, height: changePasswordViewheight)
        
        let  tpDeviateVIewwidth = self.bounds.width / 1.7
        let  tpDeviateVIewheight = self.bounds.height / 2.7
        
        let  tpDeviateVIewcenterX = self.bounds.midX - (tpDeviateVIewwidth / 2)
        let tpDeviateVIewcenterY = self.bounds.midY - (tpDeviateVIewheight / 2)
        
        
        tpDeviateReasonView?.frame = CGRect(x: tpDeviateVIewcenterX, y: tpDeviateVIewcenterY, width: tpDeviateVIewwidth, height: tpDeviateVIewheight)
        
        
        
        
        let checkinDetailsVIewwidth = self.bounds.width / 3
        let checkinDetailsVIewheight = self.bounds.height / 2.3
        
        let checkinDetailsVIewcenterX = self.bounds.midX - (checkinDetailsVIewwidth / 2)
        let checkinDetailsVIewcenterY = self.bounds.midY - (checkinDetailsVIewheight / 2)
        
        
        customerCheckoutView?.frame = CGRect(x: checkinDetailsVIewcenterX, y: checkinDetailsVIewcenterY, width: checkinDetailsVIewwidth, height: checkinDetailsVIewheight)
        
        
    }
    
    @objc func networkModified(_ notification: NSNotification) {
        
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let status = dict["Type"] as? String{
                DispatchQueue.main.async {
                    if status == ReachabilityManager.ReachabilityStatus.notConnected.rawValue  {
                        
                        self.toCreateToast("Please check your internet connection.")
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: false)
                        //  self.toConfigureMydayPlan()
                        
                    } else if  status == ReachabilityManager.ReachabilityStatus.wifi.rawValue || status ==  ReachabilityManager.ReachabilityStatus.cellular.rawValue   {
                        
                        self.toCreateToast("You are now connected.")
                        LocalStorage.shared.setBool(LocalStorage.LocalValue.isConnectedToNetwork, value: true)
                    }
                }
            }
        }
    }
    
    func checkoutAction(dcrCall: CallViewModel? = nil) {
        backgroundView.isHidden = false
        backGroundVXview.alpha = 0.3
        
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case tpDeviateReasonView:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                
            case customerCheckoutView:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                
                
            case jfwView:
                aAddedView.alpha = 0.3
                
            case detailedSlideInfoView:
                aAddedView.alpha = 0.3
                
            case backgroundView:
                aAddedView.isUserInteractionEnabled = true
              
            default:
                print("Yet to implement")
          
                
                aAddedView.isUserInteractionEnabled = false
              
                
            }
            
        }
        
        
        customerCheckoutView = self.addCallinfoVC.loadCustomView(nibname: XIBs.customerCheckoutView) as? CustomerCheckoutView
        customerCheckoutView?.delegate = self
        customerCheckoutView?.dcrCall = dcrCall
        if let nonNillcall = dcrCall {
            customerCheckoutView?.setupUI(dcrCall: nonNillcall)
        }
       
        //customerCheckoutView?.userstrtisticsVM = self.userststisticsVM
        //customerCheckoutView?.appsetup = self.appSetups

        
        
        self.addSubview(customerCheckoutView ?? CustomerCheckoutView())
        
        
    }
    
    
    func competitorCommentAction(isForremarks: Bool, remarksStr: String?) {
        backgroundView.isHidden = false
        backGroundVXview.alpha = 0.3
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case tpDeviateReasonView:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                
            case detailedSlideInfoView:
                detailedSlideInfoView?.alpha = 0.3
                
            case backgroundView:
                aAddedView.isUserInteractionEnabled = true
            default:
                
                print("Yet to implement")
                aAddedView.isUserInteractionEnabled = false
                
                
            }
            
        }
        
        tpDeviateReasonView = self.addCallinfoVC.loadCustomView(nibname: XIBs.tpDeviateReasonView) as? TPdeviateReasonView
        tpDeviateReasonView?.delegate = self
        if self.segmentType[selectedSegmentsIndex] == .detailed {
            tpDeviateReasonView?.productIndex = self.selectedProductIndex
        }
        tpDeviateReasonView?.addedSubviewDelegate = self
        tpDeviateReasonView?.isForRemarks = isForremarks
        tpDeviateReasonView?.remarks = remarksStr == "" ? nil :  remarksStr
        tpDeviateReasonView?.setupui()
        self.addSubview(tpDeviateReasonView ?? TPdeviateReasonView())
    }
    
    func didClose() {
        self.backgroundView.isHidden = true
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case jfwView:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
//            case detailedSlideInfoView:
//                aAddedView.removeFromSuperview()
//                aAddedView.alpha = 0
            case tpDeviateReasonView:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
                
            case customerCheckoutView:
                 aAddedView.removeFromSuperview()
                 aAddedView.alpha = 0
                
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
            }
            
        }
    }
    func detailedInfoAction() {
        
        
        
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case detailedSlideInfoView:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1

            default:
                
                print("Yet to implement")
                aAddedView.isUserInteractionEnabled = true
                
                
            }
            
        }
        
        detailedSlideInfoView = self.addCallinfoVC.loadCustomView(nibname: XIBs.detailedSlideInfoView) as? DetailedSlideInfoView
        detailedSlideInfoView?.delegate = self
      //  jfwView?.rootVC = self.addCallinfoVC
      //  jfwView?.pobValue = self.pobValue ?? nil
       // jfwView?.overallFeedback = self.overallFeedback ?? nil
      //  jfwView?.overallRemark = self.overallRemarks ?? nil
       // jfwView?.eventCaptureListViewModel = self.eventCaptureListViewModel
       // jfwView?.jointWorkSelectedListViewModel = self.jointWorkSelectedListViewModel
       // jfwView?.delegate = self
       // jfwView?.dcrCall = self.addCallinfoVC.dcrCall
        detailedSlideInfoView?.setupui()
        self.addSubview(detailedSlideInfoView ?? DetailedSlideInfoView())
        
    }
    
    func jfwAction() {

        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case jfwView:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1

            default:
                
                print("Yet to implement")
                aAddedView.isUserInteractionEnabled = true
                
                
            }
            
        }
        
        jfwView = self.addCallinfoVC.loadCustomView(nibname: XIBs.jfwView) as? JfwView
        jfwView?.rootVC = self.addCallinfoVC
        jfwView?.pobValue = self.pobValue ?? nil
        jfwView?.overallFeedback = self.overallFeedback ?? nil
        jfwView?.overallRemark = self.overallRemarks ?? nil
        jfwView?.eventCaptureListViewModel = self.eventCaptureListViewModel
        jfwView?.jointWorkSelectedListViewModel = self.jointWorkSelectedListViewModel
        jfwView?.delegate = self
        jfwView?.dcrCall = self.addCallinfoVC.dcrCall
        jfwView?.setupUI()
        self.addSubview(jfwView ?? JfwView())
    }
    
    func initVIews() {
        yetTosearchTF.delegate = self
        
        backHolderView.addTap {
            self.addCallinfoVC.navigationController?.popViewController(animated: true)
        }
        
        dcrNameCurvedView.addTap {
            let vc = SpecifiedMenuVC.initWithStory(self, celltype: .chemist)
            vc.isFromfilter = true
            if let chemistobj = self.chemistObj {
                vc.previousselectedObj = chemistobj
            }
            self.addCallinfoVC.modalPresentationStyle = .custom
            self.addCallinfoVC.navigationController?.present(vc, animated: false)
        }
        
        productnameCurvedView.addTap {
            let vc = SpecifiedMenuVC.initWithStory(self, celltype: .product)
            vc.isFromfilter = true
            
            if let productObj = self.productObj {
                vc.previousselectedObj = productObj
            }
           
            self.addCallinfoVC.modalPresentationStyle = .custom
            self.addCallinfoVC.navigationController?.present(vc, animated: false)
        }
        saveView.addTap {
   
            self.fetchLocationAndCheckout()
//            self.addCallinfoVC.toSaveaDCRcall(addedCallID: "1", isDataSent: false) { isSaved in
//                CoreDataManager.shared.tofetchaSavedCalls(callID: "1") { addedDCRcall in
//                    
//                dump(addedDCRcall)
//                    
//                    
//                }
//            }
        }
        
    }
    
    func cellregistration() {
        
        //yettoloadtable
        self.yetToloadContentsTable.register(UINib(nibName: "ProductNameWithSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameWithSampleTableViewCell")
        
        
        self.yetToloadContentsTable.register(UINib(nibName: "ProductNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameTableViewCell")
        
        
        
        //loadedcontentstable
        self.loadedContentsTable.register(UINib(nibName: "ProductSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductSampleTableViewCell")
        
  
        
        self.loadedContentsTable.register(UINib(nibName: "RcpaAddedListTableViewCell", bundle: nil), forCellReuseIdentifier: "RcpaAddedListTableViewCell")
        
        self.loadedContentsTable.register(UINib(nibName: "InputSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "InputSampleTableViewCell")
        
        
        
        
        self.loadedContentsTable.register(UINib(nibName: "AdditionalCallSampleInputTableViewCell", bundle: nil), forCellReuseIdentifier: "AdditionalCallSampleInputTableViewCell")
        
        
        
        
        //headers
        
        
        self.loadedContentsTable.register(UINib(nibName: "CompetitorsFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "CompetitorsFooter")
        
        self.loadedContentsTable.register(UINib(nibName: "RCPASectionheader", bundle: nil), forHeaderFooterViewReuseIdentifier: "RCPASectionheader")
        self.loadedContentsTable.register(UINib(nibName: "ProductsInfoHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ProductsInfoHeader")
        
        self.loadedContentsTable.register(UINib(nibName: "ProductInputsHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ProductInputsHeader")
        
        self.loadedContentsTable.register(UINib(nibName: "AdditionalCallsHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "AdditionalCallsHeader")
        
    }
    
    func toloadYettables() {
        yetToloadContentsTable.delegate = self
        yetToloadContentsTable.dataSource = self
        yetToloadContentsTable.reloadData()
    }
    
    
    func  toloadContentsTable() {
        loadedContentsTable.delegate = self
        loadedContentsTable.dataSource = self
        loadedContentsTable.reloadData()
    }
    
    func toLoadSegments() {
        segmentsCollection.isScrollEnabled = false
        if addCallinfoVC.dcrCall.call is DoctorFencing {
       //     if appsetup.docr == 0 {
            if Shared.instance.isDetailed {
                segmentType = [.detailed, .products, .inputs, .additionalCalls, .rcppa, .jointWork]
            } else {
                segmentType = [.detailed, .products, .inputs, .additionalCalls, .rcppa, .jointWork]
            }
               
//            } else {
//                segmentType = [.products, .inputs, .additionalCalls, .jointWork]
//            }
           
          
        }
        
        
        if addCallinfoVC.dcrCall.call is Chemist {
         //   if appsetup.chmRcpaNeed == 0 {
                segmentType = [.detailed, .products, .inputs, .rcppa, .jointWork]
//            } else {
//                segmentType = [.detailed, .products, .inputs, .jointWork]
//            }
           
        }
        
        if addCallinfoVC.dcrCall.call is Stockist {
        //    if appsetup.stk == 0 {
                segmentType = [.detailed, .products, .inputs, .rcppa, .jointWork]
//            } else {
//                segmentType = [.detailed, .products, .inputs, .jointWork]
//            }
           
        }
        
        
        if addCallinfoVC.dcrCall.call is UnListedDoctor {
           // if appsetup.docPobNeed == 0 {
                segmentType = [.detailed, .products, .inputs, .additionalCalls, .rcppa, .jointWork]
//            } else {
//                segmentType = [.detailed, .products, .inputs, .jointWork]
//            }
           
        }
     
        self.segmentsCollection.register(UINib(nibName: "PreviewTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PreviewTypeCVC")
        segmentsCollection.delegate = self
        segmentsCollection.dataSource = self
        segmentsCollection.reloadData()
        self.setSegment(.detailed)
    }
    
    
    func setupUI() {
        backgroundView.isHidden = true
        let curvedVIews: [UIView] = [dcrNameCurvedView, productnameCurvedView, productQtyCurvedView, rateCurvedView, valueCurvedVIew]
        
        btnAddRCPA.layer.cornerRadius = 5
      
                             
        btnAddRCPA.addTarget(self, action: #selector(rcpaAddCompetitorAction(_:)), for: .touchUpInside)
        
    
       
                             
        curvedVIews.forEach {
            if $0 != rateCurvedView ||  $0 != valueCurvedVIew {
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.1).cgColor
             
            } else {
            
            }
            $0.layer.cornerRadius = 5
        }
        
        rateCurvedView.backgroundColor = .appLightTextColor.withAlphaComponent(0.1)
        
        
        valueCurvedVIew.backgroundColor = .appLightTextColor.withAlphaComponent(0.1)
        productQtyTF.delegate = self
        productQtyTF.text = "1"
        loadedContentsTable.separatorStyle = .none
        self.backgroundColor = .appGreyColor
        contentsSectionVIew.layer.cornerRadius = 5
        yettoaddTableHolder.layer.cornerRadius = 5
        yettoaddSectionView.layer.cornerRadius = 5
        searchView.layer.cornerRadius = 5
       // searchView.layer.borderWidth = 1
       // searchView.layer.borderColor = UIColor.appLightTextColor.withAlphaComponent(0.2).cgColor
        saveView.layer.cornerRadius = 5
        saveView.backgroundColor = .appTextColor
        
        clearView.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.2).cgColor
        clearView.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        clearView.layer.borderWidth = 1
        clearView.layer.cornerRadius = 5
        
        backgroundView.addTap {
            self.didClose()
        }
        
        self.titleLbl.text = addCallinfoVC.dcrCall.name
 
    }
    
    @IBAction func productQtyAction(_ sender: UITextField) {
        
        let qtyInt: Int = Int(self.productQty) ?? 1
        rateLbl.text = "\(rateInt)"
        valuelbl.text = "\(rateInt * qtyInt)"
        
    }
    
    
    func getCurrentFormattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        return dateFormatter.string(from: Date())
    }
    
    func fetchLocationAndCheckout() {
        Pipelines.shared.requestAuth() {[weak self] coordinates  in
            guard let welf = self else {return}
            guard let coordinates = coordinates else {
                
                welf.showAlert()
                
                return
            }
            if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
                Pipelines.shared.getAddressString(latitude: coordinates.latitude ?? Double(), longitude:  coordinates.longitude ?? Double()) { [weak self] address in
                    guard let welf = self else {return}
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                    
//                    let currentDate = Date()
//                    let dateString = dateFormatter.string(from: currentDate)
//                    
//                    _ = dateString
                    
                    welf.addCallinfoVC.dcrCall.checkOutlatitude = coordinates.latitude ?? Double()
                    welf.addCallinfoVC.dcrCall.checkOutlongitude = coordinates.longitude ?? Double()
                    welf.addCallinfoVC.dcrCall.customerCheckOutAddress = address ?? "No address found"
                    let dcrCall = welf.addCallinfoVC.dcrCall
                    
                    
                    welf.checkoutAction(dcrCall: dcrCall)
                    
                    
                    
                }
            } else {
                welf.addCallinfoVC.dcrCall.checkOutlatitude = coordinates.latitude ?? Double()
                welf.addCallinfoVC.dcrCall.checkOutlongitude = coordinates.longitude ?? Double()
                welf.addCallinfoVC.dcrCall.customerCheckOutAddress = "No Address found"
                let dcrCall = welf.addCallinfoVC.dcrCall
                
                
                welf.checkoutAction(dcrCall: dcrCall)
            }
            

            
            
            
        }
    }
    
    
}


extension AddCallinfoView : CompetitorsFooterDelegate {
    func didUpdateComperirorValue(additionalCompetitorsInfo: AdditionalCompetitorsInfo, section: Int, index: Int, competitorIndex: Int) {
//        self.additionalCompetitorsInfo = additionalCompetitorsInfo
//        selectedAddcompetitorRow = competitorIndex
//        selectedAddcompetitorSection = section
//        selectedAddcompetitorProductRow = index
        
        
        self.rcpaDetailsModel[section].addedProductDetails?.addedProduct?[index].competitorsInfo?[competitorIndex] = additionalCompetitorsInfo
        
        self.loadedContentsTable.reloadData()
        
    }
    
    func didTapEditCompetitor(competitor: Competitor, section: Int, index: Int, competitorIndex: Int) {
      //  selectedProductIndex = index
        selectedCompetitor = competitor
        selectedAddcompetitorRow = competitorIndex
        selectedAddcompetitorSection = section
        selectedAddcompetitorProductRow = index
     //   self.rcpaDetailsModel[section].addedProductDetails?.addedProduct?[index].competitorsInfo?[selectedAddcompetitorRow]
        
        guard let remarksStr : String? = self.rcpaDetailsModel[section].addedProductDetails?.addedProduct?[index].competitorsInfo?[selectedAddcompetitorRow].remarks else {
            
            self.competitorCommentAction(isForremarks: true, remarksStr: nil)
            return}
        
         self.competitorCommentAction(isForremarks: true, remarksStr: remarksStr)
     
    }
    
    func didTapdeleteCompetitor(competitor: Competitor, section: Int, index: Int, competitorIndex: Int) {
        
        self.rcpaDetailsModel[section].addedProductDetails?.addedProduct?[index].competitorsInfo?.remove(at: competitorIndex)
        
        
      //  self.rcpaDetailsModel[section].addedProductDetails?.addedProduct?[index].removeCompetitorInfo(forCompetitor: competitor)
        
        self.loadedContentsTable.reloadData()
    }
    
    func didTapdelete(section: Int, index: Int) {
       // self.rcpaAddedListViewModel.removecompetitor(section: section, index: index)
        
    
     //   self.rcpaDetailsModel[section].competitor?.remove(at: index)
      //  self.loadedContentsTable.reloadData()
        print("Yet to delete")
    }

    
    
}


extension AddCallinfoView : JfwViewDelegate {
    func selectedObjects(eventcptureVM: EventCaptureListViewModel, jointWorkSelectedListViewModel: JointWorksListViewModel, POBValue: String, overallFeedback: Feedback, overallRemarks: String) {
        self.eventCaptureListViewModel = eventcptureVM
        self.jointWorkSelectedListViewModel = jointWorkSelectedListViewModel
        self.pobValue = POBValue
        self.overallFeedback = overallFeedback
        self.overallRemarks = overallRemarks
    }
    
    
}


extension AddCallinfoView : addedSubViewsDelegate {
    func didUpdateCustomerCheckin(dcrCall: CallViewModel) {
//        if let jfwView = self.jfwView {
//            jfwView.alpha = 0.3
//        }
        
        self.addCallinfoVC.setupParam(dcrCall: dcrCall)

    
    }
    
    
    func didUpdateFilters(filteredObjects: [NSManagedObject]) {
        print("Yet to implement")
    }
    
    func showAlert() {
        print("Yet to implement")
    }
    
    
    func didUpdate() {
        print("Yet to implement")
    }

}


extension AddCallinfoView : SessionInfoTVCDelegate {
    
    func handleAddedRemarks(remarksStr: String) {

      //  let aCompetitorInfo = AdditionalCompetitorsInfo(competitor: selectedCompetitor, qty: "", remarks: remarksStr, rate: "", value: "")
        
        self.rcpaDetailsModel[selectedAddcompetitorSection].addedProductDetails?.addedProduct?[selectedAddcompetitorProductRow].competitorsInfo?[selectedAddcompetitorRow].remarks = remarksStr
        
        self.loadedContentsTable.reloadData()
    }
    
    func handleProductsRemarks(remarksStr: String, index: Int) {
        Shared.instance.detailedSlides[index].remarks = remarksStr
    }
    
    func remarksAdded(remarksStr: String, index: Int) {
        
        dump(remarksStr)

        backgroundView.isHidden = true
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case tpDeviateReasonView:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
  
                
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
            }

        }
        if self.segmentType[selectedSegmentsIndex] == .detailed {
            handleProductsRemarks(remarksStr: remarksStr, index: index)
        } else {
            handleAddedRemarks(remarksStr: remarksStr)
        }
       

    }
    
    
    
    
    
}
extension AddCallinfoView :  DetailedSlideInfoViewDelegate {
    func didCommentTapped(comments: String, index: Int) {
        let addedcomments = Shared.instance.detailedSlides[index].remarks == nil ? comments :  Shared.instance.detailedSlides[index].remarks
        competitorCommentAction(isForremarks: true, remarksStr: addedcomments)
        self.selectedProductIndex = index
    }
    
    func didRatingTapped(rating: Int, index: Int) {
        Shared.instance.detailedSlides[index].remarksValue = Float(rating)
    }
    
}


extension CoreDataManager {
    
    
    func convertToCompetitorinfoArr(_ additionalCompetiors: [AdditionalCompetitorsInfo], context: NSManagedObjectContext, completion: @escaping (NSSet) -> Void) {
       let additionalCompetitorSet = NSMutableSet()

       // Create a dispatch group to handle asynchronous tasks
       let dispatchGroup = DispatchGroup()

       // Iterate over each GroupedBrandsSlideModel
       for additionalCompetior in additionalCompetiors {
           dispatchGroup.enter()

           if let entityDescription = NSEntityDescription.entity(forEntityName: "AdditionalCompetitorsInfoCDModel", in: context) {
               let additionalCompetiorsCDModel = AdditionalCompetitorsInfoCDModel(entity: entityDescription, insertInto: context)
 
               additionalCompetiorsCDModel.qty = additionalCompetior.qty
               additionalCompetiorsCDModel.rate = additionalCompetior.rate
               additionalCompetiorsCDModel.remarks = additionalCompetior.remarks
               additionalCompetiorsCDModel.value = additionalCompetior.value
               
               if let entityDescription = NSEntityDescription.entity(forEntityName: "Competitor", in: context) {
                   let aCompetitor = Competitor(entity: entityDescription, insertInto: context)
                   
                   
                   aCompetitor.compName = additionalCompetior.competitor?.compName
                   aCompetitor.compProductName = additionalCompetior.competitor?.compProductName
                   aCompetitor.compProductSlNo = additionalCompetior.competitor?.compProductSlNo
                   aCompetitor.compSlNo = additionalCompetior.competitor?.compSlNo
                   aCompetitor.index = additionalCompetior.competitor?.index ?? 0
                   aCompetitor.ourProductCode = additionalCompetior.competitor?.ourProductCode
                   aCompetitor.ourProductName = additionalCompetior.competitor?.ourProductName
                   
                   additionalCompetiorsCDModel.competitor = aCompetitor
                   
                   
               }
               
               
               // Add to set
               additionalCompetitorSet.add(additionalCompetiorsCDModel)
               dispatchGroup.leave()
           }
       }

       // Notify the completion handler when all tasks in the dispatch group are complete
       dispatchGroup.notify(queue: .main) {
           completion(additionalCompetitorSet)
       }
   }
    
    
    func convertToProductWithCompetitorModelArr(_ productWithCompetiors: [ProductWithCompetiors], context: NSManagedObjectContext, completion: @escaping (NSSet) -> Void) {
        let productWithCompetitorSet = NSMutableSet()
        
        // Create a dispatch group to handle asynchronous tasks
        let dispatchGroup = DispatchGroup()
        
        // Iterate over each GroupedBrandsSlideModel
        for productWithCompetior in productWithCompetiors {
            dispatchGroup.enter()
            
            guard let entityDescriptionProduct = NSEntityDescription.entity(forEntityName: "ProductWithCompetiorsCDModel", in: context),
                  let entityDescriptionProductCD = NSEntityDescription.entity(forEntityName: "Product", in: context)
            else {
                dispatchGroup.leave()
                continue
            }
            
            let productWithCompetiorsCDModel = ProductWithCompetiorsCDModel(entity: entityDescriptionProduct, insertInto: context)
            let productCDModel = Product(entity: entityDescriptionProductCD, insertInto: context)
            
            productCDModel.name = productWithCompetior.addedProduct?.name
            productCDModel.actFlg = productWithCompetior.addedProduct?.actFlg
            productCDModel.cateId = productWithCompetior.addedProduct?.cateId
            productCDModel.code = productWithCompetior.addedProduct?.code
            productCDModel.divisionCode = productWithCompetior.addedProduct?.divisionCode
            productCDModel.dRate = productWithCompetior.addedProduct?.dRate
            productCDModel.index = productWithCompetior.addedProduct?.index ?? 0
            productCDModel.mapId = productWithCompetior.addedProduct?.mapId
            productCDModel.noOfSamples = productWithCompetior.addedProduct?.noOfSamples
            productCDModel.productMode = productWithCompetior.addedProduct?.productMode
            productCDModel.pSlNo = productWithCompetior.addedProduct?.pSlNo
            
            productWithCompetiorsCDModel.addedProduct = productCDModel
            
            
            // Handle competitors info
            if let competitorsInfo = productWithCompetior.competitorsInfo  {
                convertToCompetitorinfoArr(competitorsInfo, context: context) { additionalCompetitorSet in
                    productWithCompetiorsCDModel.competitorsInfoArr = additionalCompetitorSet
                    productWithCompetitorSet.add(productWithCompetiorsCDModel)
                    dispatchGroup.leave()
                }
            } else {
                productWithCompetitorSet.add(productWithCompetiorsCDModel)
                dispatchGroup.leave()
            }
        }
        
        // Notify the completion handler when all tasks in the dispatch group are complete
        dispatchGroup.notify(queue: .main) {
            completion(productWithCompetitorSet)
        }
    }
    
    func toReturnaddedProductDetailsCDEntity(addedProductDetails: ProductDetails, completion: @escaping (ProductDetailsCDModel?) -> Void) {
        
        
        
        
        let context = self.context
        // Create a new managed object
        if let entityDescription = NSEntityDescription.entity(forEntityName: "ProductDetailsCDModel", in: context) {
           // dispatchGroup.enter()
            let aProductDetailsEntity = ProductDetailsCDModel(entity: entityDescription, insertInto: context)

            // Convert properties

            aProductDetailsEntity.addedQuantity =  addedProductDetails.addedQuantity
            
            aProductDetailsEntity.addedRate = addedProductDetails.addedRate
            aProductDetailsEntity.addedTotal = addedProductDetails.addedTotal
            aProductDetailsEntity.addedValue = addedProductDetails.addedValue
          //  aProductDetailsEntity.addedProductArr =
            

            if let productsWithCompetitors = addedProductDetails.addedProduct {
                convertToProductWithCompetitorModelArr(productsWithCompetitors, context: context) {
                    productWithCompetitorSet in
                    
                    aProductDetailsEntity.addedProductArr = productWithCompetitorSet
                    completion(aProductDetailsEntity)
                }
            }
       

        } else {
            
            completion(nil)
        }


}
    
    
    func toReturnRCPAdetailsCDModel(addedRCPAdetails: RCPAdetailsModal, completion: @escaping (RCPAdetailsCDModel?) -> Void) {

            


                let context = self.context
                // Create a new managed object
                if let entityDescription = NSEntityDescription.entity(forEntityName: "RCPAdetailsCDModel", in: context) {
                   // dispatchGroup.enter()
                    let aRCPAdetailsEntity = RCPAdetailsCDModel(entity: entityDescription, insertInto: context)

                    // Convert properties
                    if let entityDescription = NSEntityDescription.entity(forEntityName: "Chemist", in: context) {
                        let aChemist = Chemist(entity: entityDescription, insertInto: context)
                        aChemist.addr = addedRCPAdetails.addedChemist?.addr
                        aChemist.chemistContact = addedRCPAdetails.addedChemist?.chemistContact
                        aChemist.chemistEmail = addedRCPAdetails.addedChemist?.chemistEmail
                        aChemist.chemistFax = addedRCPAdetails.addedChemist?.chemistFax
                        aChemist.chemistMobile = addedRCPAdetails.addedChemist?.chemistMobile
                        aChemist.chemistPhone = addedRCPAdetails.addedChemist?.chemistPhone
                        aChemist.code = addedRCPAdetails.addedChemist?.code
                        aChemist.geoTagCnt = addedRCPAdetails.addedChemist?.geoTagCnt
                        aChemist.index = addedRCPAdetails.addedChemist?.index ?? 0
                        aChemist.lat = addedRCPAdetails.addedChemist?.lat
                        aChemist.long = addedRCPAdetails.addedChemist?.long
                        aChemist.mapId =  addedRCPAdetails.addedChemist?.mapId
                        aChemist.maxGeoMap = addedRCPAdetails.addedChemist?.maxGeoMap
                        aChemist.name = addedRCPAdetails.addedChemist?.name
                        aChemist.sfCode = addedRCPAdetails.addedChemist?.sfCode
                        aChemist.townCode = addedRCPAdetails.addedChemist?.townCode
                        aChemist.townName = addedRCPAdetails.addedChemist?.townName
                        aRCPAdetailsEntity.addedChemist = aChemist
                        
                    }
                    
                    if let addedProductDetails = addedRCPAdetails.addedProductDetails {
                        toReturnaddedProductDetailsCDEntity(addedProductDetails: addedProductDetails) { ProductDetailsCDModel in
                             aRCPAdetailsEntity.addedProductDetails = ProductDetailsCDModel
                            completion(aRCPAdetailsEntity)
                        }
                    }
      
                } else {
                    
                    completion(nil)
                }

    }
    
    
    func toReturnRCPAdetailsCDEntity(rcpadtailsCDModels: [RCPAdetailsModal], completion: @escaping (RCPAdetailsCDEntity?) -> Void) {
        let context = self.context
        
        // Create a new managed object
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "RCPAdetailsCDEntity", in: context) else {
            completion(nil)
            return
        }
        
        let aRCPAdetailsCDArrEntity = RCPAdetailsCDEntity(entity: entityDescription, insertInto: context)
        
        // Create a dispatch group
        let dispatchGroup = DispatchGroup()
        
        // Convert and add
        let rcpaDetailsCDModelSet = NSMutableSet()
        for rcpadtailsCDModel in rcpadtailsCDModels {
            dispatchGroup.enter()
            toReturnRCPAdetailsCDModel(addedRCPAdetails: rcpadtailsCDModel) { rcpaDetailsCDModel in
                if let nonNilRCPAdetailsCDModel = rcpaDetailsCDModel {
                    rcpaDetailsCDModelSet.add(nonNilRCPAdetailsCDModel)
                }
                dispatchGroup.leave()
            }
        }
        
        // Notify when all tasks are complete
        dispatchGroup.notify(queue: .main) {
            aRCPAdetailsCDArrEntity.rcpadtailsCDModelArr = rcpaDetailsCDModelSet
            
            // Call completion handler
            completion(aRCPAdetailsCDArrEntity)
        }
    }
}


extension CoreDataManager {
    
    
    func tofetchaSavedCalls(callID: String, completion: @escaping ([AddedDCRCall]?) -> () )  {
        do {
            let request = AddedDCRCall.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "addedCallID == %@", callID)
            //LIKE
            request.predicate = pred
            let calls = try context.fetch(request)
            if calls.isEmpty {
                completion(nil)
            } else {
                completion(calls)
            }
        } catch {
            print("unable to fetch")
            completion(nil)
        }
    }

}

extension CoreDataManager {
    
    func toReturnAdditionalCallCDModel(addedAdditionalCalls: AdditionalCallsListViewModel, completion: @escaping (AdditionalCallCDModel?) -> Void) {
        let context = self.context
        
        // Create a new managed object
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "AdditionalCallCDModel", in: context) else {
            print("Failed to get entity description")
            completion(nil)
            return
        }
        
        let aAdditionalCallEntity = AdditionalCallCDModel(entity: entityDescription, insertInto: context)
        let additioncallDatum = addedAdditionalCalls.getAdditionalCallData()
        
        let dispatchGroup = DispatchGroup()
        
        // Iterate over each additional call data
        for additioncallData in additioncallDatum {
            dispatchGroup.enter()
            
            convertToInputViewModelArr(additioncallData.inputs, context: context) { inputViewModelSet in
                aAdditionalCallEntity.inputs = inputViewModelSet
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            convertToProductViewModelArr(additioncallData.products, context: context) { productModelSet in
                aAdditionalCallEntity.products = productModelSet
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            toReturnInputViewModelCDModel(addedinputs: additioncallData.inputSelectedListViewModel) { inputsViewModel in
                aAdditionalCallEntity.inputSelectedListViewModel = inputsViewModel
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            toReturnProductViewModelCDModel(addedProducts: additioncallData.productSelectedListViewModel) { productsViewModel in
                aAdditionalCallEntity.productSelectedListViewModel = productsViewModel
                dispatchGroup.leave()
            }
        }
        
        // Notify completion when all tasks in the dispatch group are completed
        dispatchGroup.notify(queue: .main) {
            completion(aAdditionalCallEntity)
        }
    }

    
    
    func convertToAdditionalCallViewModelArr(_ jointWorkViewModels: [JointWorkViewModel], context: NSManagedObjectContext, completion: @escaping (NSSet) -> Void) {
       let jointWorkViewModelsSet = NSMutableSet()

       // Create a dispatch group to handle asynchronous tasks
       let dispatchGroup = DispatchGroup()

       // Iterate over each GroupedBrandsSlideModel
       for jointWorkViewModel in jointWorkViewModels {
           dispatchGroup.enter()

           if let entityDescription = NSEntityDescription.entity(forEntityName: "JointWorkDataCDModel", in: context) {
               let jointWorkDataCDModel = JointWorkDataCDModel(entity: entityDescription, insertInto: context)
 
               jointWorkDataCDModel.jointWork = jointWorkViewModel.jointWork
               // Add to set
               jointWorkViewModelsSet.add(jointWorkDataCDModel)
           }
       }

       // Notify the completion handler when all tasks in the dispatch group are complete
       dispatchGroup.notify(queue: .main) {
           completion(jointWorkViewModelsSet)
       }
   }
    
    
    
    func toReturnJointWorkViewModelCDModel(addedJonintWorks: JointWorksListViewModel, completion: @escaping (JointWorkViewModelCDEntity?) -> Void) {

            


                let context = self.context
                // Create a new managed object
                if let entityDescription = NSEntityDescription.entity(forEntityName: "JointWorkViewModelCDEntity", in: context) {
                   // dispatchGroup.enter()
                    let ajwEntity = JointWorkViewModelCDEntity(entity: entityDescription, insertInto: context)

                    // Convert properties
                  //  aInputEntity.uuid = UUID()
                    
                    // Convert and add
              
                    convertToJointworkViewModelArr(addedJonintWorks.getJointWorkData(), context: context){ jwViewModelSet in
                        ajwEntity.jointWorkViewModelArr = jwViewModelSet

                        completion(ajwEntity)
                
                    }
                } else {
                    
                    completion(nil)
                }
 

    }
    
    
    func convertToJointworkViewModelArr(_ jointWorkViewModels: [JointWorkViewModel], context: NSManagedObjectContext, completion: @escaping (NSSet) -> Void) {
       let jointWorkViewModelsSet = NSMutableSet()

       // Create a dispatch group to handle asynchronous tasks
       let dispatchGroup = DispatchGroup()

       // Iterate over each GroupedBrandsSlideModel
       for jointWorkViewModel in jointWorkViewModels {
           dispatchGroup.enter()

           if let entityDescription = NSEntityDescription.entity(forEntityName: "JointWorkDataCDModel", in: context) {
               let jointWorkDataCDModel = JointWorkDataCDModel(entity: entityDescription, insertInto: context)
 
              
               if let entityDescription = NSEntityDescription.entity(forEntityName: "JointWork", in: context) {
                   let jwCDModel = JointWork(entity: entityDescription, insertInto: context)
                   jwCDModel.actFlg = jointWorkViewModel.jointWork.actFlg
                   jwCDModel.code = jointWorkViewModel.jointWork.code
                   jwCDModel.desig = jointWorkViewModel.jointWork.desig
                   jwCDModel.divisionCode = jointWorkViewModel.jointWork.divisionCode
                   jwCDModel.index = jointWorkViewModel.jointWork.index
                   jwCDModel.mapId = jointWorkViewModel.jointWork.mapId
                   jwCDModel.name = jointWorkViewModel.jointWork.name
                   jwCDModel.ownDiv = jointWorkViewModel.jointWork.ownDiv
                   jwCDModel.reportingToSF = jointWorkViewModel.jointWork.reportingToSF
                   jwCDModel.sfName = jointWorkViewModel.jointWork.sfName
                   jwCDModel.sfStatus = jointWorkViewModel.jointWork.sfStatus
                   jwCDModel.sfType = jointWorkViewModel.jointWork.sfType
                   jwCDModel.steps = jointWorkViewModel.jointWork.steps
                   jwCDModel.usrDfdUserName = jointWorkViewModel.jointWork.usrDfdUserName
                   
                   
                   jointWorkDataCDModel.jointWork = jwCDModel
               }
               
               
               // Add to set
               jointWorkViewModelsSet.add(jointWorkDataCDModel)
               dispatchGroup.leave()
           }
       }

       // Notify the completion handler when all tasks in the dispatch group are complete
       dispatchGroup.notify(queue: .main) {
           completion(jointWorkViewModelsSet)
       }
   }
    
    
        func toReturnInputViewModelCDModel(addedinputs: InputSelectedListViewModel, completion: @escaping (InputViewModelCDEntity?) -> Void) {
    
                
     
          
                    let context = self.context
                    // Create a new managed object
                    if let entityDescription = NSEntityDescription.entity(forEntityName: "InputViewModelCDEntity", in: context) {
                      
                        let aInputEntity = InputViewModelCDEntity(entity: entityDescription, insertInto: context)
    
                        // Convert properties
                        aInputEntity.uuid = UUID()
                        
                        // Convert and add
            
                        convertToInputViewModelArr(addedinputs.inputData(), context: context){ inputViewModelSet in
                            aInputEntity.inputViewModelArr = inputViewModelSet as! NSMutableSet
    
                            completion(aInputEntity)
                        
                        }
                    } else {
                        completion(nil)
                
                    }
     
    
        }
    
    
        func convertToInputViewModelArr(_ inputViewModels: [InputViewModel], context: NSManagedObjectContext, completion: @escaping (NSSet) -> Void) {
           let inputViewModelsSet = NSMutableSet()
    
           // Create a dispatch group to handle asynchronous tasks
           let dispatchGroup = DispatchGroup()
    
           // Iterate over each GroupedBrandsSlideModel
           for inputViewModel in inputViewModels {
               dispatchGroup.enter()
    
               if let entityDescription = NSEntityDescription.entity(forEntityName: "InputDataCDModel", in: context) {
                   let inputDataCDModel = InputDataCDModel(entity: entityDescription, insertInto: context)
     
                   inputDataCDModel.availableCount = inputViewModel.input.availableCount
                   inputDataCDModel.inputCount = inputViewModel.input.inputCount
                   
                   // Fetch or create the corresponding Input managed object
                   if let entityDescription = NSEntityDescription.entity(forEntityName: "Input", in: context) {
                       let inputCDModel = Input(entity: entityDescription, insertInto: context)
                       inputCDModel.name =  inputViewModel.input.input?.name
                       inputCDModel.code =  inputViewModel.input.input?.code
                       inputCDModel.index = inputViewModel.input.input?.index ?? 0
                       inputCDModel.mapId = inputViewModel.input.input?.mapId
       
                       
                       let effF = inputViewModel.input.input?.effF
                       let effT = inputViewModel.input.input?.effT
                       if let entityDescription = NSEntityDescription.entity(forEntityName: "Efff", in: context) {
                           let effFCDModel = Efff(entity: entityDescription, insertInto: context)
                           
                           effFCDModel.timeZone = effF?.timeZone
                           effFCDModel.date = effF?.date
                           effFCDModel.timeZoneType = effF?.timeZoneType ?? 0
                           
                           inputCDModel.effF = effFCDModel
                           
                           let effTCDModel = Efff(entity: entityDescription, insertInto: context)
                           effTCDModel.timeZone = effT?.timeZone
                           effTCDModel.date = effT?.date
                           effTCDModel.timeZoneType = effT?.timeZoneType ?? 0
                           
                           inputCDModel.effT = effTCDModel
                           
                           inputDataCDModel.input = inputCDModel
                   }
                   }
                   // Add to set
                   inputViewModelsSet.add(inputDataCDModel)
                   dispatchGroup.leave()
               }
           }
    
           // Notify the completion handler when all tasks in the dispatch group are complete
           dispatchGroup.notify(queue: .main) {
               completion(inputViewModelsSet)
           }
       }
}


extension CoreDataManager {
    
    func fetchProductViewModels(completion: ([ProductViewModelCDEntity]) -> () )  {
        do {
            let savedVIewModels = try  context.fetch(ProductViewModelCDEntity.fetchRequest())
            completion(savedVIewModels )
            
        } catch {
            print("unable to fetch movies")
        }
        
    }
    
    
    func toCheckExistanceOfProductViewModel(_ id: UUID, completion: (Bool) -> ()) {
        
        do {
            let request = ProductViewModelCDEntity.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(id)'")
            //LIKE
            request.predicate = pred
            let films = try context.fetch(request)
            if films.isEmpty {
                completion(false)
            } else {
                completion(true)
            }
        } catch {
            print("unable to fetch")
            completion(false)
        }
    }
    
    
    
    func toRemoveProductViewModel(_ id: UUID, completion: (Bool) -> ()) {
        
        
        do {
            let request = ProductViewModelCDEntity.fetchRequest() as NSFetchRequest
            let pred = NSPredicate(format: "uuid == '\(id)'")
            request.predicate = pred
            let presentations = try context.fetch(request)
            if presentations.isEmpty {
                completion(false)
            } else {
                let presentationToRemove = presentations[0]
                self.context.delete(presentationToRemove)
                do {
                    try self.context.save()
                    completion(true)
                } catch {
                    completion(false)
                }
                completion(true)
            }
        } catch {
            print("unable to fetch")
            completion(false)
        }
        
    }
    
    

    
    
    func toReturnProductViewModelCDModel(addedProducts: ProductSelectedListViewModel, completion: @escaping (Bool) -> Void) {
    
            var tempcompletion: Bool = false
            let dispatchGroup = DispatchGroup()
                let context = self.context
                // Create a new managed object
                if let entityDescription = NSEntityDescription.entity(forEntityName: "ProductViewModelCDEntity", in: context) {
                    dispatchGroup.enter()
                    let aProductEntity = ProductViewModelCDEntity(entity: entityDescription, insertInto: context)
                    
                    // Convert properties
                    aProductEntity.uuid = UUID()
                    // Convert and add
                    convertToProductViewModelArr(addedProducts.productData(), context: context){ productViewModelSet in
                        aProductEntity.productViewModelArr = productViewModelSet
                        
                        // Save to Core Data
                        do {
                            try context.save()
                            tempcompletion = true
                            dispatchGroup.leave()
                        } catch {
                            print("Failed to save to Core Data: \(error)")
                            tempcompletion = false
                            dispatchGroup.leave()
                        }
                    }
                }
            
            // Notify the completion handler when all tasks in the dispatch group are complete
            dispatchGroup.notify(queue: .main) {
                completion(tempcompletion)
            }
        
    }
                    

        
    func toReturnProductViewModelCDModel(addedProducts: ProductSelectedListViewModel, completion: @escaping (ProductViewModelCDEntity?) -> Void) {
        let productUUID = addedProducts.uuid ?? UUID()
        let context = self.context
        // Create a new managed object
        if let entityDescription = NSEntityDescription.entity(forEntityName: "ProductViewModelCDEntity", in: context) {
            
            let aProductEntity = ProductViewModelCDEntity(entity: entityDescription, insertInto: context)
            
            // Convert properties
            aProductEntity.uuid = productUUID
            
            // Convert and add
            convertToProductViewModelArr(addedProducts.productData(), context: context) { productViewModelSet in
                aProductEntity.productViewModelArr = productViewModelSet
                completion(aProductEntity)
            }
        } else {
            completion(nil) // Entity creation failed
        }
    }
        
    
    

    
    
     func convertToProductViewModelArr(_ productViewModels: [ProductViewModel], context: NSManagedObjectContext, completion: @escaping (NSSet) -> Void) {
        let productViewModelsSet = NSMutableSet()

        // Create a dispatch group to handle asynchronous tasks
        let dispatchGroup = DispatchGroup()

        // Iterate over each GroupedBrandsSlideModel
        for productViewModel in productViewModels {
            dispatchGroup.enter()

            if let entityDescription = NSEntityDescription.entity(forEntityName: "ProductDataCDModel", in: context) {
                let productDataCDModel = ProductDataCDModel(entity: entityDescription, insertInto: context)
                productDataCDModel.availableCount = productViewModel.availableCount
                productDataCDModel.isDetailed = productViewModel.isDetailed
                productDataCDModel.rcpaCount = productViewModel.rcpaCount
                productDataCDModel.rxCount = productViewModel.rxCount
                productDataCDModel.sampleCount = productViewModel.sampleCount
                productDataCDModel.stockistCode = productViewModel.stockistCode
                productDataCDModel.stockistName = productViewModel.stockistName
                productDataCDModel.totalCount = productViewModel.totalCount

                if let entityDescription = NSEntityDescription.entity(forEntityName: "Product", in: context) {
                    
                    let productCDModel = Product(entity: entityDescription, insertInto: context)
                    productCDModel.name = productViewModel.product.product?.name
                    productCDModel.actFlg = productViewModel.product.product?.actFlg
                    productCDModel.cateId = productViewModel.product.product?.cateId
                    productCDModel.code = productViewModel.product.product?.code
                    productCDModel.divisionCode = productViewModel.product.product?.divisionCode
                    productCDModel.dRate = productViewModel.product.product?.dRate
                    productCDModel.index = productViewModel.product.product?.index ?? 0
                    productCDModel.mapId = productViewModel.product.product?.mapId
                    productCDModel.noOfSamples = productViewModel.product.product?.noOfSamples
                    productCDModel.productMode = productViewModel.product.product?.productMode
                    productCDModel.pSlNo = productViewModel.product.product?.pSlNo
                    
                    productDataCDModel.product = productCDModel
                    // Add to set
                  //  productViewModelsSet.add(productDataCDModel)
                }

                // Add to set
                productViewModelsSet.add(productDataCDModel)
                dispatchGroup.leave()
            }
        }

        // Notify the completion handler when all tasks in the dispatch group are complete
        dispatchGroup.notify(queue: .main) {
            completion(productViewModelsSet)
        }
    }
}
