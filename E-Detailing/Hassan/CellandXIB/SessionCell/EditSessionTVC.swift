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
    
    @IBOutlet weak var workTypeView: UIView!
    
    @IBOutlet weak var workselectionHolder: UIView!
    
    @IBOutlet var lblWorkType: UILabel!
    
    ///cluster type outlets
    
    @IBOutlet weak var clusterView: UIView!
    
  
    
    @IBOutlet weak var clusterselectionHolder: UIView!
    
    
    @IBOutlet var lblCluster: UILabel!
    
    ///headQuaters type outlets

    @IBOutlet var headQuatersView: UIView!
    
    @IBOutlet var headQuatersSelectionHolder: UIView!
    
    @IBOutlet var lblHeadquaters: UILabel!
    
    
    ///jointCall type outlets
    
    @IBOutlet var jointCallView: UIView!
    
    @IBOutlet var jointCallSelectionHolder: UIView!
    
    
    @IBOutlet var lblJointCall: UILabel!
    
    ///listedDoctor type outlets
    
    @IBOutlet var listedDoctorView: UIView!
    
    @IBOutlet var listedDoctorSelctionHolder: UIView!
    
    @IBOutlet var lblListedDoctor: UILabel!
    
    
    ///chemist type outlets
    
    @IBOutlet var chemistView: UIView!
    
    @IBOutlet var chemistSelectionHolder: UIView!
    
    @IBOutlet var lblChemist: UILabel!
    
    ///Stockist type outlets

    @IBOutlet var stockistView: UIView!
    
    @IBOutlet var chemistSectionHolder: UIView!
    
    @IBOutlet var lblstockist: UILabel!
    
    
    
    @IBOutlet var unlistedDocView: UIView!
    
    @IBOutlet var unlistedDocHolder: UIView!
    
    @IBOutlet var lblunlistedDoc: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

//        [chemistSelectionHolder,listedDoctorSelctionHolder,jointCallSelectionHolder,headQuatersSelectionHolder, clusterselectionHolder, workselectionHolder, overallContentsHolder].forEach { view in
//            view?.layer.borderColor = Themes.appTextColor.cgColor //AppColors.primaryColorWith_40per_alpha.cgColor
//            view?.layer.borderWidth = view == overallContentsHolder ? 0 : 1.5
//            view?.layer.cornerRadius = 5
//            view?.elevate(1)
//        }
      
        overallContentsHolder.layer.cornerRadius = 5
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
