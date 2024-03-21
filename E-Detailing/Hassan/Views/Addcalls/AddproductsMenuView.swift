//
//  AddproductsMenuView.swift
//  E-Detailing
//
//  Created by San eforce on 21/03/24.
//

import Foundation
import UIKit

extension AddproductsMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.segmentType[self.selectedSegmentsIndex] {
        case .products:
                return self.additionalCallListViewModel.numberOfProductsInSection(self.selectedDoctorIndex)
        case .inputs:
                return self.additionalCallListViewModel.numberOfInputsInSection(self.selectedDoctorIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalCallSampleEntryTableViewCell", for: indexPath) as! AdditionalCallSampleEntryTableViewCell
        switch self.segmentType[self.selectedSegmentsIndex] {
        case .products:
                cell.product = self.additionalCallListViewModel.fetchProductAtIndex(self.selectedDoctorIndex, index: indexPath.row)
            case .inputs:
                cell.input = self.additionalCallListViewModel.fetchInputAtIndex(self.selectedDoctorIndex, index: indexPath.row)
        }
        cell.btnProduct.addTarget(self, action: #selector(additionalCallSampleInputSelection(_:)), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(deleteAdditionalCallSampleInput(_:)), for: .touchUpInside)
        cell.txtSampleStock.addTarget(self, action: #selector(updateSampleInputQty(_:)), for: .editingChanged)
        return cell
    }
    
    @objc func updateSampleInputQty(_ sender : UITextField) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.additionalCallSampleInputTableView)
        guard let indexPath = self.additionalCallSampleInputTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        switch self.segmentType[self.selectedSegmentsIndex] {
        case .products:
                self.additionalCallListViewModel.updateProductQtyAtSection(self.selectedDoctorIndex, index: indexPath.row, qty: sender.text ?? "")
                break
        case .inputs:
                self.additionalCallListViewModel.updateInputAtSection(self.selectedDoctorIndex, index: indexPath.row, qty: sender.text ?? "")
                break
        }
    }
    
    @objc func deleteAdditionalCallSampleInput(_ sender : UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.additionalCallSampleInputTableView)
        guard let indexPath = self.additionalCallSampleInputTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        switch self.segmentType[self.selectedSegmentsIndex] {
        case .products:
                self.additionalCallListViewModel.deleteProductAtIndex(self.selectedDoctorIndex, index: indexPath.row)
                self.additionalCallSampleInputTableView.reloadData()
        case .inputs:
                self.additionalCallListViewModel.deleteInputAtIndex(self.selectedDoctorIndex, index: indexPath.row)
                self.additionalCallSampleInputTableView.reloadData()
                break
        }
    }
    
    @objc func additionalCallSampleInputSelection(_ sender : UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.additionalCallSampleInputTableView)
        guard let indexPath = self.additionalCallSampleInputTableView.indexPathForRow(at: buttonPosition) else{
            return
        }
        
        switch self.segmentType[self.selectedSegmentsIndex] {
        case .products:
                let products = DBManager.shared.getProduct()
                
                let selectionVC = UIStoryboard.singleSelectionVC
                selectionVC.selectionData = products
                selectionVC.didSelectCompletion { selectedIndex in
                    
                    if let cell = self.additionalCallSampleInputTableView.cellForRow(at: indexPath) as? AdditionalCallSampleEntryTableViewCell {
                        cell.lblName.text = products[selectedIndex].name
                    }
                    
                    self.additionalCallListViewModel.updateProductAtSection(self.selectedDoctorIndex, index: indexPath.row, product: products[selectedIndex])
                    
                }
            self.addproductsMenuVC.present(selectionVC, animated: true)
            
        case .inputs:
                
                let inputs = DBManager.shared.getInput()
                
                let selectionVC = UIStoryboard.singleSelectionVC
                selectionVC.selectionData = inputs
                selectionVC.didSelectCompletion { selectedIndex in
                    if let cell = self.additionalCallSampleInputTableView.cellForRow(at: indexPath) as? AdditionalCallSampleEntryTableViewCell {
                        cell.lblName.text = inputs[selectedIndex].name
                    }
                    self.additionalCallListViewModel.updateInputAtSection(self.selectedDoctorIndex, index: indexPath.row, input: inputs[selectedIndex])
                }
            self.addproductsMenuVC.present(selectionVC, animated: true)
         
        }
    }
    
    
}

