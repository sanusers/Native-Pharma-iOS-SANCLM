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
    
}


class CallVC : UIViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var callCollectionView: UICollectionView!
    
    @IBOutlet weak var viewSegmentControl: UIView!
    
    
    private var dcrSegmentControl : UISegmentedControl!
    private var callListViewModel : CallListViewModel!
    
    var doctor = [DoctorFencing]()
    
    private var CallListArray = CallListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callCollectionView.register(UINib(nibName: "DoctorCallCell", bundle: nil), forCellWithReuseIdentifier: "DoctorCallCell")
        
        let layout = UICollectionViewFlowLayout()
        
        self.callCollectionView.collectionViewLayout = layout
        
        self.doctor = DBManager.shared.getDoctor()
        
        self.txtSearch.setIcon(UIImage(imageLiteralResourceName: "searchIcon"))
        
        self.txtSearch.addTarget(self, action: #selector(searchFilterAction(_:)), for: .editingChanged)
        
        updateSegment()
    }
    
    deinit {
        print("ok bye")
    }
    
    @objc func searchFilterAction (_ sender : UITextField) {
        print(sender.text!)
        
        let text = sender.text ?? ""
        
        let doctor = DBManager.shared.getDoctor()
        
        if !sender.text!.isEmpty {
            self.doctor = doctor.filter{($0.name?.lowercased() ?? "").contains(text.lowercased())}
            self.callCollectionView.reloadData()
        }else {
            self.doctor = DBManager.shared.getDoctor()
            self.callCollectionView.reloadData()
        }
    }
    
    private func updateSegment() {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        var dcrList = [String]()
        
            dcrList.append("Listed Doctor")
        
            if appsetup.docNeed == 0 {
                dcrList.append("Listed Doctor")
            }
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
        lblUnderLine.topAnchor.constraint(equalTo: self.dcrSegmentControl.bottomAnchor, constant: 0).isActive = true
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
        return self.CallListArray.numberofDoctorsRows(DCRType(rawValue: self.dcrSegmentControl.selectedSegmentIndex)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorCallCell", for: indexPath) as! DoctorCallCell
        cell.CallDetail = self.CallListArray.fetchDataAtIndex(index: indexPath.row, type: DCRType(rawValue: self.dcrSegmentControl.selectedSegmentIndex)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let precallvc = UIStoryboard.preCallVC
        precallvc.dcrCall = self.CallListArray.fetchDataAtIndex(index: indexPath.row, type: DCRType(rawValue: 0)!)
        self.navigationController?.pushViewController(precallvc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = self.callCollectionView.frame.width / 4
        let size = CGSize(width: width - 10, height: 200)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
