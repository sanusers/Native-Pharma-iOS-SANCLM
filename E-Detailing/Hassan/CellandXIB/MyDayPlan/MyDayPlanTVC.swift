//
//  MyDayPlanTVC.swift
//  E-Detailing
//
//  Created by San eforce on 15/02/24.
//

import UIKit
import CoreData

class MyDayPlanTVC: UITableViewCell {
    
    
    
    @IBOutlet var deleteHolderView: UIView!
    
    @IBOutlet var contentHolderVIew: UIView!
    @IBOutlet var deleteHolderHeight: NSLayoutConstraint! // 40
    
    @IBOutlet var holderStack: UIStackView!
    
    @IBOutlet var holderStackHeight: NSLayoutConstraint! //150
    @IBOutlet var deleteIV: UIImageView!
    
    @IBOutlet var selectClusterLbl: UILabel!
    
    @IBOutlet var clusterHolderVIew: UIView!
    
    @IBOutlet var wtHolderView: UIView!
    @IBOutlet var hqHolderView: UIView!
    @IBOutlet var selectHQlbl: UILabel!
    @IBOutlet var selectWTlbl: UILabel!
    
    @IBOutlet var clusterBorderView: UIView!
    @IBOutlet var hqBorderView: UIView!
    @IBOutlet var wtBorderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clusterBorderView.layer.cornerRadius = 5
        clusterBorderView.layer.borderWidth = 1
        clusterBorderView.layer.borderColor = UIColor.appSelectionColor.cgColor
        
        hqBorderView.layer.cornerRadius = 5
        hqBorderView.layer.borderWidth = 1
        hqBorderView.layer.borderColor = UIColor.appSelectionColor.cgColor
        
        wtBorderView.layer.cornerRadius = 5
        wtBorderView.layer.borderWidth = 1
        wtBorderView.layer.borderColor = UIColor.appSelectionColor.cgColor
        
        contentHolderVIew.layer.cornerRadius = 5
        contentHolderVIew.backgroundColor = .appWhiteColor
        contentHolderVIew.elevate(2)
        selectClusterLbl.setFont(font: .medium(size: .BODY))
        selectHQlbl.setFont(font: .medium(size: .BODY))
        selectWTlbl.setFont(font: .medium(size: .BODY))
        
        
        
    }
    
//    func setupUI(model: [NSManagedObject]) {
//        model.forEach { anObject in
//            switch anObject.entity {
//            case is Territory:
//                let territoryObj =  anObject as? Territory
//                self.selectClusterLbl.text = territoryObj?.name
//            case Subordinate:
//                let hqObj =  anObject as? Subordinate
//                self.selectHQlbl.text = hqObj?.name
//            case WorkType:
//                let wtObj =  anObject as? WorkType
//                self.selectWTlbl.text = wtObj?.name
//            default:
//                print("Yet to implement")
//            }
//        }
//    }
    
    func setupUI(model: [NSManagedObject]) {
        model.forEach { anObject in
            switch anObject {
            case let territoryObj as Territory:

                if let hqName = territoryObj.name {
                     self.selectClusterLbl.text = hqName
                 } else {
                     self.selectClusterLbl.text = "Select Worktype"
                 }
                
            case let hqObj as Subordinate:
                
                if let hqName = hqObj.name {
                     self.selectHQlbl.text = hqName
                 } else {
                     self.selectHQlbl.text = "Select HQ"
                 }
            case let wtObj as WorkType:
        
                
                if let hqName = wtObj.name {
                     self.selectWTlbl.text = hqName
                 } else {
                     self.selectWTlbl.text = "Select Worktype"
                 }
                
            default:
                print("Yet to implement")
            }
        }
    }
    
    func setupHeight(_ isTodelete: Bool) {
        if isTodelete {
            deleteHolderView.isHidden = true
            deleteHolderHeight.constant = 0
        } else {
            deleteHolderView.isHidden = false
            deleteHolderHeight.constant = 40
        }
        
        if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isMR) {
            self.holderStackHeight.constant = 150
            self.clusterHolderVIew.isHidden = true
        } else {
            self.holderStackHeight.constant = 200
            self.clusterHolderVIew.isHidden = false
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
