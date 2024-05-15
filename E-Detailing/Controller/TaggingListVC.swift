//
//  TaggingListVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 26/08/23.
//

import Foundation
import UIKit


class TaggingListVC : UIViewController {
    
    
    @IBOutlet weak var lblCollection: UILabel!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var resoureHQlbl: UILabel!
    
    @IBOutlet var textFieldHolderView: UIView!
    
    var type : TaggingType!
    
    var searchText : String = ""
    
    var doctor = [DoctorFencing]()
    
    
    private var customerListViewModel = CustomerListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        self.lblCollection.text = self.type.name
        
        self.collectionView.register(UINib(nibName: "DCRTaggingCell", bundle: nil), forCellWithReuseIdentifier: "DCRTaggingCell")
        
        let layout = UICollectionViewFlowLayout()
        self.collectionView.collectionViewLayout = layout
     
        
       // self.txtSearch.setIcon(UIImage(imageLiteralResourceName: "searchIcon"))
        self.txtSearch.addTarget(self, action: #selector(updateCustomerData(_:)), for: .editingChanged)
        
        self.doctor = DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
        setHQlbl()
    }
    
    
    deinit {
        print("TaggingListVC deallocated")
    }
    
    
    @IBAction func didTapBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setHQlbl() {
        textFieldHolderView.layer.cornerRadius = 5
        textFieldHolderView.layer.borderWidth = 1
        textFieldHolderView.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.2).cgColor
        // let appsetup = AppDefaults.shared.getAppSetUp()
            CoreDataManager.shared.toRetriveSavedHQ { hqModelArr in
                let savedEntity = hqModelArr.first
                guard let savedEntity = savedEntity else{
                    
                    self.resoureHQlbl.text = "Select HQ"
                    
                    return
                    
                }
                
                self.resoureHQlbl.text = savedEntity.name == "" ? "Select HQ" : savedEntity.name
                
                let subordinates = DBManager.shared.getSubordinate()
                
                let asubordinate = subordinates.filter{$0.id == savedEntity.code}
                
                if !asubordinate.isEmpty {
                 //  self.fetchedHQObject = asubordinate.first
                    LocalStorage.shared.setSting(LocalStorage.LocalValue.selectedRSFID, text:  asubordinate.first?.id ?? "")
                  //  self.toloadCallsCollection()
                }
            
              
  
 
                
            }
            // Retrieve Data from local storage
               return
        

       
    }
    
    @objc func updateCustomerData(_ sender : UITextField) {
        
        
        self.searchText = sender.text ?? ""
        
        self.collectionView.reloadData()
        
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}




extension TaggingListVC : collectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.customerListViewModel.numberOfRows(self.type, searchText: self.searchText)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DCRTaggingCell", for: indexPath) as! DCRTaggingCell
        cell.customer = self.customerListViewModel.fetchDataAtIndex(indexPath.row, type: self.type, searchText: self.searchText)
        cell.btnView.addTarget(self, action: #selector(viewAction(_:)), for: .touchUpInside)
        return cell
        
    }
    
    @objc func viewAction(_ sender : UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: buttonPosition) else {
            return
        }
        
        let tagViewVC = UIStoryboard.tagViewVC
        tagViewVC.customer = self.customerListViewModel.fetchDataAtIndex(indexPath.row, type: self.type, searchText: self.searchText)
        self.navigationController?.pushViewController(tagViewVC, animated: true)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let width = self.collectionView.frame.width / 4
//        let size = CGSize(width: width - 10, height: 240)
//        return size
        
        let width = self.collectionView.frame.width / 4
    
        let size = CGSize(width: width - 10, height: collectionView.height / 3.5)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tagVC  = UIStoryboard.tagVC
        tagVC.customer = self.customerListViewModel.fetchDataAtIndex(indexPath.row, type: self.type, searchText: self.searchText)
        self.navigationController?.pushViewController(tagVC, animated: true)
    }
    
}
