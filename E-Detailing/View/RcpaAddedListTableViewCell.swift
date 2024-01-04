//
//  RcpaAddedListTableViewCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 07/09/23.
//

import Foundation
import UIKit


class RcpaAddedListTableViewCell : UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
    
    @IBOutlet weak var viewCompetitorList: UIView!
    
    @IBOutlet weak var heightViewCompetitorListConstraint: NSLayoutConstraint!
    
    
    var rcpaProduct : rcpaProduct! {

        didSet {
            self.lblName.text = self.rcpaProduct.product.name ?? ""
            self.lblQty.text = self.rcpaProduct.quantity
            self.lblRate.text = self.rcpaProduct.rate
            self.lblTotal.text = self.rcpaProduct.total
            
            self.btnPlus.isSelected = self.rcpaProduct.isViewTapped
            
            
            if self.rcpaProduct.isViewTapped == true {
                if self.rcpaProduct.rcpas.count != 0 { // || self.rcpaProduct.rcpas.count == 0
                    
                    var rcpa = self.rcpaProduct.rcpas
                    
                    let value = RcpaHeaderData(chemist: nil, product: nil, quantity: "", total: "", rate: "", competitorCompanyName: "Competitor Company", competitorCompanyCode: "", competitorBrandName: "Competitor Brand", competitorBrandCode: "", competitorRate: "Rate", competitorTotal: "Value", competitorQty: "Qty", remarks: "Remarks")
                    
                    
                    rcpa.insert(value, at: 0)
                    
                    
                    var previousView : UIView!
                    for (index,product) in
                            rcpa.enumerated(){
                        
                        print("rcpa == \(product)")
                        
                        let productView = RcpaSelectedCompetitorView.instanceFromNib()
                        productView.translatesAutoresizingMaskIntoConstraints = false
                        self.viewCompetitorList.addSubview(productView)
                        if self.heightViewCompetitorListConstraint != nil{
                            self.heightViewCompetitorListConstraint.isActive = false
                        }
                        productView.rcpa = product
                
                        if index == 0 {
                            var constraintArray = [productView.topAnchor.constraint(equalTo: self.viewCompetitorList.topAnchor, constant: 0),
                            productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
                            productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
                            if rcpa.count == 1{
                                constraintArray.append(productView.bottomAnchor.constraint(equalTo: self.viewCompetitorList.bottomAnchor, constant: 0))
                            }
                            NSLayoutConstraint.activate(constraintArray)
                            previousView = productView
                        }else if index == rcpa.count - 1{
                            let constraintArray = [productView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 0),
                            productView.bottomAnchor.constraint(equalTo: self.viewCompetitorList.bottomAnchor, constant: 0),
                            productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
                            productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
                            NSLayoutConstraint.activate(constraintArray)
                            previousView = productView
                        }else{
                            let constraintArray = [productView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 0),
                            productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
                            productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
                            NSLayoutConstraint.activate(constraintArray)
                            previousView = productView
                        }
                    }
                }
            }else {
                if self.heightViewCompetitorListConstraint != nil{
                    self.heightViewCompetitorListConstraint.constant = 0
                }else {
                    let productView = RcpaSelectedCompetitorView.instanceFromNib()
                    productView.translatesAutoresizingMaskIntoConstraints = false
                    self.viewCompetitorList.subviews.forEach{ $0.removeFromSuperview()}
                    self.viewCompetitorList.addSubview(productView)
                }
            }
            
            
//            if self.rcpaProduct.rcpas.count != 0 { // || self.rcpaProduct.rcpas.count == 0
//                
//                var rcpa = self.rcpaProduct.rcpas
//                
//                let value = RcpaHeaderData(chemist: nil, product: nil, quantity: "", total: "", rate: "", competitorCompanyName: "Competitor Company", competitorCompanyCode: "", competitorBrandName: "Competitor Brand", competitorBrandCode: "", competitorRate: "Rate", competitorTotal: "Value", competitorQty: "Qty", remarks: "Remarks")
//                
//                
//                rcpa.insert(value, at: 0)
//                
//                
//                var previousView : UIView!
//                for (index,product) in
//                        rcpa.enumerated(){
//                    
//                    print("rcpa == \(product)")
//                    
//                    let productView = RcpaSelectedCompetitorView.instanceFromNib()
//                    productView.translatesAutoresizingMaskIntoConstraints = false
//                    self.viewCompetitorList.addSubview(productView)
//                    if self.heightViewCompetitorListConstraint != nil{
//                        self.heightViewCompetitorListConstraint.isActive = false
//                    }
//                    productView.rcpa = product
//                    
//            
//                    if index == 0 {
//                        var constraintArray = [productView.topAnchor.constraint(equalTo: self.viewCompetitorList.topAnchor, constant: 0),
//                        productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
//                        productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
//                        if rcpa.count == 1{
//                            constraintArray.append(productView.bottomAnchor.constraint(equalTo: self.viewCompetitorList.bottomAnchor, constant: 0))
//                        }
//                        NSLayoutConstraint.activate(constraintArray)
//                        previousView = productView
//                    }else if index == rcpa.count - 1{
//                        let constraintArray = [productView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 0),
//                        productView.bottomAnchor.constraint(equalTo: self.viewCompetitorList.bottomAnchor, constant: 0),
//                        productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
//                        productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
//                        NSLayoutConstraint.activate(constraintArray)
//                        previousView = productView
//                    }else{
//                        let constraintArray = [productView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 0),
//                        productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
//                        productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
//                        NSLayoutConstraint.activate(constraintArray)
//                        previousView = productView
//                    }
//                }
//            }else {
//                if self.heightViewCompetitorListConstraint != nil{
//                    self.heightViewCompetitorListConstraint.constant = 0
//                }else {
//                    let productView = RcpaSelectedCompetitorView.instanceFromNib()
//                    productView.translatesAutoresizingMaskIntoConstraints = false
//                    self.viewCompetitorList.subviews.forEach { $0.removeFromSuperview() }
//                    self.viewCompetitorList.addSubview(productView)
//                    
//                    let constraintArray = [productView.topAnchor.constraint(equalTo: self.viewCompetitorList.topAnchor, constant: 0),
//                    productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
//                    productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0),
//                    productView.bottomAnchor.constraint(equalTo: self.viewCompetitorList.bottomAnchor, constant: 0),
//                    productView.heightAnchor.constraint(equalTo: self.viewCompetitorList.heightAnchor,constant: 0)]
//                    NSLayoutConstraint.activate(constraintArray)
//                    
//                }
//            }
            
            
//            var previousView : UIView!
//            for (index,product) in
//                    self.rcpaProduct.rcpas.enumerated(){
            
//
//                print(product)
//
//                let productView = RcpaSelectedCompetitorView.instanceFromNib()
//                productView.translatesAutoresizingMaskIntoConstraints = false
//                self.viewCompetitorList.addSubview(productView)
//                if self.heightViewCompetitorListConstraint != nil{
//                    self.heightViewCompetitorListConstraint.isActive = false
//                }
//                productView.rcpa = product
//
//
//                if index == 0{
//                    var constraintArray = [productView.topAnchor.constraint(equalTo: self.viewCompetitorList.topAnchor, constant: 0),
//                    productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
//                    productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
//                    if self.rcpaProduct.rcpas.count == 1{
//                        constraintArray.append(productView.bottomAnchor.constraint(equalTo: self.viewCompetitorList.bottomAnchor, constant: 0))
//                    }
//                    NSLayoutConstraint.activate(constraintArray)
//                    previousView = productView
//                }else if index == self.rcpaProduct.rcpas.count - 1{
//                    let constraintArray = [productView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 0),
//                    productView.bottomAnchor.constraint(equalTo: self.viewCompetitorList.bottomAnchor, constant: 0),
//                    productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
//                    productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
//                    NSLayoutConstraint.activate(constraintArray)
//                    previousView = productView
//                }else{
//                    let constraintArray = [productView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 0),
//                    productView.leftAnchor.constraint(equalTo: self.viewCompetitorList.leftAnchor, constant: 0),
//                    productView.rightAnchor.constraint(equalTo: self.viewCompetitorList.rightAnchor, constant: 0)]
//                    NSLayoutConstraint.activate(constraintArray)
//                    previousView = productView
//                }
//            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewCompetitorList.layer.cornerRadius = 5
        self.viewCompetitorList.layer.borderWidth = 1
        self.viewCompetitorList.layer.borderColor = AppColors.primaryColorWith_10per_alpha.cgColor
        
    }
    
}
