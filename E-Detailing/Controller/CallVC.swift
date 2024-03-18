//
//  CallVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 07/08/23.
//

import UIKit


enum DCRType : Int {
    
    case doctor = 0
    case chemist = 1
    case stockist = 2
    case unlistedDoctor = 3
    case hospital = 4
    case cip = 5
    
    
    
    var productNeed : Int {
        let appSetup = AppDefaults.shared.getAppSetUp()
        switch self {
            case .doctor:
                return appSetup.dpNeed ?? 0
            case .chemist:
                return appSetup.cpNeed ?? 0
            case .stockist:
                return appSetup.spNeed ?? 0
            case .unlistedDoctor:
                return appSetup.npNeed ?? 0
            case .hospital:
                return 1
            case .cip:
                return appSetup.cipPNeed ?? 0
        }
    }
    
    var inputNeed : Int {
        let appSetup = AppDefaults.shared.getAppSetUp()
        switch self {
        case .doctor:
            return appSetup.diNeed ?? 0
        case .chemist:
            return appSetup.ciNeed ?? 0
        case .stockist:
            return appSetup.siNeed ?? 0
        case .unlistedDoctor:
            return appSetup.niNeed ?? 0
        case .hospital:
            return 1
        case .cip:
            return appSetup.cipINeed ?? 0
        }
    }
 
}


extension CallVC: DCRfiltersViewDelegate {
    func isFiltersupdated(_ addedFiltercount: Int, isItemAdded: Bool) {
        print(addedFiltercount)
        if addedFiltercount % 2 != 0 && isItemAdded {
            addedDCRVIewHeight = addedDCRVIewHeight + 70
        } else if addedFiltercount % 2 == 0 && !isItemAdded {
            addedDCRVIewHeight = addedDCRVIewHeight - 70
        } else  if addedFiltercount % 2 != 0 && !isItemAdded {
           
        }

      
        self.viewDidLayoutSubviews()
        
    }
    
    
}

extension CallVC : addedSubViewsDelegate {
    func showAlert() {
        print("Yet to implement")
    }
    

    func didClose() {
       backgroundView.isHidden = true
        self.view.subviews.forEach { aAddedView in
            
            switch aAddedView {

            case dcrfiltersView:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
                
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
                
                // aAddedView.alpha = 1
                
            }
            
        }
    }
    

    
    func didUpdate() {
        backgroundView.isHidden = true
        self.view.subviews.forEach { aAddedView in
            
            switch aAddedView {
            case dcrfiltersView:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
                
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
                
                // aAddedView.alpha = 1
                
            }
            
        }
    }
    
    
}


class CallVC : UIViewController {
    
    @IBOutlet var seatchHolderVIew: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet var resoureHQlbl: UILabel!
    @IBOutlet weak var callCollectionView: UICollectionView!
    
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    @IBOutlet weak var viewSegmentControl: UIView!
    
    @IBOutlet var filtersBtn: UIButton!
    
    @IBOutlet var addedFiltersCount: UILabel!
    
    
    @IBOutlet var  backgroundView : UIView!

    
    @IBOutlet var  backGroundVXview : UIView!
    
    private var dcrSegmentControl : UISegmentedControl!
    private var callListViewModel : CallListViewModel!
    
    var dcrActivityType = [DcrActivityType]()
    
    var searchText : String = ""
    var dcrfiltersView:  DCRfiltersView?
    private var CallListArray = CallListViewModel()
    
    var addedDCRVIewHeight: CGFloat = 60 + 130 + 70
    
