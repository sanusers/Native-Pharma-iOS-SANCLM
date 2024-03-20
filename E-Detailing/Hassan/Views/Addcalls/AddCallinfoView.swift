//
//  AddCallinfoView.swift
//  E-Detailing
//
//  Created by San eforce on 20/03/24.
//

import Foundation
import UIKit


extension AddCallinfoView {
//    @objc func productSelectionAction(_ sender : UIButton) {
//        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.ProductTableView)
//        guard let indexPath = self.ProductTableView.indexPathForRow(at: buttonPosition) else{
//            return
//        }
//     
//        let productValue = self.productSelectedListViewModel.fetchProductData(indexPath.row, searchText: self.searchText,type: dcrCall.type,selectedDoctorCode: dcrCall.code)
//        if productValue.isSelected {
//            if let cell = self.ProductTableView.cellForRow(at: indexPath) as? ProductNameWithSampleTableViewCell {
//                cell.btnSelected.isSelected = false
//            }
//            self.productSelectedListViewModel.removeById(productValue.Object.code ?? "")
//            self.productSampleTableView.reloadData()
//        }else {
//            if let cell = self.ProductTableView.cellForRow(at: indexPath) as? ProductNameWithSampleTableViewCell{
//                cell.btnSelected.isSelected = true
//            }
//            self.productSelectedListViewModel.addProductViewModel(ProductViewModel(product: ProductData(product: productValue.Object as? Product, isDetailed: false, sampleCount: "", rxCount: "", rcpaCount: "", availableCount: "", totalCount: "")))
//            self.productSampleTableView.reloadData()
//        }
//    }
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
                return Int()
            default:
                return Int()
            }
//        case .inputs:
//            <#code#>
//        case .additionalCalls:
//            <#code#>
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
                //cell.btnSelected.addTarget(self, action: #selector(productSelectionAction(_:)), for: .touchUpInside)
                return cell
                
                
            case loadedContentsTable:
                return UITableViewCell()
            default:
                return UITableViewCell()
            }

//        case .products:
//            <#code#>
//        case .inputs:
//            <#code#>
//        case .additionalCalls:
//            <#code#>
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
            break
        case .products:
            break
        case .inputs:
            break
        case .additionalCalls:
            break
        case .rcppa:
            break
        case .jointWork:
            break
        }
    }
    
private var productSelectedListViewModel = ProductSelectedListViewModel()
    
   enum  SegmentType : String {
        case detailed = "Detailed"
        case products = "Products"
       case inputs = "Inputs"
       case additionalCalls = "Additional Calls"
       case rcppa = "RCPA"
       case jointWork = "JFW / Others"

    }
    
    @IBOutlet var navigationVIew: UIView!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var searchView: UIView!
    
    @IBOutlet var detailsTable: UITableView!
    
    @IBOutlet var segmentsCollection: UICollectionView!
    
    @IBOutlet var yetToloadContentsTable: UITableView!
    
    @IBOutlet var loadedContentsTable: UITableView!
    var searchText: String = ""
    var selectedSegmentsIndex: Int = 1
    var addCallinfoVC : AddCallinfoVC!

    var segmentType: [SegmentType] = []
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.addCallinfoVC = baseVC as? AddCallinfoVC
       setupUI()
       toLoadSegments()
        cellregistration()
        toloadYettables()
    }
    
    func cellregistration() {
        self.yetToloadContentsTable.register(UINib(nibName: "ProductNameWithSampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductNameWithSampleTableViewCell")
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
        segmentType = [.detailed , .products, .inputs, .additionalCalls, .rcppa, .jointWork]
        self.segmentsCollection.register(UINib(nibName: "PreviewTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PreviewTypeCVC")
        segmentsCollection.delegate = self
        segmentsCollection.dataSource = self
        segmentsCollection.reloadData()
        self.setSegment(.detailed)
    }
    
    func setupUI() {
        searchView.layer.cornerRadius = 5
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.appLightTextColor.withAlphaComponent(0.2).cgColor
        
    }
    
}
