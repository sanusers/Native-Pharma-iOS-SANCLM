//
//  SortView.swift
//  E-Detailing
//
//  Created by San eforce on 22/12/23.
//



import Foundation
import UIKit


protocol SortVIewDelegate: AnyObject {
    
    func didSelected(index: Int)
    
}

class SortVIew: UIView, UITableViewDelegate, UITableViewDataSource {

    var rowElements : [String]?
    
    var selectedIndex: Int? = nil
    

    let sotrTable: UITableView = {
        let aTable = UITableView()
        aTable.clipsToBounds = true
        return aTable
    }()
    
    
    let aview: UIView = {
        let aView = UIView()
        aView.backgroundColor = .appWhiteColor
        aView.clipsToBounds = true
        aView.layer.cornerRadius = 5

       return aView
    }()
    
    var delegate: SortVIewDelegate?
    
    override func layoutSubviews() {
        
        aview.frame = CGRect(x: 5, y: 5, width: self.width - 10, height: self.height - 10)
        
        sotrTable.frame = aview.bounds
    }
    
    
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
     //   commonInit()
        setupTableView()
        cellRegistration()
        toLoadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
   //    commonInit()
        setupTableView()
        cellRegistration()
        toLoadData()
    }
    
//    private func commonInit() {
//        // Load the XIB file
//        let nib  = UINib(nibName: "SortView", bundle: Bundle.main)
//        if let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
//            contentView.frame = bounds
//            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            addSubview(contentView)
//        }
//    }
    
    
    private func setupTableView() {
        addSubview(aview)
        aview.addSubview(sotrTable)
        var sreArr : [String] = []
        let nameElement = "By name A - Z"
        sreArr.append(nameElement)
        rowElements = sreArr
        self.layer.cornerRadius = 5
//        tableView = UITableView(frame: bounds, style: .plain)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        addSubview(tableView)
    }
    

    
    func toLoadData() {
        sotrTable.delegate = self
        sotrTable.dataSource = self
        sotrTable.reloadData()
    }
    
    func cellRegistration() {
        sotrTable.register(UINib(nibName: "RadioSelectionTVC", bundle: nil), forCellReuseIdentifier: "RadioSelectionTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowElements?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RadioSelectionTVC = tableView.dequeueReusableCell(withIdentifier: "RadioSelectionTVC", for: indexPath) as! RadioSelectionTVC
        cell.typeTitle.text = rowElements?[indexPath.row]
        cell.selectionStyle = .none
        cell.selectdSection = selectedIndex
        if cell.selectdSection == nil {
            cell.selectionIV.image = UIImage(named: "checkBoxEmpty")
        } else {
            if  cell.selectdSection ?? 0 == indexPath.row {
                cell.selectionIV.image = UIImage(named: "checkBoxSelected")
            } else {
                cell.selectionIV.image = UIImage(named: "checkBoxEmpty")
            }
        }
        

        
        cell.addTap {
            cell.selectdSection = indexPath.row
            self.delegate?.didSelected(index:  indexPath.row)
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
