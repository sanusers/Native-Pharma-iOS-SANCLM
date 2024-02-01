//
//  CreatePresentationView.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import UIKit
import MobileCoreServices


extension CreatePresentationView: UITextFieldDelegate {
    
}



class CreatePresentationView : BaseView {
    
    
    
    //    override func didDisappear(baseVC: BaseViewController) {
    //        super.didDisappear(baseVC: baseVC)
    //        arrayOfBrandSlideObjects = nil
    //        arrayOfAllSlideObjects = nil
    //        groupedBrandsSlideModel = nil
    //        savedPresentation = nil
    //        selectedSlides = nil
    //        createPresentationVC.savedPresentation = nil
    //    }
    
    
    
    var createPresentationVC : CreatePresentationVC!
    
    @IBOutlet var navigationVIew: UIView!
    
    @IBOutlet var selectSlidesCollectionHolder: UIView!
    
    
    @IBOutlet var selectSlidesCollection: UICollectionView!
    
    @IBOutlet var slidesCountHolder: UIView!
    
    @IBOutlet var selectedSlidesTableHolder: UIView!
    
    @IBOutlet var playView: UIView!
    @IBOutlet var sledeCountLbl: UILabel!
    @IBOutlet var sledesCountVxView: UIVisualEffectView!
    
    @IBOutlet var playLbl: UILabel!
    
    @IBOutlet var calcelView: UIView!
    
    @IBOutlet var cancelLbl: UILabel!
    
    @IBOutlet var saveVIew: UIView!
    
    @IBOutlet var saveLbl: UILabel!
    
    @IBOutlet var addNameTFHolderView: UIView!
    
    @IBOutlet var addNameTF: UITextField!
    @IBOutlet var slidesTutle: UILabel!
    @IBOutlet var brandsTable: UITableView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var backHolderView: UIView!
    