    var type : DCRType!
    

    
    @IBAction func didTapFiltersBtn(_ sender: UIButton) {
        filtersAction()
    }
    
    
    func setHQlbl() {
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
                 //   LocalStorage.shared.setSting(LocalStorage.LocalValue.selectedRSFID, text:  asubordinate.first?.id ?? "")
                }
            
              
  
 
                
            }
            // Retrieve Data from local storage
               return
        

       
    }

    func setupUI() {
        callCollectionView.layer.cornerRadius = 5
        seatchHolderVIew.layer.cornerRadius = 5
        seatchHolderVIew.layer.borderWidth = 1
        seatchHolderVIew.layer.borderColor = UIColor.appLightTextColor.withAlphaComponent(0.2).cgColor
        backgroundView.isHidden = true
        setHQlbl()
        self.backgroundView.addTap {
            self.didClose()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let  tpDeviateVIewwidth = view.bounds.width / 1.7
        let  tpDeviateVIewheight = addedDCRVIewHeight
        
        let  tpDeviateVIewcenterX = view.bounds.midX - (tpDeviateVIewwidth / 2)
        let tpDeviateVIewcenterY = view.bounds.midY - (tpDeviateVIewheight / 2)
        
        
        dcrfiltersView?.frame = CGRect(x: tpDeviateVIewcenterX, y: tpDeviateVIewcenterY, width: tpDeviateVIewwidth, height: tpDeviateVIewheight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.callCollectionView.register(UINib(nibName: "DoctorCallCell", bundle: nil), forCellWithReuseIdentifier: "DoctorCallCell")
        
        let layout = UICollectionViewFlowLayout()
        
        self.callCollectionView.collectionViewLayout = layout
        
        let headerLayout = UICollectionViewFlowLayout()
        headerLayout.scrollDirection = .horizontal
        self.headerCollectionView.collectionViewLayout = headerLayout
        
       // self.txtSearch.setIcon(UIImage(imageLiteralResourceName: "searchIcon"))
        
        self.txtSearch.addTarget(self, action: #selector(searchFilterAction(_:)), for: .editingChanged)
        
      //  updateSegment()
        
        updateDcrList()
        
        self.type = .doctor
    }
    
    deinit {
        print("ok bye")
    }
    
    
    func filtersAction() {
       backgroundView.isHidden = false
       backGroundVXview.alpha = 0.3
        self.view.subviews.forEach { aAddedView in
            switch aAddedView {
            case dcrfiltersView:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
            case backgroundView:
                aAddedView.isUserInteractionEnabled = true
            default:
                
                print("Yet to implement")
                aAddedView.isUserInteractionEnabled = false
                
                
            }
            
        }
        
        dcrfiltersView = self.loadCustomView(nibname: XIBs.dcrfiltersView) as? DCRfiltersView
        dcrfiltersView?.delegate = self
        
        dcrfiltersView?.addedSubviewDelegate = self
        dcrfiltersView?.setupUI()
        view.addSubview(dcrfiltersView ?? TPdeviateReasonView())
    }
    
    
    @objc func searchFilterAction (_ sender : UITextField) {
        print(sender.text!)
        self.searchText = sender.text ?? ""
        self.callCollectionView.reloadData()
    }
    
    
    private func updateDcrList (){
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.docCap ?? "", type: .doctor)))
        
        if appsetup.chmNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.chmCap ?? "", type: .chemist)))
        }
        
        if appsetup.stkNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.stkCap ?? "", type: .stockist)))
        }
        
        if appsetup.unlNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.nlCap ?? "", type: .unlistedDoctor)))
        }
        
        if appsetup.hospNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.hospCaption ?? "", type: .hospital)))
        }
        
        if appsetup.cipNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.cipCaption ?? "", type: .cip)))
        }
        
        self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.hospCaption ?? "", type: .hospital)))
        self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.cipCaption ?? "", type: .cip)))
    }
    
    private func updateSegment() {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        var dcrList = [String]()
        
            dcrList.append("Listed Doctor")
        
            if appsetup.chmNeed == 0 {
                dcrList.append("Chemist")
            }
            if appsetup.stkNeed == 0 {
                dcrList.append("Stockist")
            }
            if appsetup.unlNeed == 0 {
                dcrList.append("Unlisted Doctor")
            }
            if appsetup.hospNeed == 0 {
                dcrList.append("Hospital")
            }
            if appsetup.cipNeed == 0 {
                dcrList.append("CIP")
            }
        
        dcrList.append("Hospital")
        dcrList.append("CIP")
        
        self.dcrSegmentControl = UISegmentedControl(items: dcrList)
        
        self.dcrSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.dcrSegmentControl.selectedSegmentIndex = 0
        self.dcrSegmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        
        self.viewSegmentControl.addSubview(self.dcrSegmentControl)
        
        let font = UIFont(name: "Satoshi-Bold", size: 18)!
        self.dcrSegmentControl.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
        self.dcrSegmentControl.highlightSelectedSegment1()
        
       // self.dcrSegmentControl.backgroundColor = UIColor.red
        
        self.dcrSegmentControl.topAnchor.constraint(equalTo: self.viewSegmentControl.topAnchor,constant: 10).isActive = true
        self.dcrSegmentControl.leadingAnchor.constraint(equalTo: self.viewSegmentControl.leadingAnchor, constant: 20).isActive = true
        self.dcrSegmentControl.heightAnchor.constraint(equalTo: self.viewSegmentControl.heightAnchor, multiplier: 0.7).isActive = true
        
        
        let lblUnderLine = UILabel()
        lblUnderLine.backgroundColor = AppColors.primaryColorWith_25per_alpha
        lblUnderLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewSegmentControl.addSubview(lblUnderLine)
        
        lblUnderLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        lblUnderLine.topAnchor.constraint(equalTo: self.dcrSegmentControl.bottomAnchor, constant: -6).isActive = true
        lblUnderLine.leadingAnchor.constraint(equalTo: self.dcrSegmentControl.leadingAnchor, constant: 15).isActive = true
        lblUnderLine.trailingAnchor.constraint(equalTo: self.viewSegmentControl.trailingAnchor, constant: -15).isActive = true
        
    }
    
    @objc func segmentControlAction (_ sender : UISegmentedControl){
        self.dcrSegmentControl.underlinePosition()
        self.callCollectionView.reloadData()
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension CallVC : collectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            case self.callCollectionView:
                return self.CallListArray.numberofDoctorsRows(self.type,searchText: self.searchText)
            case self.headerCollectionView:
                return self.CallListArray.numberofDcrs()
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            case self.callCollectionView :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorCallCell", for: indexPath) as! DoctorCallCell
                cell.CallDetail = self.CallListArray.fetchDataAtIndex(index: indexPath.row, type: self.type,searchText: self.searchText)
                return cell
            case self.headerCollectionView :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DCRSelectionTitleCell", for: indexPath) as! DCRSelectionTitleCell
                cell.title = self.CallListArray.fetchAtIndex(indexPath.row)
            
                if self.type.rawValue == self.CallListArray.fetchAtIndex(indexPath.row).type.rawValue {
                    cell.lblUnderLine.isHidden = false
                }else {
                    cell.lblUnderLine.isHidden = true
                }
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DCRSelectionTitleCell", for: indexPath) as! DCRSelectionTitleCell
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
            case self.callCollectionView:
                let precallvc = UIStoryboard.preCallVC
                precallvc.dcrCall = self.CallListArray.fetchDataAtIndex(index: indexPath.row, type: self.type,searchText: self.searchText)
                self.navigationController?.pushViewController(precallvc, animated: true)
            case self.headerCollectionView:
                self.type = self.CallListArray.fetchAtIndex(indexPath.row).type
                self.headerCollectionView.reloadData()
                self.callCollectionView.reloadData()
            default:
                break
        }
    }
     
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            case self.callCollectionView :
                let width = self.callCollectionView.frame.width / 4
            
            let size = CGSize(width: width - 10, height: collectionView.height / 3.5)
                return size
            
//                if self.dcrSegmentControl.selectedSegmentIndex == 0 {
//                    let size = CGSize(width: width - 10, height: 190)
//                    return size
//                }else {
//                    let size = CGSize(width: width - 10, height: 130)
//                    return size
//                }
            case self.headerCollectionView:
            
                let label = UILabel()
            label.setFont(font: .bold(size: .BODY))
                label.text = self.CallListArray.fetchAtIndex(indexPath.row).name
                let sizeLabelFit = label.sizeThatFits(CGSize(width: self.headerCollectionView.frame.width-30, height: self.headerCollectionView.frame.height))
            
                let size = CGSize(width: sizeLabelFit.width + 40, height: self.headerCollectionView.frame.height)
                return size
            default :
                let size = CGSize(width: 200, height: 130)
                return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
