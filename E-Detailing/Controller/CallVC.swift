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
                return appSetup.dpNeed
            case .chemist:
                return appSetup.cpNeed
            case .stockist:
                return appSetup.spNeed
            case .unlistedDoctor:
                return appSetup.npNeed
            case .hospital:
                return 1
            case .cip:
                return appSetup.cipPNeed
        }
    }
    
    var inputNeed : Int {
        let appSetup = AppDefaults.shared.getAppSetUp()
        switch self {
        case .doctor:
            return appSetup.diNeed
        case .chemist:
            return appSetup.ciNeed
        case .stockist:
            return appSetup.siNeed
        case .unlistedDoctor:
            return appSetup.niNeed
        case .hospital:
            return 1
        case .cip:
            return appSetup.cipINeed
        }
    }
    
    
}


class CallVC : UIViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var callCollectionView: UICollectionView!
    
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    @IBOutlet weak var viewSegmentControl: UIView!
    
    
    private var dcrSegmentControl : UISegmentedControl!
    private var callListViewModel : CallListViewModel!
    
    var dcrActivityType = [DcrActivityType]()
    
    var searchText : String = ""
    
    private var CallListArray = CallListViewModel()
    
    var type : DCRType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callCollectionView.register(UINib(nibName: "DoctorCallCell", bundle: nil), forCellWithReuseIdentifier: "DoctorCallCell")
        
        let layout = UICollectionViewFlowLayout()
        
        self.callCollectionView.collectionViewLayout = layout
        
        let headerLayout = UICollectionViewFlowLayout()
        headerLayout.scrollDirection = .horizontal
        self.headerCollectionView.collectionViewLayout = headerLayout
        
        self.txtSearch.setIcon(UIImage(imageLiteralResourceName: "searchIcon"))
        
        self.txtSearch.addTarget(self, action: #selector(searchFilterAction(_:)), for: .editingChanged)
        
      //  updateSegment()
        
        updateDcrList()
        
        self.type = .doctor
    }
    
    deinit {
        print("ok bye")
    }
    
    @objc func searchFilterAction (_ sender : UITextField) {
        print(sender.text!)
        self.searchText = sender.text ?? ""
        self.callCollectionView.reloadData()
    }
    
    
    private func updateDcrList (){
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.docCap, type: .doctor)))
        
        if appsetup.chmNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.chmCap, type: .chemist)))
        }
        
        if appsetup.stkNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.stkCap, type: .stockist)))
        }
        
        if appsetup.unlNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.nlCap, type: .unlistedDoctor)))
        }
        
        if appsetup.hospNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.hospCaption, type: .hospital)))
        }
        
        if appsetup.cipNeed == 0 {
            self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.cipCaption, type: .cip)))
        }
        
        self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.hospCaption, type: .hospital)))
        self.CallListArray.addDcrActivity(DcrActivityViewModel(activityType: DcrActivityType(name: appsetup.cipCaption, type: .cip)))
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
            
                let size = CGSize(width: width - 10, height: 190)
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
                label.font = UIFont(name: "Satoshi-Bold", size: 20)!
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