    @IBOutlet var sampleImage: UIImageView!
    @IBOutlet var selectedSlidesTable: UITableView!
    var arrayOfBrandSlideObjects: [BrandSlidesModel]?
    var arrayOfAllSlideObjects: [SlidesModel]?
    var groupedBrandsSlideModel : [GroupedBrandsSlideModel]?
    var savedPresentation: SavedPresentation?
    var selectedSlides: [SlidesModel]?
    var selectedBrandsIndex: Int = 0
    var selectedPresentationIndex: Int? = nil
    var selectedSlidesModel : SelectedSlidesModel?
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.createPresentationVC = baseVC as? CreatePresentationVC
        setupUI()
        cellRegistration()
        toRetriveModelsFromCoreData()
        initView()
    }
    
    
    func toRetriveModelsFromCoreData() {
        self.groupedBrandsSlideModel =  CoreDataManager.shared.retriveGroupedSlides()
        if let groupedBrandsSlideModel = groupedBrandsSlideModel {
            self.selectedSlides = [SlidesModel]()
            self.selectedSlidesModel = SelectedSlidesModel()
            createPresentationVC.isToedit ? toEditPresentationData() :  toLoadNewPresentationData()
        }
     
    }
    
    func toLoadNewPresentationData() {

        toLoadBrandsTable()
        toLoadSelectedSlidesCollection()
    }
    

    
    func initView() {
        addNameTF.delegate = self
        
        playView.addTap { [weak self] in
            guard let welf = self else {return}
            
            let isToproceed =  welf.sledeCountLbl.text == "0" ||  welf.sledeCountLbl.text == "" ? false : true
            if isToproceed {
                let vc = PlayPresentationVC.initWithStory(model: welf.toSetupPlayerModel())
                welf.createPresentationVC.navigationController?.pushViewController(vc, animated: true)
            } else {
                let commonAlert = CommonAlert()
                commonAlert.setupAlert(alert: "E - Detailing", alertDescription: "Add atleast 1 slide to preview", okAction: "Ok")
                commonAlert.addAdditionalOkAction(isForSingleOption: true) {
                    print("no action")
                }
            }
            
            
            
            
        }
        
        backHolderView.addTap {
            self.createPresentationVC.navigationController?.popViewController(animated: true)
        }
        
        
        saveVIew.addTap { [weak self] in
            guard let welf = self else {return}
            let isToproceed =  welf.toCheckDataPersistance()
            
            if isToproceed {
                if welf.createPresentationVC.isToedit {
                    welf.retriveEditandSave()
                } else {
                    welf.toSaveNewPresentation()
                }
            }
            
            
        }
        
        calcelView.addTap {
            [weak self] in
               guard let welf = self else {return}
            welf.groupedBrandsSlideModel?.forEach({ aGroupedBrandsSlideModel in
                aGroupedBrandsSlideModel.groupedSlide.forEach { aSlidesModel in
                    aSlidesModel.isSelected = false
                }
            })
//            welf.selectedSlides?.forEach({ aSlidesModel in
//                aSlidesModel.isSelected = false
//            })
            
            welf.selectedSlides =  [SlidesModel]()
            
            welf.selectedSlidesModel?.slideNames =  [SlidesModel]()
                             
            welf.toLoadselectedSlidesTable()
            welf.toLoadSelectedSlidesCollection()
            welf.sledeCountLbl.text = ""
        }
        
    }
    
    func toCheckDataPersistance() -> Bool {
        if self.sledeCountLbl.text == "" {
            let commonAlert = CommonAlert()
            commonAlert.setupAlert(alert: "E - Detailing", alertDescription: "Add atleast 1 slide to save.", okAction: "Ok")
            commonAlert.addAdditionalOkAction(isForSingleOption: true) {
                print("no action")
            }
            return false
        } else if addNameTF.text == "" {
            let commonAlert = CommonAlert()
            commonAlert.setupAlert(alert: "E - Detailing", alertDescription: "Lets give presentation a name.", okAction: "Ok")
            commonAlert.addAdditionalOkAction(isForSingleOption: true) {
                print("no action")
                self.alertTF()
            }
            return false
        } else {
            return true
        }
    }
    
    
    func toSetupPlayerModel() -> [SlidesModel] {
        
        
        var selectedSlidesModelArr = [SlidesModel]()
        
        self.groupedBrandsSlideModel?.forEach({ aGroupedBrandsSlideModel in
            let selectedSlidesModelElement = aGroupedBrandsSlideModel.groupedSlide.filter { aSlidesModel in
                aSlidesModel.isSelected == true
            }
            selectedSlidesModelArr.append(contentsOf: selectedSlidesModelElement)
        })
        return selectedSlidesModelArr
        
    }
    
    
    func alertTF() {
        
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.addNameTFHolderView.backgroundColor =  .red.withAlphaComponent(0.5)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1, delay: 0, animations: {
                self.addNameTFHolderView.backgroundColor = .appWhiteColor
                self.addNameTF.becomeFirstResponder()
            })
        }
        
    }
    
    
    func retriveEditandSave() {
        
        if let savedPresentation = self.savedPresentation {
            savedPresentation.name = self.addNameTF.text ?? ""
            CoreDataManager.shared.toEditSavedPresentation(savedPresentation: savedPresentation, savedPresentation.uuid) { isEdited in
                if isEdited {
                    self.toCreateToast("Presentation saved successfully.")
                } else {
                    self.toCreateToast("Error saving presentation.")
                }
                
            }
        } else {
            self.toCreateToast("Error saving presentation.")
            
        }
        
        toExiteVC()
        
        
        
    }
    
    func toExiteVC() {
        self.createPresentationVC.delegate?.presentationSaved()
        self.createPresentationVC.navigationController?.popViewController(animated: true)
    }
    
    func toSaveNewPresentation() {
        let savedPresentation = SavedPresentation()
        savedPresentation.uuid = UUID()
        savedPresentation.name = self.addNameTF.text ?? ""
        savedPresentation.groupedBrandsSlideModel = groupedBrandsSlideModel ?? [GroupedBrandsSlideModel]()
        
        CoreDataManager.shared.saveToCoreData(savedPresentation: savedPresentation) { isObjSaved in
            if isObjSaved {
                self.toCreateToast("Presentation saved Successfully.")
            } else {
                self.toCreateToast("Presentation might be aldready saved.")
            }
        }
        
        toExiteVC()
        
        //        CoreDataManager.shared.fetchMovies { savedCDPresentationArr in
        //            dump(savedCDPresentationArr)
        //        }
    }
    
    
    func saveObjectToDafaults() {}
    
    func cellRegistration() {
        brandsTable.register(UINib(nibName: "BrandsNameTVC", bundle: nil), forCellReuseIdentifier: "BrandsNameTVC")
        
        selectedSlidesTable.register(UINib(nibName: "SelectedSlidesTVC", bundle: nil), forCellReuseIdentifier: "SelectedSlidesTVC")
        
        selectSlidesCollection.register(UINib(nibName: "SelectPresentationCVC", bundle: nil), forCellWithReuseIdentifier: "SelectPresentationCVC")
    }
    
    func setupUI() {
        brandsTable.separatorStyle = .none
        selectedSlidesTable.separatorStyle = .none
        self.backgroundColor = .appGreyColor
        navigationVIew.backgroundColor = .appTextColor
        titleLbl.setFont(font: .bold(size: .SUBHEADER))
        selectSlidesCollectionHolder.backgroundColor = .appWhiteColor
        selectedSlidesTableHolder.backgroundColor = .appWhiteColor
        selectedSlidesTableHolder.layer.cornerRadius = 5
        selectSlidesCollectionHolder.layer.cornerRadius = 5
        slidesTutle.setFont(font: .bold(size: .BODY))
        slidesTutle.textColor = .appTextColor
        slidesCountHolder.layer.cornerRadius = 3
        sledesCountVxView.backgroundColor = .appGreyColor
        sledeCountLbl.setFont(font: .bold(size: .BODY))
        sledeCountLbl.text = ""
        playView.backgroundColor = .appTextColor
        playView.layer.cornerRadius = 5
        playLbl.setFont(font: .bold(size: .BODY))
        calcelView.layer.cornerRadius = 5
        cancelLbl.setFont(font: .bold(size: .BODY))
        calcelView.backgroundColor = .appLightTextColor
        calcelView.layer.borderWidth = 0.5
        calcelView.layer.borderColor =  UIColor.appTextColor.cgColor
        saveVIew.layer.cornerRadius = 5
        saveLbl.textColor = .appWhiteColor
        saveLbl.setFont(font: .bold(size: .BODY))
        saveVIew.backgroundColor = .appTextColor
        addNameTF.font = UIFont(name: "Satoshi-Medium", size: 14)
        addNameTFHolderView.layer.cornerRadius = 5
        addNameTFHolderView.layer.borderColor =  UIColor.appSelectionColor.cgColor
        addNameTFHolderView.layer.borderWidth = 0.5
        
        
        
        
    }
    
    func toLoadBrandsTable() {
        brandsTable.delegate = self
        brandsTable.dataSource = self
        brandsTable.reloadData()
    }
    
    func toLoadselectedSlidesTable() {
        // createPresentationVC.navigationItem.rightBarButtonItem
        //  self.selectedSlidesModel = SelectedSlidesModel()
        selectedSlidesTable.delegate = self
        selectedSlidesTable.dataSource = self
        //selectedSlidesTable.dragDelegate = self
        // selectedSlidesTable.dropDelegate = self
        selectedSlidesTable.dragInteractionEnabled = true
        selectedSlidesTable.reloadData()
    }
    
    
    
    
    func toLoadSelectedSlidesCollection() {
        selectSlidesCollection.delegate = self
        selectSlidesCollection.dataSource = self
        selectSlidesCollection.reloadData()
    }
    
    func toEditPresentationData() {
        self.selectedSlidesModel = SelectedSlidesModel()
        self.savedPresentation = createPresentationVC.savedPresentation
        self.groupedBrandsSlideModel = self.savedPresentation?.groupedBrandsSlideModel
        self.addNameTF.text = self.savedPresentation?.name
        var slideModel = [SlidesModel]()
        self.groupedBrandsSlideModel?.forEach({ aGroupedBrandsSlideModel in
            
            let selectedSlides =  aGroupedBrandsSlideModel.groupedSlide.filter({ $0.isSelected })
            
            slideModel.append(contentsOf: selectedSlides)
        })
        
        self.selectedSlides = slideModel.filter({ aSlideModel in
            aSlideModel.isSelected
        })
        self.selectedSlidesModel?.slideNames = slideModel
        //   self.selectedSlides = slideModel
        if  slideModel.isEmpty {
            self.sledeCountLbl.text = ""
        } else {
            
            if let selectedSlidesModel = selectedSlidesModel {
                self.sledeCountLbl.text = "\(selectedSlidesModel.slideNames.count)"
            }
            
            
        }
        
        
        
        toLoadBrandsTable()
        toLoadSelectedSlidesCollection()
        toLoadselectedSlidesTable()
    }
    

}

