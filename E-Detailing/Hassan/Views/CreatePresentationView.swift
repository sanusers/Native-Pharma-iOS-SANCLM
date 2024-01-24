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

extension CreatePresentationView: UITableViewDelegate, UITableViewDataSource {
    //UITableViewDragDelegate
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        let mover = data.remove(at: sourceIndexPath.row)
//           data.insert(mover, at: destinationIndexPath.row)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case brandsTable:
            return 10
        case selectedSlidesTable:
            return 3
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
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.createPresentationVC = baseVC as? CreatePresentationVC
        setupUI()
        cellRegistration()
        toLoadBrandsTable()
       // toLoadSelectedSlides()
        toLoadselectedSlidesTable()
        initView()
       
       // toLoadPresentationCollection()
    }
    
    func initView() {
        addNameTF.delegate = self
        
    }
    
    func cellRegistration() {
        brandsTable.register(UINib(nibName: "BrandsNameTVC", bundle: nil), forCellReuseIdentifier: "BrandsNameTVC")
        
        selectedSlidesTable.register(UINib(nibName: "SelectedSlidesTVC", bundle: nil), forCellReuseIdentifier: "SelectedSlidesTVC")
        
        
        
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
        selectedSlidesTable.delegate = self
        selectedSlidesTable.dataSource = self
      //  selectedSlidesTable.dragDelegate = self
      //  selectedSlidesTable.dragInteractionEnabled = true
        selectedSlidesTable.reloadData()
    }
    
    
    
    
    func toLoadSelectedSlides() {
       // selectSlidesCollection.delegate = self
       // selectSlidesCollection.dataSource = self
       // selectSlidesCollection.reloadData()
    }
    
}
