//
//  previewHomeView.swift
//  E-Detailing
//
//  Created by San eforce on 07/02/24.
//

import Foundation
import UIKit
import CoreData

extension PreviewHomeView: MenuResponseProtocol {
    func selectedType(_ type: MenuView.CellType, selectedObject: NSManagedObject) {
        print("Yet to implement")
        switch type {
            

        case .listedDoctor:
            dump(selectedObject)
            self.fetchedObject = selectedObject as? DoctorFencing
            dump(fetchedObject?.mappProducts)
            self.selectDoctorsLbl.text = fetchedObject?.name ?? ""
            let mapProd = fetchedObject?.mappProducts ?? ""
            let mProd = fetchedObject?.mProd ?? ""
            if mapProd != "" {
                do {
                    let regex = try NSRegularExpression(pattern: "\\b\\d+\\b", options: .caseInsensitive)
                    let matches = regex.matches(in: mapProd, options: [], range: NSRange(location: 0, length: mapProd.utf16.count))

                    let numbers = matches.map { match in
                        return (mapProd as NSString).substring(with: match.range)
                    }

                    print(numbers)
                } catch {
                    print("Error creating regular expression: \(error.localizedDescription)")
                }
            }
   
            
           // dump(fetchedObject?.m)
        default:
            print("Yet to implement")
        }
       
    }
    
    func selectedType(_ type: MenuView.CellType, index: Int) {
        self.selectedTypesIndex = index
    }
    
    func routeToView(_ view: UIViewController) {
        print("Yet to implement")
    }
    
    func callPlanAPI() {
        print("Yet to implement")
    }
    
    
}

extension PreviewHomeView:  SelectedPreviewTypesCVCDelegate {
    func didPlayTapped(playerModel: [SlidesModel]) {
        let vc = PlayPresentationVC.initWithStory(model:  playerModel)
        self.previewHomeVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension PreviewHomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case previewTypeCollection:
            return previewType.count
            case presentationCollectionVIew:
            return 1
        default:
            return 0
        }
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case previewTypeCollection:
            let cell: PreviewTypeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewTypeCVC", for: indexPath) as! PreviewTypeCVC
            
        
            cell.selectionView.isHidden =  previewTypeIndex == indexPath.row ? false : true
            cell.titleLbl.textColor =  previewTypeIndex == indexPath.row ? .appTextColor : .appLightTextColor
            cell.titleLbl.text = previewType[indexPath.row].rawValue
            
            cell.addTap { [weak self] in
                guard let welf = self else {return}
                welf.previewTypeIndex  = indexPath.row
                welf.setPreviewType(welf.previewType[indexPath.row])
                welf.previewTypeCollection.reloadData()
                if !welf.presentationCollectionVIew.visibleCells.isEmpty {
                    welf.presentationCollectionVIew.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
                }
                }
               
            return cell
        case presentationCollectionVIew:
            let cell: SelectedPreviewTypesCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedPreviewTypesCVC", for: indexPath) as! SelectedPreviewTypesCVC
            cell.delegate = self
            switch self.previewType[previewTypeIndex] {
        
            case .home:
                cell.toPopulateCell(groupedBrandsSlideModel ?? [GroupedBrandsSlideModel](), type: .home)
            case .brand:
                cell.toPopulateCell(groupedBrandsSlideModel ?? [GroupedBrandsSlideModel](), type: .brand)
            case .speciality:
                cell.toPopulateCell(groupedBrandsSlideModel ?? [GroupedBrandsSlideModel](), type: .speciality)
            case .customPresentation:
                cell.toPopulateCell(model: savePresentationArr ?? [SavedPresentation](), type: .customPresentation)
            }

            return cell
        default:
            return UICollectionViewCell()
        }

    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate the index based on the current content offset and item size
        
        if let collect = scrollView as? UICollectionView {
            if collect == self.presentationCollectionVIew {
                let pageWidth = collect.frame.size.width
                let currentPage = Int(collect.contentOffset.x / pageWidth)
                print("Current Page: \(currentPage)")
                self.previewTypeIndex = Int(currentPage)
                self.setPreviewType(previewType[currentPage])
                self.previewTypeCollection.reloadData()
                let indexPath: IndexPath = IndexPath(item: Int(currentPage), section: 0)
                self.previewTypeCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
             //   self.presentationCollectionVIew.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case previewTypeCollection:
            return CGSize(width: previewType[indexPath.item].rawValue.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: collectionView.height)
          //  return CGSize(width: collectionView.width / 9, height: collectionView.height)
        case presentationCollectionVIew:
            return CGSize(width: collectionView.width , height: collectionView.height)

        default:
            return CGSize()
        }
    }
    
    
}

class PreviewHomeView : BaseView {
    
    enum PreviewType: String {
        case home = "Home"
        case brand = "Brand"
        case speciality = "Speciality"
        case customPresentation = "Custom Presentation"
    }
    
    enum PageType {
        case exists
        case empty
    }
    