extension CreatePresentationView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SelectPresentationCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectPresentationCVC", for: indexPath) as! SelectPresentationCVC
        
        let model = self.groupedBrandsSlideModel?[selectedBrandsIndex].groupedSlide[indexPath.row] ?? SlidesModel()
        cell.toPopulateCell(model)
        
        
        if model.isSelected {
            cell.selectionView.isHidden = false
            cell.selectedVxVIew.isHidden = false
        } else {
            cell.selectionView.isHidden = true
            cell.selectedVxVIew.isHidden = true
        }
        
        
        
        cell.addTap {
            //self.selectedPresentationIndex = indexPath.row
            model.isSelected = model.isSelected == true ? false : true
            if model.isSelected  {
                    self.selectedSlides?.append(model)
            } else {
                self.selectedSlides = self.selectedSlides?.filter({ aslideModel in
                    aslideModel.isSelected
                })

            }
            self.selectedSlides = Array(Set(self.selectedSlides ?? [SlidesModel]()))
            if self.createPresentationVC.isToedit {
                self.selectedSlidesModel?.slideNames.removeAll()
                self.selectedSlidesModel?.slideNames.append(contentsOf: self.selectedSlides ?? [SlidesModel]())
            } else {
                self.selectedSlidesModel?.slideNames =  self.selectedSlides ?? [SlidesModel]()
            }
          //  self.selectedSlidesModel = SelectedSlidesModel()
        
            self.selectSlidesCollection.reloadData()
            if let selectedSlidesModel = self.selectedSlidesModel {
                self.sledeCountLbl.text = "\(selectedSlidesModel.slideNames.count)"
            }
           
            self.toLoadselectedSlidesTable()
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.groupedBrandsSlideModel?.count != 0  else {
            return 0
        }
        
        return self.groupedBrandsSlideModel?[selectedBrandsIndex].groupedSlide.count ?? 0
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 2, height: collectionView.height / 4)
    }
    
}

