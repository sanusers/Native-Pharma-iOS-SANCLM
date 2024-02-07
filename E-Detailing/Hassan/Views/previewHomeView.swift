//
//  previewHomeView.swift
//  E-Detailing
//
//  Created by San eforce on 07/02/24.
//

import Foundation
import UIKit

extension PreviewHomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previewType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case previewTypeCollection:
            let cell: PreviewTypeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewTypeCVC", for: indexPath) as! PreviewTypeCVC
            
        
            cell.selectionView.isHidden =  previewTypeIndex == indexPath.row ? false : true
            cell.titleLbl.textColor =  previewTypeIndex == indexPath.row ? .appTextColor : .appLightTextColor
            cell.titleLbl.text = previewType[indexPath.row]
            
            cell.addTap { [weak self] in
                guard let welf = self else {return}
                welf.previewTypeIndex  = indexPath.row
                welf.previewTypeCollection.reloadData()
            }
            return cell
        case presentationCollectionVIew:
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
        
      
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case previewTypeCollection:
            return CGSize(width: previewType[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: collectionView.height)
          //  return CGSize(width: collectionView.width / 9, height: collectionView.height)
        case presentationCollectionVIew:
            return CGSize(width: collectionView.width / 4, height: collectionView.height / 2.5)

        default:
            return CGSize()
        }
    }
    
    
}

class PreviewHomeView : BaseView {
    
    enum PageType {
        case exists
        case empty
    }
    
    @IBOutlet var presentationHolderVIew: UIView!
    @IBOutlet var navigationVIew: UIView!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var doctorSelectionVIew: UIView!
    @IBOutlet var previewTypeCollection: UICollectionView!
    
    @IBOutlet var presentationCollectionVIew: UICollectionView!
    var previewTypeIndex: Int = 0
    var previewType: [String] = []
    @IBOutlet var selectDoctorsLbl: UILabel!
    @IBOutlet var selectNotifyLbl: UILabel!
    @IBOutlet var noPresentationView: UIView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var z2aView: UIView!
    @IBOutlet var a2zView: UIView!
    @IBOutlet var sortSwitchStack: UIStackView!
    @IBOutlet var seperatorView: UIView!
    
    @IBOutlet var decendingIV: UIImageView!
    @IBOutlet var ascendingIV: UIImageView!
    enum SortState {
        case ascending
        case decending
    }
    
    var sortState: SortState = .ascending
    
    func toSetPageType(pageType: PageType) {
        switch pageType {

        case .exists:
            self.presentationCollectionVIew.isHidden = false
            self.noPresentationView.isHidden = true
            //cellRegistration()
            //toLoadPresentationCollection()
        case .empty:
            self.presentationCollectionVIew.isHidden = true
           self.noPresentationView.isHidden = false
        }
    }
    
    var previewHomeVC : PreviewHomeVC!
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.previewHomeVC = baseVC as? PreviewHomeVC
        setupUI()
        initView()
        
       // retriveSavedPresentations()
        
     
    }
    
    func toLoadPreviewCollection() {
        previewTypeCollection.delegate = self
        previewTypeCollection.dataSource = self
        previewTypeCollection.reloadData()
    }
    
    func cellRegistration() {
//        if let layout = self.previewTypeCollection.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.collectionView?.isScrollEnabled = false
//            layout.scrollDirection = .horizontal
//            layout.minimumInteritemSpacing = 0
//            layout.minimumLineSpacing = 5
//            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//
//        }
     
        
        previewTypeCollection.register(UINib(nibName: "PreviewTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PreviewTypeCVC")
    }
    
    func setSortVIew() {
        switch self.sortState {
            
        case .ascending:
            a2zView.backgroundColor =  .appTextColor
            z2aView.backgroundColor =  .appWhiteColor
            ascendingIV.tintColor = .appWhiteColor
            decendingIV.tintColor = .appTextColor
        case .decending:
            a2zView.backgroundColor =  .appWhiteColor
            z2aView.backgroundColor =  .appTextColor
            ascendingIV.tintColor = .appTextColor
            decendingIV.tintColor = .appWhiteColor
        }
    
        
      
    }
    
    func initView() {
        
        backHolderView.addTap {
            self.previewHomeVC.navigationController?.popViewController(animated: true)
        }
        
        a2zView.addTap { [weak self] in
            guard let welf = self else {return}
            welf.sortState = .ascending
            welf.setSortVIew()
        }
        
        z2aView.addTap {
            [weak self] in
                guard let welf = self else {return}
            welf.sortState = .decending
                welf.setSortVIew()
        }
        doctorSelectionVIew.addTap {
            print("Tapped")
        }
    }
    
    func setupUI() {
        sortSwitchStack.layer.cornerRadius = 3
        sortSwitchStack.layer.borderWidth = 1
        sortSwitchStack.layer.borderColor = UIColor.appLightTextColor.cgColor
        titleLbl.setFont(font: .bold(size: .SUBHEADER))
        titleLbl.textColor = .appWhiteColor
        seperatorView.backgroundColor = .appLightTextColor.withAlphaComponent(0.5)
        presentationHolderVIew.layer.cornerRadius = 5
        self.backgroundColor = .appGreyColor
        presentationHolderVIew.backgroundColor = .appWhiteColor
        selectNotifyLbl.setFont(font: .bold(size:  .BODY))
        selectNotifyLbl.textColor = .appTextColor
        doctorSelectionVIew.layer.borderWidth = 1
        doctorSelectionVIew.layer.cornerRadius = 5
        doctorSelectionVIew.layer.borderColor = UIColor.appLightTextColor.cgColor
        selectDoctorsLbl.setFont(font: .medium(size: .BODY))
        selectDoctorsLbl.textColor = .appTextColor
        toSetPageType(pageType: .empty)
        previewType = ["Home", "Brand", "Speciality", "Custom presentation"]
        setSortVIew()
        cellRegistration()
        toLoadPreviewCollection()
    }
}
