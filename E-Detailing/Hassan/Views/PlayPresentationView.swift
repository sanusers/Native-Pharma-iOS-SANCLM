//
//  PlayPresentationView.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import UIKit

extension PlayPresentationView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate the index based on the current content offset and item size
        
        if let collect = scrollView as? UICollectionView {
            if collect == self.PlayingSlideCollection {
                let pageWidth = collect.frame.size.width
                let currentPage = Int(collect.contentOffset.x / pageWidth)
                print("Current Page: \(currentPage)")
                self.selectedLoadPresentationIndex = Int(currentPage)
                self.loadedSlidesCollection.reloadData()
                let indexPath: IndexPath = IndexPath(item: Int(currentPage), section: 0)
                self.loadedSlidesCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case PlayingSlideCollection:
            let cell: PlayLoadedPresentationCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayLoadedPresentationCVC", for: indexPath) as! PlayLoadedPresentationCVC
            cell.addTap {
                self.pageState = .expanded
                self.setPageType(self.pageState)
            }
            cell.presentationIV.backgroundColor = colors[indexPath.row]
           
            return cell
        case loadedSlidesCollection:
            let cell: PlayPresentationCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayPresentationCVC", for: indexPath) as! PlayPresentationCVC
            
            cell.presentationIV.backgroundColor = colors[indexPath.row]
            if indexPath.row ==  self.selectedLoadPresentationIndex  {
                cell.holderViewWidth.constant = 155
                cell.holderViewHeight.constant = 105
                cell.holderIV.layer.borderWidth = 2
                cell.holderIV.layer.borderColor = UIColor.appWhiteColor.cgColor
            } else {
                cell.holderViewWidth.constant = 150
                cell.holderViewHeight.constant = 100
                cell.holderIV.layer.borderWidth = 0
                cell.holderIV.layer.borderColor = UIColor.clear.cgColor
            }
            
            cell.addTap {
                self.selectedLoadPresentationIndex = indexPath.row
                
                self.PlayingSlideCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
                self.loadedSlidesCollection.reloadData()
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }

     
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case PlayingSlideCollection:
            return CGSize(width: PlayingSlideCollection.width, height: PlayingSlideCollection.height)
            
        case loadedSlidesCollection:
            //150 cell width padding 10
            
            return CGSize(width: 170, height: 110)
        default:
            return CGSize()
        }
    }
}

class  PlayPresentationView: BaseView {
    
    enum PageState {
        case expanded
        case minimized
    }
    
    
    func setPageType(_ type: PageState) {
        switch type {
            
        case .expanded:
            self.viewMInimize.isHidden = false
            self.viewClosePreview.isHidden = true
            self.loadedCollectionHolderView.isHidden = true
            
        case .minimized:
            self.viewMInimize.isHidden = true
            self.viewClosePreview.isHidden = false
            self.loadedCollectionHolderView.isHidden = false
        }
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.setPageType(.expanded)
//        }
        
    }
    
    var playPresentationVC : PlayPresentationVC!
    
    @IBOutlet var loadedCollectionHolderView: UIView!
    @IBOutlet var labelClosePreview: UILabel!
    @IBOutlet var PlayingSlideCollection: UICollectionView!
    
    @IBOutlet var loadedSlidesCollection: UICollectionView!
    
    @IBOutlet var viewClosePreview: UIView!
    
    @IBOutlet var loadedcollectionVxView: UIVisualEffectView!
    
    @IBOutlet var viewMInimize: UIView!
    
    var pageState : PageState = .expanded
    var selectedLoadPresentationIndex : Int? = 0
    let colors : [UIColor] = [.appBlue, .appBrown, .appGreen, .appLightPink, .appGreyColor, .appLightTextColor, .systemYellow, .systemTeal]
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.playPresentationVC = baseVC as? PlayPresentationVC
        setupUI()
        initView()
        cellregistration()
        toLoadPlayingSlideCollection()
        toLoadloadedSlidesCollection()
       // cellRegistration()
       // toLoadPresentationCollection()
    }
    
    func toLoadPlayingSlideCollection() {
        PlayingSlideCollection.delegate = self
        PlayingSlideCollection.dataSource = self
        PlayingSlideCollection.reloadData()
    }
    
    func toLoadloadedSlidesCollection() {
        loadedSlidesCollection.delegate = self
        loadedSlidesCollection.dataSource = self
        loadedSlidesCollection.reloadData()
    }
    
    func cellregistration() {
        
        loadedSlidesCollection.isPagingEnabled = false
        PlayingSlideCollection.isPagingEnabled = true
        if let loadedSlideslayout = self.loadedSlidesCollection.collectionViewLayout as? UICollectionViewFlowLayout  {
            loadedSlideslayout.scrollDirection = .horizontal
            loadedSlideslayout.collectionView?.isScrollEnabled = true
        }
        
        
        if  let PlayingSlidelayout = self.PlayingSlideCollection.collectionViewLayout as? UICollectionViewFlowLayout  {
            PlayingSlidelayout.scrollDirection = .horizontal
            PlayingSlidelayout.collectionView?.isScrollEnabled = true
        }
        
      
        
        
        loadedSlidesCollection.register(UINib(nibName: "PlayPresentationCVC", bundle: nil), forCellWithReuseIdentifier: "PlayPresentationCVC")
        
        
        PlayingSlideCollection.register(UINib(nibName: "PlayLoadedPresentationCVC", bundle: nil), forCellWithReuseIdentifier: "PlayLoadedPresentationCVC")
    }
    
    func  setupUI() {
        loadedcollectionVxView.backgroundColor = .appTextColor
        self.setPageType(self.pageState)
        viewMInimize.layer.cornerRadius = viewMInimize.height / 2
        viewClosePreview.backgroundColor = .appTextColor
        labelClosePreview.setFont(font: .bold(size: .BODY))
    }
    
    func initView() {
        
        self.viewClosePreview.addTap {
            self.playPresentationVC.navigationController?.popViewController(animated: true)
        }
        
        self.viewMInimize.addTap {
            self.pageState = self.pageState == .expanded ? .minimized : .expanded
            
            self.setPageType(self.pageState)
        }
    }
    
}
