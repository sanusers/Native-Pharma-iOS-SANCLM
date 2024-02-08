//
//  SelectedPreviewTypesCVC.swift
//  E-Detailing
//
//  Created by San eforce on 07/02/24.
//

import UIKit

protocol SelectedPreviewTypesCVCDelegate: AnyObject {
    func didPlayTapped(playerModel: [SlidesModel])
}

extension SelectedPreviewTypesCVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.previewType {
            
        case .home:
            return groupedBrandsSlideModel?.count ?? 0
        case .brand:
            return groupedBrandsSlideModel?.count ?? 0
        case .speciality:
            return groupedBrandsSlideModel?.count ?? 0
        case .customPresentation:
            return savedPresentationArr?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BrandsPreviewCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsPreviewCVC", for: indexPath) as!  BrandsPreviewCVC
        switch self.previewType {
            
        case .home:
            let model: GroupedBrandsSlideModel = groupedBrandsSlideModel?[indexPath.row] ?? GroupedBrandsSlideModel()
            cell.toPopulateCell(model)
            
            cell.addTap { [weak self] in
                guard let welf = self else {return}
                welf.delegate?.didPlayTapped(playerModel: welf.toSetupPlayerModel(indexPath.row))
            }
        case .brand:
            print("Yet to implement")
           
        case .speciality:
            print("Yet to implement")
        case .customPresentation:
            let model: SavedPresentation = self.savedPresentationArr?[indexPath.row] ?? SavedPresentation()
            cell.toPopulateCell(model: model)
            
            cell.addTap { [weak self] in
                guard let welf = self else {return}
                welf.delegate?.didPlayTapped(playerModel: welf.toSetupPlayerModel(indexPath.row))
            }
            
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 4, height: collectionView.height / 2.5)
    }
    
    
    func toSetupPlayerModel(_ index: Int) -> [SlidesModel] {
     switch self.previewType {


     case .customPresentation:
         var selectedSlidesModelArr = [SlidesModel]()
         if let savePresentationArr = self.savedPresentationArr {
             let selectedPresentation = savePresentationArr[index]
             selectedPresentation.groupedBrandsSlideModel.forEach({ aGroupedBrandsSlideModel in
                var selectedSlidesModelElement = aGroupedBrandsSlideModel.groupedSlide.filter { aSlidesModel in
                     aSlidesModel.isSelected == true
                 }
               
                 selectedSlidesModelArr.append(contentsOf: selectedSlidesModelElement)
             })
          
         }
       
         selectedSlidesModelArr.sort{$0.index < $1.index}
         return selectedSlidesModelArr
         
     default:
        // var selectedSlidesModelArr = [SlidesModel]()
         if let groupedBrandsSlideModel = self.groupedBrandsSlideModel?[index] {
             let slideArr = groupedBrandsSlideModel.groupedSlide
             
             return slideArr
         }
      return [SlidesModel]()
         
     }

        
    }
    
}


class SelectedPreviewTypesCVC: UICollectionViewCell {
    @IBOutlet var selectedPreviewTypeCollection: UICollectionView!
    var groupedBrandsSlideModel : [GroupedBrandsSlideModel]?
    var savedPresentationArr : [SavedPresentation]?
    var previewType: PreviewHomeView.PreviewType = .home
    weak var delegate: SelectedPreviewTypesCVCDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedPreviewTypeCollection.isPagingEnabled = true
      
        cellRegistration()
    }
    
    
    func toPopulateCell(_ model: [GroupedBrandsSlideModel], type: PreviewHomeView.PreviewType) {
        self.previewType = type
        self.groupedBrandsSlideModel = model
        toLoadData()
    }
    
    
    func toPopulateCell(model: [SavedPresentation], type: PreviewHomeView.PreviewType) {
        self.savedPresentationArr = model
        self.previewType = type
        if  model.count > 0 {
            toLoadData()
        }
   
    }

    func cellRegistration() {
        
        selectedPreviewTypeCollection.register(UINib(nibName: "BrandsPreviewCVC", bundle: nil), forCellWithReuseIdentifier: "BrandsPreviewCVC")
        
    }
    func toLoadData() {
        selectedPreviewTypeCollection.delegate = self
        selectedPreviewTypeCollection.dataSource = self
        selectedPreviewTypeCollection.reloadData()
    }
    
}
