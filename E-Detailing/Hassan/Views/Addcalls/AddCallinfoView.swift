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
    func routeToView(_ view: UIViewController) {
        print("Yet to implement")
    }
    
    func callPlanAPI() {
        print("Yet to implement")
    }
    
    func selectedType(_ type: MenuView.CellType, selectedObject: NSManagedObject, selectedObjects: [NSManagedObject]) {
        print("Yet to implement")
    }
    
    
}

extension AddCallinfoView {

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
        
        //MARK: - hide menu
//        self.additionalCallSampleInputTableView.reloadData()
//        UIView.animate(withDuration: 1.5){
//            self.viewAdditionalCallSampleInput.isHidden = false
//        }
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
        
        let vc = AddproductsMenuVC.initWithStory(self)
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
//        case .rcppa:
//            <#code#>
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
            
//        case .products:
//            <#code#>
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
//        case .rcppa:
//            <#code#>
//        case .jointWork:
//            <#code#>
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
            toloadYettables()
            toloadContentsTable()
        case .products:
            toloadYettables()
            toloadContentsTable()
        case .inputs:
            toloadYettables()
            toloadContentsTable()
        case .additionalCalls:
            toloadYettables()
            toloadContentsTable()
        case .rcppa:
            toloadYettables()
            toloadContentsTable()
        case .jointWork:
            toloadYettables()
            toloadContentsTable()
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
    var selectedDoctorIndex = 0
    var selectedProductIndex: Int? = nil
    var searchText: String = ""
    var selectedSegmentsIndex: Int = 0
    var addCallinfoVC : AddCallinfoVC!
    let appsetup = AppDefaults.shared.getAppSetUp()
    var segmentType: [SegmentType] = []
    private var inputSelectedListViewModel = InputSelectedListViewModel()
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.addCallinfoVC = baseVC as? AddCallinfoVC
       setupUI()
       toLoadSegments()
        cellregistration()
        toloadYettables()
       // toloadContentsTable()
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
    
}
