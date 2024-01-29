//
//  PlayPresentationView.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import UIKit

extension PlayPresentationView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func stopAllVideoPlayers() {
        // Iterate through visible cells and stop their video players
        for cell in PlayingSlideCollection.visibleCells {
            if let videoCell = cell as? VideoPlayerCVC {
                videoCell.player?.pause()
                videoCell.player = nil
            }
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoPlayerCVC {
          //  videoCell.playVideo()
        }
    }

     func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoPlayerCVC {
            videoCell.pauseVideo()
        }
    }
    
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
        return selectedSlideModel?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       
        
        switch collectionView {
 
        case PlayingSlideCollection:
            let model =  self.selectedSlideModel?[indexPath.row]
            switch model?.utType {
            case "application/pdf":
                let cell: PlayPDFCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayPDFCVC", for: indexPath) as! PlayPDFCVC
                cell.toLoadData(data: model?.slideData ?? Data())
                cell.addTap {
                    self.pageState = .expanded
                    self.setPageType(self.pageState)
                }
             //   cell.presentationIV.backgroundColor = colors[indexPath.row]
               
                return cell
            case "image/jpeg":
                let cell: PlayLoadedPresentationCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayLoadedPresentationCVC", for: indexPath) as! PlayLoadedPresentationCVC
                if let model = model {
                    cell.populateCell(model: model)
                }
              
                cell.addTap {
                    self.pageState = .expanded
                    self.setPageType(self.pageState)
                }
               // cell.presentationIV.backgroundColor = colors[indexPath.row]
               
                return cell
            case "video/mp4":
                
                let cell: VideoPlayerCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoPlayerCVC", for: indexPath) as! VideoPlayerCVC
               
                cell.setupPlayer(data: model?.slideData ?? Data())
                cell.state = self.pageState
                cell.addTap {
                    self.pageState = .expanded
                    self.setPageType(self.pageState)
                }
                //cell.presentationIV.backgroundColor = colors[indexPath.row]
               
                return cell
            default:
                
                let cell: PlayLoadedPresentationCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayLoadedPresentationCVC", for: indexPath) as! PlayLoadedPresentationCVC
               
             
                cell.addTap {
                    self.pageState = .expanded
                    self.setPageType(self.pageState)
                }
                //cell.presentationIV.backgroundColor = colors[indexPath.row]
               
                return cell
            }

        case loadedSlidesCollection:
            let model =  self.selectedSlideModel?[indexPath.row]
            let cell: PlayPresentationCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayPresentationCVC", for: indexPath) as! PlayPresentationCVC
            if let model = model {
                cell.toPopulateCell(model)
            }
          //  cell.presentationIV.backgroundColor = colors[indexPath.row]
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
                
                self.PlayingSlideCollection.reloadData()
                
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
        self.pageState = type
        switch type {
            
        case .expanded:
            self.viewMInimize.isHidden = false
            self.viewClosePreview.isHidden = true
            self.loadedCollectionHolderView.isHidden = true
            NotificationCenter.default.post(name: NSNotification.Name("viewExpanded"), object: nil)
        case .minimized:
            self.viewMInimize.isHidden = true
            self.viewClosePreview.isHidden = false
            self.loadedCollectionHolderView.isHidden = false
            NotificationCenter.default.post(name: NSNotification.Name("viewminimized"), object: nil)
           
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
    var selectedSlideModel : [SlidesModel]?
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.playPresentationVC = baseVC as? PlayPresentationVC
        setupUI()
        initView()
        cellregistration()
      
        toLoadloadedSlidesCollection()
        toLoadPlayingSlideCollection()
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
        PlayingSlideCollection.register(UINib(nibName: "PlayPDFCVC", bundle: nil), forCellWithReuseIdentifier: "PlayPDFCVC")
      
        PlayingSlideCollection.register(UINib(nibName: "VideoPlayerCVC", bundle: nil), forCellWithReuseIdentifier: "VideoPlayerCVC")
        
        
        
        loadedSlidesCollection.register(UINib(nibName: "PlayPresentationCVC", bundle: nil), forCellWithReuseIdentifier: "PlayPresentationCVC")
        
        
        PlayingSlideCollection.register(UINib(nibName: "PlayLoadedPresentationCVC", bundle: nil), forCellWithReuseIdentifier: "PlayLoadedPresentationCVC")
    }
    
    func  setupUI() {
        self.selectedSlideModel = playPresentationVC.selectedSlideModel
        loadedcollectionVxView.backgroundColor = .appTextColor
        self.setPageType(self.pageState)
        viewMInimize.layer.cornerRadius = viewMInimize.height / 2
        viewClosePreview.backgroundColor = .appTextColor
        labelClosePreview.setFont(font: .bold(size: .BODY))
    }
    
    func initView() {
        
        self.viewClosePreview.addTap {
            self.stopAllVideoPlayers()
            self.playPresentationVC.navigationController?.popViewController(animated: true)
        }
        
        self.viewMInimize.addTap {
            self.pageState = self.pageState == .expanded ? .minimized : .expanded
            
            self.setPageType(self.pageState)
        }
    }
    
}
