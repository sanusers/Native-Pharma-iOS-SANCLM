//
//  BasicReportsInfoTVC.swift
//  E-Detailing
//
//  Created by San eforce on 21/12/23.
//

import UIKit


extension BasicReportsInfoTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessionImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WorkPlansInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkPlansInfoCVC", for: indexPath) as! WorkPlansInfoCVC
        
    
        
        
        let model  = self.sessionImages?[indexPath.item]
        cell.plansIV.image = model?.Image
        cell.countsLbl.text = "\(model!.count)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 7, height: 75)
        //Int(collectionView.width) / (sessionImages?.count ?? 0)
    }
    
    
}

func isTohideCheckin(_ model: ReportsModel) -> Bool{
    if model.inaddress == "" || model.intime == "" {
        return true
    }
    return false
}

func isTohideCheckout(_ model: ReportsModel) -> Bool {
    if model.outaddress == "" || model.outtime == "" {
        return true
    }
    return false
}

func isTohideRemarks(_ model: ReportsModel) -> Bool {
    if model.remarks == "" {
        return true
    }
    return false
}
func isTohideplanCollection(count : Int) -> Bool {
    if count == 0 {
        return true
    }
    return false
}

class BasicReportsInfoTVC: UITableViewCell {
    
    func populateCell(_ model: ReportsModel) {
   
        var sessionImagesArr = [SessionImages]()
        
        if model.chm != 0 {
            let ChemistsessionImage =  SessionImages(Image: UIImage(named: "Chemist") ?? UIImage(), count: model.chm)
            sessionImagesArr.append(ChemistsessionImage)
        }
        
        if model.cip != 0 {
            let cipsessionImage =  SessionImages(Image: UIImage(named: "cip") ?? UIImage(), count: model.udr)
            sessionImagesArr.append(cipsessionImage)
        }
        
        if model.drs != 0 {
            let ListedDoctorsessionImage =  SessionImages(Image: UIImage(named: "ListedDoctor") ?? UIImage(), count: model.drs)
            sessionImagesArr.append(ListedDoctorsessionImage)
        }
        
        
        if model.stk != 0 {
            let StockistsessionImage =  SessionImages(Image: UIImage(named: "Stockist") ?? UIImage(), count: model.stk)
            sessionImagesArr.append(StockistsessionImage)
        }
     
        
        if model.udr != 0 {
            let UnlistedDocsessionImage =  SessionImages(Image: UIImage(named: "Doctor") ?? UIImage(), count: model.udr)
            sessionImagesArr.append(UnlistedDocsessionImage)
        }
        
        if model.hos != 0 {
            let HosspsessionImage =  SessionImages(Image: UIImage(named: "JointCall") ?? UIImage(), count:  model.hos)
            sessionImagesArr.append(HosspsessionImage)
        }
        self.sessionImages = sessionImagesArr
        
        userNameLbl.text = model.sfName
        WTdescLbl.text = model.wtype
        remarksDescLbl.text =  model.remarks == "" ? "No remarks available" :  model.remarks
//        checkINinfoLbl.text =  model.intime
//        checkOUTinfoLbl.text = model.outtime
//        checkINaddrLbl.text =  model.inaddress
//        checkOUTaddrLbl.text = model.outaddress
//        dateInfoLbl.text =     model.rptdate
        
        let isTohideCheckin = isTohideCheckin(model)
        let isTohideCheckout = isTohideCheckout(model)
        
        if isTohideCheckin && isTohideCheckout  {
//            inAndoutInfoView.isHidden = true
//            inAndoutHeightConst.constant = 0
//            stackHeight = stackHeight - 70
//            holderStackHeightConst.constant = stackHeight
        } else {
            inAndoutInfoView.isHidden = false
            inAndoutHeightConst.constant = 70
        }
        
       // remarksAndPlansView
        let isTohideRemarks = isTohideRemarks(model)
        let isTohideplanCollection = isTohideplanCollection(count: self.sessionImages?.count ?? 0)
        
         
        if isTohideRemarks && isTohideplanCollection {
            remarksAndPlansView.isHidden = true
            remarksAndPlansHeightConst.constant = 0
            stackHeight = stackHeight -  75
            holderStackHeightConst.constant = stackHeight
        } else {
            remarksAndPlansView.isHidden = false
            remarksAndPlansHeightConst.constant = 75
        }
        
        
        toLoadData()
    }
    
    

    
    var sessionImages: [SessionImages]?
    
