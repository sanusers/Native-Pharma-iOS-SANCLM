//
//  OutboxDetailsTVC.swift
//  E-Detailing
//
//  Created by San eforce on 18/01/24.
//

import UIKit

extension OutboxDetailsTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalldetailsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "CalldetailsCVC", for: indexPath) as! CalldetailsCVC
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: 90)
    }
    
}

class OutboxDetailsTVC: UITableViewCell {
    
    func toLoadData() {
        dcrCallDetailsCollection.delegate = self
        dcrCallDetailsCollection.dataSource = self
        dcrCallDetailsCollection.reloadData()
    }
    
    enum cellState {
        case callsExpanded
        case callsNotExpanded
        case eventExpanded
        case eventNotExpanded
    }
    
    var callsExpandState: cellState = .callsNotExpanded
    var eventExpandState: cellState = .eventNotExpanded
    
    
    @IBOutlet var dcrCallDetailsCollection: UICollectionView!
    
    
///Stack
    @IBOutlet var cellStackHeightConst: NSLayoutConstraint!
    @IBOutlet var cellStack: UIStackView!
    
///Checkin
    @IBOutlet var checkinVIew: UIView!
    @IBOutlet var checkinRefreshVIew: UIView!
    @IBOutlet var checkinLbl: UILabel!
    
///Workplan
    @IBOutlet var workPlanView: UIView!
    
    @IBOutlet var workPlanRefreshView: UIView!
    
    @IBOutlet var workPlanTitLbl: UILabel!
    ///Calls
    
    @IBOutlet var callsHolderViewHeightConst: NSLayoutConstraint!
    
    @IBOutlet var callCountVXview: UIVisualEffectView!
    @IBOutlet var callDetailHeightConst: NSLayoutConstraint! // 140
    
    @IBOutlet var callSubDetailVIew: UIView!
    
    @IBOutlet var callSubdetailHeightConst: NSLayoutConstraint! //90
    
    
    
    @IBOutlet var callDetailView: UIView!
    
    @IBOutlet var callCountHolderView: UIView!
    
    @IBOutlet var callsRefreshVIew: UIView!
    
    @IBOutlet var callsCollapseView: UIView!
    
    @IBOutlet var callsCollapseIV: UIImageView!
    
    @IBOutlet var callsCountLbl: UILabel!
    @IBOutlet var callsTitLbl: UILabel!
    
    @IBOutlet var callsViewSeperator: UIView!
    
    
    //Event Capture
    
    @IBOutlet var eventscountVxview: UIVisualEffectView!
    @IBOutlet var eventCaptureVIew: UIView!
    
    
    @IBOutlet var eventTitLbl: UILabel!
    
    @IBOutlet var eventCOuntLbl: UILabel!
    
    @IBOutlet var eventCountVIew: UIView!
    
    @IBOutlet var eventRefreshView: UIView!
    
    @IBOutlet var eventCollapseView: UIView!
    
    @IBOutlet var eventCollapseIV: UIImageView!
    
    
    //Checkout
    
    @IBOutlet var checkoutVIew: UIView!
    @IBOutlet var checkoutRefreshView: UIView!
    
    @IBOutlet var checkoutinfoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        cellRegistration()
        toLoadData()
        // Initialization code
    }
    
    func cellRegistration() {
        dcrCallDetailsCollection.register(UINib(nibName: "CalldetailsCVC", bundle: nil), forCellWithReuseIdentifier: "CalldetailsCVC")
    }
    
    
//    func setupHeight(_ state: cellState) {
//        self.callsExpandState = state
//        //90 is each of collection cell height
//        if self.callsExpandState == .callsExpanded {
//            self.cellStackHeightConst.constant = 380 + (90)
//            //self.callsHolderViewHeightConst.constant = 60 + (90 * 2)
//            self.callSubdetailHeightConst.constant = 90 * 2
//            self.callDetailHeightConst.constant = 60 + (90 * 2)
//            self.callsViewSeperator.isHidden = false
//            self.callSubDetailVIew.isHidden = false
//        } else if self.callsExpandState == .callsNotExpanded {
//            self.cellStackHeightConst.constant = 380 - (90 * 2)
//            //self.callsHolderViewHeightConst.constant = 60
//            self.callSubdetailHeightConst.constant = 0
//            self.callDetailHeightConst.constant = 60
//            self.callSubDetailVIew.isHidden = true
//            self.callsViewSeperator.isHidden = true
//        }
//
//    }
    
    func setupUI() {
     //   setupHeight(.callsNotExpanded)
        let titLbls : [UILabel] = [checkinLbl, workPlanTitLbl, callsTitLbl, eventTitLbl, checkoutinfoLbl]
        
        titLbls.forEach { lbl in
            lbl.setFont(font: .bold(size: .BODY))
            lbl.textColor = .appTextColor
        }
        
        let refreshViews : [UIView] = [checkinRefreshVIew, checkoutRefreshView, checkoutRefreshView, workPlanRefreshView, callsRefreshVIew]
        
        refreshViews.forEach { view in
            view.layer.cornerRadius = 3
        }
        
        let elevateViews: [UIView] = [checkinVIew, workPlanView, callDetailView, eventCaptureVIew, checkoutVIew]
        
        elevateViews.forEach { view in
            view.backgroundColor = .appGreyColor
            view.layer.cornerRadius = 5
        }
        
        callCountHolderView.layer.cornerRadius = 3
        callCountVXview.backgroundColor = .appGreyColor
        eventscountVxview.backgroundColor = .appGreyColor
        
        
        callsCountLbl.setFont(font: .medium(size: .BODY))
        eventCOuntLbl.setFont(font: .medium(size: .BODY))
        
        callsCountLbl.textColor = .appTextColor
        eventCOuntLbl.textColor = .appTextColor
        
//        callDCRinfoLbl.textColor = .appTextColor
//        callDCRinfoLbl.setFont(font: .medium(size: .BODY))
        
        
//        timeinfoLbl.textColor = .appLightTextColor
//        timeinfoLbl.setFont(font: .medium(size: .SMALL))
        
        
//        callStatusLbl.setFont(font: .medium(size: .BODY))
        
//        callststusView.layer.cornerRadius = 3
//        callStatusVxVIew.backgroundColor = .appLightPink
//        callStatusLbl.textColor = .appLightPink
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
