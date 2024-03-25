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
            }
        default:
            print("---><---")
        }
    }
 
}

extension AddCallinfoView {
///RCPA
    @IBAction func rcpaSaveAction(_ sender: UIButton) {
        
        if self.rcpaCallListViewModel.numberOfCompetitorRows() == 0 {
            print("Add Competitor")
            return
        }
        
//        UIView.animate(withDuration: 1.5) {
//            self.viewRcpa.isHidden = true
//        }
        yetToloadContentsTable.isHidden = false
        self.yetToloadContentsTable.reloadData()
    }
    
    @objc func plusRcpaProduct(_ sender : UIButton){
        //rcpaAddedListTableView
        let buttonPosition : CGPoint = sender.convert(CGPoint.zero, to: self.yetToloadContentsTable)
        guard let indexPath = self.yetToloadContentsTable.indexPathForRow(at: buttonPosition) else {
            return
        }
        
        let rcpa = self.rcpaAddedListViewModel.fetchAtRowIndex(indexPath.section, row: indexPath.row)
        
        let isTapped = rcpa.isViewTapped
        
        self.rcpaAddedListViewModel.updateProductIsViewTapped(indexPath.section, row: indexPath.row, isTapped: !isTapped)
        self.yetToloadContentsTable.reloadData()
    }
    
    
    @objc func deleteRcpaProduct(_ sender : UIButton) {
        //rcpaAddedListTableView
        let buttonPosition : CGPoint = sender.convert(CGPoint.zero, to: self.yetToloadContentsTable)
        guard let indexPath = self.yetToloadContentsTable.indexPathForRow(at: buttonPosition) else {
            return
        }
        
        let products = self.rcpaAddedListViewModel.fetchAtSection(indexPath.section)
        
        if products.rcpaChemist.products.count == 1{
            self.rcpaAddedListViewModel.deleteSection(indexPath.section)
            self.yetToloadContentsTable.reloadData()
            return
        }
        
        self.rcpaAddedListViewModel.deleteAtRows(indexPath.section, row: indexPath.row)
        self.yetToloadContentsTable.reloadData()
    }
    
    @objc func editRcpaProduct(_ sender : UIButton) {
        //rcpaAddedListTableView
        let buttonPosition : CGPoint = sender.convert(CGPoint.zero, to: self.yetToloadContentsTable)
        guard let indexPath = self.yetToloadContentsTable.indexPathForRow(at: buttonPosition) else {
            return
        }
        
        let chemist = self.rcpaAddedListViewModel.fetchAtSection(indexPath.section)
        
        let products = self.rcpaAddedListViewModel.fetchAtRowIndex(indexPath.section, row: indexPath.row)
        
        let rcpas = products.rcpas
        
        
        self.selectedChemistRcpa = chemist.rcpaChemist.chemist
        
        self.selectedProductRcpa = products.product
        

        rateLbl.text = products.quantity
        
        valuelbl.text = products.total
        
        
        
        self.lblSeclectedDCRName.text = chemist.rcpaChemist.chemist.name ?? "Select Chemist Name"
        self.lblSelectedProductName.text = products.product.name ?? "Select Product Name"
        
        self.rcpaCallListViewModel.removeAll()
        
     //   self.btnRcpaChemist.isHidden = true
     //   self.btnRcpaProduct.isHidden = true
        
        for i in 0..<rcpas.count {
            
            self.rcpaCallListViewModel.addRcpaCompetitor(RcpaViewModel(rcpaHeaderData: RcpaHeaderData(chemist: chemist.rcpaChemist.chemist, product: products.product, quantity: products.quantity, total: products.total, rate: products.rate, competitorCompanyName: rcpas[i].competitorCompanyName, competitorCompanyCode: rcpas[i].competitorCompanyCode, competitorBrandName: rcpas[i].competitorBrandName, competitorBrandCode: rcpas[i].competitorBrandCode, competitorRate: rcpas[i].rate, competitorTotal: rcpas[i].competitorTotal, competitorQty: rcpas[i].competitorQty,remarks: "")))
        }
        
        
        self.yetToloadContentsTable.reloadData()
        
        //MARK: - show RCPA table
        
//        UIView.animate(withDuration: 1.5) {
//            self.viewRcpa.isHidden = false
//        }
        
        print(indexPath)
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
        guard let indexPath = self.loadedContentsTable.indexPathForRow(at: buttonPosition) else {
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
           
            self.productSelectedListViewModel.addProductViewModel(ProductViewModel(product: ProductData(product: productValue.Object as? Product, isDetailed: false, sampleCount: "", rxCount: "", rcpaCount: "", availableCount: "", totalCount: "")))
            self.toloadContentsTable()
        }
    }
}