    @IBOutlet var userNameLbl: UILabel!
    
    @IBOutlet var WTtitleLbl: UILabel!
    
    @IBOutlet var WTdescLbl: UILabel!
    
    
    @IBOutlet var submittedDateLbl: UILabel!
    
    
    @IBOutlet var dateInfoLbl: UILabel!
    
    @IBOutlet var statusLbl: UILabel!
    
    
    @IBOutlet var statusInfoLbl: UILabel!
    
    @IBOutlet var statisInfoView: UIView!
    
    @IBOutlet var checkINLbl: UILabel!
    
    
    @IBOutlet var checkOUTlLbl: UILabel!
    
    
    @IBOutlet var checkINinfoLbl: UILabel!
    
    
    @IBOutlet var checkOUTinfoLbl: UILabel!
    
    
    @IBOutlet var checkINtapView: UIStackView!
    
    @IBOutlet var checkOUTtapView: UIStackView!
    
    
    @IBOutlet var checkINaddrLbl: UILabel!
    
    @IBOutlet var checkOUTaddrLbl: UILabel!
    
    @IBOutlet var checkINviewLbl: UILabel!
    
    @IBOutlet var checkOUTviewLbl: UILabel!
    
    @IBOutlet var remarksLbl: UILabel!
    
    
    @IBOutlet var remarksDescLbl: UILabel!
    
    @IBOutlet var overAllContentsHolderView: UIView!
    
    @IBOutlet var workPlansCollection: UICollectionView!
    
    
    
    //Views and height constraints

    
    @IBOutlet var inAndoutInfoView: UIView!
    
    @IBOutlet var inAndoutHeightConst: NSLayoutConstraint!
    
    @IBOutlet var holderStackHeightConst: NSLayoutConstraint!
    
    @IBOutlet var remarksAndPlansView: UIView!
    
    @IBOutlet var remarksAndPlansHeightConst: NSLayoutConstraint!
    
    @IBOutlet var nextActionVIew: UIView!
    @IBOutlet var seperatorView: UIView!
    var stackHeight: CGFloat = 245
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
       // populateCell()
       
        

    }
    
    func toLoadData() {
        workPlansCollection.delegate = self
        workPlansCollection.dataSource = self
        workPlansCollection.reloadData()
        
    }
    
    func cellRegistration() {
        workPlansCollection.register(UINib(nibName: "WorkPlansInfoCVC", bundle: nil), forCellWithReuseIdentifier: "WorkPlansInfoCVC")
        //WorkPlansInfoCVC
    }
    
    func setupUI() {
        cellRegistration()
      //  overAllContentsHolderView.elevate(2)
        overAllContentsHolderView.layer.cornerRadius = 5
        overAllContentsHolderView.backgroundColor = .appWhiteColor
        
        statisInfoView.layer.cornerRadius = 2
        statisInfoView.backgroundColor = .appSelectionColor
        
        seperatorView.backgroundColor = .appSelectionColor
        
        userNameLbl.textColor = .appLightPink
        userNameLbl.setFont(font: .bold(size: .BODY))
        
        let titLbls : [UILabel] = [WTtitleLbl, submittedDateLbl, statusLbl, checkINLbl, checkOUTlLbl, remarksLbl]
        
        titLbls.forEach { label in
            label.textColor = .appLightTextColor
            label.setFont(font: .medium(size: .BODY))
        }
        
        let descLbls : [UILabel] = [WTdescLbl, dateInfoLbl, statusInfoLbl, checkINinfoLbl, checkOUTinfoLbl, checkINaddrLbl, checkOUTaddrLbl, remarksDescLbl, checkINviewLbl, checkOUTviewLbl]
        
        descLbls.forEach { label in
            if label == statusInfoLbl {
                label.setFont(font: .medium(size: .BODY))
            } else {
                label.setFont(font: .bold(size: .BODY))
            }
            
            if label == checkINviewLbl ||  label == checkOUTviewLbl {
                label.textColor = .appLightPink
            } else if label == statusInfoLbl {
                label.textColor = .appGreen
            } else {
                label.textColor = .appTextColor
            }
            
          
            
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
