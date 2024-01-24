//
//  CreatePresentationView.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import UIKit
extension CreatePresentationView: UITextFieldDelegate {
    
}

extension CreatePresentationView: UITableViewDropDelegate {
    // MARK: - UITableViewDropDelegate
    
    /**
         Ensure that the drop session contains a drag item with a data representation
         that the view can consume.
    */
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return selectedSlidesModel!.canHandle(session)
    }

    /**
         A drop proposal from a table view includes two items: a drop operation,
         typically .move or .copy; and an intent, which declares the action the
         table view will take upon receiving the items. (A drop proposal from a
         custom view does includes only a drop operation, not an intent.)
    */
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        
        // Accept only one drag item.
        guard session.items.count == 1 else { return dropProposal }
        
        // The .move drag operation is available only for dragging within this app and while in edit mode.
        if tableView.hasActiveDrag {
            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            // Drag is coming from outside the app.
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }

        return dropProposal
    }
    
    /**
         This delegate method is the only opportunity for accessing and loading
         the data representations offered in the drag item. The drop coordinator
         supports accessing the dropped items, updating the table view, and specifying
         optional animations. Local drags with one item go through the existing
         `tableView(_:moveRowAt:to:)` method on the data source.
    */
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // Get last index path of table view.
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            // Consume drag items.
            let stringItems = items as! [String]
            
            var indexPaths = [IndexPath]()
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                self.selectedSlidesModel?.addItem(item, at: indexPath.row)
                indexPaths.append(indexPath)
            }

            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}


extension CreatePresentationView: UITableViewDragDelegate {
    // MARK: - UITableViewDragDelegate
    
    /**
         The `tableView(_:itemsForBeginning:at:)` method is the essential method
         to implement for allowing dragging from a table.
    */
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return selectedSlidesModel!.dragItems(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
       // navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
     //   navigationItem.rightBarButtonItem?.isEnabled = true
    }
}






extension CreatePresentationView: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case brandsTable:
            return 10
        case selectedSlidesTable:
            return  selectedSlidesModel?.placeNames.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case brandsTable:
            let cell: BrandsNameTVC = brandsTable.dequeueReusableCell(withIdentifier: "BrandsNameTVC", for: indexPath) as! BrandsNameTVC
            cell.selectionStyle = .none
            
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
            }
            
     return cell
            
            
        case selectedSlidesTable:
            let cell: SelectedSlidesTVC = selectedSlidesTable.dequeueReusableCell(withIdentifier: "SelectedSlidesTVC", for: indexPath) as! SelectedSlidesTVC
            cell.titleLbl.text = self.selectedSlidesModel?.placeNames[indexPath.row]
            cell.selectionStyle = .none
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
         selectedSlidesModel!.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
     func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

class CreatePresentationView : BaseView {
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
    
    @IBOutlet var selectedSlidesTable: UITableView!
    
    var selectedBrandsIndex: Int? = nil
    var selectedSlidesModel: SelectedSlidesModel?
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.createPresentationVC = baseVC as? CreatePresentationVC
        toLoadPresentationData()
        setupUI()
        cellRegistration()
        toLoadBrandsTable()
        toLoadSelectedSlidesCollection()
        toLoadselectedSlidesTable()
        initView()
    }
    
    
    func toLoadPresentationData() {

        let paramData = LocalStorage.shared.getData(key: LocalStorage.LocalValue.slideResponse)
     //   var localParamArr = [[String: Any]]()
        var encodedSlideModelData: [SlidesModel]?
        
      
        
        var localParamArr = [[String:  Any]]()
        do {
            localParamArr  = try JSONSerialization.jsonObject(with: paramData, options: []) as?  [[String:  Any]] ??  [[String:  Any]]()
            dump(localParamArr)
        } catch {
            self.toCreateToast("unable to retrive")
        }
        
//        if let jsonData = localParamArr.data(using: .utf8),
//           let person = try? JSONDecoder().decode([].self, from: jsonData) {
//            print(person.name)  // Output: John
//            print(person.age)   // Output: 30
//        } else {
//            print("Failed to decode JSON into Person")
//        }
        
        
        
        
        
        
//        ConnectionHandler.shared.toConvertDataToObj(responseData: paramData, to: [SlidesModel].self) { decodecObj in
//            encodedSlideModelData = decodecObj
//
//        }
        
    }
    
    func initView() {
        addNameTF.delegate = self
        
        playView.addTap {
            let vc = PlayPresentationVC.initWithStory()
            self.createPresentationVC.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        backHolderView.addTap {
            self.createPresentationVC.navigationController?.popViewController(animated: true)
        }
        
    }
    
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
        self.selectedSlidesModel = SelectedSlidesModel()
        selectedSlidesTable.delegate = self
        selectedSlidesTable.dataSource = self
        selectedSlidesTable.dragDelegate = self
        selectedSlidesTable.dropDelegate = self
        selectedSlidesTable.dragInteractionEnabled = true
        selectedSlidesTable.reloadData()
    }
    
    
    
    
    func toLoadSelectedSlidesCollection() {
        selectSlidesCollection.delegate = self
        selectSlidesCollection.dataSource = self
        selectSlidesCollection.reloadData()
    }
    
}


extension CreatePresentationView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SelectPresentationCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectPresentationCVC", for: indexPath) as! SelectPresentationCVC
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 2, height: collectionView.height / 5)
    }
    
}