extension CreatePresentationView: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case brandsTable:
            return self.groupedBrandsSlideModel?.count ?? 0
        case selectedSlidesTable:
            return  selectedSlidesModel?.slideNames.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case brandsTable:
            let cell: BrandsNameTVC = brandsTable.dequeueReusableCell(withIdentifier: "BrandsNameTVC", for: indexPath) as! BrandsNameTVC
            cell.selectionStyle = .none
            let model = groupedBrandsSlideModel?[indexPath.row] ?? GroupedBrandsSlideModel()
            cell.toPopulateCell(model)
            cell.contentsHolderView.layer.borderWidth = 0
            cell.contentsHolderView.layer.borderColor = UIColor.clear.cgColor
            cell.contentsHolderView.elevate(0)
            cell.accessoryIV.image = UIImage(systemName: "chevron.down")
        
            if selectedBrandsIndex == indexPath.row {
                cell.contentsHolderView.layer.borderWidth = 0.5
                cell.contentsHolderView.layer.borderColor = UIColor.appTextColor.cgColor
                cell.contentsHolderView.elevate(1)
                cell.accessoryIV.image = UIImage(systemName: "chevron.right")
            
       
            }
            
            cell.addTap {
                self.selectedBrandsIndex = indexPath.row
                self.brandsTable.reloadData()
                self.selectSlidesCollection.reloadData()
            }
            
     return cell
            
            
        case selectedSlidesTable:
            let cell: SelectedSlidesTVC = selectedSlidesTable.dequeueReusableCell(withIdentifier: "SelectedSlidesTVC", for: indexPath) as! SelectedSlidesTVC
            
            cell.selectionStyle = .none
            let model = self.selectedSlidesModel?.slideNames[indexPath.row]
            cell.titleLbl.text = model?.name
            cell.descriptionLbl.text = "Yet to be added"
            let data =  model?.slideData ?? Data()
            let utType = model?.utType ?? ""
            cell.presentationIV.toSetImageFromData(utType: utType, data: data)
            cell.deleteoptionView.addTap {
                self.selectedSlidesModel?.slideNames = self.selectedSlidesModel?.slideNames.filter { aSlideModel in
                    aSlideModel.slideId != model?.slideId
                } ?? [SlidesModel]()
                self.groupedBrandsSlideModel?[self.selectedBrandsIndex].groupedSlide.forEach({ aSlideModel in
                    if  aSlideModel.slideId == model?.slideId {
                        aSlideModel.isSelected = false
                    }
                })
                
                self.selectedSlides?.forEach({ aSlideModel in
                    if  aSlideModel.slideId == model?.slideId {
                        aSlideModel.isSelected = false
                    }
                })
                
                
                self.selectedSlides = self.selectedSlides?.filter({ aslideModel in
                    aslideModel.isSelected
                })
                if let selectedSlidesModel = self.selectedSlidesModel {
                    self.sledeCountLbl.text = "\(selectedSlidesModel.slideNames.count)"
                }
               
                self.selectedSlidesTable.reloadData()
                self.selectSlidesCollection.reloadData()
            }
            return cell
        default:
            return UITableViewCell()
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case brandsTable:
            return tableView.height / 9.5
            default:
            return tableView.height / 6
            
        }
    }
    
    
    
     func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
         selectedSlidesModel?.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
     func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

