//
//  PresentationHomeView.swift
//  E-Detailing
//
//  Created by San eforce on 23/01/24.
//

import Foundation
import UIKit


extension PresentationHomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CreatedPresentationCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "CreatedPresentationCVC", for: indexPath) as!  CreatedPresentationCVC
        cell.optionsHolderView.addTap {
            let vc = PopOverVC.initWithStory(preferredFrame: CGSize(width: cell.width / 2, height: 120), on: cell.optionsIV, onframe: CGRect(), pagetype: .presentation)
            self.presentationHomeVC.navigationController?.present(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 4, height: collectionView.height / 2.5)
    }
    
    
}

class PresentationHomeView : BaseView {
    var presentationHomeVC : PresentationHomeVC!
    
    @IBOutlet var presentationCollectionVIew: UICollectionView!
    @IBOutlet var navigationView: UIView!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var addpresentationView: UIView!
    
    @IBOutlet var titlrLbl: UILabel!
    
    @IBOutlet var addPresentationLbl: UILabel!
    
    @IBOutlet var contentsHolderView: UIView!
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.presentationHomeVC = baseVC as? PresentationHomeVC
        setupUI()
        initView()
        cellRegistration()
        toLoadPresentationCollection()
    }
    
    func toLoadPresentationCollection() {
        presentationCollectionVIew.delegate = self
        presentationCollectionVIew.dataSource = self
        presentationCollectionVIew.reloadData()
    }
    
    func cellRegistration() {
        
        presentationCollectionVIew.register(UINib(nibName: "CreatedPresentationCVC", bundle: nil), forCellWithReuseIdentifier: "CreatedPresentationCVC")
        
    }
    
    func setupUI() {
//        if let layout = self.presentationCollectionVIew.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//            layout.collectionView?.isScrollEnabled = true
//
//        }
        addPresentationLbl.setFont(font: .bold(size: .BODY))
        addPresentationLbl.textColor = .appWhiteColor
        addpresentationView.layer.cornerRadius = 5

        addpresentationView.backgroundColor = .appTextColor
    
        navigationView.backgroundColor = .appTextColor
        titlrLbl.setFont(font: .bold(size: .SUBHEADER))
        titlrLbl.textColor = .appWhiteColor
        contentsHolderView.elevate(2)
        contentsHolderView.layer.cornerRadius = 5
        contentsHolderView.backgroundColor = .appWhiteColor
        self.backgroundColor = .appGreyColor
    }
    
    
    func initView() {
        backHolderView.addTap {
            self.presentationHomeVC.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
