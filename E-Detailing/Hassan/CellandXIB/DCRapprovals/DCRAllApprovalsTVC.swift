//
//  DCRAllApprovalsTVC.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import UIKit

extension DCRAllApprovalsTVC: DCRApprovalsInfoTVCDelegate {
    func didDCRinfoTapped(index: Int) {
        pushDetailsVC()
    }
    
    func pushDetailsVC() {
        guard let rootVC = self.rootController else {return}
        
        let vc = DCRapprovalinfoVC.initWithStory()
        rootVC.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DCRAllApprovalsTVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DCRApprovalsInfoTVC = tableView.dequeueReusableCell(withIdentifier: "DCRApprovalsInfoTVC", for: indexPath) as! DCRApprovalsInfoTVC
        cell.delegate = self
        cell.populateDCRArroval()
        
        cell.selectionStyle = .none
        
        cell.addTap {
            cell.delegate?.didDCRinfoTapped(index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


 
class DCRAllApprovalsTVC: UITableViewCell {

    @IBOutlet var allApprovalsTable: UITableView!
    var rootController : UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellRegistration()
        toLoadTable()
    }
    func cellRegistration() {
        allApprovalsTable.register(UINib(nibName: "DCRApprovalsInfoTVC", bundle: nil), forCellReuseIdentifier: "DCRApprovalsInfoTVC")
    }
    
    func toLoadTable()
    {
        allApprovalsTable.delegate = self
        allApprovalsTable.dataSource = self
        allApprovalsTable.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