    func setPreviewType(_ previewType: PreviewType) {
    
        switch previewType {
           
        case .home:
           
            doctorSelectorVIewHeight.constant = 0
            self.groupedBrandsSlideModel =  CoreDataManager.shared.retriveGeneralGroupedSlides()
            if groupedBrandsSlideModel?.count == 0 {
                self.toSetPageType(pageType: .empty)
            } else {
                self.toSetPageType(pageType: .exists)
            }
        case .brand:
            self.selectNotifyLbl.text = "Select listed doctors to view content"
            doctorSelectorVIewHeight.constant = 50
            groupedBrandsSlideModel  = nil
            self.toSetPageType(pageType: .empty)
          
          
        case .speciality:
            self.selectNotifyLbl.text = "Select listed doctors to view content"
            doctorSelectorVIewHeight.constant = 50
            groupedBrandsSlideModel  = nil
            self.toSetPageType(pageType: .empty)
          
          
        case .customPresentation:
            
            self.selectNotifyLbl.text = "No saved presentation found!"
            doctorSelectorVIewHeight.constant = 0
            retriveSavedPresentations()
          
        }
    }
    
    @IBOutlet var presentationHolderVIew: UIView!
    @IBOutlet var navigationVIew: UIView!
    
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var doctorSelectionVIew: UIView!
    @IBOutlet var previewTypeCollection: UICollectionView!
    
    @IBOutlet var presentationCollectionVIew: UICollectionView!
    var previewTypeIndex: Int = 0
    var previewType: [PreviewType] = []
    @IBOutlet var selectDoctorsLbl: UILabel!
    @IBOutlet var selectNotifyLbl: UILabel!
    @IBOutlet var noPresentationView: UIView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var z2aView: UIView!
    @IBOutlet var a2zView: UIView!
    @IBOutlet var sortSwitchStack: UIStackView!
    @IBOutlet var seperatorView: UIView!
    
    @IBOutlet var doctorSelectorVIewHeight: NSLayoutConstraint!
    @IBOutlet var decendingIV: UIImageView!
    @IBOutlet var ascendingIV: UIImageView!
    var fetchedObject:  DoctorFencing?
    enum SortState {
        case ascending
        case decending
    }
    var selectedTypesIndex: Int? = nil
    var  listedDocArr : [DoctorFencing]?
    var savePresentationArr : [SavedPresentation]?
    var selectedSlides: [SlidesModel]?
    var groupedBrandsSlideModel : [GroupedBrandsSlideModel]?
    var sortState: SortState = .ascending
    
    func setBrandsData() {
        self.listedDocArr = DBManager.shared.getDoctor()
    }
    
    func toSetPageType(pageType: PageType) {
        switch pageType {

        case .exists:
        
            self.noPresentationView.isHidden = true
            presentationCollectionVIew.isHidden = false
            toLoadPreviewLoadedCollection()

        case .empty:

           toLoadPreviewLoadedCollection()
           self.noPresentationView.isHidden = false
            presentationCollectionVIew.isHidden = true
        }
    }
    
    var previewHomeVC : PreviewHomeVC!
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.previewHomeVC = baseVC as? PreviewHomeVC
        setupUI()
        initView()
        setPreviewType(.home)
       
        
     
    }
    
    func retriveSavedPresentations()  {
        
        self.savePresentationArr = CoreDataManager.shared.retriveSavedPresentations()
        
        if let savePresentationArr =   self.savePresentationArr {
            dump(savePresentationArr)
            if savePresentationArr.count == 0 {
                toSetPageType(pageType: .empty)
            } else {
                toSetPageType(pageType: .exists)
                //self.setPreviewType(previewType[previewTypeIndex])
            }
        }
        
       
 
    }
    
    func toSetupPlayerModel(_ index: Int) -> [SlidesModel] {
        var selectedSlidesModelArr = [SlidesModel]()
        if let savePresentationArr = self.savePresentationArr {
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
        
    }
    
    
 
    
    func toLoadPreviewCollection() {
        previewTypeCollection.delegate = self
        previewTypeCollection.dataSource = self
        previewTypeCollection.reloadData()
    }
    
    
    func toLoadPreviewLoadedCollection() {
        presentationCollectionVIew.delegate = self
        presentationCollectionVIew.dataSource = self
        presentationCollectionVIew.reloadData()
    }
    
    func toUnloadPreviewLoadedCollection() {
        presentationCollectionVIew.delegate = nil
        presentationCollectionVIew.dataSource = nil
    }
    
    func cellRegistration() {
        if let layout = self.presentationCollectionVIew.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.collectionView?.isScrollEnabled = true
            layout.scrollDirection = .vertical
        }
     
        
        presentationCollectionVIew.register(UINib(nibName: "SelectedPreviewTypesCVC", bundle: nil), forCellWithReuseIdentifier: "SelectedPreviewTypesCVC")
        
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
        
        self.doctorSelectionVIew.addTap {
            let menuvc = SpecifiedMenuVC.initWithStory(self, celltype: .listedDoctor)
            self.previewHomeVC.modalPresentationStyle = .custom
            self.previewHomeVC.navigationController?.present(menuvc, animated: false)
        }
        
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
  
    }
    
    func setupUI() {
        presentationCollectionVIew.backgroundColor = .clear
        presentationCollectionVIew.isPagingEnabled = false
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
        toSetPageType(pageType: .exists)
        previewType = [.home, .brand, .speciality, .customPresentation]
        setSortVIew()
        cellRegistration()
        toLoadPreviewCollection()
        //toLoadPreviewLoadedCollection()
    }
}
