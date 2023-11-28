//
//  SessionInfoTVC.swift
//  E-Detailing
//
//  Created by San eforce on 10/11/23.
//

import UIKit
//import

 
class EditSessionTVC: UITableViewCell {
    

    @IBOutlet var stackHeight: NSLayoutConstraint!
    
    @IBOutlet var overallContentsHolder: UIView!
    @IBOutlet weak var lblName: UILabel!

    ///Worktype outlets
    
    @IBOutlet var worktyprTitle: UILabel!
    @IBOutlet weak var workTypeView: UIView!
    
    @IBOutlet weak var workselectionHolder: UIView!
    
    @IBOutlet var lblWorkType: UILabel!
    
    ///cluster type outlets
    @IBOutlet var clusterTitle: UILabel!
    @IBOutlet weak var clusterView: UIView!
    
  
    
    @IBOutlet weak var clusterselectionHolder: UIView!
    
    
    @IBOutlet var lblCluster: UILabel!
    
    ///headQuaters type outlets
    @IBOutlet var headQuartersTitle: UILabel!
    @IBOutlet var headQuatersView: UIView!
    
    @IBOutlet var headQuatersSelectionHolder: UIView!
    
    @IBOutlet var lblHeadquaters: UILabel!
    
    
    ///jointCall type outlets
    @IBOutlet var jointCallTitle: UILabel!
    @IBOutlet var jointCallView: UIView!
    
    @IBOutlet var jointCallSelectionHolder: UIView!
    
    
    @IBOutlet var lblJointCall: UILabel!
    
    ///listedDoctor type outlets
    @IBOutlet var listedDocTitle: UILabel!
    @IBOutlet var listedDoctorView: UIView!
    
    @IBOutlet var listedDoctorSelctionHolder: UIView!
    
    @IBOutlet var lblListedDoctor: UILabel!
    
    
    ///chemist type outlets
    @IBOutlet var chemistTitle: UILabel!
    @IBOutlet var chemistView: UIView!
    
    @IBOutlet var chemistSelectionHolder: UIView!
    
    @IBOutlet var lblChemist: UILabel!
    
    ///Stockist type outlets
    @IBOutlet var stockistTitle: UILabel!
    @IBOutlet var stockistView: UIView!
    
    @IBOutlet var chemistSectionHolder: UIView!
    
    @IBOutlet var lblstockist: UILabel!
    
    
    ///NewCustoers type outlet
    @IBOutlet var newCustomersTitle: UILabel!
    @IBOutlet var unlistedDocView: UIView!
    
    @IBOutlet var unlistedDocHolder: UIView!
    
    @IBOutlet var lblunlistedDoc: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupUI()
       
    }
    
    
    func setupUI() {
        
        let labels : [UILabel] = [lblWorkType, lblCluster, lblHeadquaters, lblJointCall, lblListedDoctor, lblChemist, lblstockist, lblunlistedDoc]
        labels.forEach { label in
            label.textColor = .appTextColor
            label.setFont(font: .medium(size: .BODY))
        }
        
        let titleLabels : [UILabel] = [worktyprTitle, clusterTitle, headQuartersTitle, jointCallTitle, listedDocTitle,  chemistTitle, stockistTitle, newCustomersTitle]
        titleLabels.forEach { label in
            label.textColor = .appLightTextColor
            label.setFont(font: .medium(size: .BODY))
        }
        
        lblName.textColor = .appTextColor
        lblName.setFont(font: .bold(size: .SUBHEADER))
        
        
        overallContentsHolder.backgroundColor = .appSelectionColor
        overallContentsHolder.layer.cornerRadius = 5
       // lblName.setFont(font: .bold(size: .SUBHEADER))
        
        
       
    }
    
    override func prepareForReuse() {
       /// deinit {
            NotificationCenter.default.removeObserver(self)
       /// }
    }
    



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