//extension CreatePresentationView: UITableViewDragDelegate {
//    // MARK: - UITableViewDragDelegate
//
//    /**
//         The `tableView(_:itemsForBeginning:at:)` method is the essential method
//         to implement for allowing dragging from a table.
//    */
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        return selectedSlidesModel.dragItems(for: indexPath)
//    }
//
//    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
//       // navigationItem.rightBarButtonItem?.isEnabled = false
//    }
//
//    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
//     //   navigationItem.rightBarButtonItem?.isEnabled = true
//    }
//}


//extension CreatePresentationView: UITableViewDropDelegate {
//    // MARK: - UITableViewDropDelegate
//
//    /**
//         Ensure that the drop session contains a drag item with a data representation
//         that the view can consume.
//    */
//    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
//        return selectedSlidesModel.canHandle(session)
//    }
//
//    /**
//         A drop proposal from a table view includes two items: a drop operation,
//         typically .move or .copy; and an intent, which declares the action the
//         table view will take upon receiving the items. (A drop proposal from a
//         custom view does includes only a drop operation, not an intent.)
//    */
//    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
//        var dropProposal = UITableViewDropProposal(operation: .cancel)
//
//        // Accept only one drag item.
//        guard session.items.count == 1 else { return dropProposal }
//
//        // The .move drag operation is available only for dragging within this app and while in edit mode.
//        if tableView.hasActiveDrag {
//            if tableView.isEditing {
//                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//            }
//        } else {
//            // Drag is coming from outside the app.
//            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
//        }
//
//        return dropProposal
//    }
//
//    /**
//         This delegate method is the only opportunity for accessing and loading
//         the data representations offered in the drag item. The drop coordinator
//         supports accessing the dropped items, updating the table view, and specifying
//         optional animations. Local drags with one item go through the existing
//         `tableView(_:moveRowAt:to:)` method on the data source.
//    */
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//        let destinationIndexPath: IndexPath
//
//        if let indexPath = coordinator.destinationIndexPath {
//            destinationIndexPath = indexPath
//        } else {
//            // Get last index path of table view.
//            let section = tableView.numberOfSections - 1
//            let row = tableView.numberOfRows(inSection: section)
//            destinationIndexPath = IndexPath(row: row, section: section)
//        }
//
//        coordinator.session.loadObjects(ofClass: NSString.self) { items in
//            // Consume drag items.
//            let stringItems = items as! [SlidesModel]
//
//            var indexPaths = [IndexPath]()
//            for (index, item) in stringItems.enumerated() {
//                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
//                self.selectedSlidesModel.addItem(item, at: indexPath.row)
//                indexPaths.append(indexPath)
//            }
//
//            tableView.insertRows(at: indexPaths, with: .automatic)
//        }
//    }
//}




class MediaDownloader {
    func downloadMedia(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                let noDataError = NSError(domain: "E-Detailing", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(nil, noDataError)
                return
            }

            completion(data, nil)
        }.resume()
    }
}