extension AddCallinfoView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case productQtyTF:
            self.productQty = textField.text ?? "1"
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
                return self.rcpaAddedListViewModel.numberofRowsInSection(section)
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
                cell.productSample = self.productSelectedListViewModel.fetchDataAtIndex(indexPath.row)
                cell.btnDelete.addTarget(self, action: #selector(deleteProduct(_:)), for: .touchUpInside)
                cell.btnDelete.tag = indexPath.row
                cell.txtRxQty.tag = indexPath.row
                cell.txtRcpaQty.tag = indexPath.row
                cell.txtSampleQty.tag = indexPath.row
                cell.txtRxQty.addTarget(self, action: #selector(updateProductRxQty(_:)), for: .editingChanged)
                cell.txtRcpaQty.addTarget(self, action: #selector(updateProductRcpaQty(_:)), for: .editingChanged)
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
                    self.additionalCallSelectionAction(cell.btnSelected)
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
                cell.rcpaProduct = self.rcpaAddedListViewModel.fetchAtRowIndex(indexPath.section, row: indexPath.row)
                cell.btnEdit.addTarget(self, action: #selector(editRcpaProduct(_:)), for: .touchUpInside)
                cell.btnDelete.addTarget(self, action: #selector(deleteRcpaProduct(_:)), for: .touchUpInside)
                cell.btnPlus.addTarget(self, action: #selector(plusRcpaProduct(_:)), for: .touchUpInside)
                return cell
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSampleTableViewCell", for: indexPath) as! ProductSampleTableViewCell
//                cell.selectionStyle = .none
//                cell.productSample = self.productSelectedListViewModel.fetchDataAtIndex(indexPath.row)
//                cell.btnDelete.addTarget(self, action: #selector(deleteProduct(_:)), for: .touchUpInside)
//                cell.btnDelete.tag = indexPath.row
//                cell.txtRxQty.tag = indexPath.row
//                cell.txtRcpaQty.tag = indexPath.row
//                cell.txtSampleQty.tag = indexPath.row
//                cell.txtRxQty.addTarget(self, action: #selector(updateProductRxQty(_:)), for: .editingChanged)
//                cell.txtRcpaQty.addTarget(self, action: #selector(updateProductRcpaQty(_:)), for: .editingChanged)
//                cell.txtSampleQty.addTarget(self, action: #selector(updateProductSampleQty(_:)), for: .editingChanged)
//                cell.btnDeviation.addTarget(self, action: #selector(productDetailedSelection(_:)), for: .touchUpInside)
//                cell.txtSampleQty.delegate = self
//                cell.txtRxQty.delegate = self
//                cell.txtRcpaQty.delegate = self
//                if appsetup.sampleValidation != 1 {
//                  //  cell.viewStock.isHidden = true
//                }
//                return cell
            default:
                return UITableViewCell()
            }
//        case .jointWork:
//            <#code#>
            
        default:
            return UITableViewCell()
        }
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
            return 60
        case .jointWork:
            return 60
        }
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

//        case .products:
//            <#code#>
            
            
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
            
            
            
//        case .rcppa:
//            <#code#>
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
//        case .rcppa:
//            <#code#>
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
    
    func setSegment(_ segmentType: SegmentType, isfromSwipe: Bool? = false) {
        switch segmentType {
            
          
        case .detailed:
            didClose()
            jfwExceptionView.isHidden = false
            viewnoRCPA.isHidden = true
            rcpaEntryView.isHidden = true
            yetToloadContentsTable.isHidden = false
            yettoaddSectionView.backgroundColor = .clear
            toloadYettables()
            toloadContentsTable()
        case .products:
            didClose()
            jfwExceptionView.isHidden = false
            viewnoRCPA.isHidden = true
            rcpaEntryView.isHidden = true
            yetToloadContentsTable.isHidden = false
            yettoaddSectionView.backgroundColor = .clear
            toloadYettables()
            toloadContentsTable()
        case .inputs:
            didClose()
            jfwExceptionView.isHidden = false
            rcpaEntryView.isHidden = true
            yetToloadContentsTable.isHidden = false
            yettoaddSectionView.backgroundColor = .clear
            viewnoRCPA.isHidden = true
            toloadYettables()
            toloadContentsTable()
        case .additionalCalls:
            didClose()
            jfwExceptionView.isHidden = false
            rcpaEntryView.isHidden = true
            yetToloadContentsTable.isHidden = false
            yettoaddSectionView.backgroundColor = .clear
            viewnoRCPA.isHidden = true
            toloadYettables()
            toloadContentsTable()
        case .rcppa:
            didClose()
            jfwExceptionView.isHidden = false
            rcpaEntryView.isHidden = false
            yetToloadContentsTable.isHidden = true
            yettoaddSectionView.backgroundColor = .appWhiteColor
            viewnoRCPA.isHidden = false
            //toloadYettables()
            //toloadContentsTable()
        case .jointWork:
            jfwExceptionView.isHidden = true
            jfwAction()
        }
    }
    
private var productSelectedListViewModel = ProductSelectedListViewModel()
    private var additionalCallListViewModel = AdditionalCallsListViewModel()
   enum  SegmentType : String {
        case detailed = "Detailed"
        case products = "Products"
       case inputs = "Inputs"
       case additionalCalls = "Additional Calls"
       case rcppa = "RCPA"
       case jointWork = "JFW / Others"

    }
    
//    func setupjfwViews() {
//        viewPOB.layer.cornerRadius = 5
//        viewOverallFeedback.layer.cornerRadius = 5
//        viewEventCapture.layer.cornerRadius = 5
//        captureView.layer.cornerRadius = 5
//        captureVXView.layer.cornerRadius = 5
//        captureView.layer.borderWidth = 1
//        captureView.layer.borderColor = UIColor.appGreen.cgColor
//        
//        
//        
//    }
    
    @IBOutlet var bottomButtonsHolder: UIView!
    
    
    @IBOutlet var jfwExceptionView: UIView!
    
    @IBOutlet var segmentCollectionHolder: UIView!
//    @IBOutlet var eventcaptureTable: UITableView!
//    
//    @IBOutlet var btnCapture: UIButton!
//    @IBOutlet var captureVXView: UIVisualEffectView!
//    
//    @IBOutlet var captureView: UIView!
//    
//    @IBOutlet var jfwView: UIView!
//    
//    @IBOutlet var viewPOB: UIView!
//    
//    @IBOutlet var viewOverallFeedback: UIView!
//    
//    @IBOutlet var viewEventCapture: UIView!
    
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
    
    var selectedDoctorIndex = 0
    var selectedProductIndex: Int? = nil
    var searchText: String = ""
    var selectedSegmentsIndex: Int = 0
    var addCallinfoVC : AddCallinfoVC!
    let appsetup = AppDefaults.shared.getAppSetUp()
    var segmentType: [SegmentType] = []
    private var inputSelectedListViewModel = InputSelectedListViewModel()
    private var rcpaAddedListViewModel = RcpaAddedListViewModel()
    private var rcpaCallListViewModel = RcpaListViewModel()
    private var eventCaptureListViewModel = EventCaptureListViewModel()
    private var jointWorkSelectedListViewModel = JointWorksListViewModel()
    var jfwView : JfwView?
    
    var productObj: NSManagedObject?
    var chemistObj: NSManagedObject?
    var selectedChemistRcpa : AnyObject!
    var productQty: String = "1"
    var rateInt: Int = 0
    var selectedProductRcpa : AnyObject!
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.addCallinfoVC = baseVC as? AddCallinfoVC
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
        let changePasswordViewheight = self.bounds.height / 1.5
        
        let changePasswordViewcenterX = self.bounds.midX - (changePasswordViewwidth / 2)
       // let changePasswordViewcenterY = self.bounds.midY - (changePasswordViewheight / 2)
        
        self.jfwView?.frame = CGRect(x: changePasswordViewcenterX, y: segmentCollectionHolder.bottom + 5, width: changePasswordViewwidth, height: changePasswordViewheight)
        
        
    }
    
    
    func didClose() {
        self.subviews.forEach { aAddedView in
            switch aAddedView {
            case jfwView:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
                
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
            }
            
        }
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
        jfwView?.eventCaptureListViewModel = self.eventCaptureListViewModel
        jfwView?.jointWorkSelectedListViewModel = self.jointWorkSelectedListViewModel
       // jfwView?.delegate = self
      //  jfwView?.userStatisticsVM = self.userststisticsVM
     //   changePasswordView?.appsetup = self.appSetups
        jfwView?.setupUI()
        self.addSubview(jfwView ?? JfwView())
    }
    
    func initVIews() {
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
        
    }
    
    func cellregistration() {
        
        //yettoloadtable
        self.yetToloadContentsTable.register(UINib(nibName: "ProductNameWithSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameWithSampleTableViewCell")
        
        
        self.yetToloadContentsTable.register(UINib(nibName: "ProductNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameTableViewCell")
        
        
        
        //loadedcontentstable
        self.loadedContentsTable.register(UINib(nibName: "ProductSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductSampleTableViewCell")
        
  
        
        self.loadedContentsTable.register(UINib(nibName: "InputSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "InputSampleTableViewCell")
        
        
        
        
        self.loadedContentsTable.register(UINib(nibName: "AdditionalCallSampleInputTableViewCell", bundle: nil), forCellReuseIdentifier: "AdditionalCallSampleInputTableViewCell")
        
        
        
        
        //headers
        
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
        segmentType = [.products, .inputs, .additionalCalls, .rcppa, .jointWork]
        self.segmentsCollection.register(UINib(nibName: "PreviewTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PreviewTypeCVC")
        segmentsCollection.delegate = self
        segmentsCollection.dataSource = self
        segmentsCollection.reloadData()
        self.setSegment(.detailed)
    }
    
    func setupUI() {
        
        let curvedVIews: [UIView] = [dcrNameCurvedView, productnameCurvedView, productQtyCurvedView, rateCurvedView, valueCurvedVIew]
        
        btnAddRCPA.layer.cornerRadius = 5
      
                             
        btnAddRCPA.addTarget(self, action: #selector(rcpaSaveAction(_:)), for: .touchUpInside)
                             
        curvedVIews.forEach {
            if $0 != rateCurvedView ||  $0 != valueCurvedVIew {
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.2).cgColor
            }
            $0.layer.cornerRadius = 5
        }
        
 
        productQtyTF.delegate = self
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
        
    }
    
    @IBAction func productQtyAction(_ sender: UITextField) {
        
        self.productQty = sender.text ?? "1"
        let qtyInt: Int = Int(self.productQty) ?? 0
        rateLbl.text = "\(rateInt)"
        valuelbl.text = "\(rateInt * qtyInt)"
        
    }
    
    
}
