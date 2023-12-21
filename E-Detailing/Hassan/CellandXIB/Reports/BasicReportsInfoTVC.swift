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


class BasicReportsInfoTVC: UITableViewCell {
    
    func populateCell() {
        
        let sessionImage1 =  SessionImages(Image: UIImage(named: "HeadQuarter") ?? UIImage(), count: 1)
        let sessionImage2 =  SessionImages(Image: UIImage(named: "Cluster") ?? UIImage(), count: 3)
        let sessionImage3 =  SessionImages(Image: UIImage(named: "JointWork") ?? UIImage(), count: 1)
        let sessionImage4 =  SessionImages(Image: UIImage(named: "ListedDoctor") ?? UIImage(), count: 3)
        let sessionImage5 =  SessionImages(Image: UIImage(named: "Chemist") ?? UIImage(), count: 3)
        let sessionImage6 =  SessionImages(Image: UIImage(named: "Stockist") ?? UIImage(), count: 4)
        let sessionImage7 =  SessionImages(Image: UIImage(named: "Doctor") ?? UIImage(), count: 5)
        
        let sessionImagesArr : [SessionImages] = [sessionImage1, sessionImage2, sessionImage3, sessionImage4, sessionImage5, sessionImage6, sessionImage7]
        
        self.sessionImages = sessionImagesArr
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
    
    @IBOutlet var overAllContentsHolderView: UIStackView!
    
    @IBOutlet var workPlansCollection: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        populateCell()
        toLoadData()
        

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
        overAllContentsHolderView.elevate(2)
        overAllContentsHolderView.layer.cornerRadius = 2
        overAllContentsHolderView.backgroundColor = .appWhiteColor
        
        statisInfoView.backgroundColor = .appSelectionColor
        
        userNameLbl.textColor = .appLightPink
        userNameLbl.setFont(font: .bold(size: .SUBHEADER))
        
        let titLbls : [UILabel] = [WTtitleLbl, submittedDateLbl, statusLbl, checkINLbl, checkOUTlLbl, remarksLbl]
        
        titLbls.forEach { label in
            label.textColor = .appLightTextColor
            label.setFont(font: .bold(size: .BODY))
        }
        
        let descLbls : [UILabel] = [WTdescLbl, dateInfoLbl, statusInfoLbl, checkINinfoLbl, checkOUTinfoLbl, checkINaddrLbl, checkOUTaddrLbl, remarksDescLbl, checkINviewLbl, checkOUTviewLbl]
        
        descLbls.forEach { label in
            label.setFont(font: .bold(size: .BODY))
            if label == checkINviewLbl ||  label == checkOUTviewLbl {
                label.textColor = .appLightPink
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
