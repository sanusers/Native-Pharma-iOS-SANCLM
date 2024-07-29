//
//  TourplanApprovalDetailedInfoTVC.swift
//  SAN ZEN
//
//  Created by San eforce on 27/07/24.
//

import UIKit

extension TourplanApprovalDetailedInfoTVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TourplanApprovalessionInfoTVC = tableView.dequeueReusableCell(withIdentifier: "TourplanApprovalessionInfoTVC", for: indexPath) as! TourplanApprovalessionInfoTVC
        

        
      
        
        if  isForFieldWork   {
            cell.stackHeight.constant = cellStackHeightforFW
            
            let cellViewArr : [UIView] = [cell.workTypeView, cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.stockistView, cell.unlistedDocView]
            
            cellViewArr.forEach { view in
                switch view {
                    
                case cell.headQuatersView:
                    if LocalStorage.shared.getBool(key: .isMR) {
                        view.isHidden = false
                    } else {
                        view.isHidden = true
                    }
                    
                    
                case cell.jointCallView:
                    if self.isJointCallneeded {
                        view.isHidden = false
                    } else {
                        view.isHidden = true
                    }
                    
                case cell.listedDoctorView:
                    if self.isDocNeeded {
                        view.isHidden = false
                    } else {
                        view.isHidden = true
                    }
        
                case cell.chemistView:
                    if self.isChemistNeeded {
                        view.isHidden = false
                    } else {
                        view.isHidden = true
                    }
                    
                case cell.stockistView:
                    if self.isSockistNeeded {
                        view.isHidden = false
                    } else {
                        view.isHidden = true
                    }
                    

                    
                default:
                    view.isHidden = false
                }
            }
        }  else {
            cell.stackHeight.constant = cellStackHeightfOthers
            [cell.headQuatersView,cell.clusterView,cell.jointCallView,cell.listedDoctorView, cell.chemistView, cell.stockistView, cell.unlistedDocView, cell.remarksView].forEach { view in
                view?.isHidden = true
                // cell.workselectionHolder,
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isForFieldWork {
            return cellEditHeightForFW
        }  else {
            return  cellEditHeightForOthers
            
        }
    }
}


class TourplanApprovalDetailedInfoTVC: UITableViewCell {

    @IBOutlet var elevationView: UIView!
    @IBOutlet var workTypeDescriptionTable: UITableView!
    @IBOutlet var tableHolderView: UIView!
    @IBOutlet var wtStack: UIStackView!
    @IBOutlet var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var chevlonIV: UIImageView!
    @IBOutlet var wtLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    var isDocNeeded = true
    var isJointCallneeded = true
    var isChemistNeeded = true
    var isSockistNeeded = true
    var isnewCustomerNeeded = true
    var isHQNeeded = true
    var cellEditHeightForOthers : CGFloat = 100
    var cellEditHeightForFW :  CGFloat = 670 + 60
    let cellStackHeightfOthers : CGFloat = 80
    var cellStackHeightforFW : CGFloat = 600


    let isForFieldWork = true

    var cellEditStackHeightfOthers : CGFloat = 80
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentViewHeightConstraint.constant = 670 + 100 + 10
        setupUI()
        toloadData()
    }
    func populateCell(model: TourPlanApprovalDetailModel) {
        guard model.isExtended else {
            contentViewHeightConstraint.constant = 60
            tableHolderView.isHidden = true
            chevlonIV.image = UIImage(named: "chevlon.expand")
            return
        }
        contentViewHeightConstraint.constant = 670 + 100 + 10
        tableHolderView.isHidden = false
        chevlonIV.image = UIImage(named: "chevlon.collapse")
    }
    
    func toloadData() {
        workTypeDescriptionTable.delegate = self
        workTypeDescriptionTable.dataSource = self
        workTypeDescriptionTable.reloadData()
    }
    
    func setupUI() {
        workTypeDescriptionTable.register(UINib(nibName: "TourplanApprovalessionInfoTVC", bundle: nil), forCellReuseIdentifier: "TourplanApprovalessionInfoTVC")
        elevationView.layer.cornerRadius = 5
        elevationView.elevate(2)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
