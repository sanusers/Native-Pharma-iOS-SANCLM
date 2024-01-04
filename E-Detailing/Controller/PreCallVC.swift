//
//  PreCallVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 08/08/23.
//

import Foundation
import UIKit



class PreCallVC : UIViewController {
    
    
    
    @IBOutlet weak var viewSegmentControl: UIView!
    
    
    private var segmentControl : UISegmentedControl!
    
    var dcrCall : CallViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSegment()
    }
    
    deinit {
        print("ok bye")
    }
    
    private func updateSegment() {
        
        self.segmentControl = UISegmentedControl(items: ["Overview","Pre Call Analysis"])
        
        self.segmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.segmentControl.selectedSegmentIndex = 0
        self.segmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        
        self.viewSegmentControl.addSubview(self.segmentControl)
        
        let font = UIFont(name: "Satoshi-Bold", size: 18)!
        self.segmentControl.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
        self.segmentControl.highlightSelectedSegment1()
         
        
        self.segmentControl.topAnchor.constraint(equalTo: self.viewSegmentControl.topAnchor).isActive = true
        self.segmentControl.leadingAnchor.constraint(equalTo: self.viewSegmentControl.leadingAnchor, constant: 20).isActive = true
        self.segmentControl.heightAnchor.constraint(equalTo: self.viewSegmentControl.heightAnchor, multiplier: 0.7).isActive = true
        
        let color = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(42.0/255.0), blue: CGFloat(60.0/255.0), alpha: CGFloat(0.25))
        
        let lblUnderLine = UILabel()
        lblUnderLine.backgroundColor = color
        lblUnderLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewSegmentControl.addSubview(lblUnderLine)
        
        lblUnderLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        lblUnderLine.topAnchor.constraint(equalTo: self.segmentControl.bottomAnchor, constant: -6).isActive = true
        lblUnderLine.leadingAnchor.constraint(equalTo: self.viewSegmentControl.leadingAnchor, constant: 20).isActive = true
        lblUnderLine.trailingAnchor.constraint(equalTo: self.viewSegmentControl.trailingAnchor, constant: -20).isActive = true
        
    }
    
    
    @objc func segmentControlAction (_ sender : UISegmentedControl){
        
        self.segmentControl.underlinePosition()
        
    }
    
    
    
    @IBAction func startDetailingAction(_ sender: UIButton) {
        
        
        let productVC = UIStoryboard.productVC
        productVC.dcrCall = self.dcrCall
        self.navigationController?.pushViewController(productVC, animated: true)
        
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