extension AddproductsMenuView : collectionViewProtocols {
    
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

    
            case .products:
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
            case .inputs:
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
        
    }
}

class AddproductsMenuView: BaseView {
    private var productSelectedListViewModel = ProductSelectedListViewModel()
        private var additionalCallListViewModel = AdditionalCallsListViewModel()
    var selectedDoctorIndex = 0
    enum  SegmentType : String {
         case inputs = "Inputs"
         case products = "Products"


     }
    
    func cellregistration() {
        self.additionalCallSampleInputTableView.register(UINib(nibName: "AdditionalCallSampleEntryTableViewCell", bundle: nil), forCellReuseIdentifier: "AdditionalCallSampleEntryTableViewCell")
        self.segmentsCollection.register(UINib(nibName: "PreviewTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PreviewTypeCVC")
    }
    
    func setSegment(_ segmentType: SegmentType, isfromSwipe: Bool? = false) {
        switch segmentType {
            
            
            
        case .products:
            break
        case .inputs:
            break
        }
    }
    
    func toLoadSegments() {
        segmentsCollection.isScrollEnabled = false
        segmentType = [.products, .inputs]
        self.segmentsCollection.register(UINib(nibName: "PreviewTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PreviewTypeCVC")
        segmentsCollection.delegate = self
        segmentsCollection.dataSource = self
        segmentsCollection.reloadData()
        self.setSegment(.products)
    }
    
    var segmentType: [SegmentType] = []
    var addproductsMenuVC :  AddproductsMenuVC!
    @IBOutlet weak var sideMenuHolderView : UIView!
    
    @IBOutlet weak var additionalCallSampleInputTableView : UITableView!
    
    @IBOutlet weak var segmentsCollection : UICollectionView!
    
    @IBOutlet weak var contentBgView: UIView!
    
    
    
    var selectedSegmentsIndex: Int = 0
    private var animationDuration : Double = 1.0
    private let aniamteionWaitTime : TimeInterval = 0.15
    private let animationVelocity : CGFloat = 5.0
    private let animationDampning : CGFloat = 2.0
    private let viewOpacity : CGFloat = 0.3
    
    
    func toLoadData() {
        additionalCallSampleInputTableView.delegate = self
        additionalCallSampleInputTableView.dataSource = self
        additionalCallSampleInputTableView.reloadData()
    }
    
    override func didLoad(baseVC: BaseViewController) {
        self.addproductsMenuVC = baseVC as? AddproductsMenuVC

      
        self.showMenu()
        initGestures()
        cellregistration()
        segmentType = [.products, .inputs]
        toLoadSegments()
        toLoadData()
       // setupUI()
       // cellRegistration()
       // toLoadRequiredData()
    }
    
    func showMenu(){
       // let isRTL = isRTLLanguage
        let _ : CGFloat =  -1
        //isRTL ? 1 :
        let width = self.frame.width
        self.sideMenuHolderView.transform =  CGAffineTransform(translationX: width,y: 1)
        //isRTL ? CGAffineTransform(translationX: 1 * width,y: 0)  :
        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        while animationDuration > 1.6{
            animationDuration = animationDuration * 0.1
        }
        UIView.animate(withDuration: animationDuration,
                       delay: aniamteionWaitTime,
                       usingSpringWithDamping: animationDampning,
                       initialSpringVelocity: animationVelocity,
                       options: [.curveEaseOut,.allowUserInteraction],
                       animations: {
                        self.sideMenuHolderView.transform = .identity
                        self.backgroundColor = UIColor.black.withAlphaComponent(self.viewOpacity)
                       }, completion: nil)
    }
    
    func hideMenuAndDismiss(type: MenuView.CellType? = nil , index: Int? = nil){
       
        let rtlValue : CGFloat = 1
      //  isRTL ? 1 :
        let width = self.frame.width
        while animationDuration > 1.6{
            animationDuration = animationDuration * 0.1
        }
            
        
        hideAnimation(width: width, rtlValue: rtlValue)

        
        
    }
    
    func hideAnimation(width: CGFloat, rtlValue: CGFloat) {
        UIView.animate(withDuration: animationDuration,
                       delay: aniamteionWaitTime,
                       usingSpringWithDamping: animationDampning,
                       initialSpringVelocity: animationVelocity,
                       options: [.curveEaseOut,.allowUserInteraction],
                       animations: {
                        self.sideMenuHolderView.transform = CGAffineTransform(translationX: width * rtlValue,
                                                                              y: 0)
                        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                       }) { (val) in
            
                           self.addproductsMenuVC.dismiss(animated: true)
        }
    }
    
    func initGestures() {
//        clearView.addTap {
//            self.specifiedMenuVC.selectedClusterID = nil
//            self.selectedClusterID = [String: Bool]()
//            self.menuTable.reloadData()
//        }
//        
//        saveView.addTap { [weak self] in
//            guard let welf = self else {return}
//            welf.filteredTerritories = welf.clusterArr?.filter { territory in
//                guard let code = territory.code else {
//                    return false
//                }
//                return welf.selectedClusterID[code] == true
//            }
//            
//
//            
//    
//            
//            welf.hideMenuAndDismiss()
//        }
//        
//        clearTFView.addTap { [weak self] in
//            guard let welf = self else {return}
//            welf.selectedObject = nil
//            welf.selectecIndex = nil
//            welf.searchTF.text = ""
//            welf.isSearched = false
//            welf.endEditing(true)
//            welf.toLoadRequiredData(isfromTF: true)
//            welf.toLOadData()
//        }
//        
//        closeTapView.addTap { [weak self] in
//            guard let welf = self else {return}
//            welf.filteredTerritories = welf.clusterArr?.filter { territory in
//                guard let code = territory.code else {
//                    return false
//                }
//                return welf.selectedClusterID[code] == true
//            }
//            welf.hideMenuAndDismiss()
//        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleMenuPan(_:)))
        self.sideMenuHolderView.addGestureRecognizer(panGesture)
        self.sideMenuHolderView.isUserInteractionEnabled = true
    }
    
    
    @objc func handleMenuPan(_ gesture : UIPanGestureRecognizer){
      
        let _ : CGFloat =   -1
        //isRTL ? 1 :
        let translation = gesture.translation(in: self.sideMenuHolderView)
        let xMovement = translation.x
        //        guard abs(xMovement) < self.view.frame.width/2 else{return}
        var opacity = viewOpacity * (abs(xMovement * 2)/(self.frame.width))
        opacity = (1 - opacity) - (self.viewOpacity * 2)
        print("~opcaity : ",opacity)
        switch gesture.state {
        case .began,.changed:
            guard  ( xMovement > 0)  else {return}
          //  ||  (xMovement < 0)
           // isRTL && || !isRTL &&
            
            self.sideMenuHolderView.transform = CGAffineTransform(translationX: xMovement, y: 0)
            self.backgroundColor = UIColor.black.withAlphaComponent(opacity)
        default:
            let velocity = gesture.velocity(in: self.sideMenuHolderView).x
            self.animationDuration = Double(velocity)
            if abs(xMovement) <= self.frame.width * 0.25{//show
                self.sideMenuHolderView.transform = .identity
                self.backgroundColor = UIColor.black.withAlphaComponent(self.viewOpacity)
            }else{//hide
                self.hideMenuAndDismiss()
            }
            
        }
    }
}
